" vim:fileencoding=utf-8:foldmethod=marker

" ------------------------------------------------------------ "

" ██╗   ██╗██╗███╗   ███╗    ██████╗ ██╗███╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗ ███████╗
" ██║   ██║██║████╗ ████║    ██╔══██╗██║████╗  ██║██╔══██╗██║████╗  ██║██╔════╝ ██╔════╝
" ██║   ██║██║██╔████╔██║    ██████╔╝██║██╔██╗ ██║██║  ██║██║██╔██╗ ██║██║  ███╗███████╗
" ╚██╗ ██╔╝██║██║╚██╔╝██║    ██╔══██╗██║██║╚██╗██║██║  ██║██║██║╚██╗██║██║   ██║╚════██║
"  ╚████╔╝ ██║██║ ╚═╝ ██║    ██████╔╝██║██║ ╚████║██████╔╝██║██║ ╚████║╚██████╔╝███████║
"   ╚═══╝  ╚═╝╚═╝     ╚═╝    ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

" ------------------------------------------------------------ "

" Map leader key to space:
let mapleader = " "

" noremap: Applies to all modes except insert mode
" nnoremap: Maps the key in normal mode
" inoremap: Maps the key in insert mode
" vnoremap: Maps the key in visual mode
" <C> : Control key
" <A> : Alt key
" <CR> (Carriage Return) simulates pressing the enter key

" Disable arrow keys and PageUp/PageDown:
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <PageUp> <Nop>
noremap <PageDown> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <PageUp> <Nop>
inoremap <PageDown> <Nop>

" ------------------------------------------------------------ "

" ---------------- "
" General Bindings "
" ---------------- "

" Auto close quotation marks, parenthesis etc.
" inoremap ' ''<Left>
" inoremap " ""<Left>
" inoremap ( ()<Left>
" inoremap ) ()<Left>
" inoremap [ []<Left>
" inoremap ] []<Left>
" inoremap { {}<Left>
" inoremap } {}<Left>

" Move lines around with Alt + hjkl
" nnoremap <A-j> :m .+1<CR>==
" nnoremap <A-k> :m .-2<CR>==
" inoremap <A-j> <Esc>:m .+1<CR>==gi
" inoremap <A-k> <Esc>:m .-2<CR>==gi
" vnoremap <A-j> :m '>+1<CR>gv=gv
" vnoremap <A-k> :m '<-2<CR>gv=gv

" Center the cursor When Moving to the Next word During a Search.
noremap n nzz
noremap N Nzz

" Map j/k to gj/gk for better movement on warped lines:
noremap j gj
noremap k gk

" Resource Init.vim config.
noremap <leader>r :source ~/.config/nvim/init.vim<CR>

" Toggle line wrapping.
noremap <leader>w :set wrap!<CR>

" Toggle numbers/relativenumbers:
noremap <leader>n :set number! relativenumber!<CR>

" Toggle cursorLine/column.
noremap <leader>p :set cursorline! cursorcolumn!<CR>

" Unhilight lines/words.
noremap <leader>, :noh<CR>

" Enable/disable auto commenting.
noremap <leader>c :setlocal formatoptions-=cro<CR>
noremap <leader>C :setlocal formatoptions=cro<CR>

" Analyse current file with shell check.
noremap <leader>o :!clear && shellcheck %<CR>

" Replace on current line/replace on the whole file.
noremap <leader>s :s///g<Left><Left><Left>
noremap <leader>z :%s///g<Left><Left><Left>
vnoremap <leader>z :s///g<Left><Left><Left>

" Perform dot commands over visual blocks
vnoremap . :normal .<CR>

" Toggle status bar.
let s:hidden_all = 0
function! ToggleHiddenAll()
	if s:hidden_all  == 0
		let s:hidden_all = 1
		set noshowmode
		set noruler
		set laststatus=0
		set noshowcmd
	else
		let s:hidden_all = 0
		set showmode
		set ruler
		set laststatus=2
		set showcmd
	endif
endfunction
noremap <leader>u :call ToggleHiddenAll()<CR>

" ------------------------------------------------------------ "

"""""""""""""""""
" Complete menu "
"""""""""""""""""

" Change behaviour of Ctrl-n, making an item always highlighted:
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Navigate the complete menu items with up/down arrow keys:
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"

" Select the complete menu item with right/enter keys:
inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <CR> pumvisible() ? "<C-y>" :"<CR>"

" Cancel the complete menu item with the left arrow key:
inoremap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"

" ------------------------------------------------------------ "

"------------------"
" Split Management "
"------------------"

" Create splits.
noremap <leader>- :vsplit<space>
noremap <leader>_ :split<space>

" Move currently selected split to the left/bottom/top/right.
noremap <leader>h <C-W>H
noremap <leader>j <C-W>J
noremap <leader>k <C-W>K
noremap <leader>l <C-W>L

" Move across splits.
noremap <c-h> <C-W>h
noremap <c-j> <C-W>j
noremap <c-k> <C-W>k
noremap <c-l> <C-W>l

" Resize split windows.
noremap <C-left> <C-w>>
noremap <C-down> <C-w>-
noremap <C-up> <C-w>+
noremap <C-right> <C-w><

" ------------------------------------------------------------ "
