return {
	"echasnovski/mini.statusline",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		use_icons = true,
		set_vim_settings = false,
		content = {
			inactive = nil,
			active = function()
				local statusline = require("mini.statusline")

				statusline.section_filename_modified = function(args)
					-- In terminal always use plain name
					if vim.bo.buftype == 'terminal' then
						return '%t'
					elseif statusline.is_truncated(args.trunc_width) then
						-- File name with 'truncate', 'modified', 'readonly' flags
						-- Use relative path if truncated
						return '%f%m%r'
					else
						-- add spacing. if not truncated
						return '%f %m %r'
					end
				end
				statusline.section_location_modified = function(args)
					-- Use virtual column number to allow update when past last column
					if statusline.is_truncated(args.trunc_width) then
						return "%l:%L"
					end
					return ' %p%% │ %l:%L'
				end

				--stylua: ignore start
				local mode, mode_hl  = statusline.section_mode({ trunc_width = 120 })
				local git            = statusline.section_git({ trunc_width = 75 }) -- requires gitsigns plugin.
				local diagnostics    = statusline.section_diagnostics({ trunc_width = 75 })
				local filename       = statusline.section_filename_modified({ trunc_width = 140 })
				local fileinfo       = statusline.section_fileinfo({ trunc_width = 120 })
				local search         = statusline.section_searchcount({ trunc_width = 75 })
				local location       = statusline.section_location_modified({ trunc_width = 75 })

				return statusline.combine_groups({
					{ hl = mode_hl,                 strings = { mode } },
					{ hl = "MiniStatuslineDevinfo", strings = { git } },
					"%<", -- Mark general truncate point.
					{ hl = "MiniStatuslineFilename", strings = { diagnostics, filename } },
					"%=", -- End left alignment.
					{ hl = "MiniStatuslineDevinfo",  strings = { fileinfo } },
					{ hl = mode_hl,                  strings = { search, location } },
				})
				--stylua: ignore end
			end,
		},
	},
	config = function(_, opts)
		vim.opt.laststatus = 3
		require("mini.statusline").setup(opts)
	end,
}
