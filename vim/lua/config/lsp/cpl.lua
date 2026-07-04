-- Lightweight nvim-cmp completion source for CPL (cplcode.net).
-- No LSP: static keyword list + regex-scraped declarations
-- (SUBROUTINE/FUNCTION/STRUCTURE/MODULE/CONSTANT) from all *.cpl
-- files under the current working directory.

local M = {}

local KEYWORDS = {
	"MODULE", "SUBROUTINE", "FUNCTION", "INLINE", "OPERATOR", "END",
	"IF", "THEN", "ELSE",
	"LOOP", "REPEAT", "FOR", "TO", "BY", "UNTIL", "WHILE", "ALL", "DO",
	"CASE", "EXCEPT", "FOLLOWS",
	"WITH", "USE", "INCLUDE",
	"EXIT", "STOP", "TRAP", "TRACE", "ERROR",
	"CONSTANT", "VARIABLE", "OPTIONAL", "NEW", "FREE", "IS", "IN",
	"YES", "NO", "NULL",
	"AND", "OR", "NOT",
	"WRITE", "READ", "FROM", "NAME", "BINARY", "POSITION", "OPEN", "OPENRO",
	"CREATE", "CLOSE", "FLUSH", "EOF", "INPUTREADY", "ASK", "ARG", "COMMANDLINE",
	"ABS", "CEILING", "FLOOR", "ROUND", "MAX", "MIN", "MAXABS", "NORM", "RAND",
	"GAUSS", "LENGTH", "HI", "LO",
	"INTEGER", "REAL", "STRING", "BOOLEAN", "CHAR", "FILE", "POINTER", "ARRAY",
	"STRUCTURE", "STRUCTURED", "CSTRING", "SINGLE", "ENUM", "TYPE", "DYNAMIC", "STORED",
}

local DECL_PATTERNS = {
	{ pat = "^%s*SUBROUTINE%s+([%w_]+)",        kind = "Function" },
	{ pat = "^%s*INLINE%s+SUBROUTINE%s+([%w_]+)", kind = "Function" },
	{ pat = "^%s*FUNCTION%s+([%w_]+)",           kind = "Function" },
	{ pat = "^%s*INLINE%s+FUNCTION%s+([%w_]+)",  kind = "Function" },
	{ pat = "^%s*STRUCTURE%s+([%w_]+)",          kind = "Struct" },
	{ pat = "^%s*MODULE%s+([%w_]+)",             kind = "Module" },
	{ pat = "^%s*CONSTANT%s+[%w_]+%s+([%w_]+)%s*=", kind = "Constant" },
}

local cache = { items = nil, ts = 0 }

local function scan_file(path, seen, items, kinds)
	local ok, lines = pcall(vim.fn.readfile, path)
	if not ok then return end
	for _, line in ipairs(lines) do
		for _, decl in ipairs(DECL_PATTERNS) do
			local name = line:match(decl.pat)
			if name and not seen[name] then
				seen[name] = true
				table.insert(items, {
					label = name,
					kind = kinds[decl.kind],
					detail = "CPL " .. decl.kind,
				})
			end
		end
	end
end

function M.collect_symbols()
	local now = vim.loop.now()
	if cache.items and (now - cache.ts) < 2000 then
		return cache.items
	end
	local cmp = require("cmp")
	local kinds = cmp.lsp.CompletionItemKind
	local items, seen = {}, {}
	local files = vim.fn.globpath(vim.fn.getcwd(), "**/*.cpl", false, true)
	for _, f in ipairs(files) do
		scan_file(f, seen, items, kinds)
	end
	cache.items = items
	cache.ts = now
	return items
end

local source = {}
function source.new() return setmetatable({}, { __index = source }) end
function source:is_available() return vim.bo.filetype == "cpl" end
function source:get_debug_name() return "cpl" end

function source:complete(_, callback)
	local cmp = require("cmp")
	local items = {}
	for _, kw in ipairs(KEYWORDS) do
		table.insert(items, { label = kw, kind = cmp.lsp.CompletionItemKind.Keyword })
	end
	for _, s in ipairs(M.collect_symbols()) do
		table.insert(items, s)
	end
	callback(items)
end

M._source = source

function M.setup()
	local cmp = require("cmp")
	cmp.register_source("cpl", source.new())
	cmp.setup.filetype("cpl", {
		sources = cmp.config.sources({
			{ name = "cpl" },
			{ name = "ultisnips" },
		}, {
			{ name = "buffer" },
			{ name = "path" },
		}),
	})
end

return M
