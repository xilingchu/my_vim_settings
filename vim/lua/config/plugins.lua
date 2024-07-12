-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Load Plugins
require("lazy").setup({
	require("config.plugins.tokyonight"),
	-- require("config.plugins.surround"),
	require("config.plugins.airline"),
	require("config.plugins.autopairs"),
	-- require("config.plugins.test"),
	-- require("config.plugins.ultisnips"),
	require("config.plugins.lspconfig"),
	require("config.plugins.cmp"),
})
