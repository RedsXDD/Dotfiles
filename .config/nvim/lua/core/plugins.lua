-- vim:fileencoding=utf-8:foldmethod=marker

---@param plugin string
local function load_config(plugin)
	if type("plugin") ~= "string" then
		vim.notify("Invalid type for plugin config path. Make sure to specify it with a string", vim.log.levels.WARN)
		return
	end

	return function()
		local has_config, _ = pcall(require, "config." .. plugin)
		if not has_config then
			return
		end
	end
end

local colorschemes = {
	--: catppuccin {{{
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		priority = 1000,
		opts = {
			dim_inactive = {
				enabled = true,
			},
		},
	},
	--: }}}
	--: tokyonight {{{
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = true,
		priority = 1000,
		opts = {
			dim_inactive = true,
		},
	},
	--: }}}
	--: neopywal {{{
	{
		"RedsXDD/neopywal.nvim",
		branch = "testing",
		name = "neopywal",
		lazy = true,
		priority = 1000,
		config = load_config("neopywal"),
	},
	--: }}}
}

local main = {
	--: lualine.nvim {{{
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "LazyFile", "BufUnload" },
		config = load_config("lualine"),
	},
	--: }}}
	--: conform.nvim {{{
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		lazy = true,
		cmd = "ConformInfo",
		keys = "<Leader>lf",
		config = load_config("conform"),
	},
	--: }}}
	--: nvim-treesitter {{{
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
			{ "windwp/nvim-ts-autotag" },
		},
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		event = "LazyFile",
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		build = ":TSUpdate",
		config = load_config("treesitter"),
	},
	--: }}}
	--: dressing.nvim {{{
	{ "stevearc/dressing.nvim", event = "LazyFile" },
	--: }}}
	--: FTerm.nvim {{{
	{
		"numToStr/FTerm.nvim",
		keys = { "<Leader>gg", "<Leader>gt" },
		config = load_config("fterm"),
	},
	--: }}}
	--: noice.nvim {{{
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		event = "VeryLazy",
		config = load_config("noice"),
	},
	--: }}}
	--: nvim-cmp {{{
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
		config = load_config("nvim_cmp"),
	},
	--: }}}
	--: zen-mode.nvim {{{
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = "<Leader>tz",
		config = load_config("zenmode"),
	},
	--: }}}
}

local lsp = {
	--: mason.nvim {{{
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		cmd = "Mason",
		build = ":MasonUpdate",
		config = load_config("mason"),
	},
	--: }}}
	--: nvim-lspconfig {{{
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		event = "LazyFile",
		config = load_config("lsp_config"),
	},
	--: }}}
	--: nvim-lint {{{
	{
		"mfussenegger/nvim-lint",
		event = "LazyFile",
		config = load_config("nvim_lint"),
	},
	--: }}}
}

local mini = {
	--: mini.ai {{{
	{
		"echasnovski/mini.ai",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"echasnovski/mini.extra",
		},
		event = "LazyFile",
		config = load_config("mini.ai"),
	},
	--: }}}
	--: mini.clue {{{
	{
		"echasnovski/mini.clue",
		dependencies = {
			{ "echasnovski/mini.bracketed", opts = {} }, -- NOTE: Setting `mini.bracketed` as a dependency is needed to load it's clues correctly.
		},
		keys = {
			{ "<C-r>", mode = { "i", "c" } },
			{ "<C-x>", mode = { "i" } },
			{ "<C-w>", mode = { "n" } },
			{ "<Leader>", mode = { "n", "x" } },
			{ "g", mode = { "n", "x" } },
			{ "'", mode = { "n", "x" } },
			{ "`", mode = { "n", "x" } },
			{ '"', mode = { "n", "x" } },
			{ "z", mode = { "n", "x" } },
			{ "[", mode = { "n", "x" } },
			{ "]", mode = { "n", "x" } },
		},
		config = load_config("mini.clue"),
	},
	--: }}}
	--: mini.starter {{{
	{
		"echasnovski/mini.starter",
		-- Only load when no arguments.
		event = function()
			if vim.fn.argc() == 0 then
				return "VimEnter"
			end
		end,
		config = load_config("mini.starter"),
	},
	--: }}}
	--: mini.tabline {{{
	{
		"echasnovski/mini.tabline",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "LazyFile", "BufUnload" },
		config = load_config("mini.tabline"),
	},
	--: }}}
	--: mini.pick {{{
	{
		"echasnovski/mini.pick",
		dependencies = { "echasnovski/mini.extra", opts = {} },
		cmd = "Pick",
		config = load_config("mini.pick"),
	},
	--: }}}
	--: mini.diff {{{
	{
		"echasnovski/mini.diff",
		event = "LazyFile",
		config = load_config("mini.diff"),
	},
	--: }}}
	--: mini.hipatterns {{{
	{
		"echasnovski/mini.hipatterns",
		event = "LazyFile",
		config = load_config("mini.hipatterns"),
	},
	--: }}}
	--: mini.indentscope {{{
	{
		"echasnovski/mini.indentscope",
		event = "LazyFile",
		init = function()
			local group_name = "augroup_mini_indentscope_disable"
			local augroup = vim.api.nvim_create_augroup(group_name, { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				desc = "Auto disabled mini.indentscope when opening certain filetypes.",
				group = augroup,
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"Starter",
					"starter",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
					vim.api.nvim_clear_autocmds({ group = group_name })
				end,
			})
		end,
		config = load_config("mini.indentscope"),
	},
	--: }}}
	--: mini.pairs {{{
	{
		"echasnovski/mini.pairs",
		event = { "InsertEnter", "CmdlineEnter" },
		config = load_config("mini.pairs"),
	},
	--: }}}
	--: mini.splitjoin {{{
	{
		"echasnovski/mini.splitjoin",
		lazy = true,
		config = load_config("mini.splitjoin"),
	},
	--: }}}
	--: mini.surround {{{
	{
		"echasnovski/mini.surround",
		lazy = true,
		config = load_config("mini.surround"),
	},
	--: }}}
}

