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
filetype plugin indent on

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
