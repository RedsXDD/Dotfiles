local telescope = require("telescope")
local themes = require("telescope.themes")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local icons = require("core.icons").telescope

-- Load telescope extensions:
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "noice")
pcall(telescope.load_extension, "ui-select")

local function formattedName(_, path)
	local tail = vim.fs.basename(path)
	local parent = vim.fs.dirname(path)
	if parent == "." then
		return tail
	end
	return string.format("%s\t\t%s", tail, parent)
end

-- Function to disable binary previewing:
local new_maker = function(filepath, bufnr, opts)
	filepath = vim.fn.expand(filepath)
	Job:new({
		command = "file",
		args = { "--mime-type", "-b", filepath },
		on_exit = function(j)
			local mime_type = vim.split(j:result()[1], "/")[1]
			if mime_type == "text" then
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			else
				-- maybe we want to write something to the buffer here
				vim.schedule(function()
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
				end)
			end
		end,
	}):sync()
end

telescope.setup({
	file_ignore_patterns = { "%.git/." },
	defaults = {
		preview = true,
		prompt_prefix = icons.prompt_prefix,
		selection_caret = icons.selection_caret,
		file_ignore_patterns = { "node_modules", "package-lock.json" },
		initial_mode = "insert",
		select_strategy = "reset",
		sorting_strategy = "ascending",
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		buffer_previewer_maker = new_maker, -- Set previewer to `Disable binaries` function.
		layout_config = {
			prompt_position = "top",
			preview_cutoff = 120,
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--trim",
		},
		mappings = {
			i = {
				["<Esc>"] = actions.close,
				["<C-u>"] = false,
				["<C-d>"] = actions.delete_buffer + actions.move_to_top,
				["<C-k>"] = {
					actions.move_selection_previous,
					type = "action",
					opts = { nowait = true, silent = true },
				},
				["<C-j>"] = {
					actions.move_selection_next,
					type = "action",
					opts = { nowait = true, silent = true },
				},
				["<M-p>"] = action_layout.toggle_preview,
			},
		},
	},
	pickers = {
		find_files = {
			preview = false,
			path_display = formattedName,
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
			layout_config = {
				height = 0.4,
				prompt_position = "top",
				preview_cutoff = 120,
			},
		},
		git_files = {
			previewer = true,
			path_display = formattedName,
			layout_config = {
				height = 0.4,
				prompt_position = "top",
				preview_cutoff = 120,
			},
		},
		buffers = {
			previewer = false,
			path_display = formattedName,
			layout_config = {
				height = 0.4,
				width = 0.6,
				prompt_position = "top",
				preview_cutoff = 120,
			},
			mappings = {
				i = { ["<c-d>"] = actions.delete_buffer },
				n = { ["<c-d>"] = actions.delete_buffer },
			},
		},
		current_buffer_fuzzy_find = {
			previewer = true,
			layout_config = {
				prompt_position = "top",
				preview_cutoff = 120,
			},
		},
		live_grep = { only_sort_text = true, previewer = true },
		grep_string = { only_sort_text = true, previewer = true },
		lsp_references = { show_line = false, previewer = true },
		treesitter = { show_line = false, previewer = true },
		colorscheme = { enable_preview = true },
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
		["ui-select"] = {
			themes.get_dropdown({
				previewer = true,
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						width = 0.5,
						height = 0.4,
						preview_width = 0.6,
					},
				},
			}),
		},
	},
})
