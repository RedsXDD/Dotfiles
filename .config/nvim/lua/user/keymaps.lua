-- vim:fileencoding=utf-8:foldmethod=marker

-- ---------------------------------------------------------------------------------------------- --

-- ███╗   ██╗██╗   ██╗██╗███╗   ███╗    ██╗  ██╗███████╗██╗   ██╗███╗   ███╗ █████╗ ██████╗ ███████╗
-- ████╗  ██║██║   ██║██║████╗ ████║    ██║ ██╔╝██╔════╝╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗██╔════╝
-- ██╔██╗ ██║██║   ██║██║██╔████╔██║    █████╔╝ █████╗   ╚████╔╝ ██╔████╔██║███████║██████╔╝███████╗
-- ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║    ██╔═██╗ ██╔══╝    ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ ╚════██║
-- ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║    ██║  ██╗███████╗   ██║   ██║ ╚═╝ ██║██║  ██║██║     ███████║
-- ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝    ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝

-- ---------------------------------------------------------------------------------------------- --

-- Modes:
	-- "n" = normal mode.
	-- "v" = visual mode.
	-- "x" = visual block mode.
	-- "i" = insert mode.
	-- "c" = command mode.
	-- "t" = terminal mode.

local map = function(modes, keys, func, desc)
	vim.keymap.set(modes, keys, func, { noremap = true, desc = "" .. desc })
end

local pum_map = function(keys, func, desc)
	vim.keymap.set("i", keys, func, { noremap = true, expr = true, desc = "" .. desc })
end

