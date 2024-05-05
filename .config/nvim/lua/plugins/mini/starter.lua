-- vim:fileencoding=utf-8:foldmethod=marker

return {
	"echasnovski/mini.starter",
	event = "VimEnter",
	opts = function()
		--: Main variables {{{
		local starter = require("mini.starter")
		local padding = string.rep(" ", 13) -- Padding to center sections and actions.
		local icons = require("user.icons").icons.starter

		local actions_section = icons.sections.actions .. "Actions"
		starter.new_section = function(name, action, section)
			return { name = name, action = action, section = padding .. section }
		end
		--: }}}
		--: Header text {{{
		local header = [[]]
		if vim.env.DISPLAY ~= nil then
			header = table.concat({
				[[                                                                   ]],
				[[      ████ ██████           █████      ██                    ]],
				[[     ███████████             █████                            ]],
				[[     █████████ ███████████████████ ███   ███████████  ]],
				[[    █████████  ███    █████████████ █████ ██████████████  ]],
				[[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
				[[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
				[[██████  █████████████████████ ████ █████ █████ ████ ██████]],
			}, "\n")
		else
			header = table.concat({
				[[     ___           ___           ___           ___                       ___     ]],
				[[    /\__\         /\  \         /\  \         /\__\          ___        /\__\    ]],
				[[   /::|  |       /::\  \       /::\  \       /:/  /         /\  \      /::|  |   ]],
				[[  /:|:|  |      /:/\:\  \     /:/\:\  \     /:/  /          \:\  \    /:|:|  |   ]],
				[[ /:/|:|  |__   /::\~\:\  \   /:/  \:\  \   /:/__/  ___      /::\__\  /:/|:|__|__ ]],
				[[/:/ |:| /\__\ /:/\:\ \:\__\ /:/__/ \:\__\  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\]],
				[[\/__|:|/:/  / \:\~\:\ \/__/ \:\  \ /:/  /  |:|  |/:/  / /\/:/  /    \/__/~~/:/  /]],
				[[    |:/:/  /   \:\ \:\__\    \:\  /:/  /   |:|__/:/  /  \::/__/           /:/  / ]],
				[[    |::/  /     \:\ \/__/     \:\/:/  /     \::::/__/    \:\__\          /:/  /  ]],
				[[    /:/  /       \:\__\        \::/  /       ~~~~         \/__/         /:/  /   ]],
				[[    \/__/         \/__/         \/__/                                   \/__/    ]],
			}, "\n")
		end
		header = table.concat({ header, "\n" .. padding .. [[TIP: To exit Neovim, just run $sudo rm -rf /*]] }, "\n")
		--: }}}
		--: Footer text {{{
		local footer = (function()
			--[[
				NOTE:
					This timer is needed because, without it, the time delay displayed for the loading of neovim plugins is always 0ms,
					as the call of the require("mini.starter").refresh() function is needed in order for the right delay to be displayed on the footer.
				NOTE:
					The call to the require("mini.starter").refresh() function is only needed when opening neovim on a terminal.
			]]
			-- stylua: ignore start
			local delay = 1
			vim.wait(delay, vim.schedule_wrap(function()
				if vim.bo.filetype ~= "starter" then
					return false
				end
				pcall(starter.refresh)
			end), delay, true)
			-- stylua: ignore end

			return function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				return padding .. icons.footer .. "Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
			end
		end)()
		--: }}}
		--: starter.sections.recent_files_modified {{{
		-- stylua: ignore start
		-- This is a modified version of MiniStarter's default "recentfiles" function taken directly from the source code.
		-- It had to be copied over because otherwise the section padding couldn't be modified to make it aligned with all other sections from the `new_section` function.
		starter.sections.recent_files_modified = function(n, current_dir, show_path)
			n = n or 5
			if current_dir == nil then current_dir = false end

			if show_path == nil then show_path = true end
			if show_path == false then show_path = function() return "" end end
			if show_path == true then
				show_path = function(path) return string.format(" (%s)", vim.fn.fnamemodify(path, ":~:.")) end
			end
			if not vim.is_callable(show_path) then error("`show_path` should be boolean or callable.") end

			return function()
				local section = string.format(padding .. icons.sections.recent_files .. "Recent Files%s", -- Added text padding and icon compared to original source code.
					current_dir and " (Current directory)" or "")

				-- Use only actual readable files
				local files = vim.tbl_filter(function(f) return vim.fn.filereadable(f) == 1 end,
					vim.v.oldfiles or {})

				if #files == 0 then
					return { { name = "There are no recent files (`v:oldfiles` is empty)", action = "", section = section } }
				end

				-- Possibly filter files from current directory
				if current_dir then
					local sep = vim.loop.os_uname().sysname == "Windows_NT" and [[%\]] or "%/"
					local cwd_pattern = "^" .. vim.pesc(vim.fn.getcwd()) .. sep
					-- Use only files from current directory and its subdirectories
					files = vim.tbl_filter(function(f) return f:find(cwd_pattern) ~= nil end, files)
				end

				if #files == 0 then
					return { { name = "There are no recent files in current directory", action = "", section = section } }
				end

				-- Create items
				local items = {}
				for _, f in ipairs(vim.list_slice(files, 1, n)) do
					local name = vim.fn.fnamemodify(f, ":t") .. show_path(f)
					-- Added a nice `` icon for all itens compared to original source code.
					table.insert(items,
						{
							action = "edit " .. f,
							name = icons.recent_files .. name,
							section =
							    section
						})
				end

				return items
			end
		end
		-- stylua: ignore end
		--: }}}
		--: starter.sections.sessions_modified {{{
		-- stylua: ignore start
		-- This is modified version of MiniStarter's default "sessions" function taken directly from the source code.
		-- It had to be copied over because otherwise the section padding couldn't be modified to make it aligned with all other sections from the `new_section` function.
		starter.sections.sessions_modified = function(n, recent)
			n = n or 5
			if recent == nil then recent = true end

			return function()
				local section = padding ..
				    icons.sections.session ..
				    "Sessions" -- Added text padding and icon compared to original source code.

				if _G.MiniSessions == nil then
					return { { name = [[`mini.sessions` is not set up]], action = '', section = section } }
				end

				local items = {}
				for session_name, session in pairs(_G.MiniSessions.detected) do
					table.insert(items, {
						_session = session,
						name = ('%s%s'):format(session_name,
							session.type == 'local' and ' (local)' or ''),
						action = ([[lua _G.MiniSessions.read('%s')]]):format(session_name),
						section = section,
					})
				end

				if vim.tbl_count(items) == 0 then
					return { { name = [[There are no detected sessions in `mini.sessions`]], action = '', section = section } }
				end

				local sort_fun
				if recent then
					sort_fun = function(a, b)
						local a_time = a._session.type == 'local' and math.huge or
						    a._session.modify_time
						local b_time = b._session.type == 'local' and math.huge or
						    b._session.modify_time
						return a_time > b_time
					end
				else
					sort_fun = function(a, b)
						local a_name = a._session.type == 'local' and '' or a.name
						local b_name = b._session.type == 'local' and '' or b.name
						return a_name < b_name
					end
				end
				table.sort(items, sort_fun)

				-- Take only first `n` elements and remove helper fields
				return vim.tbl_map(function(x)
					x._session = nil
					return x
				end, vim.list_slice(items, 1, n))
			end
		end
		-- stylua: ignore end
		--: }}}
		--: Return options table {{{
		vim.o.laststatus = 0 -- Disable statusline when mini.starter opens.
		return {
			evaluate_single = true,
			header = header,
			footer = footer,
			query_updaters = "abcdefgimnopqrstuvwxyz0123456789_-.",
			content_hooks = {
				starter.gen_hook.adding_bullet(padding .. icons.bullet, false),
				starter.gen_hook.indexing("all", {}), -- Use numbers to index items.
				starter.gen_hook.aligning("center", "center"),
				starter.gen_hook.padding(6, 0),
			},
			items = {
				starter.new_section(icons.actions.new_file .. "New File", "ene | startinsert", actions_section),
				starter.new_section(icons.actions.quit .. "Quit Neovim", "qa!", actions_section),

				starter.new_section(icons.actions.file_explorer .. "Open File Explorer", function()
					local has_neotree, neo_tree = pcall(require, "neo-tree")
					local has_minifiles, mini_files = pcall(require, "mini.files")

					if has_neotree then
						require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
						return true
					elseif has_minifiles then
						mini_files.open(vim.uv.cwd(), true)
						return true
					else
						vim.cmd([[Lex]])
						return
					end
				end, actions_section),

				starter.new_section(
					icons.actions.list_buffers .. "List Buffers",
					[[lua require("lazy").load({ plugins = "mini.pick" }); require("mini.pick").builtin.buffers()]],
					actions_section
				),
				starter.new_section(
					icons.actions.recent_files .. "Recent Files",
					[[lua require("lazy").load({ plugins = "mini.pick" }); require("mini.extra").pickers.oldfiles()]],
					actions_section
				),
				starter.new_section(
					icons.actions.find_files .. "Find Files",
					[[lua require("lazy").load({ plugins = "mini.pick" }); require("mini.pick").builtin.files()]],
					actions_section
				),
				starter.new_section(
					icons.actions.live_grep .. "Live Grep",
					[[lua require("lazy").load({ plugins = "mini.pick" }); require("mini.pick").builtin.grep_live()]],
					actions_section
				),
				starter.new_section(icons.actions.lazy .. "Lazy", "Lazy", actions_section),
				starter.new_section(icons.actions.mason .. "Mason", "Mason", actions_section),
				starter.sections.recent_files_modified(5, false, false),
				starter.sections.recent_files_modified(5, true, false),
				starter.sections.sessions_modified(5, true),
			},
		}
		--: }}}
	end,
}
