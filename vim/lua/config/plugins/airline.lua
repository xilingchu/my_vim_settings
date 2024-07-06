return {
	-- the colorscheme should be available when starting nvim
	{
	"vim-airline/vim-airline",
    	lazy = false, -- make sure we load this during startup if it is your main colorscheme
    	priority = 1000, -- make sure to load this before all the other start plugins
    	dependencies = "vim-airline/vim-airline-themes",
    	init = function()
    		-- load the colorscheme here
		vim.cmd([[
    		let g:airline_theme='sol'
		let g:airline#extensions#tabline#enabled = 1
		let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
		]])
    	end,
  	}
}
