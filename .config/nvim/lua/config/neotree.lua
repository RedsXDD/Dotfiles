local has_neotree, neotree = pcall(require, "neo-tree")
if not has_neotree then return end

local icons = require("core.icons")
neotree.setup({
    close_if_last_window = true,
    popup_border_style = icons.misc.border,
    default_component_configs = {
        indent = {
            with_markers = true,
            indent_marker = icons.misc.indent,
            last_indent_marker = icons.misc.indent_left,
            highlight = "NeoTreeIndentMarker",
            expander_collapsed = icons.neotree.expander_collapsed,
            expander_expanded = icons.neotree.expander_expanded,
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = icons.neotree.folder_closed,
            folder_open = icons.neotree.folder_open,
            folder_empty = icons.neotree.folder_empty,
        },
        git_status = {
            symbols = {
                added = icons.neotree.git.added,
                modified = icons.neotree.git.modified,
                deleted = icons.neotree.git.deleted,
                renamed = icons.neotree.git.renamed,
                untracked = icons.neotree.git.untracked,
                ignored = icons.neotree.git.ignored,
                unstaged = icons.neotree.git.unstaged,
                staged = icons.neotree.git.staged,
                conflict = icons.neotree.git.conflict,
            },
        },
    },
    window = {
        position = "left",
        width = 30,
        mappings = {
            ["l"] = "open",
            ["L"] = "focus_preview",
            ["_"] = "open_split",
            ["-"] = "open_vsplit",
        },
    },
    filesystem = {
        filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
        },
        hijack_netrw_behavior = "open_current",
        window = {
            mappings = {
                ["z"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                ["zc"] = { "order_by_created", nowait = false },
                ["zd"] = { "order_by_diagnostics", nowait = false },
                ["zm"] = { "order_by_modified", nowait = false },
                ["zn"] = { "order_by_name", nowait = false },
                ["zs"] = { "order_by_size", nowait = false },
                ["zt"] = { "order_by_type", nowait = false },
            },
        },
    },
    buffers = {
        window = {
            mappings = {
                ["z"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                ["zc"] = { "order_by_created", nowait = false },
                ["zd"] = { "order_by_diagnostics", nowait = false },
                ["zm"] = { "order_by_modified", nowait = false },
                ["zn"] = { "order_by_name", nowait = false },
                ["zs"] = { "order_by_size", nowait = false },
                ["zt"] = { "order_by_type", nowait = false },
            },
        },
    },
    git_status = {
        window = {
            mappings = {
                ["z"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                ["zc"] = { "order_by_created", nowait = false },
                ["zd"] = { "order_by_diagnostics", nowait = false },
                ["zm"] = { "order_by_modified", nowait = false },
                ["zn"] = { "order_by_name", nowait = false },
                ["zs"] = { "order_by_size", nowait = false },
                ["zt"] = { "order_by_type", nowait = false },
            },
        },
    },
})
