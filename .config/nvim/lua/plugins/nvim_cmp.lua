-- vim:fileencoding=utf-8:foldmethod=marker

return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- Suggestions based on neovim lsp.
			"hrsh7th/cmp-buffer", -- Suggestions based on current buffer.
			"hrsh7th/cmp-path", -- Suggestions based on path(directories/files etc.).
			"hrsh7th/cmp-nvim-lua", -- Suggestions for neovim api commands.
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			{
				"L3MON4D3/LuaSnip",
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
		},
		config = function()
			local kind_icons = require("user.icons").icons.kinds
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				--: Completion options {{{
				completion = { completeopt = "menuone,longest,preview" },
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				experimental = {
					ghost_text = false,
					native_menu = false,
				},
				--: }}}
				--: Mappings {{{
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-c>"] = cmp.mapping.abort(),
					["<CR>"]  = cmp.mapping.confirm(),

					-- Better tab functionality when a completion is selected.
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				--: }}}
				--: Formatting {{{
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = function(entry, vim_item)
						-- Kind icons.
						vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							nvim_lua = "[Neovim Lua]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
						})[entry.source.name]
						return vim_item
					end,
				},
				--: }}}
				--: Completion sources {{{
				sources = cmp.config.sources({
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				--: }}}
			})
		end,
	},
}
