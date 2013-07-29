" .vimrc
" Author:     Nick Reynolds <ndreynolds@gmail.com>
" Repository: http://github.com/ndreynolds/dotfiles


" Vundle & Plugins ---------------------------------------------- {{{ 

set nocompatible
filetype off

let s:needs_vundle = !isdirectory($HOME . '/.vim/bundle/vundle')
if s:needs_vundle
  echo "-------------------------------"
  echo "Installing Vundle... Sit tight."
  echo "-------------------------------\n"
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
endif

if v:version < 703
  let g:loaded_youcompleteme = 1
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'briancollins/vim-jst'
Bundle 'digitaltoad/vim-jade'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'godlygeek/tabular'
Bundle 'groenewege/vim-less'
Bundle 'jcf/vim-latex'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'lukaszb/vim-web-indent'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'msanders/snipmate.vim'
Bundle 'rstacruz/sparkup'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/LanguageTool'
Bundle 'vim-scripts/renamer.vim'
Bundle 'vim-scripts/slimv.vim'
Bundle 'vim-scripts/VOoM'
Bundle 'wavded/vim-stylus'

filetype plugin indent on

if s:needs_vundle
  :BundleInstall
endif

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
set mouse=a
set iskeyword+=\-

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set foldmethod=marker


" Store swap, backup and undo files within .vim/ 
" Make the directories as needed.

if !isdirectory($HOME . '/.vim/swap')
  :silent !mkdir -p ~/.vim/swap > /dev/null 2>&1
endif
set dir=~/.vim/swap

if !isdirectory($HOME . '/.vim/backup')
  :silent !mkdir -p ~/.vim/backup > /dev/null 2>&1
endif
set backupdir=~/.vim/backup
set backup

if exists("+undofile")
  if !isdirectory($HOME . '/.vim/undo')
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=~/.vim/undo
  set undofile
endif

" }}}


" Plugin Configuration ------------------------------------------- {{{

let g:syntastic_javascript_checker = 'jshint'
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

let g:tex_flavor = 'latex'

" LanguageTool
let jar = '/usr/local/Cellar/languagetool/2.1/libexec/languagetool-commandline.jar'
if filereadable(jar)
  let g:languagetool_jar = jar
endif
let g:languagetool_disable_rules = 'WHITESPACE_RULE,EN_QUOTES,TYPOGRAFISCHE_ANFUEHRUNGSZEICHEN'

" Slimv servers
if has('unix') && system('uname') =~ 'Darwin'
  function! BuildTermCmd(cmd)
    return '!osascript -e "tell application \"Terminal\" to do script \"' . a:cmd . '\""'
  endfunction

  let g:slimv_swank_cmd = BuildTermCmd('sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp')
  let g:slimv_swank_scheme = BuildTermCmd("scheme --eval '(let loop () (start-swank) (loop))'")
endif

" Make Powerline fancy
if $POWERLINE_FANCY
  let g:Powerline_symbols='fancy'
endif

" Set git exec path 
"
" `push.default = simple` throws an error with Apple Git 1.7
" Try to find and use 1.8
if filereadable('/usr/local/bin/git')
  let g:fugitive_git_executable = '/usr/local/bin/git'
endif


" Solarized colorscheme
"
" Only active if within the matching $ITERM_PROFILE.
if $ITERM_PROFILE == 'SolarizedLight' || $ITERM_PROFILE == 'SolarizedDark'
  if $ITERM_PROFILE == 'SolarizedLight'
    set background=light
  elseif $ITERM_PROFILE == 'SolarizedDark'
    set background=dark
  endif

  syntax enable
  colorscheme solarized
  set t_Co=16
endif

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeHighlightCursorLine = 1

" }}}


" Mappings ------------------------------------------------------- {{{

" Set leader to ,
let mapleader = ","

" jj has same behavior as <ESC>
inoremap jj <ESC>

" Make Y behave like C & D
nnoremap Y y$

" Arrow keys move at turbo speed
nnoremap <left>  4h
nnoremap <down>  4j
nnoremap <up>    4k
nnoremap <right> 4l
vnoremap <left>  4h
vnoremap <down>  4j
vnoremap <up>    4k
vnoremap <right> 4l

" Stop vim-latex from stealing <c-j> 
nnoremap <leader>m <Plug>IMAP_JumpForward