--: }}}
--: General {{{
map("n", "<Esc>", ":noh<CR><Esc>", "Clear highlighted searches.")
map("v", ".", ":norm .<CR>", "Perform dot commands over visual blocks.")
map({ "n", "v" }, "j", "gj", "Remap j to gj for better movement on warped lines.")
map({ "n", "v" }, "k", "gk", "Remap k to gk for better movement on warped lines.")

-- Automatically center cursor.
-- local has_animate, animate =
if pcall(require, "mini.animate")then
	map("", "n",     "<Cmd>lua vim.cmd('normal! n');     require('mini.animate').execute_after('scroll', 'normal! zvzz')<CR>", "Center the cursor when moving to the next match during a search.")
	map("", "N",     "<Cmd>lua vim.cmd('normal! N');     require('mini.animate').execute_after('scroll', 'normal! zvzz')<CR>", "Center the cursor when moving to the previous match during a search.")
	map("", "<C-d>", "<Cmd>lua vim.cmd('normal! <C-d>'); require('mini.animate').execute_after('scroll', 'normal! zvzz')<CR>", "Center the cursor when moving a half page down.")
	map("", "<C-u>", "<Cmd>lua vim.cmd('normal! <C-u>'); require('mini.animate').execute_after('scroll', 'normal! zvzz')<CR>", "Center the cursor when moving a half page up.")
	map("", "<C-f>", "<Cmd>lua vim.cmd('normal! <C-f>'); require('mini.animate').execute_after('scroll', 'normal! zvzz')<CR>", "Center the cursor when moving a page down.")
	map("", "<C-b>", "<Cmd>lua vim.cmd('normal! <C-b>'); require('mini.animate').execute_after('scroll', 'normal! zvzz')<CR>", "Center the cursor when moving a page up.")
else
	map("", "n", "nzvzz",         "Center the cursor when moving to the next match during a search.")
	map("", "N", "Nzvzz",         "Center the cursor when moving to the previous match during a search.")
	map("", "<C-d>", "<C-d>zvzz", "Center the cursor when moving a half page down.")
	map("", "<C-u>", "<C-u>zvzz", "Center the cursor when moving a half page up.")
	map("", "<C-f>", "<C-f>zvzz", "Center the cursor when moving a page down.")
	map("", "<C-b>", "<C-b>zvzz", "Center the cursor when moving a page up.")
end

-- Move lines around with Alt + arrow keys:
map("n", "<A-S-J>", ":m .+1<CR>==",        "Move the current line down.")
map("n", "<A-S-K>", ":m .-2<CR>==",        "Move the current line up.")
map("n", "<A-S-H>", "<<",                  "Move the current line to the left.")
map("n", "<A-S-L>", ">>",                  "Move the current line to the right.")
map("i", "<A-S-J>", "<Esc>:m .+1<CR>==gi", "Move the current line down in insert mode.")
map("i", "<A-S-K>", "<Esc>:m .-2<CR>==gi", "Move the current line up in insert mode.")
map("i", "<A-S-H>", "<Esc><<gi",           "Move the current line to the left in insert mode.")
map("i", "<A-S-L>", "<Esc>>>gi",           "Move the current line to the right in insert mode.")
map("v", "<A-S-J>", ":m '>+1<CR>gv=gv",    "Move selected lines down.")
map("v", "<A-S-K>", ":m '<-2<CR>gv=gv",    "Move selected lines up.")
map("v", "<A-S-H>", "<gv",                 "Move selected lines to the left.")
map("v", "<A-S-L>", ">gv",                 "Move selected lines to the right.")
map("v", "<",       "<gv",                 "Move selected lines to the left.")
map("v", ">",       ">gv",                 "Move selected lines to the right.")

-- Remap shift + left/down/up/right.
for _, mode in ipairs({ "n", "v", "i" }) do
	map(mode, "<Up>", "<C-y>",    "Scroll up.")
	map(mode, "<Down>", "<C-e>",  "Scroll down.")
	map(mode, "<Left>", "<S-{>",  "Move to the start of previous block.")
	map(mode, "<Right>", "<S-}>", "Move to the end of next block.")
end

-- Closing compaction in insert mode:
-- Replaced by "https://github.com/windwp/nvim-autopairs".
-- map("i", [[']], "''<Left>", "")
-- map("i", [["]], '""<Left>', "")
-- map("i", '[', '[]<Left>', "")
-- map("i", '(', '()<Left>', "")
-- map("i", '{', '{}<Left>', "")
-- map("i", '<', '<><Left>', "")
-- map("i", '/*', '/**/<Left><Left>', "")
--: }}}
--: Clipboard management {{{
map({ "n", "v" }, "<Leader>y", '"*y', "Copy to primary clipboard.")
map({ "n", "v" }, "<Leader>p", '"*p', "Paste from primary clipboard.")
map({ "n", "v" }, "<Leader>P", '"*P', "Paste from primary clipboard.")
--: }}}
--: Toggles {{{
map({ "n", "v" }, "<Leader>ts", ":set spell!<CR>", "Toggle spell checking.")
map({ "n", "v" }, "<Leader>tw", ":set wrap!<CR>", "Toggle line wrapping.")
map({ "n", "v" }, "<Leader>tn", ":set number!<CR>", "Toggle line numbers.")
map({ "n", "v" }, "<Leader>tr", ":set relativenumber!<CR>", "Toggle relative line numbers.")
map({ "n", "v" }, "<Leader>tl", ":set cursorline! cursorcolumn!<CR>", "Toggle CursorLine/column.")
map({ "n", "v" }, "<Leader>tc", ":setlocal formatoptions-=cro<CR>", "Enable auto commenting.")
map({ "n", "v" }, "<Leader>tC", ":setlocal formatoptions=cro<CR>", "Disable auto commenting.")
--: }}}
--: Misc {{{
map("n", "<Leader>gs", ":s///g<Left><Left><Left>", "Replace string on the current line.")
map("n", "<Leader>gS", ":%s///g<Left><Left><Left>", "Replace string on the whole file.")
map("v", "<Leader>gs", ":s///g<Left><Left><Left>", "Replace on selected text.")
--: }}}
--: Complete menu {{{
--stylua: ignore start
-- This keymap function auto selects the first item of the complete menu when Ctrl-n is pressed.
-- NOTE: This function only sets a keymap when the option `completeopt` has the option `longest` on it.
-- That's because that option changes the behaviour of the complete menu so that it no longer auto selects the first item in the completion list.
local pum_map_autoselect = function()
	local completeopts = vim.opt.completeopt:get()
	local opts = {
		noremap = true,
		expr = true,
		desc = "Auto open & select first item on completion menu."
	}

	if vim.tbl_contains(completeopts, "longest") then
		vim.keymap.set("i", "<C-n>", function() return vim.fn.pumvisible() == 1 and "<C-n>" or [[<C-n><C-r>=pumvisible() ? "\<lt>C-n>" : ""<CR>]] end, opts)
	end
end
pum_map_autoselect()

-- General completion mappings.
pum_map("<Tab>",   function() return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"   end, "Navigate completion menu down with tab.")
pum_map("<S-Tab>", function() return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>" end, "Navigate completion menu up with Shift-tab.")
pum_map("<C-c>",   function() return vim.fn.pumvisible() == 1 and "<C-e>" or "<C-c>"   end, "Cancel completion menu with Ctrl-c.")
pum_map("<Left>",  function() return vim.fn.pumvisible() == 1 and "<C-e>" or "<Left>"  end, "Cancel completion menu with Left arrow.")
pum_map("<Right>", function() return vim.fn.pumvisible() == 1 and "<C-y>" or "<Right>" end, "Select completion menu item with right arrow.")
pum_map("<CR>",    function() return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"    end, "Select completion menu item with enter.")
--stylua: ignore end
--: }}}
--: Split management {{{
-- Create splits:
map({ "n", "v" }, "<Leader>-", ":vsplit|lua MiniStarter.open()<CR>", "Create vertical split.")
map({ "n", "v" }, "<Leader>_", ":split|lua MiniStarter.open()<CR>", "Create horizontal split.")

-- Move across splits:
map({ "n", "v" }, "<C-h>", "<C-W>h", "Move to the left split window.")
map({ "n", "v" }, "<C-j>", "<C-W>j", "Move to the split window below.")
map({ "n", "v" }, "<C-k>", "<C-W>k", "Move to the split window above.")
map({ "n", "v" }, "<C-l>", "<C-W>l", "Move to the right split window.")

-- Resize split windows:
map({ "n", "v" }, "<C-Left>", "<C-w>>", "Increase width of split window.")
map({ "n", "v" }, "<C-Down>", "<C-w>-", "Decrease height of split window.")
map({ "n", "v" }, "<C-Up>", "<C-w>+", "Increase height of split window.")
map({ "n", "v" }, "<C-Right>", "<C-w><", "Decrease width of split window.")

-- Move currently actively selected split to the left/bottom/top/right:
map({ "n", "v" }, "<C-S-Left>", "<C-W>H", "Move split window to the left.")
map({ "n", "v" }, "<C-S-Down>", "<C-W>J", "Move split window to the bottom.")
map({ "n", "v" }, "<C-S-Up>", "<C-W>K", "Move split window to the top.")
map({ "n", "v" }, "<C-S-Right>", "<C-W>L", "Move split window to the right.")
--: }}}
--: Tab & buffer management {{{
-- Buffer management:
map({ "n", "v" }, "<Leader>bb", "<C-w>T", "Break split into a new tab.")
map({ "n", "v" }, "<Leader>bc", ":badd ", "Open a new buffer.")
map({ "n", "v" }, "<Leader>bx", ":w!<CR>:bdelete<CR>:bprev<CR>", "Close current buffer.")
map({ "n", "v" }, "<Leader>bC", ":tabnew ", "Open a new tab.")
map({ "n", "v" }, "<Leader>bX", ":tabc<CR>", "Close current tab.")
map({ "n", "v" }, "<Leader>.", ":tabn<CR>", "Move to the next tab.")
map({ "n", "v" }, "<Leader>,", ":tabp<CR>", "Move to the previous tab.")
map({ "n", "v" }, "<Tab>", ":bnext<CR>", "Switch to the next buffer.")
map({ "n", "v" }, "<S-Tab>", ":bprevious<CR>", "Switch to the previous buffer.")

-- Select buffer using Alt + <NUM> (Requires Bufferline.nvim).
for i = 1, 9, 1 do
	map("n", string.format("<A-%s>", i), string.format(":buffer %s<CR>", i), "Directly switch to buffer [N] with Alt+[N].")
end
--: }}}
