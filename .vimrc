" .vimrc
" 

" Pathogen ------------------------------------------------------ {{{ 
filetype plugin indent on
call pathogen#infect()
call pathogen#helptags()
" }}}

" General vim stuff --------------------------------------------- {{{
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
set foldmethod=marker

" Set leader to ,
let mapleader = ","

" jj has same behavior as <ESC>
inoremap jj <ESC>

" Arrow keys move at turbo speed
nmap <down> 4j
nmap <up> 4k
nmap <right> 4l
nmap <left> 4h

" CTRL-{j,k,l,h} to switch windows
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l 
nmap <C-h> <C-w>h 

" Catch accidental uppercase W when quitting
cnoremap Wq wq
" cnoremap W w

" Open or close the NERDTree window
nmap <leader>t :NERDTreeToggle<CR>

" vim-cakephp shortcuts
nmap <leader>v :Cview<CR>
nmap <leader>c :Ccontroller<CR>
nmap <leader>m :Cmodel<CR>
" }}}

" Solarized stuff ------------------------------------------------ {{{
syntax enable
set background=dark
colorscheme solarized
set t_Co=16
" }}}

" Set the status line
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P

" Fuzzy Finder map
nmap <leader>f :FufFileWithFullCwd<CR>

" Node-dependent stuff ------------------------------------------- {{{

" Compile coffee-script on write, if node/coffee is installed.
if executable('coffee')
    au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
endif

" Compile less-css on write, if node/lessc is installed.
if executable('lessc')
    " Compile less-css on write
    au BufWritePost *.less silent !lessc %:p > %:r.css
endif
" }}}

cmap w!! w !sudo tee % > /dev/null

au VimResized * exe 'normal! \<c-w>='
