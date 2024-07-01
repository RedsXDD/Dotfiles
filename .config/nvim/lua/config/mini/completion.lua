local has_completion, completion = pcall(require, "mini.completion")
if not has_completion then
	return
end

local keymaps = require("core.utils").keymaps

keymaps.pum_map({
	key = "<C-n>",
	pum = "<C-n>",
	normal = [[<C-n><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-n>\<lt>C-p>" : ""<CR>]],
}, "Auto open & select first item on completion menu.")

completion.setup({
	set_vim_settings = true,
	delay = { completion = 100, info = 100, signature = 50 },

	-- Configuration for actions window:
	window = {
		info = { height = 25, width = 80, border = require("core.icons").misc.border },
		signature = { height = 25, width = 80, border = require("core.icons").misc.border },
	},

	lsp_completion = {
		source_func = "omnifunc", -- Should be one of 'completefunc' or 'omnifunc'.
	},

	mappings = {
		force_twostep = "<C-Space>", -- Force two-step completion
		force_fallback = "<A-Space>", -- Force fallback completion
	},
})
