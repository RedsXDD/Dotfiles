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
		keys = function()
			local M = {}

			local builtin = require("telescope.builtin")

			local tele_map = function(keys, func, desc)
				local keymap_table = { keys, func, mode = { "n" }, noremap = true, desc = "" .. desc }
				table.insert(M, keymap_table)
			end

			-- Misc:
			tele_map("<Leader>?", function()
				builtin.keymaps()
			end, "Search keymaps.")
			tele_map("<Leader>fr", function()
				builtin.resume()
			end, "Search resumes.")
			tele_map("<Leader>f?", function()
				builtin.help_tags()
			end, "Search help tags.")
			tele_map("<Leader>fc", function()
				builtin.command()
			end, "Search commands.")
			tele_map("<Leader>fC", function()
				builtin.colorscheme()
			end, "Search colorschemes.")
			tele_map("<Leader>fh", function()
				builtin.command_history()
			end, "Search command history.")
			tele_map("<Leader>fR", function()
				builtin.registers()
			end, "Search registers.")
			tele_map("<Leader>fs", function()
				builtin.spell_suggest()
			end, "Search spell suggestions.")
			tele_map("<Leader>fn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, "Search Neovim configuration files.")

			-- Buffers:
			tele_map("<Leader>fb", function()
				builtin.buffers()
			end, "Search buffers.")
			tele_map("<Leader>fB", function()
				builtin.current_buffer_fuzzy_find()
			end, "Fuzzily search in current buffer.")

			-- File searching:
			tele_map("<Leader>ff", function()
				builtin.find_files()
			end, "Find files on CWD.")
			tele_map("<Leader>fo", function()
				builtin.oldfiles()
			end, "Search recently opened files.")
			tele_map("<Leader>fF", function()
				builtin.find_files({ follow = true, no_ignore = true, hidden = true })
			end, "Find files (+ hidden files).")

			-- Grep:
			tele_map("<Leader>fgw", function()
				builtin.grep_string()
			end, "Search word under cursor.")
			tele_map("<Leader>fgl", function()
				builtin.live_grep()
			end, "Live grep for files on CWD.")
			tele_map("<Leader>fgo", function()
				builtin.live_grep({ grep_open_files = true, prompt_title = "Grep on open files." })
			end, "Grep on open files.")

			-- Git:
			tele_map("<Leader>fGb", function()
				builtin.git_branches()
			end, "Search git branches.")
			tele_map("<Leader>fGc", function()
				builtin.git_commits()
			end, "Search git commits.")
			tele_map("<Leader>fGC", function()
				builtin.git_bcommits()
			end, "Search git bcommits.")
			tele_map("<Leader>fGf", function()
				builtin.git_files()
			end, "Search git files.")
			tele_map("<Leader>fGh", function()
				builtin.git_stash()
			end, "Search git stash.")
			tele_map("<Leader>fGs", function()
				builtin.git_status()
			end, "Search git status.")

			-- LSP:
			tele_map("<Leader>fd", function()
				builtin.diagnostics()
			end, "Search diagnostics.")
			tele_map("<Leader>fld", function()
				builtin.lsp_definitions()
			end, "Search definition(s).")
			tele_map("<Leader>flS", function()
				builtin.lsp_document_symbols()
			end, "Search document symbol(s).")
			tele_map("<Leader>fli", function()
				builtin.lsp_implementations()
			end, "Search implementation(s).")
			tele_map("<Leader>flr", function()
				builtin.lsp_references()
			end, "Search reference(s).")
			tele_map("<Leader>flt", function()
				builtin.lsp_type_definitions()
			end, "Search type definition(s).")
			tele_map("<Leader>flw", function()
				builtin.lsp_dynamic_workspace_symbols()
			end, "Search workspace symbol(s).")

			-- Lists:
			tele_map("<Leader>fLq", function()
				builtin.quickfix()
			end, "Search quickfix list.")
			tele_map("<Leader>fLQ", function()
				builtin.quickfixhistory()
			end, "Search quickfix list history.")
			tele_map("<Leader>fLl", function()
				builtin.loclist()
			end, "Search location list.")
			tele_map("<Leader>fLj", function()
				builtin.jumplist()
			end, "Search jumplist.")

			return M
		end,
		config = function()
			-- Main variables/functions:
			local telescope = require("telescope")
			local themes = require("telescope.themes")
			local actions = require("telescope.actions")
			local action_layout = require("telescope.actions.layout")
			local previewers = require("telescope.previewers")
			local Job = require("plenary.job")
			local icons = require("user.icons").icons.telescope

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
					preview = false,
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
						initial_mode = "normal",
						-- theme = "dropdown",
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
		end,
	},
}
