return {
	"echasnovski/mini.map",
	keys = function()
		local M = {}

		local map = require("mini.map")

		local map_map = function(keys, func, desc)
			local keymap_table = { keys, func, mode = { "n" }, noremap = true, desc = "" .. desc }
			table.insert(M, keymap_table)
		end

		map_map("<Leader>mf", function() map.toggle_focus() end, "Focus on MiniMap.")
		map_map("<Leader>ms", function() map.toggle_side()  end, "Toggle MiniMap's display side.")
		map_map("<Leader>mr", function() map.refresh()      end, "Refresh MiniMap.")
		map_map("<Leader>mt", function() map.toggle()       end, "Toggle MiniMap.")

		return M
	end,
	opts = {},
}
