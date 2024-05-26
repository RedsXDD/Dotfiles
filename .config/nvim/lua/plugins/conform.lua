return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format()
			end,
			mode = { "n", "v" },
			desc = "Format file.",
		},
	},
	opts = function()
		local conform = require("conform")
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				conform.format({ bufnr = args.buf })
			end,
		})

		return {
			format = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
				lsp_fallback = true, -- not recommended to change
			},
			formatters_by_ft = {
				lua = { "stylua" },
				fish = { "fish_indent" },
				sh = { "shfmt" },
			},
		}
	end,
}
