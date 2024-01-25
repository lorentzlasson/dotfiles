call plug#begin('~/.vim/plugged')
Plug 'AndrewRadev/splitjoin.vim' " gS ang gJ to swap between single and multi line blocks
Plug 'LnL7/vim-nix'
Plug 'ayu-theme/ayu-vim' " colorscheme
Plug 'godlygeek/tabular' " :Tabulerize/{pattern}
Plug 'gregsexton/MatchTag' " highlight matching html tag
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'hrsh7th/nvim-cmp' " The main completion plugin
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " :MarkdownPreview
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' } " fuzzy file finder
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'simrat39/symbols-outline.nvim' " in-file tree overview
Plug 'stevearc/oil.nvim'
Plug 'tomtom/tcomment_vim' " Commenting conveniences, e.g. gcc to comment line
Plug 'tpope/vim-abolish' " Misc string formating, e.g. SnakeCase to keba-case
Plug 'tpope/vim-endwise' " Auto close blocks
Plug 'tpope/vim-fugitive' " Git
Plug 'tpope/vim-rhubarb' " Github stuff, e.g. GBrowse
Plug 'tpope/vim-surround' " insert openers/closers around selection
Plug 'zbirenbaum/copilot.lua' " unofficial copilot plugin
call plug#end()
