return {
	"mfussenegger/nvim-jdtls",
	-- ft means: only load this plugin when you open a java file
	ft = "java",
	dependencies = { "williamboman/mason.nvim" },
	config = function()
		local jdtls = require("jdtls")

		-- mason installs jdtls here
		local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

		-- jdtls ships platform-specific configs — pick the right one
		local os_config = "config_linux"
		if vim.fn.has("mac") == 1 then
			os_config = "config_mac"
		elseif vim.fn.has("win32") == 1 then
			os_config = "config_win"
		end

		-- jdtls needs a separate workspace folder per project to store
		-- its index, compiled classes, etc. We use the project folder name.
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

		local config = {
			cmd = {
				"java",
				"-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
				"-configuration", jdtls_path .. "/" .. os_config,
				-- each project gets its own workspace so indexes don't clash
				"-data", workspace_dir,
			},

			-- jdtls needs to know the project root to find source files
			root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

			-- these are the same keymaps from lsp.lua — they fire when jdtls attaches
			on_attach = function(_, bufnr)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				map("gd", vim.lsp.buf.definition, "Go to definition")
				map("gD", vim.lsp.buf.declaration, "Go to declaration")
				map("gr", vim.lsp.buf.references, "Find references")
				map("gi", vim.lsp.buf.implementation, "Go to implementation")
				map("K",  vim.lsp.buf.hover, "Hover docs")
				map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
				map("<leader>ca", vim.lsp.buf.code_action, "Code action")
				map("<leader>d", vim.diagnostic.open_float, "Show diagnostics")
				map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
				map("]d", vim.diagnostic.goto_next, "Next diagnostic")

				-- java-specific extras
				map("<leader>oi", jdtls.organize_imports, "Organize imports")
				map("<leader>ev", jdtls.extract_variable, "Extract variable")
				map("<leader>em", jdtls.extract_method, "Extract method")
			end,

			capabilities = require("cmp_nvim_lsp").default_capabilities(),

			settings = {
				java = {
					format = { enabled = true },
					saveActions = { organizeImports = true },
				},
			},
		}

		-- start jdtls whenever a java file is opened
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function()
				jdtls.start_or_attach(config)
			end,
		})
	end,
}
