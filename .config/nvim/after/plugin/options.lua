-- vim:fileencoding=utf-8:foldmethod=marker

local o = vim.opt

-- Gui options:
o.guifont = "JetBrainsMono Nerd Font,Noto_Color_Emoji:h14" -- The font used in graphical Neovim applications.
--: File history {{{
o.backup = true -- Creates a backup file.
o.undofile = true -- Creates a undo file.
o.swapfile = true -- Creates a swap file.
o.writebackup = true -- Creates a backup file before overwritting a file.
o.history = 10000 -- Set the amount of commands to be saved in history.
o.undolevels = 10000 -- Maximum number of changes that can be undone.
o.backupdir = vim.fn.stdpath("cache") .. "/backup//" -- Directory to store backup files.
o.undodir = vim.fn.stdpath("cache") .. "/undo//" -- Directory to store undo files.
o.directory = vim.fn.stdpath("cache") .. "/swap//" -- Directory to store swap files.
--: }}}
--: Complete menu {{{
o.wildmenu = true -- When on, pressing <Tab> on the command-line will open a completion menu.
o.wildmode = "longest,list,full" -- Make wildmenu behave like similar to bash completion.
o.pumblend = 0 -- Pop up menu transparency.
o.pumheight = 15 -- Pop up menu height.
o.completeopt = "menuone,longest,preview,fuzzy" -- options for completion menu.
o.complete:append(",kspell") -- Enable auto complete with spell checking.
--: }}}
--: Indentation {{{
o.autoindent = true -- Copy indent from current line when starting a new line.
o.breakindent = true -- Every wrapped line will continue visually indented (same amount of space as the beginning of that line).
o.cindent = true -- Get the amount of indent for line {lnum} according the C indenting rules, as with 'cindent'.
o.shiftround = true -- Round indent to a multiple of 'shiftwidth'.
o.softtabstop = -1 -- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS> (if negative, shiftwidth value is used).
o.shiftwidth = 0 -- Width for auto indents (if set to 0, tabstop value is used).
o.tabstop = 8 -- Number of columns occupied by a tab.
o.smartindent = true -- Do smart autoindenting when starting a new line.
o.smarttab = true -- When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
o.expandtab = true -- Expand tabs to individual space characters.
--: }}}
--: Styling {{{
o.statusline = "%<" -- Empty statusline (Useful for cleaning starter pages from plugins).
-- o.winbar = "%<" -- Similar to statusline but displayed right below tabline.
o.laststatus = 3 -- Display one global statusline for all windows.
o.showtabline = 2 -- When to display tabpages (0: never, 1: only if there are at least two tab pages, 2: always).
-- o.cursorline = true -- Highlight current line.
-- o.cursorcolumn = true -- Highlight current column.
-- o.colorcolumn = "80" -- Highlight column at `x` characters.
o.cmdheight = 2 -- More space in the Neovim command line for displaying messages.
-- o.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
-- o.showcmd = false -- Do not show (partial) command in the last line of the screen.
o.showmode = false -- Do not show the current mode in the last line of the screen.
o.winblend = 0 -- Enables pseudo-transparency for a floating window.
o.list = true -- Sets how Neovim will display certain whitespace characters in the editor.
o.listchars = require("reds.icons").listchars -- Characters used for certain whitespace characters.
o.fillchars = require("reds.icons").fillchars -- Characters to fill the statuslines, vertical separators and special lines in the window.
o.number = true -- Enable line numbers.
o.relativenumber = true -- Enable relative line numbers.
o.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor.
o.sidescrolloff = 8 -- Minimal number of screen columns to keep on either side of cursor if wrap is `false`.
o.signcolumn = "yes" -- Always show the sign column.
-- o.wrap = true -- Enable/disable text wrapping.
--: }}}
--: Search/substitution {{{
o.hlsearch = true -- Highlight all matches on previous search pattern.
o.ignorecase = true -- Ignore case in search patterns.
o.smartcase = true -- When used together with `ignorecase` only does case sensitive search when it's specified on pattern.
o.incsearch = true -- While typing a search command, show where the pattern, as it was typed so far, matches.
o.inccommand = "split" -- Preview substitutions live, as you type!
--: }}}
--: Fold {{{
o.foldcolumn = "2" -- When and how to draw the foldcolumn.
o.foldmethod = "marker" -- The kind of folding used for the current window.
-- o.foldminlines = 1 -- Sets the number of screen lines above which a fold can be displayed closed.
-- o.foldnestmax = 3 -- Sets the maximum nesting of folds for the "indent" and "syntax" methods.
-- o.foldlevelstart = 99 -- Sets `foldlevel` when starting to edit another buffer in a window.
--: }}}
--: Editor {{{
o.autowrite = true -- Write the contents of the file, if it has been modified, on each `:next`, `:rewind`, `:last`, `:first`, `:previous`, `:stop`, `:suspend`, `:tag`, `:!`, `:make`, CTRL-] and CTRL-^ command.
o.clipboard = "unnamedplus" -- Use system clipboard.
o.confirm = true -- Confirm to save changes before exiting modified buffer.
-- o.fileencoding = "utf-8" -- The encoding written to a file.
o.grepformat = "%f:%l:%c:%m" -- Format to recognize for the ":grep" command output.
o.grepprg = "rg --vimgrep" -- Program to use for the |:grep| command.
o.hidden = true -- Does not close file when opening a new one.
o.iskeyword:append({ "-", "_" }) -- Add the "-" and "_" symbols as part of keywords.
o.jumpoptions = "view" -- Preserve view while jumping.
o.linebreak = true -- Warp lines at the end of words.
o.mouse = "a" -- Enable mouse support.
o.runtimepath:remove("/usr/share/vim/vimfiles") -- Separate vim plugins from Neovim in case vim still in use.
o.shortmess:append({ W = true, I = true, c = true, C = true })
o.showmatch = true -- When a bracket is inserted, briefly jump to the matching one.
o.spelllang = "en_us" -- Main language for spell checking.
-- o.spell = true -- Enable spell checking by default.
o.splitbelow = true -- Force all horizontal splits to go below current window.
o.splitkeep = "screen" -- The value of this option determines the scroll behavior when opening, closing or resizing horizontal splits.
o.splitright = true -- Force all vertical splits to go to the right of current window.
o.textwidth = 300 -- Maximum width of text that is being inserted. A longer line will be broken after white space to get this width.
o.timeoutlen = 300 -- Time in milliseconds to wait for a mapped sequence to complete.
o.updatetime = 250 -- If this many milliseconds nothing is typed the swap file will be written to disk.
o.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode.
o.whichwrap = "bs<>[]hl" -- Which "horizontal" keys are allowed to travel to prev/next line.
o.winminwidth = 5 -- Minimum window width.
if vim.fn.has("nvim-0.10") == 1 then o.smoothscroll = true end
--: }}}
