"vimrc
"
"appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme nord
"set statusline
hi StatusLine term=reverse ctermbg=white ctermfg=black
set laststatus=2
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
"Window Div
hi VertSplit cterm=NONE
set fillchars+=vert:│
"globals
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
set nocompatible
filetype plugin on
set tabstop=4 shiftwidth=4
set smartindent
set mouse=a
set number relativenumber
set incsearch
set nohlsearch
set shortmess=I
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
"define commands
"open Netrw
nnoremap <Leader>f :Explore<cr>
"vimrc edit
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
"source my vimrc file
nnoremap <Leader>sv :source $MYVIMRC<cr>
"ctags
command! MakeTags !ctags -R .
"easy resize
nnoremap <C-J> :resize +5<CR>
nnoremap <C-K> :resize -5<CR>
nnoremap <C-H> :vertical resize -5<CR>
nnoremap <C-L> :vertical resize +5<CR>
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
"toggle relative line numbers
nnoremap <Leader>l :setlocal norelativenumber!<cr>
"inner next parentheses
onoremap in( :<c-u>normal! f(vi(<cr>
"inner prev parentheses
onoremap il( :<c-u>normal! F)vi(<cr>


augroup filetype_default
    nnoremap <Leader>cc I#<space><esc>
    nnoremap <Leader>cu 0xx
augroup END

augroup filetype_python
    autocmd FileType python set expandtab
augroup END

augroup filetype_vim
    autocmd FileType vim nnoremap <Leader>cc I"<space><esc>
    autocmd FileType vim nnoremap <Leader>cu 0xx
augroup END

augroup filetype_rust
    autocmd FileType rust nnoremap <Leader>cc I//<space><esc>
    autocmd FileType rust nnoremap <Leader>cu 0xxx
augroup END

augroup filetype_haskell
    autocmd FileType haskell nnoremap <Leader>cc I--<space><esc>
    autocmd FileType haskell nnoremap <Leader>cu 0xxx
augroup END

augroup filetype_c
    ""c file
    "keymap
    autocmd FileType c nnoremap <Leader>cc I//<space><esc>
    autocmd FileType c nnoremap <Leader>cu 0xxx
    "abrev
    autocmd FileType c iabbrev <buffer> iff if ()<left>
    ""header file
    autocmd FileType h nnoremap <Leader>cc I//<space><esc>
    autocmd FileType h nnoremap <Leader>cu 0xxx
augroup END

augroup filetype_md
    " settings for markdown
    autocmd FileType markdown set tabstop=2 shiftwidth=2 expandtab
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-plug
call plug#begin('~/.vim/plugged')

"vimtex
Plug 'lervag/vimtex'

"vim-toml
Plug 'cespare/vim-toml'

"vim-table-mode
Plug 'dhruvasagar/vim-table-mode'
call plug#end()
