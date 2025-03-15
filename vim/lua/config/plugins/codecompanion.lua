return {
	{
	"olimorris/codecompanion.nvim",

		dependencies = {
    		"nvim-lua/plenary.nvim",
    		"nvim-treesitter/nvim-treesitter"},
	keys ={
		{ "<leader>cc", ":CodeCompanionChat<cr>", desc = "Chat" },
		{ "<leader>cl", ":CodeCompanion", mode={'v'}, desc = "Inline" },
		},
  	opts = {
		adapters = {
			deepseek = function()
				local filetype = vim.bo.filetype
				local model = "deepseek-coder"

				if filetype == "tex" or filetype == "plaintex" then
					model = "deepseek-reasoner"
				end
				print(model)
				return require('codecompanion.adapters').extend("deepseek", {
					env = {
						api_key = os.getenv("DEEPSEEK_API_KEY")  -- Use environment variable
					},
					schema = {
						model = {default = model},
					},
				})
				end
			},
    		strategies = {
			chat = {
				adapter = "deepseek",
				keymaps = {
        				send = {
        				  modes = { n = "<C-s>", i = "<C-s>" },
        				},
        				close = {
        				  modes = { n = "<C-c>", i = "<C-c>" },
        				},
				},
			},
			inline = {
				adapter = "deepseek",
				keymaps = {
        				accept_change = {
        				  modes = { n = "ga" },
        				  description = "Accept the suggested change",
        				},
        				reject_change = {
        				  modes = { n = "gr" },
        				  description = "Reject the suggested change",
        				},
				},
			},
		},
		display = {
    				action_palette = {
      					width = 95,
      					height = 10,
      					prompt = "Prompt ", -- Prompt used for interactive LLM calls
      					provider = "telescope", -- default|telescope|mini_pick
      					opts = {
      					  	show_default_actions = true, -- Show the default actions in the action palette?
      					  	show_default_prompt_library = true, -- Show the default prompt library in the action palette?
      				},
    			},
  		},
   		opts = {
      			-- Set debug logging
      			log_level = "DEBUG",
    			},
  		},
	}
}
