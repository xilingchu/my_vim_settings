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
		"mason-org/mason.nvim",
		opts = {},
		},
		{
		"mason-org/mason-lspconfig.nvim",
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
					"texlab",
					"rust_analyzer"
			},
			automatic_installation = true,
			automatic_enable = false
		}
		},
		{
		"hrsh7th/cmp-nvim-lsp",
		},
	},
	config = function()
		-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		-- local lsp = require('lspconfig')
		-- This settings to disable the hints required by nvim-lsp
		-- https://github.com/microsoft/pyright/issues/4652
		capabilities.textDocument.publishDiagnostics = { tagSupport = { valueSet = { 2 } } }
		vim.lsp.config('bashls', {
			capabilities = capabilities,
			settings = require('config.lsp.bash').settings,
		})
		vim.lsp.config('lua_ls', {
			capabilities = capabilities,
			settings = require('config.lsp.lua').settings,
		})
		-- lsp.ltex.setup({
		-- 	capabilities = capabilities,
		-- 	settings = require('config.lsp.ltex').settings,
		-- })
		vim.lsp.config('fortls', {
			capabilities = capabilities,
		})
		vim.lsp.config('marksman', {
			capabilities = capabilities,
		})
		vim.lsp.config('pyright', {
			capabilities = capabilities,
		})
		vim.lsp.config('sqlls', {
			capabilities = capabilities,
			filetypes = {"sql"},
		})
		vim.lsp.config('rust_analyzer', {
			capabilities = capabilities,
		})
		-- lsp.sqls.setup({
		-- 	capabilities = capabilities,
		-- 	filetypes = {"sql", "lua"},
		-- 	settings = require("config.lsp.sql").settings
		-- })
		vim.lsp.config('texlab', {
			capabilities = capabilities,
		})
	end
	},
}
