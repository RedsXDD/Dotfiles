local pick = require("mini.pick")
local extra = require("mini.extra")
local border_style = require("core.icons").misc.border
local icons = require("core.icons").pick
local keymaps = require("core.utils").keymaps

-- stylua: ignore start
-- Main pickers:
keymaps.map("n", "<Leader>ff", function() pick.builtin.files() end, "Pick files.")
keymaps.map("n", "<Leader>fb", function() pick.builtin.buffers() end, "Pick buffers.")
keymaps.map("n", "<Leader>f?", function() pick.builtin.help() end, "Pick help tags.")

keymaps.map("n", "<Leader>?", function() extra.pickers.keymaps() end, "Pick keymaps.")
keymaps.map("n", "<Leader>f/", function() extra.pickers.explorer() end, "Open file explorer.")
keymaps.map("n", "<Leader>fo", function() extra.pickers.oldfiles() end, "Pick recently opened files.")
keymaps.map("n", "<Leader>fh", function() extra.pickers.history() end, "Pick command history.")

keymaps.map("n", "<Leader>fm", function() extra.pickers.marks() end, "Pick marks.")
keymaps.map("n", "<Leader>fr", function() extra.pickers.registers() end, "Pick registers.")
keymaps.map("n", "<Leader>fs", function() extra.pickers.spellsuggest() end, "Pick spell suggestions.")

keymaps.map("n", "<Leader>fq", function() extra.pickers.list({ scope = "quickfix" }) end, "Pick quickfix list.")
keymaps.map("n", "<Leader>fL", function() extra.pickers.list({ scope = "location-list" }) end, "Pick location list.")
keymaps.map("n", "<Leader>fj", function() extra.pickers.list({ scope = "jumplist" }) end, "Pick jumplist.")
keymaps.map("n", "<Leader>fc", function() extra.pickers.list({ scope = "changelist" }) end, "Pick changelist.")

keymaps.map("n", "<Leader>fB", function() extra.pickers.buf_lines() end, "Pick buffer lines.")
keymaps.map("n", "<Leader>fec", function() extra.pickers.commands() end, "Pick commands.")
keymaps.map("n", "<Leader>fep", function() extra.pickers.hipatterns() end, "Pick hipatterns.")
keymaps.map("n", "<Leader>feh", function() extra.pickers.hl_groups() end, "Pick highlight groups.")
keymaps.map("n", "<Leader>feo", function() extra.pickers.options() end, "Pick options.")
keymaps.map("n", "<Leader>fet", function() extra.pickers.treesitter() end, "Pick treesitter nodes.")

-- Grep & git:
keymaps.map("n", "<Leader>fgg", function() pick.builtin.grep() end, "Grep for files on CWD.")
keymaps.map("n", "<Leader>fgl", function() pick.builtin.grep_live() end, "Live grep for files on CWD.")
keymaps.map("n", "<Leader>fgw", function() pick.builtin.grep({ pattern = vim.fn.expand("<cWORD>") }) end, "Pick string under cursor (Current buffer).")
keymaps.map("n", "<Leader>fgb", function() extra.pickers.git_branches() end, "Pick git branches.")
keymaps.map("n", "<Leader>fgc", function() extra.pickers.git_commits() end, "Pick git commits.")
keymaps.map("n", "<Leader>fgf", function() extra.pickers.git_files() end, "Pick git files.")
keymaps.map("n", "<Leader>fgh", function() extra.pickers.git_hunks() end, "Pick git hunks.")

-- Lsp:
keymaps.map("n", "<Leader>fd", function() extra.pickers.diagnostic() end, "Pick diagnostics.")
keymaps.map("n", "<Leader>fld", function() extra.pickers.lsp({ scope = "definition" }) end, "Pick definition(s).")
keymaps.map("n", "<Leader>flD", function() extra.pickers.lsp({ scope = "declaration" }) end, "Pick declaration(s).")
keymaps.map("n", "<Leader>fls", function() extra.pickers.lsp({ scope = "document_symbol" }) end, "Pick document symbol(s).")
keymaps.map("n", "<Leader>fli", function() extra.pickers.lsp({ scope = "implementation" }) end, "Pick implementation(s).")
keymaps.map("n", "<Leader>flr", function() extra.pickers.lsp({ scope = "references" }) end, "Pick reference(s).")
keymaps.map("n", "<Leader>flt", function() extra.pickers.lsp({ scope = "type_definition" }) end, "Pick type definition(s).")
keymaps.map("n", "<Leader>flw", function() extra.pickers.lsp({ scope = "workspace_symbol" }) end, "Pick workspace symbol(s).")
-- stylua: ignore end

local win_config = function() -- Function to center mini.pick on screen.
	local height = math.floor(0.618 * vim.o.lines)
	local width = math.floor(0.618 * vim.o.columns)
	return {
		border = border_style,
		anchor = "NW",
		height = height,
		width = width,
		row = math.floor(0.5 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
	}
end

pick.setup({
	window = {
		config = win_config(),
		prompt_cursor = icons.prompt_cursor,
		prompt_prefix = icons.prompt_prefix,
	},
	options = {
		content_from_bottom = true,
		use_cache = true,
	},
	mappings = {
		move_down = "<C-j>",
		move_up = "<C-k>",
		toggle_info = "<C-i>",
		toggle_preview = "<C-p>",
	},
})
