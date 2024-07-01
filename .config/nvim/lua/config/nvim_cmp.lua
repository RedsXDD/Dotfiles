local has_cmp, cmp = pcall(require, "cmp")
if not has_cmp then
	return
end

local has_luasnip, luasnip = pcall(require, "luasnip")
if not has_luasnip then
	return
end

local kind_icons = require("core.icons").kinds
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
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
		completion = {
			winhighlight = "Normal:Pmenu",
			col_offset = -3,
			side_padding = 0,
		},
		documentation = {
			border = require("core.icons").misc.border,
		},
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-c>"] = cmp.mapping.abort(),

		-- Better tab functionality when a completion is selected.
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif not pcall(cmp.mapping.complete()) then
				fallback()
			end
		end, { "i", "s" }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			elseif not pcall(cmp.mapping.complete()) then
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons.
			vim_item.kind = string.format(" %s", kind_icons[vim_item.kind])
			vim_item.menu = ({
				nvim_lsp = "(LSP)",
				nvim_lua = "(Neovim Lua)",
				luasnip = "(Snippet)",
				buffer = "(Buffer)",
				path = "(Path)",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})
