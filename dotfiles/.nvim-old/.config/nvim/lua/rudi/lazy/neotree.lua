return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- file icons (needs a Nerd Font)
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
	},
	config = function()
		require("neo-tree").setup({
			window = {
				width = 30,
				mappings = {
					["<space>"] = "none", -- don't let neo-tree steal <space> (your leader)
				},
			},
			filesystem = {
				follow_current_file = {
					enabled = true, -- highlight the current file in the tree
				},
				hijack_netrw_behavior = "disabled",
			},
		})
	end,
}
