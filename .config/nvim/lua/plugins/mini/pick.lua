return {
	"echasnovski/mini.pick",
	dependencies = { "echasnovski/mini.extra", opts = {} },
	cmd = "Pick",
	keys = function()
		local M = {}

		local pick = require("mini.pick")
		local extra = require("mini.extra")

		local pick_map = function(keys, func, desc)
			local keymap_table = { keys, func, mode = { "n" }, noremap = true, desc = "" .. desc }
			table.insert(M, keymap_table)
		end

		--stylua: ignore start
		-- Main keymaps:
		pick_map("<Leader>fb", function() pick.builtin.buffers() end, "Search buffers.")
		pick_map("<Leader>ff", function() pick.builtin.files()   end, "Find files on CWD.")
		pick_map("<Leader>fr", function() pick.builtin.resume()  end, "Search resumes.")
		pick_map("<Leader>f?", function() pick.builtin.help()    end, "Search help tags.")

		-- Extra keymaps:
		pick_map("<Leader>fc", function() extra.pickers.commands()     end, "Search commands.")
		pick_map("<Leader>f/", function() extra.pickers.explorer()     end, "Open file explorer.")
		pick_map("<Leader>fh", function() extra.pickers.history()      end, "Search command history.")
		pick_map("<Leader>?",  function() extra.pickers.keymaps()      end, "Search keymaps.")
		pick_map("<Leader>fo", function() extra.pickers.oldfiles()     end, "Search recently opened files.")
		pick_map("<Leader>fm", function() extra.pickers.marks()        end, "Search marks.")
		pick_map("<Leader>fR", function() extra.pickers.registers()    end, "Search registers.")
		pick_map("<Leader>fs", function() extra.pickers.spellsuggest() end, "Search spell suggestions.")

		-- Grep:
		pick_map("<Leader>fgg", function() pick.builtin.grep()                                       end, "Grep for files on CWD.")
		pick_map("<Leader>fgl", function() pick.builtin.grep_live()                                  end, "Live grep for files on CWD.")
		pick_map("<Leader>fgw", function() pick.builtin.grep({ pattern = vim.fn.expand("<cWORD>") }) end, "Search string under cursor (Current buffer).")

		-- Git:
		pick_map("<Leader>fGb", function() extra.pickers.git_branches() end, "Search git branches.")
		pick_map("<Leader>fGc", function() extra.pickers.git_commits()  end, "Search git commits.")
		pick_map("<Leader>fGf", function() extra.pickers.git_files()    end, "Search git files.")
		pick_map("<Leader>fGh", function() extra.pickers.git_hunks()    end, "Search git hunks.")

		-- Lsp:
		pick_map("<Leader>fd",  function() extra.pickers.diagnostic()                        end, "Search diagnostics.")
		pick_map("<Leader>fld", function() extra.pickers.lsp({ scope = "definition" })       end, "Search definition(s).")
		pick_map("<Leader>flD", function() extra.pickers.lsp({ scope = "declaration" })      end, "Search declaration(s).")
		pick_map("<Leader>flS", function() extra.pickers.lsp({ scope = "document_symbol" })  end, "Search document symbol(s).")
		pick_map("<Leader>fli", function() extra.pickers.lsp({ scope = "implementation" })   end, "Search implementation(s).")
		pick_map("<Leader>flR", function() extra.pickers.lsp({ scope = "references" })       end, "Search reference(s).")
		pick_map("<Leader>flt", function() extra.pickers.lsp({ scope = "type_definition" })  end, "Search type definition(s).")
		pick_map("<Leader>flw", function() extra.pickers.lsp({ scope = "workspace_symbol" }) end, "Search workspace symbol(s).")

		-- Lists:
		pick_map("<Leader>fLq", function() extra.pickers.list({ scope = "quickfix" })      end, "Search quickfix list.")
		pick_map("<Leader>fLl", function() extra.pickers.list({ scope = "location-list" }) end, "Search location list.")
		pick_map("<Leader>fLj", function() extra.pickers.list({ scope = "jumplist" })      end, "Search jumplist.")
		pick_map("<Leader>fLc", function() extra.pickers.list({ scope = "changelist" })    end, "Search changelist.")
		--stylua: ignore end

		return M
	end,
	opts = function()
		local win_config = function() -- Function to center mini.pick on screen.
			local height = math.floor(0.618 * vim.o.lines)
			local width = math.floor(0.618 * vim.o.columns)
			return {
				border = "rounded",
				anchor = "NW", height = height, width = width,
				row = math.floor(0.5 * (vim.o.lines - height)),
				col = math.floor(0.5 * (vim.o.columns - width)),
			}
		end

		return {
			window = {
				config = win_config(),
				prompt_cursor = "▏",
				prompt_prefix = "> ",
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
