-- vim:fileencoding=utf-8:foldmethod=marker

---@param plugin string
local function load_config(plugin)
	if type("plugin") ~= "string" then
		vim.notify("Invalid type for plugin config path. Make sure to specify it with a string", vim.log.levels.WARN)
		return
	end

	local has_config, _ = pcall(require, "config." .. plugin)
	if not has_config then
		return
	end
end

---@param keys string
---@param func string|function
---@param desc string
---@param opts table?
local function map(modes, keys, func, desc, opts)
	local mapping = { keys, func, mode = modes, desc = "" .. desc }

	opts = opts or { noremap = true }
	for k, v in pairs(opts) do
		mapping[k] = v
	end

	return mapping
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
		config = function()
			load_config("neopywal")
		end,
	},
	--: }}}
}

local main = {
	--: lualine.nvim {{{
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "LazyFile", "BufUnload" },
		config = function()
			load_config("lualine")
		end,
	},
	--: }}}
	--: conform.nvim {{{
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		lazy = true,
		cmd = "ConformInfo",
		keys = {
			{
				"<Leader>lf",
				function()
					require("conform").format()
				end,
				mode = { "n", "v" },
				desc = "Format file.",
			},
		},
		config = function()
			load_config("conform")
		end,
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
		keys = {
			{ "<C-Space>", desc = "Increment Selection" },
			{ "<BS>", desc = "Decrement Selection", mode = "x" },
		},
		build = ":TSUpdate",
		config = function()
			load_config("treesitter")
		end,
	},
	--: }}}
	--: dressing.nvim {{{
	{
		"stevearc/dressing.nvim",
		event = "LazyFile",
		opts = {},
	},
	--: }}}
	--: FTerm.nvim {{{
	{
		"numToStr/FTerm.nvim",
		keys = function()
			local fterm = require("FTerm")

			return {
				-- stylua: ignore
				map("", "<Leader>gt", function() fterm.toggle() end, "Open a floating terminal."),
				map("", "<Leader>gg", function()
					local use_lazygit = true
					local git_integration = fterm:new({
						ft = use_lazygit and "fterm_lazygit" or "fterm_gitui",
						cmd = use_lazygit and "lazygit" or { "gg", "-d", vim.api.nvim_buf_get_name(0) }, -- Uses custom gitui script that fixes ssh.
						blend = 0,
						dimensions = {
							height = 0.9,
							width = 0.9,
						},
					})
					git_integration:toggle()
				end, "Open git integration."),
			}
		end,
		config = function()
			load_config("fterm")
		end,
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
		keys = function()
			local noice = require("noice")
			local noice_lsp = require("noice.lsp")

			return {
				-- stylua: ignore start
				map("c", "<S-Enter>", function() noice.redirect(vim.fn.getcmdline()) end, "Redirect Cmdline"),
				map("n", "<Leader>gnl", function() noice.cmd("last") end, "Noice Last Message"),
				map("n", "<Leader>gnh", function() noice.cmd("history") end, "Noice History"),
				map("n", "<Leader>gna", function() noice.cmd("all") end, "Noice All"),
				map("n", "<Leader>gnd", function() noice.cmd("dismiss")  end, "Dismiss All"),
				-- stylua: ignore end

				map({ "n", "i", "s" }, "<C-f>", function()
					if not noice_lsp.scroll(4) then
						return "<C-f>"
					end
				end, "Scroll Forward", { noremap = true, silent = true, expr = true }),

				map({ "n", "i", "s" }, "<C-b>", function()
					if not noice_lsp.scroll(-4) then
						return "<C-b>"
					end
				end, "Scroll Backward", { noremap = true, silent = true, expr = true }),
			}
		end,
		config = function()
			load_config("noice")
		end,
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
		event = "LazyFile",
		keys = {
			{ "<Leader>gm", "<CMD>Mason<CR>", desc = "Open Mason UI." },
		},
		cmd = "Mason",
		build = ":MasonUpdate",
		config = function()
			load_config("mason")
		end,
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
		config = function()
			load_config("lsp_config")
		end,
	},
	--: }}}
	--: nvim-lint {{{
	{
		"mfussenegger/nvim-lint",
		event = "LazyFile",
		config = function()
			load_config("nvim_lint")
		end,
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
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		config = function()
			load_config("mini.ai")
		end,
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
		config = function()
			load_config("mini.clue")
		end,
	},
	--: }}}
	--: mini.starter {{{
	{
		"echasnovski/mini.starter",
		event = "VimEnter",
		config = function()
			load_config("mini.starter")
		end,
	},
	--: }}}
	--: mini.completion {{{
	{
		"echasnovski/mini.completion",
		event = "InsertEnter",
		keys = function()
			return {
				-- stylua: ignore
				map("i", "<C-n>", function()
						return vim.fn.pumvisible() ~= 0 and "<C-n>" or [[<C-n><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-n>\<lt>C-p>" : ""<CR>]]
				end, "Auto open & select first item on completion menu.", { noremap = true, silent = true, expr = true }),
			}
		end,
		config = function()
			load_config("mini.completion")
		end,
	},
	--: }}}
	--: mini.tabline {{{
	{
		"echasnovski/mini.tabline",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "LazyFile", "BufUnload" },
		config = function()
			load_config("mini.tabline")
		end,
	},
	--: }}}
	--: mini.pick {{{
	{
		"echasnovski/mini.pick",
		dependencies = { "echasnovski/mini.extra", opts = {} },
		cmd = "Pick",
		keys = function()
			local pick = require("mini.pick").builtin
			local extra = require("mini.extra").pickers

			return {
				-- stylua: ignore start
				-- Main pickers
				map("n", "<Leader>ff", function() pick.files() end, "Pick files."),
				map("n", "<Leader>fb", function() pick.buffers() end, "Pick buffers."),
				map("n", "<Leader>f?", function() pick.help() end, "Pick help tags."),

				map("n", "<Leader>?", function() extra.keymaps() end, "Pick keymaps."),
				map("n", "<Leader>f/", function() extra.explorer() end, "Open file explorer."),
				map("n", "<Leader>fo", function() extra.oldfiles() end, "Pick recently opened files."),
				map("n", "<Leader>fh", function() extra.history() end, "Pick command history."),

				map("n", "<Leader>fm", function() extra.marks() end, "Pick marks."),
				map("n", "<Leader>fr", function() extra.registers() end, "Pick registers."),
				map("n", "<Leader>fs", function() extra.spellsuggest() end, "Pick spell suggestions."),

				map("n", "<Leader>fq", function() extra.list({ scope = "quickfix" }) end, "Pick quickfix list."),
				map("n", "<Leader>fL", function() extra.list({ scope = "location-list" }) end, "Pick location list."),
				map("n", "<Leader>fj", function() extra.list({ scope = "jumplist" }) end, "Pick jumplist."),
				map("n", "<Leader>fc", function() extra.list({ scope = "changelist" }) end, "Pick changelist."),

				map("n", "<Leader>fB", function() extra.buf_lines() end, "Pick buffer lines."),
				map("n", "<Leader>fec", function() extra.commands() end, "Pick commands."),
				map("n", "<Leader>fep", function() extra.hipatterns() end, "Pick hipatterns."),
				map("n", "<Leader>feh", function() extra.hl_groups() end, "Pick highlight groups."),
				map("n", "<Leader>feo", function() extra.options() end, "Pick options."),
				map("n", "<Leader>fet", function() extra.treesitter() end, "Pick treesitter nodes."),

				-- Grep & git,
				map("n", "<Leader>fgg", function() pick.builtin.grep() end, "Grep for files on CWD."),
				map("n", "<Leader>fgl", function() pick.builtin.grep_live() end, "Live grep for files on CWD."),
				map("n", "<Leader>fgw", function() pick.builtin.grep({ pattern = vim.fn.expand("<cWORD>") }) end, "Pick string under cursor (Current buffer)."),
				map("n", "<Leader>fgb", function() extra.git_branches() end, "Pick git branches."),
				map("n", "<Leader>fgc", function() extra.git_commits() end, "Pick git commits."),
				map("n", "<Leader>fgf", function() extra.git_files() end, "Pick git files."),
				map("n", "<Leader>fgh", function() extra.git_hunks() end, "Pick git hunks."),

				-- Lsp,
				map("n", "<Leader>fd", function() extra.diagnostic() end, "Pick diagnostics."),
				map("n", "<Leader>fld", function() extra.lsp({ scope = "definition" }) end, "Pick definition(s)."),
				map("n", "<Leader>flD", function() extra.lsp({ scope = "declaration" }) end, "Pick declaration(s)."),
				map("n", "<Leader>fls", function() extra.lsp({ scope = "document_symbol" }) end, "Pick document symbol(s)."),
				map("n", "<Leader>fli", function() extra.lsp({ scope = "implementation" }) end, "Pick implementation(s)."),
				map("n", "<Leader>flr", function() extra.lsp({ scope = "references" }) end, "Pick reference(s)."),
				map("n", "<Leader>flt", function() extra.lsp({ scope = "type_definition" }) end, "Pick type definition(s)."),
				map("n", "<Leader>flw", function() extra.lsp({ scope = "workspace_symbol" }) end, "Pick workspace symbol(s)."),
				-- stylua: ignore end
			}
		end,
		config = function()
			load_config("mini.pick")
		end,
	},
	--: }}}
	--: mini.diff {{{
	{
		"echasnovski/mini.diff",
		event = "LazyFile",
		keys = {
			{ "[h", "]h", "[H", "]H" },
			{ "<Leader>d" },
			{
				"<Leader>do",
				function()
					require("mini.diff").toggle_overlay(0)
				end,
				desc = "Toggle mini.diff overlay.",
			},
		},
		config = function()
			load_config("mini.diff")
		end,
	},
	--: }}}
	--: mini.hipatterns {{{
	{
		"echasnovski/mini.hipatterns",
		event = "LazyFile",
		config = function()
			load_config("mini.hipatterns")
		end,
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
		config = function()
			load_config("mini.indentscope")
		end,
	},
	--: }}}
	--: mini.pairs {{{
	{
		"echasnovski/mini.pairs",
		event = "CmdlineEnter",
		keys = function()
			local M = {
				map({ "n", "x" }, "<Leader>tp", function()
					local state = vim.g.minipairs_disable
					state = not state
					vim.g.minipairs_disable = state
					vim.notify(state and "Disabled " .. "mini.pairs" or "Enabled " .. "mini.pairs", vim.log.levels.INFO)
				end, "Toggle Mini.pairs."),
			}

			local lazy_load_keys = { "'", '"', "`", "´", "(", ")", "[", "]", "{", "}", "<", ">" }
			for _, key in ipairs(lazy_load_keys) do
				table.insert(M, { key, mode = { "i" } })
			end

			return M
		end,
		config = function()
			load_config("mini.pairs")
		end,
	},
	--: }}}
	--: mini.splitjoin {{{
	{
		"echasnovski/mini.splitjoin",
		keys = {
			{ "gS", desc = "Toggle splitjoining." },
		},
		config = function()
			load_config("mini.splitjoin")
		end,
	},
	--: }}}
	--: mini.surround {{{
	{
		"echasnovski/mini.surround",
		keys = {
			{ "sa", mode = { "n", "v" }, desc = "Add Surrounding." },
			{ "sd", desc = "Delete Surrounding." },
			{ "sr", desc = "Replace Surrounding." },
			{ "sf", desc = "Find Right Surrounding." },
			{ "sF", desc = "Find Left Surrounding." },
			{ "sh", desc = "Highlight Surrounding." },
			{ "sn", desc = "Update `MiniSurround.config.n_lines`." },
		},
		config = function()
			load_config("mini.surround")
		end,
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
	--: alpha-nvim {{{
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			load_config("alpha")
		end,
	},
	--: }}}
	--: nvim-autopairs {{{
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			load_config("autopairs")
		end,
	},
	--: }}}
	--: bufferline.nvim {{{
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		version = "*",
		event = "LazyFile",
		config = function()
			load_config("bufferline")
		end,
	},
	--: }}}
	--: gitsigns.nvim {{{
	{
		"lewis6991/gitsigns.nvim",
		event = "LazyFile",
		keys = {
			{ "[h", mode = { "n", "v" } },
			{ "]h", mode = { "n", "v" } },
			{ "<Leader>ghs", mode = { "n", "v" } },
			{ "<Leader>ghr", mode = { "n", "v" } },
			{ "<Leader>ghi", mode = { "o", "x" } },
			{ "<Leader>gh", mode = { "n" } },
		},
		config = function()
			load_config("gitsigns")
		end,
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
		config = function()
			load_config("neotree")
		end,
	},
	--: }}}
	--: netrw.nvim {{{
	{
		"prichrd/netrw.nvim",
		lazy = true,
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
		config = function()
			load_config("nvim_cmd")
		end,
	},
	--: }}}
	--: telescope.nvim {{{
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
		branch = "0.1.x",
		cmd = "Telescope",
		keys = function()
			local builtin = require("telescope.builtin")

			return {
				-- stylua: ignore start
				-- Main:
				map("n", "<Leader>?", function() builtin.keymaps() end, "Search keymaps."),
				map("n", "<Leader>f?", function() builtin.help_tags() end, "Search help tags."),
				map("n", "<Leader>ft", function() builtin.tags() end, "Search tags."),
				map("n", "<Leader>fT", function() builtin.current_buffer_fuzzy_find() end, "Search tags on current buffer."),
				map("n", "<Leader>fh", function() builtin.command_history() end, "Search command history."),
				map("n", "<Leader>fS", function() builtin.search_history() end, "Search search history."),
				map("n", "<Leader>fr", function() builtin.registers() end, "Search registers."),
				map("n", "<Leader>fs", function() builtin.spell_suggest() end, "Search spell suggestions."),
				map("n", "<Leader>fn", function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end, "Search Neovim configuration files."),
				map("n", "<Leader>fm", function() builtin.marks() end, "Search marks."),
				map("n", "<Leader>fM", function() builtin.man_pages() end, "Search man pages."),

				-- Lists:
				map("n", "<Leader>fq", function() builtin.quickfix() end, "Search quickfix list."),
				map("n", "<Leader>fQ", function() builtin.quickfixhistory() end, "Search quickfix list history."),
				map("n", "<Leader>fL", function() builtin.loclist() end, "Search location list."),
				map("n", "<Leader>fj", function() builtin.jumplist() end, "Search jumplist."),

				-- Buffers:
				map("n", "<Leader>fb", function() builtin.buffers() end, "Search buffers."),
				map("n", "<Leader>fB", function() builtin.current_buffer_fuzzy_find() end, "Search lines in current buffer."),

				-- File searching:
				map("n", "<Leader>ff", function() builtin.find_files({ follow = true, no_ignore = true, hidden = true }) end, "Find files on CWD (+ hidden files)."),
				map("n", "<Leader>fo", function() builtin.oldfiles() end, "Search recently opened files."),

				-- Extra
				map("n", "<Leader>feo", function() builtin.vim_options() end, "Search options."),
				map("n", "<Leader>fec", function() builtin.commands() end, "Search commands."),
				map("n", "<Leader>feC", function() builtin.colorscheme() end, "Search colorschemes."),
				map("n", "<Leader>fea", function() builtin.autocommands() end, "Search autocommands."),
				map("n", "<Leader>fet", function() builtin.filetypes() end, "Search filetypes."),
				map("n", "<Leader>feh", function() builtin.highlights() end, "Search highlight groups."),
				map("n", "<Leader>fet", function() builtin.treesitter() end, "Search treesitter nodes."),

				-- Grep & git:
				map("n", "<Leader>fgw", function() builtin.grep_string() end, "Search word under cursor."),
				map("n", "<Leader>fgl", function() builtin.live_grep() end, "Live grep for files on CWD."),
				map("n", "<Leader>fgo", function() builtin.live_grep({ grep_open_files = true, prompt_title = "Grep on open files." }) end, "Grep on open files."),
				map("n", "<Leader>fgb", function() builtin.git_branches() end, "Search git branches."),
				map("n", "<Leader>fgc", function() builtin.git_commits() end, "Search git commits."),
				map("n", "<Leader>fgf", function() builtin.git_files() end, "Search git files."),
				map("n", "<Leader>fgh", function() builtin.git_status() end, "Search git hunks."),
				map("n", "<Leader>fgs", function() builtin.git_stash() end, "Search git stash."),

				-- LSP:
				map("n", "<Leader>fd", function() builtin.diagnostics() end, "Search diagnostics."),
				map("n", "<Leader>fld", function() builtin.lsp_definitions() end, "Search definition(s)."),
				map("n", "<Leader>fls", function() builtin.lsp_document_symbols() end, "Search document symbol(s)."),
				map("n", "<Leader>fli", function() builtin.lsp_implementations() end, "Search implementation(s)."),
				map("n", "<Leader>flI", function() builtin.lsp_incoming_calls() end, "Search incoming call(s)."),
				map("n", "<Leader>flo", function() builtin.lsp_outgoing_calls() end, "Search outgoing call(s)."),
				map("n", "<Leader>flr", function() builtin.lsp_references() end, "Search reference(s)."),
				map("n", "<Leader>flt", function() builtin.lsp_type_definitions() end, "Search type definition(s)."),
				map("n", "<Leader>flw", function() builtin.lsp_workspace_symbols() end, "Search workspace symbol(s)."),
				map("n", "<Leader>flW", function() builtin.lsp_dynamic_workspace_symbols() end, "Search workspace symbol(s) dynamically."),
				-- stylua: ignore end
			}
		end,
		config = function()
			load_config("telescope")
		end,
	},
	--: }}}
	--: zen-mode.nvim {{{
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{
				"<leader>tz",
				function()
					require("zen-mode").toggle()
					vim.notify("Toggled zenmode", vim.log.levels.INFO)
				end,
				desc = "Toggle Zenmode.",
			},
		},
		config = function()
			load_config("zenmode")
		end,
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
		keys = function()
			local M = {}

			local center_map = function(keys, desc)
				local keymap_table = {
					keys,
					keys .. [[<Cmd>lua require("mini.animate").execute_after("scroll", "normal! zvzz")<CR>]],
					mode = { "n", "x" },
					noremap = true,
					silent = true,
					desc = "" .. desc,
				}
				table.insert(M, keymap_table)
			end

			center_map("n", "Center cursor when moving to the next match during a search.")
			center_map("N", "Center cursor when moving to the previous match during a search.")
			center_map("G", "Center cursor when moving to the last line of buffer.")
			center_map("<C-d>", "Center cursor when moving a half page down.")
			center_map("<C-u>", "Center cursor when moving a half page up.")
			center_map("<C-f>", "Center cursor when moving a page down.")
			center_map("<C-b>", "Center cursor when moving a page up.")

			return M
		end,
		config = function()
			load_config("mini.animate")
		end,
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
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{ "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } },
		},
		keys = {
			{ "gc", mode = { "n", "x" }, desc = "Toggle comment" },
		},
		config = function()
			load_config("mini.comment")
		end,
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
		config = function()
			load_config("mini.files")
		end,
	},
	--: }}}
	--: mini.map {{{
	{
		"echasnovski/mini.map",
		keys = function()
			local map = require("mini.map")

			return {
				-- stylua: ignore start
				map("<Leader>mf", function() map.toggle_focus() end, "Focus on MiniMap."),
				map("<Leader>ms", function() map.toggle_side() end, "Toggle MiniMap's display side."),
				map("<Leader>mr", function() map.refresh() end, "Refresh MiniMap."),
				map("<Leader>mt", function() map.toggle() end, "Toggle MiniMap."),
				-- stylua ignore end
			}
		end,
	},
	--: }}}
	--: mini.notify {{{
	{
		"echasnovski/mini.notify",
		event = "LazyFile",
		config = function()
			load_config("mini.notify")
		end,
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
