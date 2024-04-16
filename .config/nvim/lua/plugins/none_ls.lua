return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = { { "<Leader>lf", vim.lsp.buf.format, desc = "Format file." }, },
	event = "LspAttach",
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		local completion = null_ls.builtins.completion

		null_ls.setup({
			debug = false,
			sources = {
				formatting.clang_format, -- C formatting.
				formatting.stylua, -- Lua formatting.
				formatting.prettier, -- JS formatting.
				formatting.black, -- Python formatting.
				-- formatting.isort, -- Python formatting.
				-- diagnostics.eslint_d, -- JS/Typescript linter.
				diagnostics.pylint, -- Python Linter.
				completion.spell,
			},
		})
	end,
}
