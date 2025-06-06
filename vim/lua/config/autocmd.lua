-- autocmd settings

-- Augroup settings
local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Not need now
-- -- For Debug
-- vim.api.nvim_create_autocmd({"VimEnter"}, {
-- 	pattern = "*",
-- 	command = "echomsg 'vimenter event'",
-- })

-- vim.api.nvim_create_autocmd({"FileType"}, {
-- 	pattern = "*",
-- 	command = "echomsg 'filetype event '..&filetype",
-- })
-- vim.api.nvim_create_autocmd({"BufReadPost"}, {
-- 	pattern = "*",
-- 	command = "echomsg 'bufreadpost event'",
-- })
-- vim.api.nvim_create_autocmd({"BufReadPre"}, {
-- 	pattern = "*",
-- 	command = "echomsg 'bufreadpre event'",
-- })

-- Autostart Lsp
-- vim.api.nvim_create_autocmd({"VimEnter"}, {
-- 	pattern = "*",
-- 	command = "doautocmd FileType",
-- })

-- NVIMRC
-- Reset the configuration of vimrc if save it.
vim.api.nvim_create_autocmd({"BufWritePost"}, {
	group = augroup("nvimrc"),
	pattern = "init.lua",
	command = "source $MYVIMRC"
})

-- PySettings
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
	group = augroup("pysettings"),
	pattern = "*.py",
	command = [[
                set tabstop=4 
                set softtabstop=4
                set shiftwidth=4
        ]]
})

-- Fortran Settings
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
	group = augroup("forsettings"),
	pattern = "*.f90",
	command = [[
                let fortran_have_tabs=1
                set tabstop=4 
                set softtabstop=4
                set shiftwidth=4
        ]]
})

-- Latex Settings
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
	group = augroup("texsettings"),
	pattern = {"*.tex", "*.sty", "*.cls"},
	command = [[
                set tabstop=2
                set softtabstop=2
                set shiftwidth=2
                set expandtab
        ]]
})
