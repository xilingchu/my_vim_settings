-- Keymap settings
-- vim.keymap.set({mode},{lhs},{rhs},{opts})
vim.g.mapleader = " "
local mode_nv = {"n", "v"}
local mode_nx = {"n", "x"}
local mode_n  = {"n"}
local mode_v  = {"v"}
local mode_i  = {"i"}
local mode_t  = {"t"}
local mode_nvo  = {"n", "v", "o"}

local mappings = {
	-- movement
	{ from = "j", to = "v:count == 0 ? 'gj' : 'j'", mode = mode_nx, opt = {desc="Down", expr=true, silent=true} },
	{ from = "k", to = "v:count == 0 ? 'gk' : 'k'", mode = mode_nx, opt = {desc="Up", expr=true, silent=true} },
	-- save & quit
	{ from = "Q", to = ":q<CR>", mode = mode_n, opt = {desc="Quit", remap=false} },
	{ from = "S", to = ":w<CR>", mode = mode_n, opt = {desc="Save", remap=false} },
	{ from = "<C-c>", to = "<esc>", mode = mode_nvo, opt = {desc="Esc", remap=false} },
	-- spell
	{ from = "<leader>s", to = ":spell!", mode = mode_n, opt = {desc="Spell", remap=false} },
	-- tabe settings
	{ from = "<leader>n", to = ":tabnew<cr>", mode = mode_n, opt = {desc="New tabe", remap=false} },
	{ from = "<leader>rt", to = ":+tabnext<cr>", mode = mode_n, opt = {desc="Next tabe", remap=false} },
	{ from = "<leader>lt", to = ":-tabnext<cr>", mode = mode_n, opt = {desc="Prev tabe", remap=false} },
	-- terminal settings
	{ from = "<esc>", to = "<c-\\><c-n>", mode = mode_t, opt = {desc="esc in terminal", remap=false} },
	{ from = "<leader>te", to = ":tabnew<cr>:term<cr>", mode = mode_n, opt = {desc="New terminal", remap=false} },
	{ from = "<leader>gi", to = ":tabnew<cr>:term lazygit<cr>", mode = mode_n, opt = {desc="Open lazygit", remap=false} },
	-- Window settings
	{ from = "<leader>v", to = "<c-w>t<c-w>H", mode = mode_n, opt = {desc="Horizon to vertical", remap=false} },
	{ from = "<leader>h", to = "<c-w>t<c-w>K", mode = mode_n, opt = {desc="Vertical to horizon", remap=false} },
	-- Switch the background
	{ from = "<F5>", to = function()
			if (vim.o.background == "dark")
			then
				vim.g.airline_theme = "sol"
				vim.o.background = "light"
			else
				vim.g.airline_theme = "term"
				vim.o.background = "dark"
			end
		end,
		mode = mode_nx, opt = {desc="Down", expr=true, silent=true} },
}

for _, mapping in ipairs(mappings) do
	vim.keymap.set(mapping.mode, mapping.from, mapping.to, mapping.opt)
end
