return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim'
	},
	keys = {
		{ "<leader>ff", ":Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fg", ":Telescope live_grep<cr>", desc = "Live grep" },
		{ "<leader>fs", ":Telescope grep_string<cr>", desc = "Grep strings" },
		{ "<leader>ft", ":Telescope tabs<cr>", desc = "Get tabs" },
	}
}
