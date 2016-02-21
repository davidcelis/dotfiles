" Vundle
if &shell =~# 'fish$'
  set shell=/usr/local/bin/zsh
endif

set nocompatible
set encoding=utf-8

call plug#begin('~/.vim/plugged')

" Theming
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bogado/file-line'
Plug 'myusuf3/numbers.vim'
Plug 'airblade/vim-gitgutter'

" Syntaxes
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
Plug 'tpope/vim-haml',          { 'for': 'haml' }
Plug 'tpope/vim-markdown',      { 'for': 'markdown' }
Plug 'tpope/vim-rails',         { 'for': 'ruby' }
Plug 'stephencelis/vim-mml',    { 'for': 'mml' }

" Utilities
Plug 'tpope/vim-bundler',       { 'on': 'Bundle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch',      { 'on': 'Dispatch' }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'rking/ag.vim',            { 'on': 'Ag' }
Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'
Plug 'JazzCore/ctrlp-cmatcher'
Plug 'benmills/vimux'

call plug#end()

" Speed
nnoremap ; :

" Theme/Colors
syntax on
colorscheme Tomorrow-Night
set background=dark
set cursorline
set nowrap
set numberwidth=4
set visualbell

highlight ColorColumn ctermbg=233
call matchadd('ColorColumn', '\%81v', 100)
set list
set listchars=""
set listchars=tab:\ \
set listchars+=trail:.
set listchars+=extends:>
set listchars+=precedes:<

set wildmenu
set wildmode=list:longest,full

" Indentation
set autoindent
set expandtab
set shiftwidth=2
set smartindent
set tabstop=2

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" Code folding
set foldmethod=syntax
set foldminlines=3
set foldlevel=100

" Ignore tmp/ directories
set wildignore+=*/tmp/*

" Interaction
set backspace=indent,eol,start
set laststatus=2
set number
set scrolloff=3
set sidescrolloff=5
set showcmd

" Undo
set undodir=~/.vim/tmp
set undofile
set undolevels=1000
set undoreload=10000

set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

" git
hi def link gitcommitOverflow WarningMsg

" Make
au FileType make setlocal noexpandtab

" Markdown
function! s:Wrap()
  set wrap linebreak nolist
  set textwidth=120
  call matchadd('ColorColumn', '\%121v', 100)
endfunction

autocmd BufWritePre * :%s/\s\+$//e
autocmd BufRead,BufNewFile *.md set filetype=markdown
au FileType markdown call s:Wrap()

" Mml
augroup myvimrc
  au!
  autocmd FileType mml nnoremap <leader>m :w<cr>:MmlMake<cr>
augroup END

" Ctrl-P
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" Dispatch
augroup dispatch
  au!
  autocmd BufNewFile,BufRead *_spec.rb compiler rspec
  autocmd BufNewFile,BufRead *_spec.rb set makeprg=bundle\ exec\ rspec\ %
  autocmd BufNewFile,BufRead *_test.rb compiler rake
  autocmd BufNewFile,BufRead *_test.rb set makeprg=bundle\ exec\ rake\ minitest\ TEST=%
augroup END

" Airline
let g:airline_powerline_fonts=1
let g:airline_theme='base16'
