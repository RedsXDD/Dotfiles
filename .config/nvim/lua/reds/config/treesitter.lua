local has_treesitter_configs, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not has_treesitter_configs then return end

treesitter_configs.setup({
    auto_install = true,
    ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "ron",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
    },
    indent = { enable = true },
    highlight = {
        enable = true,
        disable = { "tmux" },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<C-backspace>",
        },
    },
    textobjects = {
        select = {
            enable = false, -- Disabled to avoid conflicts with mini.ai.
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ii"] = "@conditional.inner",
                ["ai"] = "@conditional.outer",
                ["il"] = "@loop.inner",
                ["al"] = "@loop.outer",
                ["at"] = "@comment.outer",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
            -- goto_next = {
            --   [']i'] = "@conditional.inner",
            -- },
            -- goto_previous = {
            --   ['[i'] = "@conditional.inner",
            -- }
        },
        swap = {
            enable = true,
            swap_next = { ["]e"] = "@parameter.inner" },
            swap_previous = { ["[e"] = "@parameter.inner" },
        },
    },
})
