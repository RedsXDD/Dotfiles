local has_dashboard, dashboard = pcall(require, "dashboard")
if not has_dashboard then
	return
end

local startpage = require("core.startpage")

local opts = {
	theme = "doom",
	hide = {
		statusline = false,
	},
	config = {
		header = startpage.dashboard.header,
		center = startpage.dashboard.sections,
		footer = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			return {
				startpage.icons.footer
					.. "Neovim loaded "
					.. stats.loaded
					.. "/"
					.. stats.count
					.. " plugins in "
					.. ms
					.. "ms",
			}
		end,
	},
}

for _, button in ipairs(opts.config.center) do
	button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
	button.key_format = "  %s"
end

-- close Lazy and re-open when the dashboard is ready
if vim.o.filetype == "lazy" then
	vim.cmd.close()
	vim.api.nvim_create_autocmd("User", {
		pattern = "DashboardLoaded",
		callback = function()
			require("lazy").show()
		end,
	})
end

dashboard.setup(opts)