local misc = {
	--: hyprland-vim-syntax {{{
	{
		"theRealCarneiro/hyprland-vim-syntax",
		ft = "hypr",
	},
	--: }}}
	--: lf-vim {{{
	-- {
	-- 	"camnw/lf-vim",
	-- 	ft = "lf",
	-- },
	--: }}}
	--: vim-kitty {{{
	-- {
	-- 	"fladson/vim-kitty",
	-- 	ft = "kitty",
	-- },
	--: }}}
	--: rust.vim {{{
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	--: }}}
}

local disabled = {
	--: mini.completion {{{
	{
		"echasnovski/mini.completion",
		event = "InsertEnter",
		config = load_config("mini.completion"),
	},
	--: }}}
	--: alpha-nvim {{{
	{
		"goolord/alpha-nvim",
		-- Only load when no arguments.
		event = function()
			if vim.fn.argc() == 0 then
				return "VimEnter"
			end
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = load_config("alpha"),
	},
	--: }}}
	--: nvim-autopairs {{{
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = load_config("autopairs"),
	},
	--: }}}
	--: bufferline.nvim {{{
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		version = "*",
		event = "LazyFile",
		config = load_config("bufferline"),
	},
	--: }}}
	--: gitsigns.nvim {{{
	{
		"lewis6991/gitsigns.nvim",
		event = "LazyFile",
		cmd = "Gitsigns",
		config = load_config("gitsigns"),
	},
	--: }}}
	--: neo-tree.nvim {{{
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		lazy = true,
		branch = "v3.x",
		cmd = "Neotree",
		-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it, because `cwd` is not set up properly.
		init = function()
			vim.api.nvim_create_autocmd("BufEnter", {
				desc = "Start Neo-tree with directory",
				group = vim.api.nvim_create_augroup("augroup_neotree_start_directory", { clear = true }),
				once = true,
				callback = function()
					if package.loaded["neo-tree"] then
						return
					else
						---@diagnostic disable-next-line: undefined-field
						local stats = vim.uv.fs_stat(vim.fn.argv(0))
						if stats and stats.type == "directory" then
							require("neo-tree")
						end
					end
				end,
			})
		end,
		config = load_config("neotree"),
	},
	--: }}}
	--: netrw.nvim {{{
	{
		"prichrd/netrw.nvim",
		lazy = true,
	},
	--: }}}
	--: telescope.nvim {{{
	-- Disable "mini.pick":
	{ "echasnovski/mini.pick", enabled = false },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		branch = "master",
		cmd = "Telescope",
		config = load_config("telescope"),
	},
	--: }}}
	--: mini.animate {{{
	{
		"echasnovski/mini.animate",
		cond = function()
			if vim.g.neovide then
				return false
			end

			return true
		end,
		event = "LazyFile",
		config = load_config("mini.animate"),
	},
	--: }}}
	--: mini.bracketed {{{
	{
		"echasnovski/mini.bracketed",
		keys = { "[", "]" },
	},
	--: }}}
	--: mini.comment {{{
	{
		"echasnovski/mini.comment",
		-- Enabled if not on version 0.10.
		enabled = vim.fn.has("nvim-0.10.0") == 0,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{ "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } },
		},
		keys = "gc",
		config = load_config("mini.comment"),
	},
	--: }}}
	--: mini.cursorword {{{
	{
		"echasnovski/mini.cursorword",
		event = "LazyFile",
	},
	--: }}}
	--: mini.files {{{
	{
		"echasnovski/mini.files",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- FIX: use `autocmd` for lazy-loading mini.files instead of directly requiring it, because `cwd` is not set up properly.
		init = function()
			vim.g.loaded_netrwPlugin = 1
			vim.g.loaded_netrw = 1
			vim.api.nvim_create_autocmd("VimEnter", {
				desc = "Start Mini.files with directory",
				group = vim.api.nvim_create_augroup("augroup_mini_files_start_directory", { clear = true }),
				once = true,
				callback = function()
					---@diagnostic disable-next-line: undefined-field
					local stats = vim.uv.fs_stat(vim.fn.argv(0))
					if stats and stats.type == "directory" then
						require("lazy").load({ plugins = "mini.files" })
						require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
					end
				end,
			})
		end,
		config = load_config("mini.files"),
	},
	--: }}}
	--: mini.map {{{
	{
		"echasnovski/mini.map",
		keys = "<Leader>m",
		config = load_config("mini.map"),
	},
	--: }}}
	--: mini.notify {{{
	{
		"echasnovski/mini.notify",
		event = "LazyFile",
		config = load_config("mini.notify"),
	},
	--: }}}
	--: mini.sessions {{{
	{
		"echasnovski/mini.sessions",
		opts = {},
	},
	--: }}}
}

return { colorschemes, main, lsp, mini, misc }
