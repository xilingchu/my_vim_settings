return {
	-- The basic LSP configs of nvim.	
	{
	"neovim/nvim-lspconfig",
	-- Why useless?
	-- The problem comes from lazy.nvim, it force you to open a new file to start LSP.
	-- event = {"BufReadPre", "BufNewFile"},
	-- event = {"VimEnter"},
	dependencies = {
		{
		"williamboman/mason.nvim",
		opts = {},
		},
		{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
					"bashls",
					"lua_ls",
					-- "ltex",  -- Have error while loading slf4j, don't know how to fix.
					"fortls",
					"marksman",
					"pyright",
					 -- "sqls",
					"sqlls",
					"texlab"
			},
			automatic_installation = true
		}
		},
		{
		"hrsh7th/cmp-nvim-lsp",
		},
	},
	config = function()
		-- For lspconfig
		vim.api.nvim_exec_autocmds("FileType", {})
		-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		local lsp = require('lspconfig')
		lsp.bashls.setup({
			capabilities = capabilities,
			settings = require('config.lsp.bash').settings,
		})
		lsp.lua_ls.setup({
			capabilities = capabilities,
			settings = require('config.lsp.lua').settings,
		})
		-- lsp.ltex.setup({
		-- 	capabilities = capabilities,
		-- 	settings = require('config.lsp.ltex').settings,
		-- })
		lsp.fortls.setup({
			capabilities = capabilities,
		})
		lsp.marksman.setup({
			capabilities = capabilities,
		})
		lsp.pyright.setup({
			capabilities = capabilities,
		})
		lsp.sqlls.setup({
			capabilities = capabilities,
			filetypes = {"sql"},
		})
		-- lsp.sqls.setup({
		-- 	capabilities = capabilities,
		-- 	filetypes = {"sql", "lua"},
		-- 	settings = require("config.lsp.sql").settings
		-- })
		lsp.texlab.setup({
			capabilities = capabilities,
		})
	end
	},
}
