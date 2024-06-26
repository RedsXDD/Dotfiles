local map = require("mini.map")
local keymaps = require("core.utils").keymaps

-- stylua: ignore start
keymaps.map("n", "<Leader>mf", function() map.toggle_focus() end, "Focus on map.")
keymaps.map("n", "<Leader>ms", function() map.toggle_side() end, "Toggle map's display side.")
keymaps.map("n", "<Leader>mr", function() map.refresh() end, "Refresh map.")
keymaps.map("n", "<Leader>mt", function() map.toggle() end, "Toggle map.")
-- stylua ignore end

map.setup({})
