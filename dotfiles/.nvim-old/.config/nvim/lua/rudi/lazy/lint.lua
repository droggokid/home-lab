return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			go         = { "golangcilint" },
			java       = { "checkstyle" },
			sh         = { "shellcheck" },
		}

		-- run linters after saving or reading a file
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
