return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local padding = string.rep(" ", 13)

		dashboard.config.opts.margin = 0
		dashboard.config.opts.noautocmd = true
		vim.cmd([[autocmd User AlphaReady echo 'ready']])

		dashboard.section.header.val = {
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                     ]],
			[[       ████ ██████           █████      ██                     ]],
			[[      ███████████             █████                             ]],
			[[      █████████ ███████████████████ ███   ███████████   ]],
			[[     █████████  ███    █████████████ █████ ██████████████   ]],
			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
			'', padding .. [[TIP: To exit Neovim, just run $sudo rm -rf /*]]
		}

		dashboard.section.footer.val = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			return "󱐋 Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
		end

		local new_section = function(key, desc, action)
			return dashboard.button(key, " " .. desc, action)
		end

		dashboard.section.buttons.val = {
			new_section("1", " New File",    ":ene <BAR> startinsert <CR>"),
			new_section("2", "󰅚 Quit Neovim", ":qa<CR>"),

			new_section("3", "󰉋 Open File Explorer", function()
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
			end),

			new_section("4", "󰮊 List Buffers",   [[lua require("mini.pick").builtin.buffers()]]),
			new_section("5", " Recently Files", [[lua require("mini.extra").pickers.oldfiles()]]),
			new_section("6", "󰱼 Find Files",     [[lua require("mini.pick").builtin.files()]]),
			new_section("7", "󰈬 Live Grep",      [[lua require("mini.pick").builtin.grep_live()]]),
			new_section("8", "󰒲 Lazy",           "Lazy"),
			new_section("9", "◍ Mason",          "Mason"),
		}

		alpha.setup(dashboard.config)
	end,
}
