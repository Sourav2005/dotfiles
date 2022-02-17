syntax on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set numberwidth=4
set relativenumber
set signcolumn=number
set noswapfile
set nobackup
set undofile
set incsearch
set nohlsearch
set ignorecase
set smartcase
set nowrap
set splitbelow
set splitright
set hidden
set scrolloff=8
set noshowmode
set updatetime=250
set encoding=UTF-8
set mouse=a
set cmdheight=1
set shortmess+=c
set showtabline=2
set colorcolumn=80
set bg=dark
set cursorline
filetype plugin indent on
if has('termguicolors')
    set termguicolors
endif

let mapleader = " "
nnoremap <leader>v :e $MYVIMRC<CR>

" set cursor
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au VimEnter,VimResume * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

au VimLeave,VimSuspend * set guicursor=a:ver90-blinkon1

" clipboard
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'szw/vim-maximizer'
Plug 'kassio/neoterm'
Plug 'tpope/vim-commentary'
Plug '9mm/vim-closer'
Plug 'tweekmonster/startuptime.vim'
Plug 'lunarvim/colorschemes'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'tomasiser/vim-code-dark'
call plug#end()

" vim-maximizer
nnoremap <C-m> :MaximizerToggle!<CR>

" neoterm
let g:neoterm_default_mod = 'vertical'
let g:neoterm_autoinsert = 1
let g:neoterm_autoscroll = 1
let g:neoterm_term_per_tab = 1
nnoremap <c-y> :Ttoggle<CR>
inoremap <c-y> <Esc>:Ttoggle<CR>
tnoremap <c-y> <c-\><c-n>:Ttoggle<CR>
nnoremap <leader>x :TREPLSendLine<CR>
vnoremap <leader>x :TREPLSendSelection<CR>
if has('nvim')
  au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
endif

" colorscheme
colorscheme onedarker

" lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ 'colorscheme': 'one',
      \ }
