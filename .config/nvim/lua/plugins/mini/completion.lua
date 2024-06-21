return {
	"echasnovski/mini.completion",
	event = "InsertEnter",
	keys = function()
		local M = {}

		local pum_map = function(actions, desc)
			if type(actions) ~= "table" then
				error("Could not find `table` for `pum_map()`.")
			end

			if actions.key == nil then
				actions.key = actions.normal
			end

			local keymap_table = {
				actions.key,
				function()
					return vim.fn.pumvisible() ~= 0 and actions.pum or actions.normal
				end,
				mode = { "i" },
				noremap = true,
				silent = true,
				expr = true,
				desc = "" .. desc,
			}

			table.insert(M, keymap_table)
		end

		pum_map({
			key = "<C-n>",
			pum = "<C-n>",
			normal = [[<C-n><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-n>\<lt>C-p>" : ""<CR>]],
		}, "Auto open & select first item on completion menu.")

		return M
	end,
	opts = {
		set_vim_settings = true,
		delay = { completion = 100, info = 100, signature = 50 },

		-- Configuration for actions window:
		window = {
			info = { height = 25, width = 80, border = require("user.icons").misc.border },
			signature = { height = 25, width = 80, border = require("user.icons").misc.border },
		},

		lsp_completion = {
			source_func = "omnifunc", -- Should be one of 'completefunc' or 'omnifunc'.
		},

		mappings = {
			force_twostep = "<C-Space>", -- Force two-step completion
			force_fallback = "<A-Space>", -- Force fallback completion
		},
	},
}
