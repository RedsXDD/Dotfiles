" vim:fileencoding=utf-8:foldmethod=marker

" ------------------------------------------------------------ "

" ██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
" ██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
" ██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
" ██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
" ██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
" ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝

" ------------------------------------------------------------ "

" Source Basic Stuff:
source ~/.config/nvim/bindings.vim
" source ~/.config/nvim/vim_tmux_navigator.vim

" Set pywal colorscheme only if not on a TTY:
if !empty($DISPLAY)
	set termguicolors
	colorscheme wal
endif

" Fix :wq Mispellings.
command! W w
command! Q q
command! Wq wq
command! WQ wq

" set spell                                " enable spell check (may need to download language package).
set lazyredraw                           " Run macros Faster.
set backupdir=~/.cache/nvim              " Directory to store backup files.
set history=10000                        " Set the amount of commands to be saved in history.
set clipboard=unnamedplus                " Use system clipboard.
set mouse=a                              " Enable mouse support.
set nocompatible                         " Disable compatibility to old-time vi.
set cursorline cursorcolumn              " Highlight current cursorline/cursorcolumn.
set hidden                               " Does not close file when opening a new one.
set incsearch hlsearch showmatch         " Incremental/highlight search & Show matching words during a search.
set number relativenumber                " Enable line & relative numbers.
" set shiftwidth=4 softtabstop=4 tabstop=4 " Width for autoindents/set multiple spaces as tabstops/number of columns occupied by a tab.
set showcmd showmode                     " Show mode/partial command you type in the last line of the screen.
set ignorecase smartcase                 " Case insensitive only when matches pattern.
set autoindent smartindent               " Indent a new line the same amount as the line just typed.
set complete+=kspell                     " Enable autocomplete with spell checking.
set completeopt=menuone,longest          " Options of auto complete mode.
set shortmess+=c                         " Remove status message when using the complete menus.
set linebreak                            " Make nvim warp lines at the end of words.
set ttyfast                              " Speed up scrolling in vim.
set wildmenu                             " Enable auto completion menu after pressing TAB.
set wildmode=longest,list,full           " Make wildmenu behave like similar to bash completion.
set splitbelow splitright                " Splits open at the bottom and right.
syntax on                                " Enable syntax highlighting.

" Disable automatic commenting on newline.
autocmd FileType * setlocal formatoptions-=cro

" Turns off highlighting on the bits of code that are changed.
" if &diff
"  highlight! link DiffText MatchParen
" endif

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Define Default Cursor/CursorLine/CursorColumn Colors
hi Cursor       ctermbg=233 cterm=bold gui=bold
hi CursorLine   ctermbg=233 cterm=bold gui=bold
hi CursorColumn ctermbg=233 cterm=bold gui=bold
hi CursorLineNr ctermbg=233 cterm=bold gui=bold

" ------------------------------------------------------------ "

"""""""""""""""""
" Auto commands "
"""""""""""""""""

" Set filetypes.
autocmd BufRead,BufNewFile *.tmux set filetype=tmux
autocmd BufRead,BufNewFile *.c set filetype=c
autocmd BufRead,BufNewFile *.cpp set filetype=cpp

" Auto reload waybar.
autocmd BufWritePost ~/.config/waybar/* !pywal_postrun

" Auto reload swaync.
autocmd BufWritePost ~/.config/swaync/*,~/.config/wal/templates/colors-swaync.css !reload_swaync

" Reload pywal themes when changing configs:
autocmd BufWritePost ~/.config/wal/templates/* !wal -Rq

" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" ------------------------------------------------------------ "

"""""""""""""""
" Status line "
"""""""""""""""

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 1x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

" %F – Display the full path of the current file.
" %M – Modified flag shows if file is unsaved.
" %Y – Type of file in the buffer.
" %R – Displays the read-only flag.
" %b – Shows the ASCII/Unicode character under cursor.
" 0x%B – Shows the hexadecimal character under cursor.
" %l – Display the row number.
" %c – Display the column number.
" %p%% – Show the cursor percentage from the top of the file.

" ------------------------------------------------------------ "
