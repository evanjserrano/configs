" Use spaces instead of tabs
set expandtab

" Be smart when using tabkey
set smarttab

" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2

" Enable filetype plugins
filetype plugin on
filetype indent on

set guioptions=Te
set ai "Auto indent
set si "Smart indent
set nowrap "Don't wrap lines
set cindent
set ruler
set lbr
set ignorecase
set nu
set cursorline
set so=5 "scrolloff have 10 char buffer above/below cursor

set smartcase
set hlsearch
set colorcolumn=100

set splitbelow
set splitright

au VimLeave * :!clear

" Navigate windows with single key presses
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l
nmap <C-h> <C-W>h
nmap <Space> $

" Faster split windows
"nmap <C-s> <C-W>s<C-W>j
"nmap <C-d> <C-W>v<C-W>l
" no FZF
" nmap <C-s> <C-W>s<C-W>j:e.<CR>
" nmap <C-d> <C-W>v<C-W>l:e.<CR>
" FZF
nmap <C-s> <C-W>s:FZF<CR>
nmap <C-c> <C-W>v:FZF<CR>
nmap <C-t> :tabe<CR>:FZF<CR>
nmap <C-p> :FZF<CR>
cabbrev bterm bo term
cabbrev bt bo term
cabbrev NERDTree NERDTreeToggle
nmap <C-n> :NERDTree<CR>

" Function for determining the remap setting for { Gets current file type
function GetFileType()

  " Declare an array of filetypes that we want the spaced out curly braces
  let fts = ['c', 'cpp', 'ino', 'h', 'java', 'objc', 'haskell', 'javascript']

  " Grab filetype of current file
  let curr = &filetype

  " See if our current filetype is in our list
  if index(fts, curr) == -1

    " Not found, return 0 (false)
    return 0
  else

    " Found it, return 1 (true)
    return 1
  endif
endfunction
"inoremap <expr> { (GetFileType() == 1 ? '{ <Esc>o}<Esc>kA' : '{<Esc>a')

" Set to auto read when a file is changed from the outside
set autoread

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=1

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

set virtualedit=insert,block,onemore

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

syntax on
hi Search cterm=NONE ctermfg=BLACK ctermbg=DARKCYAN
hi CursorLine cterm=BOLD ctermfg=NONE ctermbg=NONE

set mouse=a

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdtree'
  Plug 'francoiscabrol/ranger.vim'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'wincent/ferret'
  Plug 'google/vim-maktaba'
  Plug 'bazelbuild/vim-bazel'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'ericbn/vim-solarized'
  Plug 'github/copilot.vim'
  Plug 'joshdick/onedark.vim'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
call plug#end()

let g:NERDTreeHijackNetrw = 0  " add this line if you use NERDTree
let g:ranger_replace_netrw = 1 " open ranger when vim open a directory

colorscheme onehalfdark

"copilot keybindings
"ALT-]
inoremap ‘ <Plug>(copilot-next)
"ALT-[
inoremap “ <Plug>(copilot-previous)
"ALT-\
inoremap « <Plug>(copilot-suggest)

nmap <M-]> <D-]>

"Mode Settings

" let &t_SI.="\e[5 q" "SI = INSERT mode
" let &t_SR.="\e[4 q" "SR = REPLACE mode
" let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

"Cursor settings:

"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar


" clang-format
if has('python')
  map <C-Q> :pyf /usr/share/vim/addons/syntax/clang-format.py<cr>
  imap <C-Q> :pyf /usr/share/vim/addons/syntax/clang-format.py<cr>
elseif has('python3')
  map <C-Q> :py3f /usr/share/vim/addons/syntax/clang-format.py<cr>
  imap <C-Q> :py3f /usr/share/vim/addons/syntax/clang-format.py<cr>
endif

function! Formatonsave()
  let l:formatdiff = 1
  if has('python')
    :pyf /usr/share/vim/addons/syntax/clang-format.py
  elseif has('python3')
    :py3f /usr/share/vim/addons/syntax/clang-format.py
  endif
endfunction
autocmd BufWritePre *.c,*.h,*.cc,*.hh,*.cpp,*.hpp,*.inl call Formatonsave()

" Show cursorline/column only in focused window
augroup CursorLine
    au!
    au BufWinEnter,BufEnter,FocusGained,VimEnter,WinEnter * setlocal cursorline
    au BufWinLeave,BufLeave,FocusLost,VimLeave,WinLeave * setlocal nocursorline
augroup END

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'relative': v:true} }
