
call plug#begin('~/.vim/plugged')
Plug 'AndrewRadev/splitjoin.vim' " gS ang gJ to swap between single and multi line blocks
Plug 'ayu-theme/ayu-vim' " colorscheme
Plug 'godlygeek/tabular' " :Tabulerize/{pattern}
Plug 'gregsexton/MatchTag' " highlight matching html tag
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " :MarkdownPreview
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' } " fuzzy file finder
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'tomtom/tcomment_vim' " Commenting conveniences, e.g. gcc to comment line
Plug 'tpope/vim-abolish' " Misc string formating, e.g. SnakeCase to keba-case
Plug 'tpope/vim-endwise' " Auto close blocks
Plug 'tpope/vim-fugitive' " Git
Plug 'tpope/vim-rhubarb' " Github stuff, e.g. GBrowse
Plug 'tpope/vim-surround' " insert openers/closers around selection
call plug#end()

set termguicolors
colorscheme ayu

set number " display line numbers
set wrap " continue long lines on next lines
set linebreak "Wrap lines at convenient points
set cursorcolumn cursorline " highlight column and row
set ruler " display column number
set hidden " allow unsaved buffers
set nofoldenable " disable folding
set nofixendofline " don't auto insert newline at end of file on save

set clipboard+=unnamedplus " connect to system clipboard (linux)
syntax enable " enable syntax highlighting

set mouse=a " enable mouse selection https://github.com/neovim/neovim/issues/6082

" turn off swap files
set noswapfile
set nobackup
set nowb

" indentation
set list
set listchars=tab:>- " visualize tabs
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab " spaces

" folds
set foldmethod=indent "fold based on indent
set foldnestmax=3 "deepest fold is 3 levels
set nofoldenable "dont fold by default

" completion
set wildmode=list:longest
set wildmenu
" ignore folliwing when scrolling using ctrl-n and ctrl-p
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" set spell spelllang=en_us spell check

" scrolling
set scrolloff=8 "start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" search
set incsearch " find the next match as we type the search
set hlsearch " highlight searches by default
set ignorecase " ignore case when searching...
set smartcase " ...unless we type a capital

" auto delete trailing white spaces for all filetypes except markdown
let allow_trailing_whitespace = ['markdown']
autocmd BufWritePre * if index(allow_trailing_whitespace, &ft) < 0 | %s/\s\+$//e

autocmd FocusGained,BufEnter * :silent! !  " auto read from file when gaining focus

" set leader to space
let mapleader = "\<Space>"

" Nvim Tree
lua require('mod-nvim-tree')
nnoremap <C-n> :NvimTreeToggle<cr>
nnoremap <leader>nf :NvimTreeFindFile<cr>

let g:fzf_history_dir = '~/.local/share/fzf-history'
" file name search for files in git
nnoremap <C-f> :GFiles<cr>
" file name search for all files (fallback when file outside git)
nnoremap <C-A-f> :Files<cr>
" content search
nnoremap <M-f> :Rg<cr>
" select all
nnoremap <M-a> gg<S-V>G

" Use enter in normal mode to insert new lines but stay in normal mode
nnoremap <M-Enter> O<Esc>
nnoremap <Enter> o<Esc>

" skip newline when jumping to end of line in visual mode
vnoremap $ $h

" shift + Y copies remainder of line (similar to C and D)
nmap <S-y> v$y<ESC>
" copy and search for selection
vnoremap // y/<C-R>"<Esc>

" use leader for navigation instead of ctrl+w
nnoremap <C-w> :echo "Use leader (Space) instead!"<cr>
nnoremap <leader> <C-w>
" 2x space to jump to leftmost pane (usually nerd tree)
nnoremap <leader><leader> 1<C-w>w

"resize pane by 20 to left or right
nnoremap <leader>> 20<C-w>>
nnoremap <leader>< 20<C-w><

:ca rel source $MYVIMCONFIG " reload vim config
:ca cpp let @+ = expand("%") " path for open file to clipboard

" insert messages into current buffer
" put =execute('messages')

" smart indent when entering insert mode with A on empty lines
function! IndentWithA()
  if len(getline('.')) == 0
    return "cc"
  else
    return "A"
  endif
endfunction
nnoremap <expr> A IndentWithA()

" COC
" Auto-installs extensions if they don't exist
let g:coc_global_extensions = ['coc-tsserver', 'coc-prettier', 'coc-eslint', 'coc-highlight', 'coc-deno', 'coc-yaml', 'coc-json', 'coc-sh', 'coc-clangd']
" And install clangd lsp: :CocCommand clangd.install

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh :call CocActionAsync('doHover')<CR>

nmap <leader>rn <Plug>(coc-rename)

:cabbrev tsfix :call CocActionAsync('runCommand', 'tsserver.executeAutofix')<CR>