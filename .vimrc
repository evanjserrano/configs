" Use spaces instead of tabs
set expandtab

" Be smart when using tabkey
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

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

set smartcase
set hlsearch
" set colorcolumn=80

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
colorscheme delek
hi Search cterm=NONE ctermfg=BLACK ctermbg=DARKCYAN

set mouse=a



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
" map <C-K> :pyf /usr/local/Cellar/clang-format/11.0.0/share/clang/clang-format.py<cr>
" imap <C-K> <c-o>:pyf /usr/local/Cellar/clang-format/11.0.0/share/clang/clang-format.py<cr>

" function! Formatonsave()
"   let l:formatdiff = 1
"   pyf /usr/local/Cellar/clang-format/11.0.0/share/clang/clang-format.py
" endfunction
" autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()
