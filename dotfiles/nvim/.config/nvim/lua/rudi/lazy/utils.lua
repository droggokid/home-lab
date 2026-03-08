return {
	-- auto-detect indentation — no config needed, just works
	{ "tpope/vim-sleuth" },

	-- auto-close brackets, parens, quotes
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	-- add/change/delete surrounding characters
	-- cs"'  → change surrounding " to '
	-- ds"   → delete surrounding "
	-- ysiw" → surround word with "
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},

	-- highlight and search TODO: FIXME: NOTE: etc.
	{
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()

			-- search all todos in project with telescope
			vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })
		end,
	},
}
