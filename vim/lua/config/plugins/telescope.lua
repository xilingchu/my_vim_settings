return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'xiyaowong/telescope-emoji.nvim'
	},
	keys = {
		{ "<leader>ff", ":Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fg", ":Telescope live_grep<cr>", desc = "Live grep" },
		{ "<leader>fs", ":Telescope grep_string<cr>", desc = "Grep strings" },
		{ "<leader>ft", ":Telescope tabs<cr>", desc = "Get tabs" },
		{ "<leader>fe", ":Telescope emoji<cr>", desc = "Get emoji" },
	},
	opts = {
		extensions = {
			emoji = {
      				action = function(emoji)
        				-- argument emoji is a table.
        				-- {name="", value="", cagegory="", description=""}

        				vim.fn.setreg("*", emoji.value)
        				print([[Press p or "*p to paste this emoji]] .. emoji.value)

        				-- insert emoji when picked
        				vim.api.nvim_put({ emoji.value }, 'c', false, true)
      				end,
    			},
  		},
	},
}

