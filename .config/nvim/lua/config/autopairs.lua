local has_autopairs, autopairs = pcall(require, "nvim-autopairs")
if not has_autopairs then
	return
end

local has_cmp, cmp = pcall(require, "cmp")
if not has_cmp then
	return
end

-- Import nvim-autopairs completion functionality
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- Make autopairs and completion work together
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

autopairs.setup({
	check_ts = true, -- enable treesitter
	ts_config = {
		lua = { "string" }, -- don't add pairs in lua string treesitter nodes
		javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
		java = false, -- don't check treesitter on java
	},
})
