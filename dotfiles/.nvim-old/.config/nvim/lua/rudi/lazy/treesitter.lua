return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		branch = "main",
		build = ":TSUpdate",
		config = function()
			-- New API: setup() only accepts install_dir now.
			-- highlight, indent, ensure_installed etc. are all gone from here.
			require("nvim-treesitter").setup()

			-- Install parsers in the background (async, won't block startup)
			require("nvim-treesitter").install({
				"vimdoc", "lua",
				"go", "java", "scala",
				"c_sharp", "bash", "typescript", "javascript", "cpp",
			})

			-- Neovim enables treesitter highlight automatically when a parser exists.
			-- We use an autocmd to turn it OFF for html and large files.
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					if ev.match == "html" then
						vim.treesitter.stop(ev.buf)
						return
					end

					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
					if ok and stats and stats.size > max_filesize then
						vim.treesitter.stop(ev.buf)
						vim.notify(
							"File larger than 100KB, treesitter disabled for performance",
							vim.log.levels.WARN,
							{ title = "Treesitter" }
						)
					end
				end,
			})

			vim.treesitter.language.register("templ", "templ")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
}