" CTRL-{j,k,l,h} to switch windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l 
nnoremap <c-h> <c-w>h 

" Catch accidental shift keys
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file Wqa wqa<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang -nargs=* -complete=file Q q<bang> <args>
command! -bang -nargs=* -complete=file Vsp vsp<bang> <args>

" No-shift-key-required alternatives
nnoremap <leader>w :w<cr>
nnoremap <leader>wq :wq<cr>

" Open or close the NERDTree window
nnoremap <leader>tt :NERDTreeToggle<cr>

" vim-cakephp shortcuts
nnoremap <leader>cv :Cview<cr>
nnoremap <leader>cc :Ccontroller<cr>
nnoremap <leader>cm :Cmodel<cr>

" vim-rails shortcuts
nnoremap <leader>rv :Rview<cr>
nnoremap <leader>rc :Rcontroller<cr>
nnoremap <leader>rm :Rmodel<cr>

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

" EasyMotion
let g:EasyMotion_leader_key = '<leader><space>'

" Reflow text to 80 cols
nnoremap <leader>sw :set textwidth=80<cr>:normal! gggqG<esc>

" Give the buffer a header comment
nnoremap <leader>ti :call s:HeaderComment()<cr>

" Write ROs as root
cnoremap w!! w !sudo tee % > /dev/null

" Write file with 'eventignore' set.
cnoremap w-- noautocmd w

" Toggle spellcheck
nnoremap <leader>sp :set spell!<cr>

" Edit vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Set current directory to directory of file
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

" Quick open some URLs.
nnoremap <leader>ox :OpenURLAtCursor<cr>
vnoremap <leader>ox :OpenURLAtCursor<cr>
nnoremap <leader>og :OpenURL google.com<cr>
nnoremap <leader>om :OpenURL mail.google.com<cr>
nnoremap <leader>oh :OpenURL github.com<cr>
nnoremap <leader>on :OpenURL news.ycombinator.com<cr>
nnoremap <leader>oc :OpenURL my.cl.ly<cr>
nnoremap <leader>os :OpenURL grooveshark.com<cr>
nnoremap <leader>ov :OpenURL tnerual.eriogerg.free.fr/vimqrc.html<cr>
nnoremap <leader>ol :OpenURL localhost<cr>

" Show definition of word under cursor
nnoremap <leader>d :call OpenURL("dict.cc/?s=" . expand("<cword>"))<cr>

" Copy to Mac clipboard (if on a Mac and not in MacVim)
if system("uname") =~ "Darwin" && !has("gui_running")
  vnoremap "+y !pbcopy<cr>u
endif

" Open scratchpad
nnoremap <leader>p :set paste!<cr>

" ctrlp
nnoremap <leader><leader> :CtrlP<cr>

" Pretty print JSON and XML
nnoremap <leader>j :%!python -m json.tool<cr>
vnoremap <leader>j :!python -m json.tool<cr>
nnoremap <leader>x :%!tidy -i -q -asxhtml -utf8<cr>
vnoremap <leader>x :!tidy -i -q -xml -utf8<cr>

" Underline a heading
nnoremap <leader>u yyp<c-v>$r-

" * and # in visual mode search for the selection (from Practical Vim)
xnoremap * :<c-u>call <sid>VSetSearch()<cr>/<c-r>=@/<cr><cr> 
xnoremap # :<c-u>call <sid>VSetSearch()<cr>?<c-r>=@/<cr><cr>

" Tabularize shortcuts
nnoremap <leader>a= :Tabularize /=<cr>
vnoremap <leader>a= :Tabularize /=<cr>
nnoremap <leader>a: :Tabularize /:\zs<cr>
vnoremap <leader>a: :Tabularize /:\zs<cr>
nnoremap <leader>ac :Tabularize /,\zs\+/<cr>
vnoremap <leader>ac :Tabularize /,\zs\+/<cr>

" Rspec with Dispatch
nnoremap <leader>r :Dispatch rspec %<cr>

" }}}


" Functions ------------------------------------------------------ {{{

" Open my scratchpad
function! s:OpenScratchpad()
  if $SCRATCHPAD
    exe ":Gist " . $SCRATCHPAD
    au! BufLeave,FocusLost * silent! wall
  else
    echoe "No $SCRATCHPAD"
  endif
endfunction
command! OpenScratchpad call s:OpenScratchpad()

