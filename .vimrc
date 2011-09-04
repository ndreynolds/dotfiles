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
map <down> 4j
map <up> 4k
map <right> 4l
map <left> 4h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l 
map <C-h> <C-w>h 
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

" Pathogen
filetype plugin indent on
call pathogen#infect()
call pathogen#helptags()

" Solarized stuff
syntax enable
set background=dark
colorscheme solarized
set t_Co=16

" Compile coffee-script on write 
au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
