return {
	-- the colorscheme should be available when starting nvim
	{
	"vim-airline/vim-airline",
    	lazy = false, -- make sure we load this during startup if it is your main colorscheme
    	priority = 1000, -- make sure to load this before all the other start plugins
    	dependencies = "vim-airline/vim-airline-themes",
    	config = function()
    		-- load the colorscheme here
    		vim.g.airline_theme='papercolor'
    	end,
  	}
}
