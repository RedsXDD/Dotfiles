-- vim:fileencoding=utf-8:foldmethod=marker

-- ---------------------------------------------------------------------------------------------- --

-- ███╗   ██╗██╗   ██╗██╗███╗   ███╗    ██╗  ██╗███████╗██╗   ██╗███╗   ███╗ █████╗ ██████╗ ███████╗
-- ████╗  ██║██║   ██║██║████╗ ████║    ██║ ██╔╝██╔════╝╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗██╔════╝
-- ██╔██╗ ██║██║   ██║██║██╔████╔██║    █████╔╝ █████╗   ╚████╔╝ ██╔████╔██║███████║██████╔╝███████╗
-- ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║    ██╔═██╗ ██╔══╝    ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ ╚════██║
-- ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║    ██║  ██╗███████╗   ██║   ██║ ╚═╝ ██║██║  ██║██║     ███████║
-- ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝    ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝

-- ---------------------------------------------------------------------------------------------- --

--[[
	-- Modes:
	"n" = normal mode.
	"v" = visual mode.
	"x" = visual block mode.
	"i" = insert mode.
	"c" = command mode.
	"t" = terminal mode.
]]

-- Require helper keymap functions from `utils.lua`
local keymaps = require("core.utils").keymaps
--: General {{{
keymaps.map("n", "<Esc>", ":noh<CR><Esc>", "Clear highlighted searches.")
keymaps.map("v", ".", ":norm .<CR>", "Perform dot commands over visual blocks.")
keymaps.map("", "j", "gj", "Remap j to gj for better movement on warped lines.")
keymaps.map("", "k", "gk", "Remap k to gk for better movement on warped lines.")

-- Replace commands:
keymaps.map("n", "<Leader>gs", ":s///g<Left><Left><Left>", "Replace string on the current line.")
keymaps.map("n", "<Leader>gS", ":%s///g<Left><Left><Left>", "Replace string on the whole file.")
keymaps.map("v", "<Leader>gs", ":s///g<Left><Left><Left>", "Replace on selected text.")
keymaps.map("v", "<Leader>gS", ":s///g<Left><Left><Left>", "Replace on selected text.")

-- Remap left/down/up/right.
keymaps.map("", "<Up>", "<C-y>", "Scroll up.")
keymaps.map("", "<Down>", "<C-e>", "Scroll down.")
keymaps.map("", "<Left>", "<S-{>", "Move to the start of previous block.")
keymaps.map("", "<Right>", "<S-}>", "Move to the end of next block.")

-- Saner behavior of n and N.
-- stylua: ignore start
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { noremap = true, silent = true, expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]",      { noremap = true, silent = true, expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]",      { noremap = true, silent = true, expr = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { noremap = true, silent = true, expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]",      { noremap = true, silent = true, expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]",      { noremap = true, silent = true, expr = true, desc = "Prev Search Result" })
-- stylua: ignore end
--: Automatically center cursor {{{
keymaps.center_map("n", "Center cursor when moving to the next match during a search.")
keymaps.center_map("N", "Center cursor when moving to the previous match during a search.")
keymaps.center_map("G", "Center cursor when moving to the last line of buffer.")
keymaps.center_map("<C-d>", "Center cursor when moving a half page down.")
keymaps.center_map("<C-u>", "Center cursor when moving a half page up.")
keymaps.center_map("<C-f>", "Center cursor when moving a page down.")
keymaps.center_map("<C-b>", "Center cursor when moving a page up.")
--: }}}
--: Move lines around with Alt + H/J/K/L {{{
keymaps.map("n", "<A-S-J>", ":m .+1<CR>==", "Move the current line down.")
keymaps.map("n", "<A-S-K>", ":m .-2<CR>==", "Move the current line up.")
keymaps.map("n", "<A-S-H>", "<<", "Move the current line to the left.")
keymaps.map("n", "<A-S-L>", ">>", "Move the current line to the right.")
keymaps.map("i", "<A-S-J>", "<Esc>:m .+1<CR>==gi", "Move the current line down in insert mode.")
keymaps.map("i", "<A-S-K>", "<Esc>:m .-2<CR>==gi", "Move the current line up in insert mode.")
keymaps.map("i", "<A-S-H>", "<Esc><<gi", "Move the current line to the left in insert mode.")
keymaps.map("i", "<A-S-L>", "<Esc>>>gi", "Move the current line to the right in insert mode.")
keymaps.map("v", "<A-S-J>", ":m '>+1<CR>gv=gv", "Move selected lines down.")
keymaps.map("v", "<A-S-K>", ":m '<-2<CR>gv=gv", "Move selected lines up.")
keymaps.map("v", "<A-S-H>", "<gv", "Move selected lines to the left.")
keymaps.map("v", "<A-S-L>", ">gv", "Move selected lines to the right.")
keymaps.map("v", "<", "<gv", "Move selected lines to the left.")
keymaps.map("v", ">", ">gv", "Move selected lines to the right.")
--: }}}
--: Auto close pairs {{{
-- Replaced by "https://github.com/windwp/nvim-autopairs".
-- map("i", [[']], "''<Left>", "")
-- map("i", [["]], '""<Left>', "")
-- map("i", '[', '[]<Left>', "")
-- map("i", '(', '()<Left>', "")
-- map("i", '{', '{}<Left>', "")
-- map("i", '<', '<><Left>', "")
-- map("i", '/*', '/**/<Left><Left>', "")
--: }}}
--: }}}
--: Terminal mappings {{{
keymaps.map("t", "<ESC><ESC>", "<C-\\><C-n>", "Enter normal mode.")
keymaps.map("t", "<C-/>", "<C-\\><C-n><CMD>bdelete!<CR>", "Close terminal.")
keymaps.map("t", "<C-_>", "<C-\\><C-n><CMD>bdelete!<CR>", "Close terminal.")
--: }}}
--: Clipboard management {{{
keymaps.map("", "<Leader>y", '"*y', "Copy to primary clipboard.")
keymaps.map("", "<Leader>p", '"*p', "Paste from primary clipboard.")
keymaps.map("", "<Leader>P", '"*P', "Paste from primary clipboard.")
--: }}}
--: Toggles {{{
keymaps.toggle_map("", "<Leader>ts", "spell", "spell checking.")
keymaps.toggle_map("", "<Leader>tw", "wrap", "line wrapping.")
keymaps.toggle_map("", "<Leader>tn", { "number", "relativenumber" }, "line numbers.")
keymaps.toggle_map("", "<Leader>tr", "relativenumber", "relative line numbers.")
keymaps.toggle_map("", "<Leader>tl", { "cursorline", "cursorcolumn" }, "Toggle cursorline/cursorcolumn.")
keymaps.toggleStr_map("", "<Leader>tc", "formatoptions", "cro", "newline auto commenting.")
--: }}}
--: Complete menu {{{
-- General completion mappings.
keymaps.pum_map({
    normal = "<Tab>",
    pum = "<C-n>",
}, "Navigate completion menu down with tab.")
keymaps.pum_map({
    normal = "<S-Tab>",
    pum = "<C-p>",
}, "Navigate completion menu up with Shift-tab.")
keymaps.pum_map({
    normal = "<C-c>",
    pum = "<C-e>",
}, "Cancel completion menu with Ctrl-c.")
keymaps.pum_map({
    key = "<C-p>",
    pum = "<C-p>",
    normal = "<C-x><C-o>",
}, "Open omni completion menu with Ctrl-p.")

--[[
	This keymap auto selects the first item of the complete menu when Ctrl-n is pressed.
	NOTE: This keymap is only set when the option `completeopt` has the option `longest` on it,
	as that option changes the behaviour of the complete menu so that it no longer auto selects the first item in the completion list.
]]
local ctrn_n_action = function()
    local action = ""
    local complete_opts = vim.opt.completeopt:get()
    local has_longest = vim.tbl_contains(complete_opts, "longest")
    local has_fuzzy = vim.tbl_contains(complete_opts, "fuzzy")

    if has_longest and has_fuzzy then
        action = [[\<lt>C-n>\<lt>C-p>]]
    elseif has_longest then
        action = [[\<lt>C-n>]]
    else
        return "<C-n>"
    end

    return [[<C-n><C-r>=pumvisible()]] .. " ? " .. '"' .. action .. '"' .. " : " .. [[""<CR>]]
end

keymaps.pum_map({
    key = "<C-n>",
    pum = "<C-n>",
    normal = ctrn_n_action(),
}, "Auto open & select first item on completion menu.")
--: }}}
--: Split management {{{
-- Create splits:
keymaps.map("", "<Leader>-", ":vsplit | enew<CR>", "Create vertical split.")
keymaps.map("", "<Leader>_", ":split | enew<CR>", "Create horizontal split.")
keymaps.map("", "<Leader>z", function() require("core.utils").maximize() end, "Maximize current window.")

-- Move across splits:
keymaps.map("", "<C-h>", "<CMD>wincmd h<CR>", "Move to the left split window.")
keymaps.map("", "<C-j>", "<CMD>wincmd j<CR>", "Move to the split window below.")
keymaps.map("", "<C-k>", "<CMD>wincmd k<CR>", "Move to the split window above.")
keymaps.map("", "<C-l>", "<CMD>wincmd l<CR>", "Move to the right split window.")

-- Resize split windows:
keymaps.map("", "<C-Left>", "<CMD>wincmd ><CR>", "Increase width of split window.")
keymaps.map("", "<C-Down>", "<CMD>wincmd -<CR>", "Decrease height of split window.")
keymaps.map("", "<C-Up>", "<CMD>wincmd +<CR>", "Increase height of split window.")
keymaps.map("", "<C-Right>", "<CMD>wincmd <<CR>", "Decrease width of split window.")

-- Move currently actively selected split to the left/bottom/top/right:
keymaps.map("", "<C-S-Left>", "<CMD>wincmd H<CR>", "Move split window to the left.")
keymaps.map("", "<C-S-Down>", "<CMD>wincmd J<CR>", "Move split window to the bottom.")
keymaps.map("", "<C-S-Up>", "<CMD>wincmd K<CR>", "Move split window to the top.")
keymaps.map("", "<C-S-Right>", "<CMD>wincmd L<CR>", "Move split window to the right.")
--: }}}
--: Tab & buffer management {{{
-- Buffer management:
keymaps.map("", "<Leader>bb", "<CMD>wincmd T<CR>", "Break split into a new tab.")
keymaps.map("", "<Leader>bc", ":badd | enew<CR>", "Open a new buffer.")
keymaps.map("", "<Leader>bC", ":tabnew | enew<CR>", "Open a new tab.")
keymaps.map("", "<Leader>x", "<CMD>bdelete %<CR>", "Close current buffer.")
keymaps.map("", "<Leader>.", ":tabn<CR>", "Move to the next tab.")
keymaps.map("", "<Leader>,", ":tabp<CR>", "Move to the previous tab.")
keymaps.map("n", "[b", "<CMD>bprev<CR>", "Buffer previous")
keymaps.map("n", "]b", "<CMD>bnext<CR>", "Buffer next")
keymaps.map("n", "[B", "<CMD>bfirst<CR>", "Buffer first")
keymaps.map("n", "]B", "<CMD>blast<CR>", "Buffer last")
keymaps.map("n", "<Leader>bb", "<CMD>e #<CR>", "Switch to previously active buffer")
--: }}}
--: File explorer {{{
keymaps.map(
    "n",
    "<Leader>gf",
    function() require("core.utils").toggle_file_explorer() end,
    "Open file explorer on CWD."
)

keymaps.map(
    "n",
    "<Leader>gF",
    function() require("core.utils").toggle_file_explorer(true) end,
    "Open file explorer on directory of current file."
)
--: }}}
--: Netrw mappings {{{
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("augroup_netrw_keymaps", { clear = true }),
    pattern = "netrw",
    callback = function()
        ---@param keys string
        ---@param func string
        ---@param desc string
        local buf_map = function(keys, func, desc)
            vim.api.nvim_buf_set_keymap(0, "n", keys, func, { noremap = true, silent = true, desc = "" .. desc })
        end

        ---@param vsplit boolean
        ---@diagnostic disable-next-line: duplicate-set-field
        function _G.netrw_split_file(vsplit)
            if type(vsplit) ~= "boolean" then error("netrw_split_file: expected boolean, got" .. type(vsplit)) end

            ---@param filepath string
            local function openFile(filepath)
                local split_method = vsplit and "vsplit " or "split "
                require("core.utils").toggle_netrw()
                vim.cmd(split_method .. filepath)
                require("core.utils").toggle_netrw()
            end

            -- https://vi.stackexchange.com/questions/34790/how-to-get-path-in-netrw
            vim.cmd([[let g:filepath=netrw#Call("NetrwTreePath", w:netrw_treetop)]])

            local filepath = vim.g.filepath
            if vim.fn.isdirectory(filepath) ~= 0 then
                vim.cmd([[let g:filename=netrw#Call('NetrwFile', netrw#Call('NetrwGetWord'))]])
                filepath = filepath .. vim.g.filename
            end

            openFile(filepath)
            vim.g.filepath = nil
        end

        buf_map("_", "v:lua netrw_split_file(false)<CR>", "Open file under cursor on a horizontal split.")
        buf_map("-", "v:lua netrw_split_file(true)<CR>", "Open file under cursor on a vertical split.")
        buf_map("o", "v:lua netrw_split_file(false)<CR>", "Open file under cursor on a horizontal split.")
        buf_map("v", "v:lua netrw_split_file(true)<CR>", "Open file under cursor on a vertical split.")

        buf_map("q", "<CMD>wincmd q<CR>", "Close netrw with q.")
        buf_map("<C-h>", "<CMD>wincmd h<CR>", "Move to the left split window.")
        buf_map("<C-j>", "<CMD>wincmd j<CR>", "Move to the split window below.")
        buf_map("<C-k>", "<CMD>wincmd k<CR>", "Move to the split window above.")
        buf_map("<C-l>", "<CMD>wincmd l<CR>", "Move to the right split window.")
        buf_map("[b", "<CMD>wincmd p | bprev | wincmd p<CR>", "Buffer backward")
        buf_map("]b", "<CMD>wincmd p | bnext | wincmd p<CR>", "Buffer forward")
        buf_map(".", "<CMD>call netrw#SetTreetop(0, netrw#Call('NetrwGetWord'))<CR>", "Buffer forward")
    end,
})
--: }}}
