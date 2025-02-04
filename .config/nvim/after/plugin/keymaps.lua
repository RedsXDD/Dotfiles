-- vim:fileencoding=utf-8:foldmethod=marker

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
local map = require("reds.utils").map

---@param keys string
---@param desc string
local function center_map(keys, desc)
    vim.keymap.set("", keys, keys .. "<CMD>norm! zvzz<CR>", { noremap = true, silent = true, desc = "" .. desc })
end

-- General
map("n", "<Esc>", "<CMD>noh<CR><Esc>", "Clear highlighted searches.")
map("v", ".", "<CMD>norm .<CR>", "Perform dot commands over visual blocks.")
map("", "j", "gj", "Remap j to gj for better movement on warped lines.")
map("", "k", "gk", "Remap k to gk for better movement on warped lines.")

-- Substitute commands:
-- stylua: ignore start
map("v", "<Leader>ss", ":s///gc" .. string.rep("<Left>", 4), "Substitute string on selection.")
map("n", "<Leader>ss", ":s///gc" .. string.rep("<Left>", 4), "Substitute string.")
map("n", "<Leader>sS", ":%s///gc" .. string.rep("<Left>", 4), "Substitute string on the whole file.")
map("n", "<Leader>sw", ":s/\\<<C-r><C-w>\\>//gc" .. string.rep("<Left>", 3), "Substitute word under cursor.")
map("n", "<Leader>sW", ":%s/\\<<C-r><C-w>\\>//gc" .. string.rep("<Left>", 3), "Substitute word under cursor on the whole file.")
map("n", "<Leader>sq", ":cdo %s///gc" .. string.rep("<Left>", 4), "Substitute string on the quickfix list.")
-- stylua: ignore end

-- Automatically center cursor
-- stylua: ignore start
map({"n", "x", "o"}, "n", [['Nn'[v:searchforward].'zzzv']], "Center cursor when moving to the next search result.", { silent = true, expr = true })
map({ "n", "x", "o"}, "N", [['nN'[v:searchforward].'zzzv']], "Center cursor when moving to the previous search result.", { silent = true, expr = true })
-- stylua: ignore end
center_map("G", "Center cursor when moving to the last line of buffer.")
center_map("<C-d>", "Center cursor when moving a half page down.")
center_map("<C-u>", "Center cursor when moving a half page up.")
center_map("<C-f>", "Center cursor when moving a page down.")
center_map("<C-b>", "Center cursor when moving a page up.")

-- Clipboard management
map("", "<Leader>y", '"*y', "Copy to primary clipboard.")
map("", "<Leader>p", '"*p', "Paste from primary clipboard.")
map("", "<Leader>P", '"*P', "Paste from primary clipboard.")

-- Create splits.
map("", "<Leader>-", "<CMD>vsplit | enew<CR>", "Create vertical split.")
map("", "<Leader>_", "<CMD>split | enew<CR>", "Create horizontal split.")

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

-- File explorer
-- stylua: ignore start
map("n", "<Leader>gf", function() require("reds.utils").toggle_file_explorer() end, "Open file explorer on CWD.")
map("n", "<Leader>gF", function() require("reds.utils").toggle_file_explorer(true) end, "Open file explorer on directory of current file.")
-- stylua: ignore end