" Prepend a header comment with the filename and a dashed line.
function! s:HeaderComment()
  " Prepend the buffer with filename and a dashed line.
  call append(0, [expand('%:t'), repeat('-', strlen(expand('%:t')))])
  " Comment it out with TComment
  exe ':1,2 TComment'
endfunction

" Open a URL using a system-appropriate opener
function! OpenURL(url)
  let url = a:url
  if url !~ "http://"
    let url = "http://" . url
  endif

  " Mac?
  if system("uname") =~ "Darwin" " Mac ?
    silent call system('open "' . url . '" &')
  " Windows?
  elseif has("win32") || has("win64")
    silent call system("start " . url)
  " Some *nix? Does it have xdg-open?
  elseif has("unix") && executable("xdg-open")
    silent call system("xdg-open " . url . " &")
  else
    echoe "Couldn't find a suitable url opener."
  endif

  redraw!
endfunction
command! -nargs=1 OpenURL call OpenURL(<f-args>)

" Open a URL that's under the cursor or visually selected
function! OpenURLAtCursor()
  if mode() ==# 'n'
    let uri = expand("<cWORD>")
    if match(uri, "://")
      let uri = expand("<cfile>")
    endif
  else
    let uri = s:GetSelectedText()
  endif

  call OpenURL(uri)
endfunction
command! -bar OpenURLAtCursor call OpenURLAtCursor(<f-args>)

function! s:GetSelectedText()
  let save_z = getreg('z', 1)
  let save_z_type = getregtype('z')

  try
    normal! gv"zy
    return @z
  finally
    call setreg('z', save_z, save_z_type)
  endtry
endfunction

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g') 
  let @s = temp
endfunction

function! s:ReloadChrome()
  if exists('g:autoloaded_rails')
    silent call system("osascript ~/dotfiles/bin/reload-chrome.scpt ")
  endif
endfunction

" }}}


" Statusline ----------------------------------------------------- {{{

set statusline=[%n]\ %<%.99f\ %h%w%m%r%{fugitive#statusline()}%{SyntasticStatuslineFlag()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P

" }}}


" Misc ----------------------------------------------------------- {{{

" Highlight lines longer than 80 chars
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}


" Abbreviations -------------------------------------------------- {{{

iabbrev @@ ndreynolds@gmail.com
iabbrev ndr Nick Reynolds
iabbrev <expr> dts strftime("%c")

" }}}


" Event Autocommands --------------------------------------------- {{{

" Resize splits on window resize
au VimResized * :wincmd =

" Set syntax for a few template extensions
au BufNewFile,BufRead *.jst set syntax=jst
au BufNewFile,BufRead *.json set filetype=json
au BufNewFile,BufRead *.tpl set filetype=html.twig

au BufNewFile,BufRead *.txt set filetype=markdown

" JSON
au BufNewFile,BufRead *.json set filetype=javascript

" Header files should assume C (most likely for me)
au BufNewFile,BufRead *.h set filetype=c

if executable("osascript")
  au BufWritePost * call s:ReloadChrome()
endif

" }}}


" FileType Autocommands ------------------------------------------ {{{

augroup FTOptions
  autocmd Filetype python                   setlocal ai et sta sw=4 sts=4 tw=79
  autocmd Filetype cpp,cs,java              setlocal ai et sta sw=4 sts=4 cin
  autocmd Filetype c,ruby,coffee,javascript setlocal ai et sta sw=2 sts=2
  autocmd Filetype css,scss,less            setlocal ai et sta sw=2 sts=2
  autocmd Filetype jst,eruby,eco,haml       setlocal ai et sta sw=2 sts=2
  autocmd Filetype html,xhtml               setlocal ai et sta sw=2 sts=2
  autocmd Filetype html.twig,jade           setlocal ai et sta sw=2 sts=2
  autocmd Filetype eruby,yaml,json          setlocal ai et sta sw=2 sts=2
  autocmd Filetype cucumber                 setlocal ai et sta sw=2 sts=2
  autocmd Filetype vim,markdown             setlocal ai et sta sw=2 sts=2
  autocmd Filetype sh,bash,zsh              setlocal ai et sta sw=2 sts=2
  autocmd FileType gitcommit,markdown       setlocal spell
  autocmd FileType crontab                  set nobackup nowritebackup
  autocmd FileType help                     nnoremap <silent><buffer> q :q<cr>
augroup END

" }}}
