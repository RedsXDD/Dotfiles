local has_dashboard, dashboard = pcall(require, "dashboard")
if not has_dashboard then
	return
end

local header = function()
	local M = ""

	for _, line in ipairs(require("core.icons").header) do
		M = M .. line .. "\n"
	end

	M = M .. "\n" .. [[TIP: To exit Neovim, just run $sudo rm -rf /*]]

	return M
end
header = string.rep("\n", 8) .. header() .. "\n\n"

---@param key string
---@param icon string
---@param desc string
---@param action string|function
local new_section = function(key, icon, desc, action)
	return { key = key, icon = icon, desc = desc, action = action }
end

local opts = {
	theme = "doom",
	hide = {
		statusline = false,
	},
	config = {
		header = vim.split(header, "\n"),
		center = {
			new_section("1", " ", "New File", "ene <BAR> startinsert "),
			new_section("2", "󰅚 ", "Quit Neovim", "qa"),
			new_section("3", "󰉋 ", "Open File Explorer", function()
				require("core.utils").toggle_file_explorer()
			end),
			new_section("4", "󰮊 ", "List Buffers", [[lua require("mini.pick").builtin.buffers()]]),
			new_section("5", " ", "Recently Files", [[lua require("mini.extra").pickers.oldfiles()]]),
			new_section("6", "󰱼 ", "Find Files", [[lua require("mini.pick").builtin.files()]]),
			new_section("7", "󰈬 ", "Live Grep", [[lua require("mini.pick").builtin.grep_live()]]),
			new_section("8", "󰒲 ", "Lazy", "Lazy"),
			new_section("9", "◍ ", "Mason", "Mason"),
		},
		footer = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			return {
				"󱐋 Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
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
