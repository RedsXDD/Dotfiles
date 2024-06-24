local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local padding = string.rep(" ", 13)

-- Header.
dashboard.section.header.val = {
	[[                                                                     ]],
	[[       ████ ██████           █████      ██                     ]],
	[[      ███████████             █████                             ]],
	[[      █████████ ███████████████████ ███   ███████████   ]],
	[[     █████████  ███    █████████████ █████ ██████████████   ]],
	[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
	[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
	[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
	"",
	padding .. [[TIP: To exit Neovim, just run $sudo rm -rf /*]],
}

-- Footer.
vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("autocmd_refresh_alpha", { clear = true }),
	callback = function()
		local stats = require("lazy").stats()
		local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
		dashboard.section.footer.val = "󱐋 Neovim loaded "
			.. stats.loaded
			.. "/"
			.. stats.count
			.. " plugins in "
			.. ms
			.. "ms"
		pcall(vim.cmd.AlphaRedraw)
	end,
})

-- Dashboard buttons.
dashboard.section.buttons.val = {
	dashboard.button("1", " New File", ":ene <BAR> startinsert <CR>"),
	dashboard.button("2", "󰅚 Quit Neovim", ":qa<CR>"),
	dashboard.button("3", "󰉋 Open File Explorer", function()
		require("core.utils").toggle_file_explorer()
	end),
	dashboard.button("4", "󰮊 List Buffers", [[<CMD>lua require("mini.pick").builtin.buffers()<CR>]]),
	dashboard.button("5", " Recently Files", [[<CMD>lua require("mini.extra").pickers.oldfiles()<CR>]]),
	dashboard.button("6", "󰱼 Find Files", [[<CMD>lua require("mini.pick").builtin.files()<CR>]]),
	dashboard.button("7", "󰈬 Live Grep", [[<CMD>lua require("mini.pick").builtin.grep_live()<CR>]]),
	dashboard.button("8", "󰒲 Lazy", "<CMD>Lazy<CR>"),
	dashboard.button("9", "◍ Mason", "<CMD>Mason<CR>"),
}

-- Set dashboard highlight colors.
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "AlphaFooter"

-- Main options.
dashboard.opts.layout[1].val = 8
dashboard.config.opts.margin = 0
dashboard.config.opts.noautocmd = true

alpha.setup(dashboard.config)
