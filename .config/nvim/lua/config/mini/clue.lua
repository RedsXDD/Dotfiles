-- vim:fileencoding=utf-8:foldmethod=marker

local has_clue, clue = pcall(require, "mini.clue")
if not has_clue then return end

local border_style = require("core.icons").misc.border

---@param modes string|table
---@param key string
---@param postkeys string?
---@param desc string?
local function add_clue(modes, key, postkeys, desc)
    if type(modes) == "string" then
        return { mode = modes, keys = key, postkeys = postkeys, desc = desc }
    elseif type(modes) == "table" then
        local ret = {}
        for _, mode in pairs(modes) do
            table.insert(ret, { mode = mode, keys = key, postkeys = postkeys, desc = desc })
        end
        return ret
    end
end

local function plugin_clue(plugin, clues)
    if plugin and type(plugin) == "string" then
        local success, _ = pcall(require, plugin)
        if not success then
            return false
        else
            return { clues }
        end
    end
end

clue.setup({
    window = {
        delay = 300, -- Delay in ms.
        scroll_up = "<C-k>",
        scroll_down = "<C-j>",
        config = {
            anchor = "SW",
            row = "auto",
            col = "auto",
            width = "auto",
            border = border_style,
        },
    },
    triggers = {
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
        { mode = "i", keys = "<C-x>" },
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },
        { mode = "n", keys = "<C-w>" },
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
        { mode = "x", keys = "[" },
        { mode = "x", keys = "]" },
    },
    clues = {
        --: Builtin {{{
        clue.gen_clues.builtin_completion(),
        clue.gen_clues.g(),
        clue.gen_clues.marks(),
        clue.gen_clues.registers(),
        clue.gen_clues.z(),
        clue.gen_clues.windows({
            submode_move = true,
            submode_navigate = true,
            submode_resize = true,
        }),
        --: }}}
        --: Conform {{{
        plugin_clue("conform", add_clue({ "n", "x" }, "<Leader>lf", nil, "Format File.")),
        --: }}}
        --: General {{{
        add_clue({ "n", "x" }, "<Leader>b", nil, "+Buffers & Tabs."),
        add_clue({ "n", "x" }, "<Leader>t", nil, "+Toggles."),
        add_clue({ "n", "x" }, "<Leader>g", nil, "+Misc."),
        --: }}}
        --: Noice {{{
        plugin_clue("noice", add_clue("n", "<Leader>u", nil, "+Noice")),
        --: }}}
        --: Lsp {{{
        plugin_clue("lspconfig", {
            add_clue({ "n", "x" }, "<Leader>l", nil, "+Lsp"),
            add_clue({ "n", "x" }, "]d", "]", nil),
            add_clue({ "n", "x" }, "[d", "[", nil),
            add_clue({ "n", "x" }, "]D", "]", nil),
            add_clue({ "n", "x" }, "[D", "[", nil),
        }),
        --: }}}
        --: Telescope {{{
        plugin_clue("telescope", {
            { mode = "n", keys = "<Leader>f", desc = "+Telescope" },
            { mode = "n", keys = "<Leader>fg", desc = "+Grep & Git" },
            { mode = "n", keys = "<Leader>fl", desc = "+LSP" },
            { mode = "n", keys = "<Leader>fe", desc = "+Extra" },
        }),
        --: }}}
        --: Jump betwheen brackets {{{
        add_clue({ "n", "x" }, "])", nil, "Jump to next `)`"),
        add_clue({ "n", "x" }, "]]", nil, "Jump to next `]`"),
        add_clue({ "n", "x" }, "]}", nil, "Jump to next `}`"),
        add_clue({ "n", "x" }, "[(", nil, "Jump to previous `(`"),
        add_clue({ "n", "x" }, "[[", nil, "Jump to previous `[`"),
        add_clue({ "n", "x" }, "[{", nil, "Jump to previous `{`"),
        --: }}}
        --: Mini.surround {{{
        plugin_clue("mini.surround", add_clue({ "n", "x" }, "<Leader>s", nil, "+Surround")),
        --: }}}
        --: Mini.operators {{{
        plugin_clue("mini.operators", add_clue({ "n", "x" }, "<Leader>o", nil, "+Operators")),
        --: }}}
        --: Mini.splitjoin {{{
        plugin_clue("mini.splitjoin", add_clue({ "n", "x" }, "<Leader>j", nil, "+Splitjoin")),
        --: }}}
        --: Mini.pairs {{{
        plugin_clue("mini.pairs", add_clue({ "n", "x" }, "<Leader>tp", nil, "Toggle Mini.pairs.")),
        --: }}}
        --: Mini.diff {{{
        plugin_clue("mini.diff", {
            add_clue({ "n", "x" }, "<Leader>d", nil, "+MiniDiff"),
            add_clue({ "n", "x" }, "]h", "]", nil),
            add_clue({ "n", "x" }, "]H", "]", nil),
            add_clue({ "n", "x" }, "[h", "[", nil),
            add_clue({ "n", "x" }, "[H", "[", nil),
        }),
        --: }}}
        --: Mini.bracketed {{{
        plugin_clue("mini.bracketed", {
            --: Jump betwheen buffers {{{
            { mode = "n", keys = "]b", postkeys = "]" },
            { mode = "n", keys = "]B", postkeys = "]" },
            { mode = "n", keys = "[b", postkeys = "[" },
            { mode = "n", keys = "[B", postkeys = "[" },
            --: }}}
            --: Jump betwheen comments {{{
            add_clue({ "n", "x" }, "]c", "]", nil),
            add_clue({ "n", "x" }, "]C", "]", nil),
            add_clue({ "n", "x" }, "[c", "[", nil),
            add_clue({ "n", "x" }, "[C", "[", nil),
            --: }}}
            --: Jump betwheen conflicts {{{
            add_clue({ "n", "x" }, "]x", "]", nil),
            add_clue({ "n", "x" }, "]X", "]", nil),
            add_clue({ "n", "x" }, "[x", "[", nil),
            add_clue({ "n", "x" }, "[X", "[", nil),
            --: }}}
            --: Jump betwheen files {{{
            { mode = "n", keys = "]f", postkeys = "]" },
            { mode = "n", keys = "]F", postkeys = "]" },
            { mode = "n", keys = "[f", postkeys = "[" },
            { mode = "n", keys = "[F", postkeys = "[" },
            --: }}}
            --: Jump betwheen indentation {{{
            add_clue({ "n", "x" }, "]i", "]", nil),
            add_clue({ "n", "x" }, "]I", "]", nil),
            add_clue({ "n", "x" }, "[i", "[", nil),
            add_clue({ "n", "x" }, "[I", "[", nil),
            --: }}}
            --: Jump betwheen jumps from jump-list {{{
            { mode = "n", keys = "]j", postkeys = "]" },
            { mode = "n", keys = "]J", postkeys = "]" },
            { mode = "n", keys = "[j", postkeys = "[" },
            { mode = "n", keys = "[J", postkeys = "[" },
            --: }}}
            --: Jump betwheen locations from location-list {{{
            { mode = "n", keys = "]l", postkeys = "]" },
            { mode = "n", keys = "]L", postkeys = "]" },
            { mode = "n", keys = "[l", postkeys = "[" },
            { mode = "n", keys = "[L", postkeys = "[" },
            --: }}}
            --: Jump betwheen old files {{{
            { mode = "n", keys = "]o", postkeys = "]" },
            { mode = "n", keys = "]O", postkeys = "]" },
            { mode = "n", keys = "[o", postkeys = "[" },
            { mode = "n", keys = "[O", postkeys = "[" },
            --: }}}
            --: Jump betwheen quickfixes from quickfix-list {{{
            { mode = "n", keys = "]q", postkeys = "]" },
            { mode = "n", keys = "]Q", postkeys = "]" },
            { mode = "n", keys = "[q", postkeys = "[" },
            { mode = "n", keys = "[Q", postkeys = "[" },
            --: }}}
            --: Jump betwheen tree-sitter node and parents {{{
            add_clue({ "n", "x" }, "]t", "]", nil),
            add_clue({ "n", "x" }, "]T", "]", nil),
            add_clue({ "n", "x" }, "[t", "[", nil),
            add_clue({ "n", "x" }, "[T", "[", nil),
            --: }}}
            --: Jump betwheen undo states {{{
            { mode = "n", keys = "]u", postkeys = "]" },
            { mode = "n", keys = "]U", postkeys = "]" },
            { mode = "n", keys = "[u", postkeys = "[" },
            { mode = "n", keys = "[U", postkeys = "[" },
            --: }}}
            --: Jump betwheen windows {{{
            { mode = "n", keys = "]w", postkeys = "]" },
            { mode = "n", keys = "]W", postkeys = "]" },
            { mode = "n", keys = "[w", postkeys = "[" },
            { mode = "n", keys = "[W", postkeys = "[" },
            --: }}}
            --: Jump betwheen yank selection replacing latest put region {{{
            { mode = "n", keys = "]y", postkeys = "]" },
            { mode = "n", keys = "]Y", postkeys = "]" },
            { mode = "n", keys = "[y", postkeys = "[" },
            { mode = "n", keys = "[Y", postkeys = "[" },
            --: }}}
        }),
        --: }}}
    },
})
