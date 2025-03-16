-- Configuration for the CodeCompanion.nvim plugin
-- This file sets up keybindings, adapters, strategies, and UI options
return {
	{
	"olimorris/codecompanion.nvim",

		dependencies = {
    		"nvim-lua/plenary.nvim",
    		"nvim-treesitter/nvim-treesitter"},
	-- Keybindings for CodeCompanion
	-- <leader>cc: Open chat interface
	-- <leader>cl: Use inline suggestions in visual mode
	keys ={
		{ "<leader>cc", ":CodeCompanionChat<cr>", desc = "Chat" },
		{ "<leader>cl", ":CodeCompanion", mode={'v'}, desc = "Inline" },
		},
  	opts = {
		-- Adapter configuration for Deepseek
		-- Automatically selects model based on filetype
		-- Uses environment variable for API key
		adapters = {
			deepseek = function()
				local filetype = vim.bo.filetype
				local model = "deepseek-coder"

				if filetype == "tex" or filetype == "plaintex" then
					model = "deepseek-reasoner"
				end
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
		-- Strategies for different interaction modes
		-- chat: Full chat interface with custom keymaps
		-- inline: Inline suggestions with accept/reject options
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
		-- Display configuration
		-- chat: UI settings for chat window and icons
		-- action_palette: Configuration for interactive prompt interface
		display = {
				chat = {
					icons = {
						pinned_buffer = " ",
						watched_buffer = "👀 ",
					},
				debug_window = {
						width = vim.o.columns - 5,
						height = vim.o.lines - 2,
					},
				window = {
						layout = "horizontal",
						position = 'bottom',
						height = 0.33,
						width = 0.4,
						opts = {
							cursorline = true
						}
					}
				},
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
