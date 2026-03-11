return {
	"scalameta/nvim-metals",
	-- load for scala and sbt (build file) filetypes
	ft = { "scala", "sbt" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local metals = require("metals")

		-- bare_config() gives you an empty config to fill in yourself,
		-- as opposed to metals.setup() which makes more assumptions
		local metals_config = metals.bare_config()

		-- metals installs itself via coursier the first time you open a
		-- scala file — you'll see a prompt. No mason needed.
		metals_config.settings = {
			showImplicitArguments = true,   -- show implicit args in hover
			showInferredType = true,        -- show inferred types inline
			excludedPackages = {},
		}

		metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

		metals_config.on_attach = function(_, bufnr)
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

			-- scala-specific: trigger metals hover (richer than vim.lsp.buf.hover)
			map("<leader>mh", metals.hover_worksheet, "Metals hover worksheet")
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "scala", "sbt" },
			callback = function()
				metals.initialize_or_attach(metals_config)
			end,
		})
	end,
}
