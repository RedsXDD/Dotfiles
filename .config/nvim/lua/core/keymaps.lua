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
local map = require("core.utils").map

---@param keys string
---@param desc string
local function center_map(keys, desc)
    vim.keymap.set("", keys, keys .. "<CMD>norm! zvzz<CR>", { noremap = true, silent = true, desc = "" .. desc })
end

--: General {{{
map("n", "<Esc>", ":noh<CR><Esc>", "Clear highlighted searches.")
map("v", ".", ":norm .<CR>", "Perform dot commands over visual blocks.")
map("", "j", "gj", "Remap j to gj for better movement on warped lines.")
map("", "k", "gk", "Remap k to gk for better movement on warped lines.")

-- Replace commands:
map("n", "<Leader>gs", ":s///g<Left><Left><Left>", "Replace string on the current line.")
map("n", "<Leader>gS", ":%s///g<Left><Left><Left>", "Replace string on the whole file.")
map("v", "<Leader>gs", ":s///g<Left><Left><Left>", "Replace on selected text.")
map("v", "<Leader>gS", ":s///g<Left><Left><Left>", "Replace on selected text.")

-- Remap left/down/up/right.
map("", "<Up>", "<C-y>", "Scroll up.")
map("", "<Down>", "<C-e>", "Scroll down.")
map("", "<Left>", "<S-{>", "Move to the start of previous block.")
map("", "<Right>", "<S-}>", "Move to the end of next block.")

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
center_map("n", "Center cursor when moving to the next match during a search.")
center_map("N", "Center cursor when moving to the previous match during a search.")
center_map("G", "Center cursor when moving to the last line of buffer.")
center_map("<C-d>", "Center cursor when moving a half page down.")
center_map("<C-u>", "Center cursor when moving a half page up.")
center_map("<C-f>", "Center cursor when moving a page down.")
center_map("<C-b>", "Center cursor when moving a page up.")
--: }}}
--: Move lines around with Alt + H/J/K/L {{{
map("n", "<A-S-J>", ":m .+1<CR>==", "Move the current line down.")
map("n", "<A-S-K>", ":m .-2<CR>==", "Move the current line up.")
map("n", "<A-S-H>", "<<", "Move the current line to the left.")
map("n", "<A-S-L>", ">>", "Move the current line to the right.")
map("i", "<A-S-J>", "<Esc>:m .+1<CR>==gi", "Move the current line down in insert mode.")
map("i", "<A-S-K>", "<Esc>:m .-2<CR>==gi", "Move the current line up in insert mode.")
map("i", "<A-S-H>", "<Esc><<gi", "Move the current line to the left in insert mode.")
map("i", "<A-S-L>", "<Esc>>>gi", "Move the current line to the right in insert mode.")
map("v", "<A-S-J>", ":m '>+1<CR>gv=gv", "Move selected lines down.")
map("v", "<A-S-K>", ":m '<-2<CR>gv=gv", "Move selected lines up.")
map("v", "<A-S-H>", "<gv", "Move selected lines to the left.")
map("v", "<A-S-L>", ">gv", "Move selected lines to the right.")
map("v", "<", "<gv", "Move selected lines to the left.")
map("v", ">", ">gv", "Move selected lines to the right.")
--: }}}
--: }}}
--: Clipboard management {{{
map("", "<Leader>y", '"*y', "Copy to primary clipboard.")
map("", "<Leader>p", '"*p', "Paste from primary clipboard.")
map("", "<Leader>P", '"*P', "Paste from primary clipboard.")
--: }}}
--: Split/buffer/tab management {{{
-- Create splits.
map("", "<Leader>-", ":vsplit | enew<CR>", "Create vertical split.")
map("", "<Leader>_", ":split | enew<CR>", "Create horizontal split.")

-- Move across splits.
map("", "<C-h>", "<CMD>wincmd h<CR>", "Move to the left split window.")
map("", "<C-j>", "<CMD>wincmd j<CR>", "Move to the split window below.")
map("", "<C-k>", "<CMD>wincmd k<CR>", "Move to the split window above.")
map("", "<C-l>", "<CMD>wincmd l<CR>", "Move to the right split window.")

-- Resize split windows.
map("", "<C-Left>", "<CMD>wincmd ><CR>", "Increase width of split window.")
map("", "<C-Down>", "<CMD>wincmd -<CR>", "Decrease height of split window.")
map("", "<C-Up>", "<CMD>wincmd +<CR>", "Increase height of split window.")
map("", "<C-Right>", "<CMD>wincmd <<CR>", "Decrease width of split window.")

-- Move currently actively selected split to the left/bottom/top/right.
map("", "<C-S-Left>", "<CMD>wincmd H<CR>", "Move split window to the left.")
map("", "<C-S-Down>", "<CMD>wincmd J<CR>", "Move split window to the bottom.")
map("", "<C-S-Up>", "<CMD>wincmd K<CR>", "Move split window to the top.")
map("", "<C-S-Right>", "<CMD>wincmd L<CR>", "Move split window to the right.")

-- Buffer management.
map("", "<Leader>bb", "<CMD>wincmd T<CR>", "Break split into a new tab.")
map("", "<Leader>bc", ":badd | enew<CR>", "Open a new buffer.")
map("", "<Leader>bC", ":tabnew | enew<CR>", "Open a new tab.")

-- Move across buffers.
map("n", "[b", "<CMD>bprev<CR>", "Buffer previous")
map("n", "]b", "<CMD>bnext<CR>", "Buffer next")
map("n", "[B", "<CMD>bfirst<CR>", "Buffer first")
map("n", "]B", "<CMD>blast<CR>", "Buffer last")

-- Tab management.
map("", "<Leader>.", ":tabn<CR>", "Move to the next tab.")
map("", "<Leader>,", ":tabp<CR>", "Move to the previous tab.")
map("n", "<Leader>bb", "<CMD>e #<CR>", "Switch to previously active buffer")
--: }}}
--: File explorer {{{
-- stylua: ignore start
map("n", "<Leader>gf", function() require("core.utils").toggle_file_explorer() end, "Open file explorer on CWD.")
map("n", "<Leader>gF", function() require("core.utils").toggle_file_explorer(true) end, "Open file explorer on directory of current file.")
-- stylua: ignore end
--: }}}
