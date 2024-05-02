-- vim:fileencoding=utf-8:foldmethod=marker

-- --------------------------------------------------------------------------------- --

-- ███╗   ██╗██╗   ██╗██╗███╗   ███╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗
-- ████╗  ██║██║   ██║██║████╗ ████║    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝
-- ██╔██╗ ██║██║   ██║██║██╔████╔██║    ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
-- ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║    ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
-- ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
-- ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝

-- --------------------------------------------------------------------------------- --

-- Set variables for ease of typing:
local g = vim.g
local o = vim.opt
local wo = vim.wo
local bo = vim.bo

o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
g.netrw_banner = 0                          -- Disable netrw banner text.
g.netrw_browse_split=4                      -- Open in prior window.
g.netrw_altv = 1                            -- Change from left splitting to right splitting.
g.netrw_liststyle=3                         -- Tree style view in netrw.
o.confirm = true                            -- Confirm to save changes before exiting modified buffer.
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"
o.numberwidth = 4                           -- Set number column width.
o.showtabline = 2                           -- Always show tabs.
-- o.fileencoding = "utf-8"                    -- The encoding written to a file.
o.conceallevel = 0                          -- So that `` is visible in markdown files.
o.cmdheight = 2                             -- More space in the neovim command line for displaying messages.
o.history = 10000                           -- Set the amount of commands to be saved in history.
o.clipboard = "unnamedplus"                 -- Use system clipboard.
o.mouse = "a"                               -- Enable mouse support.
o.compatible = false                        -- Disable compatibility to old-time vi.
o.hidden = true                             -- Does not close file when opening a new one.
o.ttyfast = true                            -- Speed up scrolling in vim.
o.wrap = false                              -- Enable/disable text wrapping.
o.wildmenu = true                           -- Enable auto completion menu after pressing TAB.
o.wildmode = { "longest", "list", "full" } -- Make wildmenu behave like similar to bash completion.
o.jumpoptions = "view"                      -- Preserve view while jumping.
o.splitkeep = "screen"                      -- Stable buffer content on window open/close events.
o.inccommand = "split"                      -- Preview substitutions live, as you type!
o.backspace = { "indent", "eol", "start" }  -- Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode.
o.guifont = "JetBrainsMono Nerd Font:h12"   -- The font used in graphical neovim applications.
o.whichwrap = "bs<>[]hl"                    -- Which "horizontal" keys are allowed to travel to prev/next line.
o.scrolloff = 8                             -- Minimal number of screen lines to keep above and below the cursor.
o.sidescrolloff = 8                         -- Minimal number of screen columns either side of cursor if wrap is `false`.
o.incsearch = true                          -- While typing a search command, show where the pattern, as it was typed so far, matches.
o.hlsearch = true                           -- Highlight all matches on previous search pattern.
o.showmatch = true                          -- When a bracket is inserted, briefly jump to the matching one.
o.showcmd = false                           -- Do not show partial command in the last line of the screen.
o.showmode = false                          -- Do not show the current mode in the last line of the screen.
o.ignorecase = true                         -- Ignore case in search patterns.
o.smartcase = true                          -- When used together with `ignorecase` only does case sensitive search when it's specified on pattern.
o.number = true                             -- Enable line numbers.
o.relativenumber = true                     -- Enable relative line numbers.
o.cursorline = true                         -- Highlight cursorline.
o.cursorcolumn = true                       -- Highlight cursorcolumn.
-- o.colorcolumn = "80"                        -- Display colored column.
o.signcolumn  = "yes"                       -- Always show the sign column, otherwise it would shift the text each time.
o.splitkeep = "screen"
o.splitbelow = true                         -- Force all horizontal splits to go below current window.
o.splitright = true                         -- Force all vertical splits to go to the right of current window.
-- o.laststatus = 3                            -- Only display one global statusline for all windows.
o.laststatus = 0                            -- Disable statusline (used for better lazy loading of mini.starter/alpha.nvim and mini.statusline/mini.tabline/bufferline.nvim/lualine.nvim).
-- o.winbar = "%f"                             -- Display filename for the winbar of every buffer.
o.updatetime = 250                          -- Faster completion (4000ms default).
o.timeoutlen = 300                          -- Time to wait for a mapped sequence to complete (in milliseconds).
-- o.spell = true                             -- Enable spell checking by default.
o.spelllang = "en_us"                       -- Main language for spell checking.
o.pumblend = 15                             -- Popup blend.
o.pumheight = 15                            -- Pop up menu height.
o.completeopt = { "menuone", "longest", "preview" } -- Options for neovim's complete menu.
o.textwidth = 300                           -- Maximum width of text that is being inserted.
-- o.expandtab = true                          -- Expand tabs to individual space characters.
o.smarttab = true                           -- Typing a <Tab> in front of a line inserts blanks according to `shiftwidth`.
o.cindent = true                            -- Get the amount of indent for line {lnum} according the C indenting rules, as with 'cindent'.
o.autoindent = true                         -- Indent a new line the same amount as the line just typed.
o.smartindent = true                        -- Do smart autoindenting when starting a new line.
o.breakindent = true                        -- Enable break indent.
o.linebreak = true                          -- Warp lines at the end of words.
o.shiftround = true                         -- Round indent.
o.shiftwidth = 8                            -- Width for auto indents.
o.tabstop = 8                               -- Number of columns occupied by a tab.
o.softtabstop = -1                          -- Set multiple spaces as tabstops (if negative, shiftwidth value is used).
o.backup = true                             -- Creates a backup file.
o.virtualedit = "block"                     -- Allow cursor to move where there is no text in visual block mode.
o.winminwidth = 5                           -- Minimum window width.
o.foldmethod = "manual"                     -- Set fold method.
o.foldcolumn = "1"                          -- Enable fold columns.
-- o.foldlevelstart = 99                       -- Sets `foldlevel` when starting to edit another buffer in a window.
-- o.foldnestmax = 3                           -- Sets the maximum nesting of folds for the "indent" and "syntax" methods.
-- o.foldminlines = 1                          -- Sets the number of screen lines above which a fold can be displayed closed.
o.list = true                                       -- Sets how neovim will display certain whitespace characters in the editor.
o.listchars = require("user.icons").icons.listchars -- Characters used for certain whitespace characters.
o.fillchars = require("user.icons").icons.fillchars -- Characters to fill the statuslines, vertical separators and special lines in the window.
o.undolevels = 10000
o.swapfile = true                           -- Creates a swap file.
o.undofile = true                           -- Creates a undo file.
o.writebackup = true                        -- Creates a backup file before overwritting a file.
o.undodir = os.getenv('HOME') .. '/.cache/nvim/'   -- Directory to store undo files.
o.backupdir = os.getenv('HOME') .. '/.cache/nvim/' -- Directory to store backup files.
o.directory = os.getenv('HOME') .. '/.cache/nvim/' -- Directory to store swap files.

o.iskeyword:append({ "-", "_" })          -- Add the "-" and "_" symbols as part of keywords.
o.shortmess:append({ W = true, I = true, c = true, C = true })
o.complete:append(",kspell")              -- Enable auto complete with spell checking.
o.formatoptions:remove({ "c", "r", "o" }) -- Don"t insert comments on newlines.
o.runtimepath:remove("/usr/share/vim/vimfiles") -- Separate vim plugins from neovim in case vim still in use.

if vim.fn.has("nvim-0.10") == 1 then
	o.smoothscroll = true
end
