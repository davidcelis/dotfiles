" Vundle
if &shell =~# 'fish$'
  set shell=/usr/local/bin/zsh
endif

set nocompatible
filetype off
set encoding=utf-8

set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/vundle'

" Theming
Plugin 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plugin 'junegunn/goyo.vim'
Plugin 'bling/vim-airline'
Plugin 'bogado/file-line'
Plugin 'myusuf3/numbers.vim'
Plugin 'airblade/vim-gitgutter'

" Syntaxes
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'stephencelis/vim-mml'

" Utilities
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-tbone'
Plugin 'ervandew/ag'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
Plugin 'JazzCore/ctrlp-cmatcher'

call vundle#end()
filetype plugin indent on

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
set undodir=~/.vim/_temp
set undofile
set undolevels=1000
set undoreload=10000

set backupdir=~/.vim/_temp
set directory=~/.vim/_temp

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
let g:airline_theme='tomorrow'
