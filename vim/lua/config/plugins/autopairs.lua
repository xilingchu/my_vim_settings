return  {
	{
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	config = function()
		local npairs = require('nvim-autopairs')
		local rule   = require('nvim-autopairs.rule')
		local cond   = require('nvim-autopairs.conds')

		-- Settings of the autopairs
		npairs.setup({
			-- enable fast wrap (Who needs surround!!!)
			fast_wrap = {
				map = '<c-e>',
				chars = { '{', '[', '(', '"', "'", "|", "$" },
			},
		})

		-- Add rules of autopairs
		npairs.add_rules({
			rule("$","$",{"plaintex", "tex", "latex"})
			:with_pair(cond.not_before_regex("%%"))
			:with_pair(cond.not_after_regex("."))
			}
		)
	end,
	}
}
