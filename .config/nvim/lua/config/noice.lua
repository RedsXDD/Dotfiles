local has_noice, noice = pcall(require, "noice")
if not has_noice then
	return
end

local noice_lsp = require("noice.lsp")
local keymaps = require("core.utils").keymaps

-- stylua: ignore start
keymaps.map("c", "<S-Enter>", function() noice.redirect(vim.fn.getcmdline()) end, "Redirect Cmdline")
keymaps.map("n", "<Leader>gnl", function() noice.cmd("last") end, "Noice Last Message")
keymaps.map("n", "<Leader>gnh", function() noice.cmd("history") end, "Noice History")
keymaps.map("n", "<Leader>gna", function() noice.cmd("all") end, "Noice All")
keymaps.map("n", "<Leader>gnd", function() noice.cmd("dismiss")  end, "Dismiss All")
-- stylua: ignore end

keymaps.map({ "n", "i", "s" }, "<C-f>", function()
	if not noice_lsp.scroll(4) then
		return "<C-f>"
	end
end, "Scroll Forward", { noremap = true, silent = true, expr = true })

keymaps.map({ "n", "i", "s" }, "<C-b>", function()
	if not noice_lsp.scroll(-4) then
		return "<C-b>"
	end
end, "Scroll Backward", { noremap = true, silent = true, expr = true })

noice.setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	routes = {
		{
			filter = {
				event = "msg_show",
				any = {
					{ find = "%d+L, %d+B" },
					{ find = "; after #%d+" },
					{ find = "; before #%d+" },
				},
			},
			view = "mini",
		},
	},
	presets = {
		long_message_to_split = true,
		inc_rename = true,
	},
})
