return {
	"echasnovski/mini.animate",
	cond = function()
		if vim.g.neovide then
			return false
		end

		return true
	end,
	event = "LazyFile",
	keys = function()
		local M = {}

		local center_map = function(keys, desc)
			local keymap_table = {
				keys,
				keys .. [[<Cmd>lua require("mini.animate").execute_after("scroll", "normal! zvzz")<CR>]],
				mode = { "n", "x" },
				noremap = true,
				silent = true,
				desc = "" .. desc,
			}
			table.insert(M, keymap_table)
		end

		center_map("n",     "Center cursor when moving to the next match during a search.")
		center_map("N",     "Center cursor when moving to the previous match during a search.")
		center_map("G",     "Center cursor when moving to the last line of buffer.")
		center_map("<C-d>", "Center cursor when moving a half page down.")
		center_map("<C-u>", "Center cursor when moving a half page up.")
		center_map("<C-f>", "Center cursor when moving a page down.")
		center_map("<C-b>", "Center cursor when moving a page up.")

		return M
	end,
	opts = function()
		local animate = require("mini.animate")
		local mouse_scrolled = false -- don't use animate when scrolling with the mouse.

		for _, scroll in ipairs({ "Up", "Down" }) do
			local key = "<ScrollWheel" .. scroll .. ">"
			vim.keymap.set({ "", "i" }, key, function()
				mouse_scrolled = true
				return key
			end, { expr = true })
		end

		return {
			resize = {
				timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
			},
			scroll = {
				timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
				subscroll = animate.gen_subscroll.equal({
					predicate = function(total_scroll)
						if mouse_scrolled then
							mouse_scrolled = false
							return false
						end
						return total_scroll > 1
					end,
				}),
			},
		}
	end,
}
