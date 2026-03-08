-- nvim-cmp: completion engine. LSP sends completion data, cmp shows the popup.
-- It needs "sources" — each source is a plugin that feeds cmp with suggestions.
return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",   -- feeds LSP completions into cmp
			"hrsh7th/cmp-buffer",     -- suggests words from the current buffer
			"hrsh7th/cmp-path",       -- completes file system paths
			"L3MON4D3/LuaSnip",       -- snippet engine (cmp needs one to work)
			"saadparwaiz1/cmp_luasnip", -- connects LuaSnip to cmp
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					-- cmp requires a snippet engine — this tells it to use LuaSnip
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),   -- manually trigger completion
					["<C-e>"]     = cmp.mapping.abort(),      -- close completion window
					["<CR>"]      = cmp.mapping.confirm({ select = true }), -- confirm selection
					["<C-n>"]     = cmp.mapping.select_next_item(),
					["<C-p>"]     = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- highest priority: LSP suggestions
					{ name = "luasnip" }, -- then snippets
				}, {
					{ name = "buffer" },  -- fallback: words in current file
					{ name = "path" },    -- fallback: file paths
				}),
			})
		end,
	},

	{
		-- mason.nvim: a UI + installer for LSP servers, linters, formatters.
		-- Open it with :Mason to browse and install things manually too.
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		-- mason-lspconfig: the glue between mason and nvim-lspconfig.
		-- "ensure_installed" auto-installs servers if they're missing.
		-- Without this, mason and lspconfig don't know about each other.
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",      -- Go
					"ts_ls",      -- TypeScript / JavaScript
					"omnisharp",  -- C#
					"clangd",     -- C / C++
					"bashls",     -- Bash / Zsh
				},
				-- automatically call lspconfig.setup() for every installed server
				automatic_installation = true,
			})
		end,
	},

	{
		-- nvim-lspconfig: still needed for server definitions (cmd, filetypes,
		-- root patterns). But we no longer call require('lspconfig').x.setup().
		-- Instead we use vim.lsp.config which is built into Neovim 0.11+.
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- on_attach runs every time an LSP server connects to a buffer.
			local on_attach = function(_, bufnr)
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
			end

			-- '*' applies this config to every server as a base.
			-- Individual servers can override these in their own vim.lsp.config() call.
			vim.lsp.config('*', {
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Enable all our servers. nvim-lspconfig provides the defaults
			-- (cmd, filetypes, root markers) so we don't have to specify them.
			vim.lsp.enable({
				"gopls",     -- Go
				"ts_ls",     -- TypeScript / JavaScript
				"omnisharp", -- C#
				"clangd",    -- C / C++
				"bashls",    -- Bash / Zsh
			})
		end,
	},
}
