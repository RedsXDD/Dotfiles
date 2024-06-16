return {
	"echasnovski/mini.pick",
	dependencies = { "echasnovski/mini.extra", opts = {} },
	cmd = "Pick",
	keys = function()
		local M = {}

		local pick = require("mini.pick").builtin
		local extra = require("mini.extra").pickers

		local pick_map = function(keys, func, desc)
			local keymap_table = { keys, func, mode = { "n" }, noremap = true, desc = "" .. desc }
			table.insert(M, keymap_table)
		end

		-- stylua: ignore start
		-- Main pickers
		pick_map("<Leader>ff", function() pick.files() end, "Pick files.")
		pick_map("<Leader>fb", function() pick.buffers() end, "Pick buffers.")
		pick_map("<Leader>f?", function() pick.help() end, "Pick help tags.")

		pick_map("<Leader>?", function() extra.keymaps() end, "Pick keymaps.")
		pick_map("<Leader>f/", function() extra.explorer() end, "Open file explorer.")
		pick_map("<Leader>fo", function() extra.oldfiles() end, "Pick recently opened files.")
		pick_map("<Leader>fh", function() extra.history() end, "Pick command history.")

		pick_map("<Leader>fm", function() extra.marks() end, "Pick marks.")
		pick_map("<Leader>fr", function() extra.registers() end, "Pick registers.")
		pick_map("<Leader>fs", function() extra.spellsuggest() end, "Pick spell suggestions.")
		pick_map("<Leader>ft", function() extra.treesitter() end, "Pick treesitter nodes.")

		pick_map("<Leader>fq", function() extra.list({ scope = "quickfix" }) end, "Pick quickfix list.")
		pick_map("<Leader>fL", function() extra.list({ scope = "location-list" }) end, "Pick location list.")
		pick_map("<Leader>fj", function() extra.list({ scope = "jumplist" }) end, "Pick jumplist.")
		pick_map("<Leader>fc", function() extra.list({ scope = "changelist" }) end, "Pick changelist.")

		pick_map("<Leader>fB", function() extra.buf_lines() end, "Pick buffer lines.")
		pick_map("<Leader>fec", function() extra.commands() end, "Pick commands.")
		pick_map("<Leader>fep", function() extra.hipatterns() end, "Pick hipatterns.")
		pick_map("<Leader>feh", function() extra.hl_groups() end, "Pick highlight groups.")
		pick_map("<Leader>feo", function() extra.options() end, "Pick options.")

		-- Grep & git
		pick_map("<Leader>fgg", function() pick.builtin.grep() end, "Grep for files on CWD.")
		pick_map("<Leader>fgl", function() pick.builtin.grep_live() end, "Live grep for files on CWD.")
		pick_map("<Leader>fgw", function() pick.builtin.grep({ pattern = vim.fn.expand("<cWORD>") }) end, "Pick string under cursor (Current buffer).")
		pick_map("<Leader>fgb", function() extra.git_branches() end, "Pick git branches.")
		pick_map("<Leader>fgc", function() extra.git_commits() end, "Pick git commits.")
		pick_map("<Leader>fgf", function() extra.git_files() end, "Pick git files.")
		pick_map("<Leader>fgh", function() extra.git_hunks() end, "Pick git hunks.")

		-- Lsp
		pick_map("<Leader>fd", function() extra.diagnostic() end, "Pick diagnostics.")
		pick_map("<Leader>fld", function() extra.lsp({ scope = "definition" }) end, "Pick definition(s).")
		pick_map("<Leader>flD", function() extra.lsp({ scope = "declaration" }) end, "Pick declaration(s).")
		pick_map("<Leader>fls", function() extra.lsp({ scope = "document_symbol" }) end, "Pick document symbol(s).")
		pick_map("<Leader>fli", function() extra.lsp({ scope = "implementation" }) end, "Pick implementation(s).")
		pick_map("<Leader>flr", function() extra.lsp({ scope = "references" }) end, "Pick reference(s).")
		pick_map("<Leader>flt", function() extra.lsp({ scope = "type_definition" }) end, "Pick type definition(s).")
		pick_map("<Leader>flw", function() extra.lsp({ scope = "workspace_symbol" }) end, "Pick workspace symbol(s).")
		-- stylua: ignore end

		return M
	end,
	opts = function()
		local border_style = require("user.icons").icons.misc.border
		local icons = require("user.icons").icons.pick

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

		return {
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
				caret_left = "<Left>",
				caret_right = "<Right>",

				choose = "<CR>",
				choose_in_split = "<C-s>",
				choose_in_vsplit = "<C-v>",
				choose_in_tabpage = "<C-t>",
				choose_marked = "<M-CR>",

				delete_char = "<BS>",
				delete_char_right = "<Del>",
				delete_left = "<C-u>",
				delete_word = "<C-w>",

				mark = "<C-x>",
				mark_all = "<C-a>",

				move_up = "<C-k>",
				move_down = "<C-j>",
				move_start = "<C-g>",

				paste = "<C-S-v>",

				refine = "<C-Space>",
				refine_marked = "<M-Space>",

				scroll_down = "<C-f>",
				scroll_up = "<C-b>",
				scroll_left = "<C-h>",
				scroll_right = "<C-l>",

				stop = "<Esc>",

				toggle_info = "<S-Tab>",
				toggle_preview = "<Tab>",
			},
		}
	end,
}
