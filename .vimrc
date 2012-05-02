" .vimrc
" Author:     Nick Reynolds <ndreynolds@gmail.com>
" Repository: http://github.com/ndreynolds/dotfiles


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
set wildignore+=.git,.svn,.hg,.pyc,.sw?
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

" No-shift-key-required alternatives
nnoremap <leader>w :w<cr>
nnoremap <leader>wq :wq<cr>

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
" (gc is used by TComment)
nnoremap <leader>go :Gcheckout<cr> 
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gh :Gbrowse<cr>

" Reflow text to 80 cols
nnoremap <leader>sw :set textwidth=80<cr>:normal! gggqG<esc>

" Give the buffer a header comment
nnoremap <leader>ti :call HeaderComment()<cr>

" Write ROs as root
cnoremap w!! w !sudo tee % > /dev/null

" Write file with 'eventignore' set.
cnoremap w-- noautocmd w

" Toggle spellcheck
nnoremap <leader>sp :set spell!<cr>

" Edit vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Set current directory to directory of file
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

" Quick open some URLs.
nnoremap <leader>og :OpenURL google.com<cr>
nnoremap <leader>om :OpenURL mail.google.com<cr>
nnoremap <leader>oh :OpenURL github.com<cr>
nnoremap <leader>on :OpenURL news.ycombinator.com<cr>
nnoremap <leader>oc :OpenURL my.cl.ly<cr>
nnoremap <leader>os :OpenURL grooveshark.com<cr>
nnoremap <leader>ol :OpenURL localhost<cr>

" ctrlp
nnoremap <leader><leader> :CtrlP<cr>

" }}}


" Functions ------------------------------------------------------ {{{

" Prepend a header comment with the filename and a dashed line.
function! HeaderComment()
    " Prepend the buffer with filename and a dashed line.
    call append(0, [expand('%:t'), repeat('-', strlen(expand('%:t')))])
    " Comment it out with TComment
    exe ':1,2 TComment'
endfunction

" Open a URL using a system-appropriate opener
function! OpenURL(url)
    let url = a:url
    " Prepend http:// if necessary.
    if url !~ "http://"
        let url = "http://" . url
    endif
    " Mac? Use open.
    if system("uname") =~ "Darwin"
        " Run the cmd with a & to take back our prompt.
        silent call system("open " . url . " &")
    " Windows?
    elseif has("win32") || has("win64")
        silent call system("start " . url)
    " Some *nix? Does it have xdg-open?
    elseif has("unix") && executable('xdg-open')
        silent call system("gnome-open " . url . " &")
    else
        echoe "Couldn't find a suitable url opener."
    endif
    redraw!
endfunction
command! -nargs=1 OpenURL :call OpenURL(<f-args>)

" }}}


" Statusline ----------------------------------------------------- {{{

set statusline=[%n]\ %<%.99f\ %h%w%m%r%{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P

" }}}


" Misc ----------------------------------------------------------- {{{

" Highlight lines longer than 80 chars
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Solarized colorscheme stuff
syntax enable
set background=dark
colorscheme solarized
set t_Co=16

" }}}


" Abbreviations -------------------------------------------------- {{{

iabbrev @@ ndreynolds@gmail.com
iabbrev ndr Nick Reynolds

" }}}


" Event Autocommands --------------------------------------------- {{{

" Compile coffee-script on write, if coffee is executable
" if executable('coffee')
"     au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
" endif

" Compile less on write, if lessc is executable
" if executable('lessc')
"     au BufWritePost *.less silent !lessc %:p > %:r.css
" endif

" Save when focus is lost
au FocusLost * :wa

" Resize splits on window resize
au VimResized * :wincmd =

au BufNewFile,BufRead *.jst set syntax=jst
au BufNewFile,BufRead *.json set filetype=json
au BufNewFile,BufRead *.tpl set filetype=html.twig

" }}}


" FileType Autocommands ------------------------------------------ {{{

augroup FTOptions
    autocmd Filetype coffee,ruby,css,html,less,jst,json,html.twig setlocal ai et sw=2 sts=2
    autocmd FileType gitcommit,markdown setlocal spell
    autocmd FileType help nnoremap <silent><buffer> q :q<CR>
augroup END

" }}}
