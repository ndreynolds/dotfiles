" Pathogen
filetype plugin indent on
call pathogen#infect()
call pathogen#helptags()

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

" Solarized stuff
syntax enable
set background=dark
colorscheme solarized
set t_Co=16

" Set the status line
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P

if executable('coffee')
    " Compile coffee-script on write 
    au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
endif
if executable('lessc')
    " Compile less-css on write
    au BufWritePost *.less silent !lessc %:p > %:r.css
endif

function! s:Nosetests(quiet)
    exec '! nosetests --where ' . shellescape(expand('%:h')) . ' > /dev/null'
    if a:quiet
        redraw!
    endif
    if v:shell_error
        hi! StatusLine term=reverse ctermbg=White ctermfg=DarkRed gui=undercurl guifg=DarkRed
        set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}
        set statusline+=%y\ Nose:\ Tests\ Failed\ %=%-16(\ %l,%c-%v\ %)%P
    endif
endfunction

command! -n=0 Nose call s:Nosetests(1)
