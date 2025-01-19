-- vim:fileencoding=utf-8:foldmethod=marker:foldenable

local M = {}

--[[
	NOTE: The `set_icons` function creates a table inside M.icons with the name given from the `table_name` argument.
	The table `table_name` either:
	- Contains a set of icons for when neovim is not opened on a TTY enviroment
	- Contains a set strings of text that are TTY compatible for when neovim is opened on a TTY enviroment
--]]
local function set_icons(table_name, normal_icons, tty_icons)
    if vim.env.DISPLAY ~= nil then
        M[table_name] = normal_icons
    else
        M[table_name] = tty_icons
    end
end

--: listchars {{{
set_icons("listchars", {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
    extends = "▸",
    precedes = "◂",
}, {
    tab = "- ",
    trail = ".",
    nbsp = "_",
    extends = ">",
    precedes = "<",
})
--: }}}
--: fillchars {{{
set_icons("fillchars", {
    foldopen = "",
    foldclose = "",
    fold = "·",
    foldsep = "│",
    diff = "╱",
    eob = " ",
}, {
    foldopen = "-",
    foldclose = ">",
    fold = "-",
    foldsep = "|",
    diff = "/",
    eob = " ",
    horiz = "-",
    horizup = "-",
    horizdown = "-",
    vert = "|",
    vertleft = "|",
    vertright = "|",
    verthoriz = "+",
})
--: }}}
--: misc {{{
set_icons("misc", {
    dots = "󰇘",
    indent = "│",
    indent_left = "└",
    border = "rounded",
}, {
    dots = "...",
    indent = "|",
    indent_left = "`-",
    border = { "+", "-", "+", "|", "+", "-", "+", "|" },
})
--: }}}
--: lazy {{{
set_icons("lazy", {
    cmd = " ",
    config = "",
    event = " ",
    favorite = " ",
    ft = " ",
    init = " ",
    import = " ",
    keys = " ",
    lazy = "󰒲 ",
    loaded = "●",
    not_loaded = "○",
    plugin = " ",
    runtime = " ",
    require = "󰢱 ",
    source = " ",
    start = " ",
    task = "✔ ",
    list = {
        "●",
        "➜",
        "★",
        "‒",
    },
}, {
    cmd = "[:]",
    config = "[?]",
    event = "[$]",
    favorite = "[*]",
    ft = "[FT]",
    init = "[^]",
    import = "[<]",
    keys = "[K]",
    lazy = "zzz",
    loaded = "@",
    not_loaded = "O",
    plugin = "[]",
    runtime = "{}",
    require = "<=",
    source = "</>",
    start = "[>]",
    task = "^",
    list = {
        "@",
        ">",
        "*",
        "-",
    },
})
--: }}}
--: snacks {{{
set_icons("snacks", {
    config_files = " ",
    corner_bottom = "└",
    corner_top = "┌",
    file_explorer = "󰉋 ",
    find_files = "󰱼 ",
    footer = "󱐋 ",
    indent_horizontal = "─",
    indent_vertical = "│",
    keymaps = " ",
    lazy = "󰒲 ",
    live_grep = "󰈬 ",
    mason = " ",
    new_file = " ",
    projects = "",
    quit = "󰅚 ",
    recent_files = "󰥔 ",
    sessions = "󰍹 ",
    header = {
        [[                                                                   ]],
        [[      ████ ██████           █████      ██                    ]],
        [[     ███████████             █████                            ]],
        [[     █████████ ███████████████████ ███   ███████████  ]],
        [[    █████████  ███    █████████████ █████ ██████████████  ]],
        [[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
        [[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
        [[██████  █████████████████████ ████ █████ █████ ████ ██████]],
        [[]],
        [[            TIP: To exit Neovim, just run $sudo rm -rf /*            ]],
    },
}, {
    config_files = "C ",
    corner_bottom = "+",
    corner_top = "+",
    file_explorer = "E ",
    find_files = "F ",
    footer = "=> ",
    indent_horizontal = "-",
    indent_vertical = "|",
    keymaps = "K ",
    lazy = "L ",
    live_grep = "G ",
    mason = "M ",
    new_file = "N ",
    projects = "P ",
    quit = "Q ",
    recent_files = "R ",
    sessions = "S ",
    header = {
        [[     ___           ___           ___           ___                       ___     ]],
        [[    /\__\         /\  \         /\  \         /\__\          ___        /\__\    ]],
        [[   /::|  |       /::\  \       /::\  \       /:/  /         /\  \      /::|  |   ]],
        [[  /:|:|  |      /:/\:\  \     /:/\:\  \     /:/  /          \:\  \    /:|:|  |   ]],
        [[ /:/|:|  |__   /::\~\:\  \   /:/  \:\  \   /:/__/  ___      /::\__\  /:/|:|__|__ ]],
        [[/:/ |:| /\__\ /:/\:\ \:\__\ /:/__/ \:\__\  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\]],
        [[\/__|:|/:/  / \:\~\:\ \/__/ \:\  \ /:/  /  |:|  |/:/  / /\/:/  /    \/__/~~/:/  /]],
        [[    |:/:/  /   \:\ \:\__\    \:\  /:/  /   |:|__/:/  /  \::/__/           /:/  / ]],
        [[    |::/  /     \:\ \/__/     \:\/:/  /     \::::/__/    \:\__\          /:/  /  ]],
        [[    /:/  /       \:\__\        \::/  /       ~~~~         \/__/         /:/  /   ]],
        [[    \/__/         \/__/         \/__/                                   \/__/    ]],
        [[]],
        [[                  TIP: To exit Neovim, just run $sudo rm -rf /*                  ]],
    },
})
--: }}}
--: mini_files {{{
set_icons("mini_files", {
    directory_icon = " ",
}, {
    directory_icon = "D ",
})
--: }}}
--: dap {{{
set_icons("dap", {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
}, {
    Stopped = { "-", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = "*",
    BreakpointCondition = "?",
    BreakpointRejected = { "!", "DiagnosticError" },
    LogPoint = ".>",
})
--: }}}
--: mason {{{
set_icons("mason", {
    installed = "✓",
    pending = "➜",
    uninstalled = "✗",
}, {
    installed = "*",
    pending = ">",
    uninstalled = "X",
})
--: }}}
--: telescope {{{
set_icons("telescope", {
    prompt_prefix = "  ",
    selection_caret = " ◆ ",
}, {
    prompt_prefix = " > ",
    selection_caret = " * ",
})
--: }}}
--: pick {{{
set_icons("pick", {
    prompt_cursor = "▏",
    prompt_prefix = " ",
}, {
    prompt_cursor = "_",
    prompt_prefix = "-> ",
})
--: }}}
--: diagnostics {{{
set_icons("diagnostics", {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}, {
    Error = "E",
    Warn = "W",
    Hint = "H",
    Info = "I",
})
--: }}}
--: git {{{
set_icons("git", {
    added = " ",
    modified = " ",
    removed = " ",
}, {
    added = "[+]",
    modified = "[~]",
    removed = "[-]",
})
--: }}}
--: gitsigns {{{
set_icons("gitsigns", {
    add = "▎",
    change = "▎",
    delete = "",
    topdelete = "",
    changedelete = "",
    untracked = "▎",
}, {
    add = "+",
    change = "~",
    delete = "-",
    topdelete = "^",
    changedelete = "<",
    untracked = "?",
})
--: }}}
--: kinds {{{
set_icons("kinds", {
    Array = "  ",
    Boolean = " 󰨙 ",
    Class = "  ",
    Codeium = " 󰘦 ",
    Color = " 󰏘 ",
    Control = "  ",
    Collapsed = "  ",
    Constant = " 󰏿 ",
    Constructor = "  ",
    Copilot = "  ",
    Enum = "  ",
    EnumMember = "  ",
    Event = "  ",
    Field = "  ",
    File = " 󰈙 ",
    Folder = "  ",
    Function = " 󰊕 ",
    Interface = "  ",
    Key = "  ",
    Keyword = " 󰌋 ",
    Method = " 󰊕 ",
    Module = "  ",
    Namespace = " 󰦮 ",
    Null = "  ",
    Number = " 󰎠 ",
    Object = "  ",
    Operator = "  ",
    Package = "  ",
    Property = " 󰜢 ",
    Reference = "  ",
    Snippet = "  ",
    String = "  ",
    Struct = " 󰆼 ",
    TabNine = " 󰏚 ",
    Text = "  ",
    TypeParameter = "  ",
    Unit = " 󰑭 ",
    Value = "  ",
    Variable = " 󰀫 ",
}, {
    Array = " [ ] ",
    Boolean = " 0/1 ",
    Class = " #=# ",
    Codeium = " {.} ",
    Color = " (*) ",
    Control = " %-% ",
    Collapsed = " <<< ",
    Constant = " Phi ",
    Constructor = " [?] ",
    Copilot = " GiH ",
    Enum = " A-Z ",
    EnumMember = " A-Z ",
    Event = " >>> ",
    Field = " [:] ",
    File = " [F] ",
    Folder = " Dir ",
    Function = " Fun ",
    Interface = " *-* ",
    Key = " Abc ",
    Keyword = " <*> ",
    Method = " FuM ",
    Module = " [#] ",
    Namespace = " ]-# ",
    Null = " (0) ",
    Number = " 123 ",
    Object = " { } ",
    Operator = " +/- ",
    Package = " [#] ",
    Property = " {+} ",
    Reference = " <-> ",
    Snippet = " < > ",
    String = " Abc ",
    Struct = " [=] ",
    TabNine = " Tb9 ",
    Text = " TxT ",
    TypeParameter = " <T> ",
    Unit = " 1-9 ",
    Value = " Abc ",
    Variable = " Var ",
})
--: }}}

return M
