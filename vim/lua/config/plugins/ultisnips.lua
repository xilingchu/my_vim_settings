return {
	{
	"SirVer/ultisnips",
	dependencies = {
		"honza/vim-snippets",
	},
	init = function()
		vim.g.UltiSnipsExpandTrigger="<tab>"
		vim.g.UltiSnipsJumpForwardTrigger="<c-b>"
		vim.g.UltiSnipsJumpBackwardTrigger="<c-z>"
		vim.g.UltiSnipsEditSplit="vertical"
	end
	}
}
