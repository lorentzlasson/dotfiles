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

" ================ Elm ===========================
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:elm_syntastic_show_warnings = 1

" ================ Terminal ========================
tnoremap <Esc> <C-\><C-n>

" ================ Tabs ========================
let g:lasttab = 1
nmap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
au TabLeave * let g:lasttab = tabpagenr()

" ================ NERDTree ========================
let g:NERDTreeChDirMode=2 " follow current dir
let NERDTreeShowHidden=1

" lint
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_python_python_exe = 'python3'

" silver searcher
let g:ackprg = 'ag --vimgrep'
let g:fzf_history_dir = '~/.local/share/fzf-history'

" https://github.com/skwp/greplace.vim#customization
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

" JamshedVesuna/vim-markdown-preview
let vim_markdown_preview_github=1

nnoremap <C-n> :NERDTreeTabsToggle<cr>
nnoremap <C-f> :FZF<cr>
nnoremap <M-f> :Ag<cr>
nnoremap <M-a> gg<S-V>G
nnoremap <M-Enter> O<Esc>
nnoremap <Enter> o<Esc>
vnoremap $ $h
nmap <S-y> v$y<ESC>
vnoremap // y/<C-R>"<Esc>

" ===== Leader ====
let mapleader = "\<Space>"
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

:ca rel so ~/.vimrc
:ca cpp let @+ = expand("%")

:ca sqlformat !sqlformat --reindent --keywords upper --identifiers lower -

" map <leader><C-w>

" enable mouse selection https://github.com/neovim/neovim/issues/6082
set mouse=a

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
Plug 'AndrewRadev/splitjoin.vim'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'benekastah/neomake'
Plug 'elixir-lang/vim-elixir'
Plug 'elmcast/elm-vim'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'gregsexton/MatchTag'
Plug 'itspriddle/vim-shellcheck'
Plug 'jaawerth/neomake-local-eslint-first'
Plug 'jiangmiao/auto-pairs'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'jpo/vim-railscasts-theme'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user'
Plug 'lukaszb/vim-web-indent'
Plug 'mileszs/ack.vim'
Plug 'mxw/vim-jsx'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'ngmy/vim-rubocop'
Plug 'scrooloose/nerdtree'
Plug 'skwp/greplace.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'Shougo/deoplete.nvim'
call plug#end()
