" .vimrc
" 

" Pathogen ------------------------------------------------------ {{{ 
filetype plugin indent on
call pathogen#infect()
call pathogen#helptags()
" }}}

" Options ------------------------------------------------------- {{{
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

set noswapfile
" }}}

" Mappings ------------------------------------------------------- {{{

" Set leader to ,
let mapleader = ","

" jj has same behavior as <ESC>
inoremap jj <ESC>

" Make Y behave like C & D
nnoremap Y y$

" Arrow keys move at turbo speed
nnoremap <down> 4j
nnoremap <up> 4k
nnoremap <right> 4l
nnoremap <left> 4h

" CTRL-{j,k,l,h} to switch windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l 
nnoremap <c-h> <c-w>h 

" Catch accidental uppercase W when quitting
cnoremap Wq wq

" Open or close the NERDTree window
nnoremap <leader>t :NERDTreeToggle<cr>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeHighlightCursorLine = 1

" vim-cakephp shortcuts
nnoremap <leader>cv :Cview<cr>
nnoremap <leader>cc :Ccontroller<cr>
nnoremap <leader>cm :Cmodel<cr>

" fugitive shortcuts
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gci :Gcheckout<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gh :Gbrowse<cr>

" Write ROs as root
cnoremap w!! w !sudo tee % > /dev/null

" Edit vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Set current directory to directory of file
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

" ctrlp
nnoremap <leader>p :CtrlP<cr>

" }}}

" Solarized colorscheme ------------------------------------------ {{{
syntax enable
set background=dark
colorscheme solarized
set t_Co=16
" }}}

" Set the status line
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P

" CoffeeScript & LESS -------------------------------------------- {{{

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

" Highlight lines longer than 80 chars
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Abbreviations
iabbrev @@ ndreynolds@gmail.com
iabbrev ndr Nick Reynolds

au VimResized * exe 'normal! \<c-w>='

" FileType Autocommands ------------------------------------------ {{{
augroup FTOptions
    autocmd FileType python  setlocal sw=4 sts=4
    autocmd FileType gitcommit,markdown setlocal spell
    autocmd FileType help nnoremap <silent><buffer> q :q<CR>
augroup END
" }}}
