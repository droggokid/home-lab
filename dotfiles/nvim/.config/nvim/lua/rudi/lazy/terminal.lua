return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<C-j>", desc = "Toggle terminal" },
	},
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<C-j>]],
			direction = "float",
			float_opts = {
				border = "curved",
			},
		})

		-- Esc exits terminal mode back to normal mode instead of sending Esc to the shell
		vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
	end,
}
