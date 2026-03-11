return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				css        = { "prettier" },
				json       = { "prettier" },
				markdown   = { "prettier" },
				go         = { "goimports" }, -- install via Mason; includes gofmt + auto imports
				java       = { "google-java-format" },
				scala      = { "scalafmt" },  -- installed by coursier alongside Metals, no Mason needed
				cpp        = { "clang-format" },
				sh         = { "shfmt" },
				lua        = { "stylua" },
			},
			-- format automatically on save
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true, -- fall back to LSP formatting if no formatter configured
			},
		})
	end,
}
