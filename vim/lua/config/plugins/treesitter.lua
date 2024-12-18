return {
	"nvim-treesitter/nvim-treesitter",
	-- event = {"BufNewFile", "BufReadPre"},
	lazy = false,
	dependencies = {"neovim/nvim-lspconfig"},
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup{
			ensure_installed = {
				-- "latex",
				"c",
				"lua",
				"python",
				"bash",
				"fortran",
				"vim",
				"vimdoc",
				"yaml",
				"markdown",
				"markdown_inline",
			},
			sync_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		}
	end
}
