syntax on
set number
set tabstop=4
set expandtab
set shiftwidth=4

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

let mapleader = ","

inoremap jj <ESC>
map <down> <C-w>j
map <up> <C-w>k
map <right> <C-w>l
map <left> <C-w>h
map <C-j> 4j
map <C-k> 4k
map <C-l> 4l
map <C-h> 4h
nmap <C-Up> [e
nmap <C-Down> ]e
cmap Wq wq
cmap W w 
cmap Q q
map <leader>t :NERDTreeToggle<CR>
map <leader>v :Cview<CR>
map <leader>c :Ccontroller<CR>
map <leader>m :Cmodel<CR>

set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P

filetype plugin indent on
call pathogen#infect()
call pathogen#helptags()

syntax enable
set background=dark
colorscheme solarized
set t_Co=16
