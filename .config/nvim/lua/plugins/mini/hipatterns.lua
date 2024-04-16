return {
	"echasnovski/mini.hipatterns",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			-- Delays (in ms) defining asynchronous highlighting process.
			delay = {
				text_change = 200, -- How much to wait for update after every text change.
				scroll = 50, -- How much to wait for update after window scroll.
			},
			highlighters = {
				-- Highlight hex color strings (`#rrggbb`) using that color
				hex_color = hipatterns.gen_highlighter.hex_color(),

				-- Highlight standalone 'BUG', 'FIX', 'FIXME', 'HACK', 'TODO', 'NOTE'
				bug = { pattern = "%f[%w]()BUG()%f[%W]", group = "MiniHipatternsFixme" },
				fix = { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
			},
		})
	end,
}
