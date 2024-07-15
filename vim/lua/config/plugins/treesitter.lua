return {
	"nvim-treesitter/nvim-treesitter",
	event = {"BufNewFile", "BufReadPre"},
	opts = {
		ensure_installed = {
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
		},
		indent = {
			enable = true,
		},
	}
}
