return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPost",
	config = function()
		require("gitsigns").setup({
			signs = {
				add          = { text = "▎" },
				change       = { text = "▎" },
				delete       = { text = "" },
				topdelete    = { text = "" },
				changedelete = { text = "▎" },
			},
			-- show git blame for current line after cursor is still for a moment
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 500,
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				-- navigate between hunks (changed sections)
				map("]h", gs.next_hunk, "Next hunk")
				map("[h", gs.prev_hunk, "Prev hunk")

				-- stage/reset individual hunks without leaving the editor
				map("<leader>hs", gs.stage_hunk, "Stage hunk")
				map("<leader>hr", gs.reset_hunk, "Reset hunk")
				map("<leader>hp", gs.preview_hunk, "Preview hunk")

				-- open full blame for the line
				map("<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
			end,
		})
	end,
}
