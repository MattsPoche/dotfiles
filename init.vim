"vimrc
"
"appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set termguicolors
colorscheme onedark
"set statusline
set laststatus=2
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
"Window Div
hi VertSplit cterm=NONE
set fillchars+=vert:│
"settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4 shiftwidth=4
set mouse=a
set autoindent
set number relativenumber
set incsearch
set nohlsearch
set ignorecase
set smartcase
set shortmess=I
set hidden
"jumps to buffer in open window or tab
set switchbuf=usetab
"fuzzy file finding
set path+=**
"set spelllang
set spelllang=en_us
"Display all matching files when we tab complete
set wildmenu
"Activate Man command
runtime! ftplugin/man.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"fix delay on shift-O after esc
set timeout timeoutlen=5000 ttimeoutlen=100
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""Mappings
"define Leader
let mapleader = "\<Space>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"define keymaps/commands
"open Netrw
nnoremap <Leader>f :vsplit<CR>:Explore<CR>
"vimrc edit
nnoremap <Leader>ev <C-w>s:e $MYVIMRC<CR>
"source my vimrc file
nnoremap <Leader>sv :source $MYVIMRC<CR>
"ctags
command! MakeTags !ctags -R .
"Bindings for easier command mode editing
cnoremap <C-^> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <M-f> <S-Right>
cnoremap <M-b> <S-Left>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
"Easier tab navigation
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 5gt
nnoremap <Leader>7 5gt
nnoremap <Leader>8 5gt
nnoremap <Leader>9 5gt
"easy resize
nnoremap <silent> <C-J> :resize +5<CR>
nnoremap <silent> <C-K> :resize -5<CR>
nnoremap <silent> <C-H> :vertical resize -5<CR>
nnoremap <silent> <C-L> :vertical resize +5<CR>
"insert date 
nnoremap <Leader>d "=system("date " . shellescape("+<%F %a>"))<CR>p
"insert SCHEDUlED tag
nnoremap <Leader>sc "=system("date " . shellescape("+[SCHEDULED]: <%F %a>"))<CR>p
"insert TODO tag
nnoremap <Leader>td o[TODO]<ESC>
"paste from clipboard
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
"yank selection to clipboard
vnoremap <Leader>yy "+y
"move line up
nnoremap  <Leader>k ddkP
"move line down
nnoremap <Leader>j ddp
"qoute word
nnoremap <Leader>" viw<esc>a"<esc>bi"<esc>lel
"qoute selection
vnoremap <Leader>" di""<esc>hp
"single qoute word
nnoremap <Leader>' viw<esc>a'<esc>bi'<esc>lel
"single qoute selection
vnoremap <Leader>' di''<esc>hp
"toggle line numbers
nnoremap <Leader>lr :setlocal relativenumber!<CR>
nnoremap <Leader>ln :setlocal number!<CR>
"inner next parentheses
onoremap in( :<c-u>normal! f(vi(<CR>
"inner prev parentheses
onoremap il( :<c-u>normal! F)vi(<CR>
"change `zt` so that it leaves some space above the current line
nnoremap zt zt3<C-y>
" functions and commands
"`Maximize` current window
function! ToggleAutoMaximize()
	if exists('g:tautomax')
		autocmd! maxCurrWin
		wincmd =
		unlet g:tautomax
	else
		augroup maxCurrWin
			autocmd! WinEnter * call Maximize()
		augroup END
		do maxCurrWin WinEnter 
		let g:tautomax=1
	endif
endfunction
function! Maximize()
	"wincmd |
	wincmd _
endfunction
nnoremap <Leader>max :call ToggleAutoMaximize()<CR>
nnoremap <C-w>m :call Maximize()<CR>

"create `scratch` buffer
function! ScratchBuffer(...)
	let l:fname = get(a:, 1, "")
	execute "new " . l:fname
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
endfunction
command! -nargs=? Scratch call ScratchBuffer(<f-args>)

function! Todo()
	cexpr system('sch -t')
endfunction
command! Todo call Todo()

function! Agenda()
	cexpr system('sch -a')
endfunction
command! Agenda call Agenda()

"search with ag, result in quickfix 
function! Ag(pattern, ...)
	let l:fname = get(a:, 1, "")
	if l:fname == ""
		cexpr system('ag --vimgrep --silent ' . shellescape(a:pattern))
	else
		cexpr system('ag --vimgrep ' . shellescape(a:pattern) . ' ' . shellescape(l:fname))
	endif
endfunction
command! -nargs=* Ag call Ag(<f-args>)

function! Shellchk()
	cexpr system('shellcheck -f gcc -s sh ' . shellescape(@%))
endfunction
command! Shellchk call Shellchk()

"delete buffer without closing current window
function! Bclose()
	bn
	bdelete #
endfunction
command! Bclose call Bclose()
" vim detects *.h files as cpp files instead of c header files; 
" this fixes that
autocmd BufRead,BufNewFile *.h set filetype=c
"autogroups
augroup filetype_default
	autocmd!
    nnoremap <Leader>cc I#<space><esc>
    nnoremap <Leader>cu 0xx
	vnoremap <Leader>cc :s/^\(\s*\)\(.\+\)/\1# \2/<CR>
augroup END

augroup filetype_python
	autocmd!
    autocmd FileType python setlocal expandtab
augroup END

augroup filetype_vim
	autocmd!
	autocmd FileType vim nnoremap <buffer> <Leader>cc :s/^/"/ge<CR>
	autocmd FileType vim nnoremap <buffer> <Leader>cu :s/^"//ge<CR>
	autocmd FileType vim vnoremap <buffer> <Leader>cc :s/^/"/ge<CR>
	autocmd FileType vim vnoremap <buffer> <Leader>cu :s/^"//ge<CR>
augroup END

augroup filetype_lua
	autocmd!
    autocmd FileType lua nnoremap <buffer> <Leader>cc I--<space><esc>
    autocmd FileType lua nnoremap <buffer> <Leader>cu 0xxx
augroup END

augroup filetype_rust
	autocmd!
    autocmd FileType rust nnoremap <buffer> <Leader>cc I//<space><esc>
    autocmd FileType rust nnoremap <buffer> <Leader>cu 0xxx
	autocmd FileType rust vnoremap <buffer> <Leader>cc :s/^\(\s*\)\(.\+\)/\1\/\/ \2/<CR>
	autocmd FileType rust vnoremap <buffer> <Leader>cu :s/\(^\s*\)\/\/ /\1/<CR>
	autocmd FileType rust vnoremap <buffer> <Leader>cb :<C-u>'<s/\(^.*$\)/\/*\1/<CR>:<C-u>'>s/\(^.*$\)/\1*\//<CR>
augroup END

augroup filetype_haskell
	autocmd!
    autocmd FileType haskell setlocal expandtab
    autocmd FileType haskell nnoremap <buffer> <Leader>cc I--<space><esc>
    autocmd FileType haskell nnoremap <buffer> <Leader>cu 0xxx
	autocmd FileType haskell vnoremap <buffer> <Leader>cc :s/^\(\s*\)\(.\+\)/\1-- \2/<CR>
	autocmd FileType haskell vnoremap <buffer> <Leader>cu :s/\(^\s*\)-- /\1/<CR>
	autocmd FileType haskell vnoremap <buffer> <Leader>cb :<C-u>'<s/\(^.*$\)/{-\1/<CR>:<C-u>'>s/\(^.*$\)/\1-}/<CR>
augroup END

augroup filetype_c
	autocmd!
    ""c file
    "keymap
	"jump to main function assume vim is in root project directory
	autocmd FileType c,cpp nnoremap <buffer> <Leader>gm :grep "^main" src/*<CR><CR>
	autocmd FileType c,cpp nnoremap <buffer> <Leader>cc :s/^\(.*\)/\/\* \1 \*\//ge<CR><
    autocmd FileType c,cpp nnoremap <buffer> <Leader>cu :s/\/\* \(.*\) \*\//\1/ge<CR>
	autocmd FileType c,cpp vnoremap <buffer> <Leader>cc :s/^\(.*\)/\/\* \1 \*\//ge<CR>
    autocmd FileType c,cpp vnoremap <buffer> <Leader>cu :s/\/\* \(.*\) \*\//\1/ge<CR>
	"fix horrible case statement indentation
	autocmd FileType c,cpp set cino=l1 
    "abrev
    autocmd FileType c,cpp iabbrev <buffer> iff if()<left>
    ""cpp file
augroup END

augroup filetype_md
	autocmd!
    " settings for markdown
    autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab
augroup END

"pathogen
execute pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-plug
call plug#begin('~/.config/nvim/plugged')

"vimtex
Plug 'lervag/vimtex'

"vim-toml
Plug 'cespare/vim-toml'

"vim-table-mode
Plug 'dhruvasagar/vim-table-mode'

" Syntax highlighting 
Plug 'sheerun/vim-polyglot'

" Nord theme
Plug 'arcticicestudio/nord-vim'

" OneDark theme
Plug 'joshdick/onedark.vim'

call plug#end()
