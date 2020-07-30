"vimrc
"
"appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set statusline
set laststatus=2
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
"Window Div
hi VertSplit cterm=NONE
set fillchars+=vert:│
"settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"filetype plugin on
set tabstop=4 shiftwidth=4
set smartindent
set mouse=a
set number relativenumber
set incsearch
set nohlsearch
set ignorecase
set smartcase
set shortmess=I
set hidden
"set auto maximize on by default
let tautomax=1
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
"Easier tag navigation
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 5gt
nnoremap <leader>7 5gt
nnoremap <leader>8 5gt
nnoremap <leader>9 5gt
"easy resize
nnoremap <C-J> :resize +5<CR>
nnoremap <C-K> :resize -5<CR>
nnoremap <C-H> :vertical resize -5<CR>
nnoremap <C-L> :vertical resize +5<CR>
"`Maximize` current window
function! ToggleAutoMaximize()
	if exists('g:tautomax')
		autocmd! maxCurrWin
		wincmd =
		unlet g:tautomax
	else
		augroup maxCurrWin
			"autocmd! WinEnter * call Maximize()
			autocmd! WinEnter * wincmd _
		augroup END
		do maxCurrWin WinEnter 
		let g:tautomax=1
	endif
endfunction
function! Maximize()
	wincmd |
	wincmd _
endfunction
nnoremap <Leader>max :call ToggleAutoMaximize()<CR>
nnoremap <C-w>m :call Maximize()<CR>
"insert date
nnoremap <Leader>d "=strftime("%x %H:%M:%S")<CR>P
"insert deadline
nnoremap <Leader>D <end>"=strftime(" DEADLINE <%x %H:%M:%S>")<CR>p
"paste from clipboard
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
"yank to clipboard
vnoremap <Leader>y "+y
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
"grep Todos
nnoremap <Leader>td :grep "TODO" src/*<CR><CR>:cw<CR>
"change `zt` so that it leaves some space above the current line
nnoremap zt zt3<C-y>
"create `scratch` buffer
function! ScratchBuffer(...)
	let l:fname = get(a:, 1, "")
	execute "new " . l:fname
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
endfunction
command! -nargs=? Scratch call ScratchBuffer(<f-args>)

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
    autocmd FileType vim nnoremap <buffer> <Leader>cc I"<space><esc>
    autocmd FileType vim nnoremap <buffer> <Leader>cu 0xx
	autocmd FileType vim vnoremap <buffer> <Leader>cc :s/^\(\s*\)\(.\+\)/\1" \2/<CR>
	"TODO: Fix this V
	autocmd FileType vim vnoremap <buffer> <Leader>cu :s/\(^\s*\)\/\/ /\1/<CR>
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
    autocmd FileType c,cpp nnoremap <buffer> <Leader>cc I//<space><esc>
    autocmd FileType c,cpp nnoremap <buffer> <Leader>cu 0xxx
	autocmd FileType c,cpp vnoremap <buffer> <Leader>cc :s/^\(\s*\)\(.\+\)/\1\/\/ \2/<CR>
	autocmd FileType c,cpp vnoremap <buffer> <Leader>cu :s/\(^\s*\)\/\/ /\1/<CR>
	autocmd FileType c,cpp vnoremap <buffer> <Leader>cb :<C-u>'<s/\(^.*$\)/\/*\1/<CR>:<C-u>'>s/\(^.*$\)/\1*\//<CR>
    "abrev
    autocmd FileType c,cpp iabbrev <buffer> iff if ()<left>
    ""cpp file
augroup END

augroup filetype_md
	autocmd!
    " settings for markdown
    autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab
augroup END

" Pathogen
execute pathogen#infect('~/.config/nvim/bundle/{}')

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

call plug#end()
