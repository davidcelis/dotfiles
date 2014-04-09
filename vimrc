" Vundle

if &shell =~# 'fish$'
  set shell=/usr/local/bin/zsh
endif

set nocompatible
filetype off
set encoding=utf-8

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Bundle 'bling/vim-airline'

Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-dispatch'
Bundle 'ekalinin/Dockerfile.vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-tbone'

Bundle 'ervandew/ag'
Bundle 'jiangmiao/auto-pairs'
Bundle 'kien/ctrlp.vim'
Bundle 'JazzCore/ctrlp-cmatcher'
Bundle 'bogado/file-line'
Bundle 'myusuf3/numbers.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'stephencelis/vim-mml'

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
set cindent
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
