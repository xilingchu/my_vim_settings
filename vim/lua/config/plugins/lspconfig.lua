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
		opts = {}
		}
	},
	config = function()
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
			filetypes = {"sql", "lua"},
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
