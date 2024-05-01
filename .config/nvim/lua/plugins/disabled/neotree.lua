return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	branch = "v3.x",
	cmd = "Neotree",
	keys = {
		{ "<Leader>gf", function() require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() }) end, desc = "Open Neotree on CWD." },
	},
	-- NOTE: The init function allows the plugin to be lazy loaded without breaking the netrw hijack functionality.
	init = function()
		vim.g.loaded_netrwPlugin = 1
		vim.g.loaded_netrw = 1

		local group_name = "augroup_neotree_netrw_hijack"
		local augroup = vim.api.nvim_create_augroup(group_name, { clear = true })

		vim.api.nvim_create_autocmd("BufEnter", {
			desc = "Auto open Neotree when loading a directory.",
			group = augroup,
			callback = function(args)
				local f = vim.fn.expand("%:p")
				if vim.fn.isdirectory(f) ~= 0 then
					require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
					vim.api.nvim_clear_autocmds({ group = group_name })
				end
			end,
		})
	end,
	opts = {
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,
		sort_case_insensitive = true,
		window = {
			mappings = {
				["l"] = "open",
				["L"] = "focus_preview",
				["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
				["_"] = "open_split",
				["-"] = "open_vsplit",
				-- ["_"] = "split_with_window_picker",
				-- ["-"] = "vsplit_with_window_picker",
				["t"] = "open_tabnew",
				-- ["<cr>"] = "open_drop",
				-- ["t"] = "open_tab_drop",
				["w"] = "open_with_window_picker",
				["h"] = "close_node",
				["C"] = "close_all_nodes",
				--["Z"] = "expand_all_nodes",
				["a"] = {
					"add",
					config = {
						show_path = "none",
					},
				},
				["A"] = "add_directory",
				["d"] = "delete",
				["r"] = "rename",
				["p"] = "paste_from_clipboard",
				["x"] = "cut_to_clipboard",
				["y"] = "copy_to_clipboard",
				["Y"] = "copy",
				["m"] = "move",
				["q"] = "close_window",
				["R"] = "refresh",
				["?"] = "show_help",
				["<"] = "prev_source",
				[">"] = "next_source",
				["i"] = "show_file_details",
			},
		},
		filesystem = {
			hijack_netrw_behavior = "open_current",
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = true,
			},
			window = {
				mappings = {
					[","] = "navigate_up",
					["H"] = "toggle_hidden",
					["."] = "set_root",
					["/"] = "fuzzy_finder",
					["#"] = "fuzzy_sorter",
					-- ["D"] = "fuzzy_sorter_directory",
					["D"] = "fuzzy_finder_directory",
					["f"] = "filter_on_submit",
					["<C-x>"] = "clear_filter",
					["[g"] = "prev_git_modified",
					["]g"] = "next_git_modified",
					["z"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["zc"] = { "order_by_created", nowait = false },
					["zd"] = { "order_by_diagnostics", nowait = false },
					["zg"] = { "order_by_git_status", nowait = false },
					["zm"] = { "order_by_modified", nowait = false },
					["zn"] = { "order_by_name", nowait = false },
					["zs"] = { "order_by_size", nowait = false },
					["zt"] = { "order_by_type", nowait = false },
				},
				fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
					["<C-k>"] = "move_cursor_up",
					["<C-j>"] = "move_cursor_down",
					["<C-n>"] = "move_cursor_down",
					["<C-p>"] = "move_cursor_up",
				},
			},
		},
		buffers = {
			window = {
				mappings = {
					["bd"] = "buffer_delete",
					["h"] = "navigate_up",
					["."] = "set_root",
					["z"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["zc"] = { "order_by_created", nowait = false },
					["zd"] = { "order_by_diagnostics", nowait = false },
					["zm"] = { "order_by_modified", nowait = false },
					["zn"] = { "order_by_name", nowait = false },
					["zs"] = { "order_by_size", nowait = false },
					["zt"] = { "order_by_type", nowait = false },
				},
			},
		},
		git_status = {
			window = {
				position = "float",
				mappings = {
					["A"] = "git_add_all",
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gg"] = "git_commit_and_push",
					["z"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["zc"] = { "order_by_created", nowait = false },
					["zd"] = { "order_by_diagnostics", nowait = false },
					["zm"] = { "order_by_modified", nowait = false },
					["zn"] = { "order_by_name", nowait = false },
					["zs"] = { "order_by_size", nowait = false },
					["zt"] = { "order_by_type", nowait = false },
				},
			},
		},
	},
}
