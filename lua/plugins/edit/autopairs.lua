local config = function()
	local npairs = require'nvim-autopairs'
	local Rule = require'nvim-autopairs.rule'
	local cond = require'nvim-autopairs.conds'
	npairs.setup{}

	local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
	npairs.add_rules {
		Rule(' ', ' ')
			:with_pair(function (opts)
				local pair = opts.line:sub(opts.col - 1, opts.col)
				return vim.tbl_contains({
					brackets[1][1]..brackets[1][2],
					brackets[2][1]..brackets[2][2],
					brackets[3][1]..brackets[3][2],
				}, pair)
			end)
	}
	for _,bracket in pairs(brackets) do
		npairs.add_rules {
			Rule(bracket[1]..' ', ' '..bracket[2])
				:with_pair(function() return false end)
				:with_move(function(opts)
					return opts.prev_char:match('.%'..bracket[2]) ~= nil
				end)
				:use_key(bracket[2])
		}
	end

	-- auto space
	Rule('=', '')
		:with_pair(cond.not_inside_quote())
		:with_pair(function(opts)
				local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
				if last_char:match('[%w%=%s]') then
						return true
				end
				return false
		end)
		:replace_endpair(function(opts)
				local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
				local next_char = opts.line:sub(opts.col, opts.col)
				next_char = next_char == ' ' and '' or ' '
				if prev_2char:match('%w$') then
						return '<bs> =' .. next_char
				end
				if prev_2char:match('%=$') then
						return next_char
				end
				if prev_2char:match('=') then
						return '<bs><bs>=' .. next_char
				end
				return ''
		end)
		:set_end_pair_length(0)
		:with_move(cond.none())
		:with_del(cond.none())

	-- https://github.com/rstacruz/vim-closer/blob/master/autoload/closer.vim
	local get_closing_for_line = function (line)
		local i = -1
		local clo = ''

		while true do
			i, _= string.find(line, "[%(%)%{%}%[%]]", i + 1)
			if i == nil then break end
			local ch = string.sub(line, i, i)
			local st = string.sub(clo, 1, 1)

			if ch == '{' then
				clo = '}' .. clo
			elseif ch == '}' then
				if st ~= '}' then return '' end
				clo = string.sub(clo, 2)
			elseif ch == '(' then
				clo = ')' .. clo
			elseif ch == ')' then
				if st ~= ')' then return '' end
				clo = string.sub(clo, 2)
			elseif ch == '[' then
				clo = ']' .. clo
			elseif ch == ']' then
				if st ~= ']' then return '' end
				clo = string.sub(clo, 2)
			end
		end

		return clo
	end

	npairs.add_rule(Rule("[%(%{%[]", "")
		:use_regex(true)
		:replace_endpair(function(opts)
			return get_closing_for_line(opts.line)
		end)
		:end_wise(function(opts)
			-- Do not endwise if there is no closing
			return get_closing_for_line(opts.line) ~= ""
		end))
	
	local cmp = require"cmp"
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end


return {
	'windwp/nvim-autopairs',
	event = {
    "InsertEnter",
    "CmdlineEnter",
  },
	dependencies = "hrsh7th/nvim-cmp",
	config = config
}