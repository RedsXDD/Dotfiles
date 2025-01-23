local has_blink, blink = pcall(require, "blink.cmp")
if not has_blink then return end

blink.setup({
    keymap = {
        preset = "none",
        ["<C-n>"] = { "show", "snippet_forward", "select_next" },
        ["<C-p>"] = { "show", "snippet_backward", "select_prev" },

        ["<C-j>"] = { "show", "select_next", "fallback" },
        ["<C-k>"] = { "show", "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },

        ["<C-space>"] = { "show", "show_documentation", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<C-e>"] = { "hide", "fallback" },
        ["<C-y>"] = { "select_and_accept", "fallback" },
    },
    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
        kind_icons = require("reds.icons").kinds,
    },
    sources = {
        default = { "lsp", "snippets", "path", "buffer" },
    },
    signature = {
        enabled = true,
    },
    snippets = { preset = "mini_snippets" },
    completion = {
        trigger = { prefetch_on_insert = true },
        accept = {
            auto_brackets = {
                enabled = true,
            },
        },
        menu = {
            max_height = 15,
            auto_show = true,
            draw = {
                padding = 0,
                treesitter = { "lsp" },
                columns = { { "kind_icon" }, { "label", "label_description" } },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 50,
            update_delay_ms = 200,
        },
        ghost_text = {
            enabled = true,
        },
    },
})
