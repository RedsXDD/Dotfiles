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

--: Main functions {{{
---@param modes string|table
---@param keys string
---@param func string|function
---@param desc string
---@param opts table?
local map = function(modes, keys, func, desc, opts)
	if opts ~= nil and type(opts) ~= "table" then
		error("expect table under 'opts' for keymap set but got " .. type(opts))
	end

	opts = opts or { noremap = true }
	opts.desc = "" .. desc

	vim.keymap.set(modes, keys, func, opts)
end

---@param keys string
---@param desc string
local center_map = function(keys, desc)
	vim.keymap.set("", keys, keys .. "<CMD>norm! zvzz<CR>", { noremap = true, silent = true, desc = "" .. desc })
end

---@param actions table
---@param desc string
local pum_map = function(actions, desc)
	if type(actions) ~= "table" then
		error("Could not find `table` for `pum_map()`.")
	end

	if actions.key == nil then
		actions.key = actions.normal
	end

	vim.keymap.set("i", actions.key, function()
		return vim.fn.pumvisible() ~= 0 and actions.pum or actions.normal
	end, { noremap = true, silent = true, expr = true, desc = "" .. desc })
end

---@param modes string|table
---@param keys string
---@param options string|table
---@param desc string
local toggle_map = function(modes, keys, options, desc)
	vim.keymap.set(modes, keys, function()
		local state = false

		if type(options) == "string" then
			state = vim.o[options]
			state = not state
			vim.o[options] = state
		end

		if type(options) == "table" then
			for _, option in ipairs(options) do
				state = vim.o[option]
				state = not state
				vim.o[option] = state
			end
		end

		vim.notify(state and "Enabled " .. desc or "Disabled " .. desc, state and vim.log.levels.INFO or vim.log.levels.WARN)
	end, { noremap = true, silent = true, desc = "Toggle " .. desc })
end

---@param modes string|table
---@param keys string
---@param option string
---@param str string
---@param desc string
local toggleStr_map = function(modes, keys, option, str, desc)
	vim.keymap.set(modes, keys, function()
		local has_str = vim.o[option]:find("" .. str) ~= nil
		vim.opt[option] = has_str and vim.o[option]:gsub("" .. str, "") or vim.o[option] .. "" .. str
		vim.notify(has_str and "Disabled " .. desc or "Enabled " .. desc, has_str and vim.log.levels.WARN or vim.log.levels.INFO)
	end, { noremap = true, silent = true, desc = "Toggle " .. desc })
end
--: }}}
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
map("t", "<ESC><ESC>", "<C-\\><C-n>", "Enter normal mode.")
map("t", "<C-/>", "<C-\\><C-n><CMD>bdelete!<CR>", "Close terminal.")
map("t", "<C-_>", "<C-\\><C-n><CMD>bdelete!<CR>", "Close terminal.")
--: }}}
--: Clipboard management {{{
map("", "<Leader>y", '"+y', "Copy to primary clipboard.")
map("", "<Leader>p", '"+p', "Paste from primary clipboard.")
map("", "<Leader>P", '"+P', "Paste from primary clipboard.")
--: }}}
--: Toggles {{{
toggle_map("", "<Leader>ts", "spell", "spell checking.")
toggle_map("", "<Leader>tw", "wrap", "line wrapping.")
toggle_map("", "<Leader>tn", { "number", "relativenumber" }, "line numbers.")
toggle_map("", "<Leader>tr", "relativenumber", "relative line numbers.")
toggle_map("", "<Leader>tl", { "cursorline", "cursorcolumn" }, "Toggle cursorline/cursorcolumn.")
toggleStr_map("", "<Leader>tc", "formatoptions", "cro", "newline auto commenting.")
--: }}}
--: Complete menu {{{
-- General completion mappings.
pum_map({
	normal = "<Tab>",
	pum = "<C-n>",
}, "Navigate completion menu down with tab.")
pum_map({
	normal = "<S-Tab>",
	pum = "<C-p>",
}, "Navigate completion menu up with Shift-tab.")
pum_map({
	normal = "<C-c>",
	pum = "<C-e>",
}, "Cancel completion menu with Ctrl-c.")
pum_map({
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

pum_map({
	key = "<C-n>",
	pum = "<C-n>",
	normal = ctrn_n_action(),
}, "Auto open & select first item on completion menu.")
--: }}}
--: Split management {{{
-- Create splits:
map("", "<Leader>-", ":vsplit | enew<CR>", "Create vertical split.")
map("", "<Leader>_", ":split | enew<CR>", "Create horizontal split.")
map("", "<Leader>z", function()
	require("core.utils").maximize()
end, "Maximize current window.")

-- Move across splits:
map("", "<C-h>", "<CMD>wincmd h<CR>", "Move to the left split window.")
map("", "<C-j>", "<CMD>wincmd j<CR>", "Move to the split window below.")
map("", "<C-k>", "<CMD>wincmd k<CR>", "Move to the split window above.")
map("", "<C-l>", "<CMD>wincmd l<CR>", "Move to the right split window.")

-- Resize split windows:
map("", "<C-Left>", "<CMD>wincmd ><CR>", "Increase width of split window.")
map("", "<C-Down>", "<CMD>wincmd -<CR>", "Decrease height of split window.")
map("", "<C-Up>", "<CMD>wincmd +<CR>", "Increase height of split window.")
map("", "<C-Right>", "<CMD>wincmd <<CR>", "Decrease width of split window.")

-- Move currently actively selected split to the left/bottom/top/right:
map("", "<C-S-Left>", "<CMD>wincmd H<CR>", "Move split window to the left.")
map("", "<C-S-Down>", "<CMD>wincmd J<CR>", "Move split window to the bottom.")
map("", "<C-S-Up>", "<CMD>wincmd K<CR>", "Move split window to the top.")
map("", "<C-S-Right>", "<CMD>wincmd L<CR>", "Move split window to the right.")
--: }}}
--: Tab & buffer management {{{
-- Buffer management:
map("", "<Leader>bb", "<CMD>wincmd T<CR>", "Break split into a new tab.")
map("", "<Leader>bc", ":badd | enew<CR>", "Open a new buffer.")
map("", "<Leader>bC", ":tabnew | enew<CR>", "Open a new tab.")
map("", "<Leader>x", "<CMD>wincmd q<CR>", "Close current buffer.")
map("", "<Leader>.", ":tabn<CR>", "Move to the next tab.")
map("", "<Leader>,", ":tabp<CR>", "Move to the previous tab.")
map("n", "[b", "<CMD>bprev<CR>", "Buffer previous")
map("n", "]b", "<CMD>bnext<CR>", "Buffer next")
map("n", "[B", "<CMD>bfirst<CR>", "Buffer first")
map("n", "]B", "<CMD>blast<CR>", "Buffer last")
map("n", "<Leader>bb", "<CMD>e #<CR>", "Switch to previously active buffer")
--: }}}
--: File explorer {{{
map("n", "<Leader>gf", function()
	require("core.utils").toggle_file_explorer()
end, "Open file explorer on CWD.")

map("n", "<Leader>gF", function()
	require("core.utils").toggle_file_explorer(true)
end, "Open file explorer on directory of current file.")
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
			if type(vsplit) ~= "boolean" then
				error("netrw_split_file: expected boolean, got" .. type(vsplit))
			end

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
