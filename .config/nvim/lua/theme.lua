local cmd = vim.cmd

cmd 'colorscheme dunkel-kontrast'

-- make horizontal splits clearer
-- TODO: with dunkel?
cmd [[ highlight StatusLineNC guibg=black guifg=white ]]
cmd [[ highlight StatusLine guibg=black guifg=#7a59ff ]]