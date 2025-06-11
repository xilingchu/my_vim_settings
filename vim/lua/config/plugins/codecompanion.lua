-- Configuration for the CodeCompanion.nvim plugin
-- This file sets up keybindings, adapters, strategies, and UI options
return {
	{
	"olimorris/codecompanion.nvim",
	dependencies = {
    		"nvim-lua/plenary.nvim",
    		"nvim-treesitter/nvim-treesitter",
		"ravitemer/codecompanion-history.nvim",
	},
	-- Keybindings for CodeCompanion
	-- <leader>cc: Open chat interface
	-- <leader>cl: Use inline suggestions in visual mode
	keys ={
		{ "<leader>cc", ":CodeCompanionChat<cr>", desc = "Chat" },
		{ "<leader>cl", ":CodeCompanion", mode={'v'}, desc = "Inline" },
		},
  	opts = {
		extensions = {
			history = {
				enable = true,
				opts = {
                			-- Keymap to open history from chat buffer (default: gh)
                			keymap = "gh",
                			-- Automatically generate titles for new chats
                			auto_generate_title = true,
                			---On exiting and entering neovim, loads the last chat on opening chat
                			continue_last_chat = false,
                			---When chat is cleared with `gx` delete the chat from history
                			delete_on_clearing_chat = false,
                			-- Picker interface ("telescope" or "snacks" or "default")
                			picker = "telescope",
                			---Enable detailed logging for history extension
                			enable_logging = false,
                			---Directory path to save the chats
                			dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
                			-- Save all chats by default
                			auto_save = true,
                			-- Keymap to save the current chat manually
                			save_chat_keymap = "sc", },
				},
		},
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
				end,
			my_claude = function()
				return require("codecompanion.adapters").extend("openai_compatible", {
        			env = {
        			  url = "https://api.gpt.ge", -- optional: default value is ollama url http://127.0.0.1:11434
        			  api_key = os.getenv("OPENAI_API_KEY"), -- optional: if your endpoint is authenticated
        			  chat_url = "/v1/chat/completions", -- optional: default value, override if different
        			  models_endpoint = "/v1/models", -- optional: attaches to the end of the URL to form the endpoint to retrieve models
        			},
        			schema = {
        			  model = {
        			    default = "gpt-4",  -- define llm model to be used
        			  },
				}})
				end
			},
		-- Strategies for different interaction modes
		-- chat: Full chat interface with custom keymaps
		-- inline: Inline suggestions with accept/reject options
    		strategies = {
			chat = {
				adapter = "my_claude",
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
				adapter = "my_claude",
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
