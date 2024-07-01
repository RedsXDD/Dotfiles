local has_conform, conform = pcall(require, "conform")
if not has_conform then
	return
end

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})

vim.keymap.set({ "n", "v" }, "<Leader>lf", function()
	conform.format()
end, { noremap = true, desc = "Format File." })

conform.setup({
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
		rust = { "rustfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		liquid = { "prettier" },
		python = { "isort", "black" },
	},
})
