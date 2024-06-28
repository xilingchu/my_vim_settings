-- Some default settings of Vim

-- Load the default settings of nvim
vim.cmd('source $VIMRUNTIME/defaults.vim')

-- Dont split a wrod in a sentence
vim.o.linebreak = true
-- Set number
vim.o.number = true
vim.o.relativenumber = true
-- Autochdir
vim.o.autochdir = true
-- Highlight the line
vim.o.cursorline = true
-- No expand <Tab>
vim.o.expandtab = false
-- Fold settings
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
vim.o.foldenable = true
vim.foldlevelstart = 99
-- Position of the split windows
vim.o.splitright = true
vim.o.splitbelow = true
