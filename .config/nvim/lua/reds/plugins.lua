-- vim:fileencoding=utf-8:foldmethod=marker:foldenable

---@param plugin string
local function load_config(plugin)
    if type("plugin") ~= "string" then
        vim.notify("Invalid type for plugin config path. Make sure to specify it with a string", vim.log.levels.WARN)
        return
    end

    return function()
        local has_config, _ = pcall(require, "reds.config." .. plugin)
        if not has_config then return end
    end
end

local lsp_treesitter = {
    --: nvim-treesitter {{{
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "windwp/nvim-ts-autotag" },
        },
        lazy = vim.fn.argc(-1) == 0, -- Dont lazy load treesitter when opening a file from the cmdline.
        event = "LazyFile",
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        build = ":TSUpdate",
        config = load_config("treesitter"),
    },
    --: }}}
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
    --: mini.diff {{{
    {
        "echasnovski/mini.diff",
        event = "LazyFile",
        config = load_config("mini.diff"),
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
    --: mini.hipatterns {{{
    {
        "echasnovski/mini.hipatterns",
        event = "LazyFile",
        config = load_config("mini.hipatterns"),
    },
    --: }}}
    --: mini.icons {{{
    { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    {
        "echasnovski/mini.icons",
        opts = { style = (function() return vim.env.DISPLAY ~= nil and "glyph" or "ascii" end)() },
        event = "VeryLazy",
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            package.preload["nvim-web-devicons"] = function()
                -- needed since it will be false when loading and mini will fail
                package.loaded["nvim-web-devicons"] = {}
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
    --: }}}
    --: mini.jump {{{
    {
        "echasnovski/mini.jump",
        keys = { "f", "F", "t", "T" },
        config = load_config("mini.jump"),
    },
    --: }}}
    --: mini.jump2d {{{
    {
        "echasnovski/mini.jump2d",
        keys = { { "s", mode = { "n", "x", "o" }, desc = "Jump" } },
        config = load_config("mini.jump2d"),
    },
    --: }}}
    --: mini.operators {{{
    {
        "echasnovski/mini.operators",
        keys = "<Leader>o",
        config = load_config("mini.operators"),
    },
    --: }}}
    --: mini.pairs {{{
    {
        "echasnovski/mini.pairs",
        event = { "InsertEnter", "CmdlineEnter" },
        config = load_config("mini.pairs"),
    },
    --: }}}
    --: mini.snippets {{{
    { "echasnovski/mini.snippets", lazy = true, opts = {} },
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
    --: mini.tabline {{{
    {
        "echasnovski/mini.tabline",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = { "LazyFile", "BufUnload" },
        config = load_config("mini.tabline"),
    },
    --: }}}
}

local misc = {
    --: neopywal.nvim {{{
    {
        dir = os.getenv("HOME") .. "/.local/sources/Reds/neopywal",
        name = "neopywal",
        lazy = false,
        priority = 1000,
        config = load_config("neopywal"),
    },
    --: }}}
    --: snacks.nvim {{{
    {
        "folke/snacks.nvim",
        priority = 1000,
        event = "VeryLazy",
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...) Snacks.debug.inspect(...) end
                    _G.bt = function() Snacks.debug.backtrace() end
                    vim.print = _G.dd -- Override print to use snacks for `:=` command

                    local map = require("reds.utils").map

                    -- stylua: ignore start
                    -- Misc.
                    map("", "<Leader>x", function() Snacks.bufdelete() end, "Delete current buffer.")
                    map("", "<Leader>gr", function() Snacks.rename.rename_file() end, "Rename current file.")
                    map("n", "<Leader>gN", function() Snacks.win({ file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1], width = 0.6, height = 0.6, wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3, }, }) end, "Look at Neovim news.")

                    -- Git.
                    map("", "<Leader>gg", function() Snacks.lazygit() end, "Open lazygit.")
                    map("", "<Leader>gl", function() Snacks.lazygit.log() end, "Open lazygit log (CWD).")
                    map("", "<Leader>gL", function() Snacks.lazygit.log_file() end, "Lazygit current file history.")
                    map({ "n", "v" }, "<Leader>gb", function() Snacks.gitbrowse() end, "Open gitbrowse.")
                    map("", "<Leader>ga", function() Snacks.git.blame_line() end, "Git blame line.")

                    -- Scratch buffer.
                    map("", "<Leader>e", function() Snacks.scratch() end, "Toggle scratch buffer.")
                    map("", "<Leader>E", function() Snacks.scratch.select() end, "Select scratch buffer.")

                    -- Notifier.
                    map("", "<Leader>gh", function() Snacks.notifier.show_history() end, "Show notification history.")
                    map("", "<Leader>gn", function() Snacks.notifier.hide() end, "Dismiss all notifications")

                    -- Terminal.
                    map("", "<C-/>", function() Snacks.terminal.toggle() end, "Toggle terminal.")
                    map("", "<C-_>", function() Snacks.terminal.toggle() end, "Toggle terminal.")
                    map("t", "<A-;>", function() Snacks.terminal.open() end, "Open a new terminal window.")

                    -- Lsp.
                    map({ "n", "t" }, "<Leader>[", function() Snacks.words.jump(-vim.v.count1) end, "Previous word reference.")
                    map({ "n", "t" },"<Leader>]", function() Snacks.words.jump(vim.v.count1) end, "Next word reference.")

                    -- Toggle mappings.
                    map("", "<Leader>z", function() Snacks.zen.zoom() end, "Toggle Zoom.")
                    map("", "<Leader>Z", function() Snacks.zen() end, "Toggle Zenmode.")
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<Leader>ts")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<Leader>tw")
                    Snacks.toggle.line_number():map("<Leader>tl")
                    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<Leader>tL")
                    Snacks.toggle.diagnostics():map("<Leader>td")
                    Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<Leader>tc")
                    Snacks.toggle.treesitter():map("<Leader>tt")
                    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<Leader>tb")
                    Snacks.toggle.inlay_hints():map("<Leader>th")
                    Snacks.toggle.indent():map("<Leader>ti")
                    Snacks.toggle.dim():map("<Leader>tD")
                    -- stylua: ignore end
                end,
            })
        end,
        config = load_config("snacks"),
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
                cond = function() return vim.fn.executable("make") == 1 end,
            },
        },
        branch = "master",
        cmd = "Telescope",
        config = load_config("telescope"),
    },
    --: }}}
    --: dressing.nvim {{{
    {
        "stevearc/dressing.nvim",
        event = "LazyFile",
        -- Snacks.nvim input precedence.
        opts = { input = { enabled = false } },
    },
    --: }}}
    --: noice.nvim {{{
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "folke/snacks.nvim",
        },
        event = function() return { "CmdlineEnter", "LazyFile" } end,
        config = load_config("noice"),
    },
    -- --: }}}
    --: barbecue.nvim {{{
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        event = "LazyFile",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        config = function()
            local neopywal_barbecue = require("neopywal.theme.plugins.barbecue")
            if neopywal_barbecue then neopywal_barbecue.setup({ dim_background = true }) end

            require("barbecue").setup({
                theme = "neopywal",
            })
        end,
    },
    --: }}}
    --: lualine.nvim {{{
    { "echasnovski/mini.statusline", enabled = false },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = { "LazyFile", "BufUnload" },
        config = load_config("lualine"),
    },
    --: }}}
    --: blink.cmp {{{
    {
        "saghen/blink.cmp",
        dependencies = { "echasnovski/mini.snippets", "rafamadriz/friendly-snippets" },
        event = "InsertEnter",
        build = "cargo build --release",
        config = load_config("blink"),
        -- opts_extend = { "sources.default" },
    },
    --: }}}
}

return { lsp_treesitter, mini, misc }
