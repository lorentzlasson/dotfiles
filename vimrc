set number
set nowrap
" set clipboard=unnamed "osx
set clipboard+=unnamedplus "linux
syntax enable
colorscheme railscasts

set list
set listchars=tab:>-

" auto delete trailing white spaces for all filetypes except markdown
let allow_trailing_whitespace = ['markdown']
autocmd BufWritePre * if index(allow_trailing_whitespace, &ft) < 0 | %s/\s\+$//e

set cursorcolumn
set ruler " display column no
set showcmd

" auto read from file when gaining focus
au FocusGained,BufEnter * :silent! !

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Indentation ======================

" tabs
" set tabstop=2 autoindent noexpandtab shiftwidth=2

" spaces
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Spell check =======================
:set spell spelllang=en_us

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Terminal ========================
tnoremap <Esc> <C-\><C-n>

" ================ Tabs ========================
let g:lasttab = 1
nmap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
au TabLeave * let g:lasttab = tabpagenr()

" ================ NERDTree ========================
nnoremap <C-n> :NERDTreeTabsToggle<cr>
let g:NERDTreeChDirMode=2 " follow current dir

" lint
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']

" silver searcher
let g:ackprg = 'ag --vimgrep'

" JamshedVesuna/vim-markdown-preview
let vim_markdown_preview_github=1

let mapleader = "\<Space>"

nnoremap <M-Enter> O<Esc>
nnoremap <Enter> o<Esc>
nnoremap <M-f> :Ag<cr>
nnoremap <C-f> :FZF<cr>
nnoremap <M-a> gg<S-V>G
nmap <S-y> v$y<ESC>
inoremap <C-s> <ESC>:w<cr>
nnoremap <leader> <C-w>
nnoremap <leader>ntf :NERDTreeFind<cr>
" DRYable?
nnoremap <leader><leader> 1<C-w>w
nnoremap <leader>1 1<C-w>w
nnoremap <leader>2 2<C-w>w
nnoremap <leader>3 3<C-w>w
nnoremap <leader>> 20<C-w>>
nnoremap <leader>< 20<C-w><

nnoremap <C-w> :echo "Use leader instead!"<cr>

vnoremap // y/<C-R>"<Esc>
:ca rel so ~/.vimrc
:ca cpp let @+ = expand("%")
" open current buffer in NERDTree
map <leader>r :NERDTreeFind<cr>

" making $ useful in visual mode
vnoremap $ $h

"smart indent when entering insert mode with A on empty lines
function! IndentWithA()
  if len(getline('.')) == 0
    return "cc"
  else
    return "A"
  endif
endfunction
nnoremap <expr> A IndentWithA()

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'benekastah/neomake'
Plug 'lukaszb/vim-web-indent'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'gregsexton/MatchTag'
Plug 'fatih/vim-go'
Plug 'mxw/vim-jsx'
Plug 'elixir-lang/vim-elixir'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-rails'
Plug 'ngmy/vim-rubocop'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'skwp/greplace.vim'
Plug 'tpope/vim-endwise'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-abolish'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'tpope/vim-rhubarb'
Plug 'jpo/vim-railscasts-theme'
"Plug 'Shougo/deoplete.nvim'
call plug#end()
