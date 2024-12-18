return {
	-- the colorscheme should be available when starting nvim
	{
	'nvim-lualine/lualine.nvim',
    	lazy = false, -- make sure we load this during startup if it is your main colorscheme
    	priority = 1000, -- make sure to load this before all the other start plugins
    	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
			options = {
				theme = 'auto'
			},
		},
	}
}
