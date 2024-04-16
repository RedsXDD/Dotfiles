-- vim:fileencoding=utf-8:foldmethod=marker

return {
	"echasnovski/mini.starter",
	event = "VimEnter",
	config = function()
		--: Main variables/functions {{{
		local starter = require("mini.starter")
		local padding = string.rep(" ", 13) -- Padding to center sections and actions.

		local header = table.concat({
			[[                                                                     ]],
			[[       ████ ██████           █████      ██                     ]],
			[[      ███████████             █████                             ]],
			[[      █████████ ███████████████████ ███   ███████████   ]],
			[[     █████████  ███    █████████████ █████ ██████████████   ]],
			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
			"\n" .. padding .. [[TIP: To exit Neovim, just run $sudo rm -rf /*]]
		}, "\n")

		local footer = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			return padding .. "󱐋 Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
		end

		local new_section = function(name, action, section)
			return { name = name, action = action, section = padding .. section }
		end
		--: }}}
		--: Modified function `MiniStarter.sections.recent_files()` {{{
		--stylua: ignore start
		-- This is MiniStarter's default "recentfiles" function taken directly from the source code.
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
				local section = string.format(padding .. "Recent Files%s", -- Added the `padding ..` part compared to the original source code.
					current_dir and " (Current directory)" or "")

				-- Use only actual readable files
				local files = vim.tbl_filter(function(f) return vim.fn.filereadable(f) == 1 end, vim.v.oldfiles or {})

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
					table.insert(items, { action = "edit " .. f, name = " " .. name, section = section })
				end

				return items
			end
		end
		--stylua: ignore end
		--: }}}
		--: Modified function `MiniStarter.sections.sessions()` {{{
		--stylua: ignore start
		-- This is MiniStarter's default "sessions" function taken directly from the source code.
		-- It had to be copied over because otherwise the section padding couldn't be modified to make it aligned with all other sections from the `new_section` function.
		starter.sections.sessions_modified = function(n, recent)
			n = n or 5
			if recent == nil then recent = true end

			return function()
				local section = padding .. "Sessions" -- Added local variable with padding compared to original source code.

				if _G.MiniSessions == nil then
					return { { name = [['mini.sessions' is not set up]], action = '', section = section } }
				end

				local items = {}
				for session_name, session in pairs(_G.MiniSessions.detected) do
					table.insert(items, {
						_session = session,
						name = ('%s%s'):format(session_name, session.type == 'local' and ' (local)' or ''),
						action = ([[lua _G.MiniSessions.read('%s')]]):format(session_name),
						section = section,
					})
				end

				if vim.tbl_count(items) == 0 then
					return { { name = [[There are no detected sessions in 'mini.sessions']], action = '', section = section } }
				end

				local sort_fun
				if recent then
					sort_fun = function(a, b)
						local a_time = a._session.type == 'local' and math.huge or a._session.modify_time
						local b_time = b._session.type == 'local' and math.huge or b._session.modify_time
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
		--stylua: ignore end
		--: }}}
		--: Setup function {{{
		starter.setup({
			evaluate_single = true,
			header = header,
			footer = footer,
			content_hooks = {
				starter.gen_hook.adding_bullet(padding .. "░ ", true),
				starter.gen_hook.indexing("all", { "Actions" }), -- Use numbers to index items.
				starter.gen_hook.aligning("center", "center"),
				starter.gen_hook.padding(6, 0),
			},
			items = {
				--stylua: ignore start
				new_section(" New File",    "ene | startinsert", "Actions"),
				new_section("󰅚 Quit Neovim", "qa!",               "Actions"),
				--stylua: ignore end

				new_section("󰉋 Open File Explorer", function()
					local has_neo_tree, neo_tree = pcall(require, "neo-tree")
					local has_mini_files, mini_files = pcall(require, "mini.files")

					if has_neo_tree then
						require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
						return true
					elseif has_mini_files then
						mini_files.open(vim.uv.cwd(), true)
						return true
					else
						vim.cmd([[Lex]])
						return
					end
				end, "Actions"),

				--stylua: ignore start
				new_section("󰮊 List Buffers", [[lua require("mini.pick").builtin.buffers()]],   "Actions"),
				new_section(" Recent Files", [[lua require("mini.extra").pickers.oldfiles()]], "Actions"),
				new_section("󰱼 Find Files",   [[lua require("mini.pick").builtin.files()]],     "Actions"),
				new_section("󰈬 Live Grep",    [[lua require("mini.pick").builtin.grep_live()]], "Actions"),
				new_section("󰒲 Lazy",         "Lazy",              "Actions"),
				new_section("◍ Mason",        "Mason",             "Actions"),
				starter.sections.recent_files_modified(5, false),
				starter.sections.recent_files_modified(5, true),
				starter.sections.sessions_modified(5, true)
				--stylua: ignore end
			},
		})
		--: }}}
	end,
}
