return {
	settings = {
		Lua = {
			diagnostics = {
				globals = {"vim", "lsqlite3"},
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.fn.expand'~/.luarocks/share/lua/5.1',
					'/usr/share/lua/5.1',
				}
			},
			completion = {
				callSnippet = "Replace"
			},
			runtime = {
				version = "Lua 5.1"
			}
		}
	}
}
