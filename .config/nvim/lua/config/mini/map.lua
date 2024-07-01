local has_map, map = pcall(require, "mini.map")
if not has_map then
	return
end

local keymaps = require("core.utils").keymaps

-- stylua: ignore start
keymaps.map("n", "<Leader>mf", function() map.toggle_focus() end, "Focus on map.")
keymaps.map("n", "<Leader>ms", function() map.toggle_side() end, "Toggle map's display side.")
keymaps.map("n", "<Leader>mr", function() map.refresh() end, "Refresh map.")
keymaps.map("n", "<Leader>mt", function() map.toggle() end, "Toggle map.")
-- stylua ignore end

map.setup({})
