return {
	-- The basic LSP configs of nvim.	
	{
	"neovim/nvim-lspconfig",
	event = {"BufEnter"},
	dependencies = {
		{
		"williamboman/mason.nvim",
		build = function()
			vim.cmd([[MasonInstall]])
		end,
		opts = {},
		},
		{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {"lua_ls"},
			automatic_installation = true
		}
		},
		{
		"hrsh7th/cmp-nvim-lsp",
		opts = {}
		}
	},
	config = function()
		-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		local lsp = require('lspconfig')
		-- Warning: Useless settings of lua.
		lsp.lua_ls.setup{
			capabilities = capabilities,
			-- settings = require('config.lsp.lua').settings,
		}
	end
	},
}
