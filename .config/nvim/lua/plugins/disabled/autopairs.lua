return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	opts = {
		check_ts = true, -- enable treesitter
		ts_config = {
			lua = { "string" }, -- don't add pairs in lua string treesitter nodes
			javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
			java = false, -- don't check treesitter on java
		},
	},
	config = function(_, opts)
		require("nvim-autopairs").setup(opts)

		-- Import nvim-autopairs completion functionality
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		-- Import nvim-cmp plugin (completions plugin)
		local cmp = require("cmp")

		-- Make autopairs and completion work together
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
