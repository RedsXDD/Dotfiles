-- vim:fileencoding=utf-8:foldmethod=marker

return {
	"echasnovski/mini.files",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- NOTE: This init function allows the plugin to be lazy loaded without breaking the netrw hijack functionality.
	init = function()
		vim.g.loaded_netrwPlugin = 1
		vim.g.loaded_netrw = 1

		local group_name = "augroup_mini_files_netrw_hijack"
		local augroup = vim.api.nvim_create_augroup(group_name, { clear = true })

		vim.api.nvim_create_autocmd("VimEnter", {
			desc = "Auto open mini.files when loading a directory.",
			group = augroup,
			callback = function(args)
				local f = vim.fn.expand("%:p")
				if vim.fn.isdirectory(f) ~= 0 then
					require("mini.files").open()
					vim.api.nvim_clear_autocmds({ group = group_name })
				end
			end,
		})
	end,
	--stylua: ignore start
	keys = function()
		local M = {}

		local files = require("mini.files")

		local files_toggle = function(path, use_lastest)
			if not files.close() then files.open(path, use_lastest) end
		end

		local files_map = function(keys, func, desc)
			local keymap_table = { keys, func, mode = { "n" }, noremap = true, desc = "" .. desc }
			table.insert(M, keymap_table)
		end

		files_map("<Leader>gf", function() files_toggle(vim.uv.cwd(), true) end, "Open Mini.files on CWD.")
		files_map("<Leader>gF", function() files_toggle(vim.api.nvim_buf_get_name(0), true) end,
			"Open Mini.files (Directory of current file).")

		return M
	end,
	--stylua: ignore end
	config = function()
		--: Window options {{{
		-- Set window options:
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesWindowOpen",
			callback = function(args)
				local win_id = args.data.win_id
				-- vim.wo[win_id].winblend = 90 -- Window opacity.
				vim.api.nvim_win_set_config(win_id, { border = "rounded" })
			end,
		})
		--: }}}
		--: Toggle dotfiles {{{
		local show_dotfiles = true

		local filter_show = function(fs_entry)
			return true
		end

		local filter_hide = function(fs_entry)
			return not vim.startswith(fs_entry.name, ".")
		end

		local toggle_dotfiles = function()
			show_dotfiles = not show_dotfiles
			local new_filter = show_dotfiles and filter_show or filter_hide
			files.refresh({ content = { filter = new_filter } })
		end

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id
				vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle dotfiles displaying." })
			end,
		})
		--: }}}
		--: Open files in splits {{{
		local map_split = function(buf_id, keys, direction)
			local split_function = function()
				-- Make new window and set it as target.
				local new_target_window
				vim.api.nvim_win_call(files.get_target_window(), function()
					vim.cmd(direction .. " split")
					new_target_window = vim.api.nvim_get_current_win()
				end)

				files.set_target_window(new_target_window)
			end

			-- Adding `desc` will result into `show_help` entries.
			local desc = "Split " .. direction
			vim.keymap.set("n", keys, split_function, { buffer = buf_id, desc = desc })
		end

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id

				-- Tweak keys to your liking
				map_split(buf_id, "<Leader>gs", "belowright horizontal")
				map_split(buf_id, "<Leader>gv", "belowright vertical")
				map_split(buf_id, "<Leader>_", "belowright horizontal")
				map_split(buf_id, "<Leader>-", "belowright vertical")
			end,
		})
		--: }}}
		--: Set current working directory {{{
		local files_set_cwd = function(path)
			-- Works only if cursor is on the valid file system entry.
			local cur_entry_path = files.get_fs_entry().path
			local cur_directory = vim.fs.dirname(cur_entry_path)
			vim.fn.chdir(cur_directory)
		end

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				vim.keymap.set("n", "<Leader>g,", files_set_cwd, { buffer = args.data.buf_id })
			end,
		})
		--: }}}
		--: Setup function {{{
		local files = require("mini.files")

		files.setup({
			mappings = {
				close = "q",
				go_in = "<C-l>",
				go_in_plus = "<CR>", -- Close explorer after opening file.
				go_out = "<C-h>",
				go_out_plus = "",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
			options = {
				permanent_delete = false, -- Whether to delete permanently or move into module-specific trash.
				use_as_default_explorer = true, -- Whether to use for editing directories.
			},
			windows = {
				max_number = math.huge, -- Maximum number of windows to show side by side.
				preview = true, -- Whether to show preview of file/directory under cursor.
				width_focus = 50, -- Width of focused window.
				width_nofocus = 15, -- Width of non-focused window.
				width_preview = 80, -- Width of preview window.
			},
		})
		--: }}}
	end,
}
