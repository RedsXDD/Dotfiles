-- vim:fileencoding=utf-8:foldmethod=marker

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		branch = "0.1.x",
		cmd = "Telescope",
		--: Main keymappings {{{
		--stylua: ignore start
		keys = {
			--: Misc {{{
			{ "<Leader>?",  ":Telescope keymaps<CR>",                                                                                   desc = "Search keymaps.", },
			{
				"<Leader>fn",
				function()
					require("telescope.builtin").find_files({
						cwd = vim.fn.stdpath(
							"config")
					})
				end,
				desc = "Search Neovim configuration files.",
			},
			{ "<Leader>fh", ":Telescope command_history<CR>",                                                                           desc = "Search command history.", },
			{ "<Leader>fH", ":Telescope help_tags<CR>",                                                                                 desc = "Search help tags.", },
			{ "<Leader>fr", ":Telescope resume<CR>",                                                                                    desc = "Search resumes.", },
			--: }}}
			--: Buffers {{{
			{ "<Leader>fb", ":Telescope buffers<CR>",                                                                                   desc = "Search buffers.", },
			{ "<Leader>fB", function() require("telescope.builtin").current_buffer_fuzzy_find() end,                                    desc = "Fuzzily search in current buffer.", },
			--: }}}
			--: File searching {{{
			{ "<Leader>ff", ":Telescope find_files<CR>",                                                                                desc = "Find files on CWD.", },
			{ "<Leader>fF", function() require("telescope.builtin").find_files({ follow = true, no_ignore = true, hidden = true }) end, desc = "Find files (+ hidden files).", },
			{ "<Leader>fo", ":Telescope oldfiles<CR>",                                                                                  desc = "Search recently opened files.", },
			--: }}}
			--: Grepping {{{
			{ "<Leader>fw", ":Telescope grep_string<CR>",                                                                               desc = "Search word under cursor.", },
			{ "<Leader>fg", ":Telescope live_grep<CR>",                                                                                 desc = "Live grep for files on CWD.", },
			{
				"<Leader>fG",
				function()
					require("telescope.builtin").live_grep({
						grep_open_files = true,
						prompt_title =
						"Live grep in open files.",
					})
				end,
				desc = "Grep on open files.",
			},
			--: }}}
			--: LSP mappings {{{
			{ "<Leader>fd",  ":Telescope diagnostics<CR>",                   desc = "Search diagnostics.", },
			{ "<Leader>fld", ":Telescope lsp_definitions<CR>",               desc = "Goto definition.", },
			{ "<Leader>flD", ":Telescope lsp_type_definitions<CR>",          desc = "Type definition.", },
			{ "<Leader>flr", ":Telescope lsp_references<CR>",                desc = "Goto references.", },
			{ "<Leader>fli", ":Telescope lsp_implementations<CR>",           desc = "Goto implementation.", },
			{ "<Leader>flS", ":Telescope lsp_document_symbols<CR>",          desc = "Document symbols.", },
			{ "<Leader>flw", ":Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace symbols.", },
			--: }}}
		},
		--stylua: ignore end
		--: }}}
		config = function()
			--: Main variables/functions {{{
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local themes = require("telescope.themes")
			local actions = require("telescope.actions")
			local action_layout = require("telescope.actions.layout")
			local previewers = require("telescope.previewers")
			local Job = require("plenary.job")

			local function formattedName(_, path)
				local tail = vim.fs.basename(path)
				local parent = vim.fs.dirname(path)
				if parent == "." then
					return tail
				end
				return string.format("%s\t\t%s", tail, parent)
			end

			-- Function to disable binary previewing
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
			--: }}}
			telescope.setup({
				file_ignore_patterns = { "%.git/." },
				defaults = {
					preview = false,
					prompt_prefix = "  ",
					selection_caret = "  ",
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
						n = {
							["<C-c>"] = actions.close,
							["cd"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								local dir = vim.fn.fnamemodify(selection.path, ":p:h")
								require("telescope.actions").close(prompt_bufnr)
								-- Depending on what you want put `cd`, `lcd`, `tcd`
								vim.cmd(string.format("silent cd %s", dir))
							end,
						},
						i = {
							-- ["<esc>"] = actions.close,
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
						previewer = false,
						path_display = formattedName,
						layout_config = {
							height = 0.4,
							prompt_position = "top",
							preview_cutoff = 120,
						},
					},
					buffers = {
						path_display = formattedName,
						mappings = {
							i = { ["<c-d>"] = actions.delete_buffer },
							n = { ["<c-d>"] = actions.delete_buffer },
						},
						previewer = false,
						initial_mode = "normal",
						-- theme = "dropdown",
						layout_config = {
							height = 0.4,
							width = 0.6,
							prompt_position = "top",
							preview_cutoff = 120,
						},
					},
					current_buffer_fuzzy_find = {
						previewer = true,
						layout_config = {
							prompt_position = "top",
							preview_cutoff = 120,
						},
					},
					live_grep = {
						only_sort_text = true,
						previewer = true,
					},
					grep_string = {
						only_sort_text = true,
						previewer = true,
					},
					lsp_references = {
						show_line = false,
						previewer = true,
					},
					treesitter = {
						show_line = false,
						previewer = true,
					},
					colorscheme = {
						enable_preview = true,
					},
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
							previewer = false,
							initial_mode = "normal",
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
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "noice")
			pcall(telescope.load_extension, "ui-select")
		end,
	},
}
