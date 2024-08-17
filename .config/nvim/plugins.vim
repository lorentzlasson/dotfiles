call plug#begin('~/.vim/plugged')
Plug 'AndrewRadev/splitjoin.vim' " gS ang gJ to swap between single and multi line blocks
Plug 'LnL7/vim-nix'
Plug 'godlygeek/tabular' " :Tabulerize/{pattern}
Plug 'gregsexton/MatchTag' " highlight matching html tag
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'hrsh7th/nvim-cmp' " The main completion plugin
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " :MarkdownPreview
Plug 'ibhagwan/fzf-lua'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' } " fuzzy file finder
Plug 'nanotee/sqls.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'simrat39/symbols-outline.nvim' " in-file tree overview
Plug 'stevearc/dressing.nvim'
Plug 'stevearc/oil.nvim'
Plug 'tomtom/tcomment_vim' " Commenting conveniences, e.g. gcc to comment line
Plug 'tpope/vim-abolish' " Misc string formating, e.g. SnakeCase to keba-case
Plug 'tpope/vim-endwise' " Auto close blocks
Plug 'tpope/vim-fugitive' " Git
Plug 'tpope/vim-rhubarb' " Github stuff, e.g. GBrowse
Plug 'tpope/vim-surround' " insert openers/closers around selection
Plug 'ziontee113/icon-picker.nvim'

" colorschemes
Plug 'Luxed/ayu-vim'
Plug 'glepnir/zephyr-nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'mhartington/oceanic-next'
Plug 'navarasu/onedark.nvim'
Plug 'ofirgall/ofirkai.nvim'"
call plug#end()
