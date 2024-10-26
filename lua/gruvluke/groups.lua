local M = {}

M.setup = function()
	local colors = require('gruvluke.palette').get_base_colors()

	vim.g.terminal_color_0 = colors.bg0
	vim.g.terminal_color_8 = colors.gray
	vim.g.terminal_color_1 = colors.neutral_red
	vim.g.terminal_color_9 = colors.red
	vim.g.terminal_color_2 = colors.neutral_green
	vim.g.terminal_color_10 = colors.green
	vim.g.terminal_color_3 = colors.neutral_yellow
	vim.g.terminal_color_11 = colors.yellow
	vim.g.terminal_color_4 = colors.neutral_blue
	vim.g.terminal_color_12 = colors.blue
	vim.g.terminal_color_5 = colors.neutral_purple
	vim.g.terminal_color_13 = colors.purple
	vim.g.terminal_color_6 = colors.neutral_aqua
	vim.g.terminal_color_14 = colors.aqua
	vim.g.terminal_color_7 = colors.fg4
	vim.g.terminal_color_15 = colors.fg1

	local groups = {
		-- Base groups
		GruvlukeFg0 = { fg = colors.fg0 },
		GruvlukeFg1 = { fg = colors.fg1 },
		GruvlukeFg2 = { fg = colors.fg2 },
		GruvlukeFg3 = { fg = colors.fg3 },
		GruvlukeFg4 = { fg = colors.fg4 },
		GruvlukeGray = { fg = colors.gray },
		GruvlukeBg0 = { fg = colors.bg0 },
		GruvlukeBg1 = { fg = colors.bg1 },
		GruvlukeBg2 = { fg = colors.bg2 },
		GruvlukeBg3 = { fg = colors.bg3 },
		GruvlukeBg4 = { fg = colors.bg4 },
		GruvlukeRed = { fg = colors.red },
		GruvlukeRedBold = { fg = colors.red, bold = true },
		GruvlukeGreen = { fg = colors.green },
		GruvlukeGreenBold = { fg = colors.green, bold = true },
		GruvlukeYellow = { fg = colors.yellow },
		GruvlukeYellowBold = { fg = colors.yellow, bold = true },
		GruvlukeBlue = { fg = colors.blue },
		GruvlukeBlueBold = { fg = colors.blue, bold = true },
		GruvlukePurple = { fg = colors.purple },
		GruvlukePurpleBold = { fg = colors.purple, bold = true },
		GruvlukeAqua = { fg = colors.aqua },
		GruvlukeAquaBold = { fg = colors.aqua, bold = true },
		GruvlukeOrange = { fg = colors.orange },
		GruvlukeOrangeBold = { fg = colors.orange, bold = true },
		GruvlukeRedSign = { fg = colors.red, bg = colors.bg0, reverse = false },
		GruvlukeGreenSign = { fg = colors.green, bg = colors.bg0, reverse = false },
		GruvlukeYellowSign = { fg = colors.yellow, bg = colors.bg0, reverse = false },
		GruvlukeBlueSign = { fg = colors.blue, bg = colors.bg0, reverse = false },
		GruvlukePurpleSign = { fg = colors.purple, bg = colors.bg0, reverse = false },
		GruvlukeAquaSign = { fg = colors.aqua, bg = colors.bg0, reverse = false },
		GruvlukeOrangeSign = { fg = colors.orange, bg = colors.bg0, reverse = false },
		GruvlukeRedUnderline = { undercurl = true, sp = colors.red },
		GruvlukeGreenUnderline = { undercurl = true, sp = colors.green },
		GruvlukeYellowUnderline = { undercurl = true, sp = colors.yellow },
		GruvlukeBlueUnderline = { undercurl = true, sp = colors.blue },
		GruvlukePurpleUnderline = { undercurl = true, sp = colors.purple },
		GruvlukeAquaUnderline = { undercurl = true, sp = colors.aqua },
		GruvlukeOrangeUnderline = { undercurl = true, sp = colors.orange },

		Normal = { fg = colors.fg1, bg = colors.bg0 },
		NormalFloat = { link = 'Normal' },
		NormalNC = { link = 'Normal' },
		CursorLine = { bg = colors.bg1 },
		CursorColumn = { link = 'CursorLine' },
		TabLineFill = { fg = colors.fg4, bg = colors.bg0 },
		TabLineSel = { fg = colors.bg0, bg = colors.fg4 },
		TabLine = { fg = colors.fg4, bg = colors.bg1 },
		TabWinSel = { link = 'TabLineSel' },
		TabWin = { link = 'TabLineSel' },
		MatchParen = { bg = colors.bg3, bold = true },
		ColorColumn = { bg = colors.color_column },
		Conceal = { fg = colors.blue },
		CursorLineNr = { fg = colors.fg3 },
		NonText = { link = 'GruvlukeBg2' },
		SpecialKey = { link = 'GruvlukeFg4' },
		Visual = { bg = colors.visual, reverse = false },
		VisualNOS = { link = 'Visual' },
		Search = { fg = colors.bg0, bg = colors.orange, reverse = false },
		IncSearch = { fg = colors.bg0, bg = colors.red },
		CurSearch = { link = 'IncSearch' },
		QuickFixLine = { fg = colors.bg0, bg = colors.yellow, bold = true },
		Underlined = { fg = colors.blue, underline = true },
		StatusLine = { fg = colors.bg2, bg = colors.fg1, reverse = false },
		StatusLineNC = { fg = colors.bg1, bg = colors.fg4, reverse = false },
		WinBar = { fg = colors.fg4, bg = colors.bg0 },
		WinBarNC = { link = 'WinBar' },
		WinSeparator = { fg = colors.bg3, bg = colors.bg0 },
		WildMenu = { fg = colors.blue, bg = colors.bg2, bold = true },
		Directory = { link = 'GruvlukeBlueBold' },
		Title = { link = 'GruvlukeGreenBold' },
		ErrorMsg = { fg = colors.bg0, bg = colors.red, bold = true },
		MoreMsg = { link = 'GruvlukeYellowBold' },
		ModeMsg = { link = 'GruvlukeYellowBold' },
		Question = { link = 'GruvlukeOrangeBold' },
		WarningMsg = { link = 'GruvlukeRedBold' },
		LineNr = { fg = colors.bg2 },
		SignColumn = { link = 'LineNr' },
		Folded = { link = 'Comment' },
		FoldColumn = { link = 'LineNr' },
		Cursor = { reverse = false },
		vCursor = { link = 'Cursor' },
		iCursor = { link = 'Cursor' },
		lCursor = { link = 'Cursor' },
		Special = { link = 'GruvlukeOrange' },

		Comment = { fg = colors.gray, italic = true },
		Todo = { fg = colors.bg0, bg = colors.yellow, bold = true, italic = true },
		Done = { fg = colors.orange, bold = true, italic = true },
		Error = { fg = colors.red, bold = true, reverse = false },
		Statement = { link = 'GruvlukeRed' },
		Conditional = { link = 'GruvlukeRed' },
		Repeat = { link = 'GruvlukeRed' },
		Label = { link = 'GruvlukeRed' },
		Exception = { link = 'GruvlukeRed' },
		Operator = { fg = colors.orange, italic = true },
		Keyword = { link = 'GruvlukeRed' },
		Identifier = { link = 'GruvlukeBlue' },
		Function = { link = 'GruvlukeGreen' },
		PreProc = { link = 'GruvlukeAqua' },
		Include = { link = 'GruvlukeAqua' },
		Define = { link = 'GruvlukeAqua' },
		Macro = { link = 'GruvlukeAqua' },
		PreCondit = { link = 'GruvlukeAqua' },
		Constant = { link = 'GruvlukePurple' },
		Character = { link = 'GruvlukeGreen' },
		String = { link = 'GruvlukeGreen' },
		Boolean = { link = 'GruvlukePurple' },
		Number = { link = 'GruvlukePurple' },
		Float = { link = 'GruvlukePurple' },
		Type = { link = 'GruvlukeYellow' },
		StorageClass = { link = 'GruvlukeOrange' },
		Structure = { link = 'GruvlukeAqua' },
		Typedef = { link = 'GruvlukeYellow' },

		Pmenu = { link = 'Normal' },
		PmenuSel = { link = 'Visual' },
		PmenuSbar = { bg = colors.fg1 },
		PmenuThumb = { link = 'PmenuSbar' },
		DiffDelete = { fg = colors.red, bg = colors.bg0, reverse = false },
		DiffAdd = { fg = colors.green, bg = colors.bg0, reverse = false },
		DiffChange = { fg = colors.aqua, bg = colors.bg0, reverse = false },
		DiffText = { fg = colors.yellow, bg = colors.bg0, reverse = false },
		SpellCap = { link = 'GruvlukeBlueUnderline' },
		SpellBad = { link = 'GruvlukeRedUnderline' },
		SpellLocal = { link = 'GruvlukeAquaUnderline' },
		SpellRare = { link = 'GruvlukePurpleUnderline' },
		Whitespace = { fg = colors.bg2 },

		-- LSP Diagnostic
		DiagnosticError = { link = 'GruvlukeRed' },
		DiagnosticSignError = { link = 'GruvlukeRedSign' },
		DiagnosticUnderlineError = { link = 'GruvlukeRedUnderline' },
		DiagnosticWarn = { link = 'GruvlukeYellow' },
		DiagnosticSignWarn = { link = 'GruvlukeYellowSign' },
		DiagnosticUnderlineWarn = { link = 'GruvlukeYellowUnderline' },
		DiagnosticInfo = { link = 'GruvlukeBlue' },
		DiagnosticSignInfo = { link = 'GruvlukeBlueSign' },
		DiagnosticUnderlineInfo = { link = 'GruvlukeBlueUnderline' },
		DiagnosticHint = { link = 'GruvlukeAqua' },
		DiagnosticSignHint = { link = 'GruvlukeAquaSign' },
		DiagnosticUnderlineHint = { link = 'GruvlukeAquaUnderline' },
		DiagnosticFloatingError = { link = 'GruvlukeRed' },
		DiagnosticFloatingWarn = { link = 'GruvlukeOrange' },
		DiagnosticFloatingInfo = { link = 'GruvlukeBlue' },
		DiagnosticFloatingHint = { link = 'GruvlukeAqua' },
		DiagnosticVirtualTextError = { link = 'GruvlukeRed' },
		DiagnosticVirtualTextWarn = { link = 'GruvlukeYellow' },
		DiagnosticVirtualTextInfo = { link = 'GruvlukeBlue' },
		DiagnosticVirtualTextHint = { link = 'GruvlukeAqua' },
		LspReferenceRead = { bold = true },
		LspReferenceText = { bold = true },
		LspReferenceWrite = { bold = true },
		LspCodeLens = { link = 'GruvlukeGray' },
		LspSignatureActiveParameter = { link = 'Search' },

		-- nvim-treesitter
		-- See `nvim-treesitter/CONTRIBUTING.md`

		--
		-- Misc
		--
		-- @comment               ; line and block comments
		['@comment'] = { link = 'Comment' },
		-- @comment.documentation ; comments documenting code
		-- @none                  ; completely disable the highlight
		['@none'] = { bg = 'NONE', fg = 'NONE' },
		-- @preproc               ; various preprocessor directives & shebangs
		['@preproc'] = { link = 'PreProc' },
		-- @define                ; preprocessor definition directives
		['@define'] = { link = 'Define' },
		-- @operator              ; symbolic operators (e.g. `+` / `*`)
		['@operator'] = { link = 'Operator' },

		--
		-- Punctuation
		--
		-- @punctuation.delimiter ; delimiters (e.g. `;` / `.` / `,`)
		['@punctuation.delimiter'] = { link = 'Comment' },
		-- @punctuation.bracket   ; brackets (e.g. `()` / `{}` / `[]`)
		['@punctuation.bracket'] = { fg = colors.fg1 },
		-- @punctuation.special   ; special symbols (e.g. `{}` in string interpolation)
		['@punctuation.special'] = { link = 'Delimiter' },

		--
		-- Literals
		--
		-- @string               ; string literals
		['@string'] = { link = 'String' },
		-- @string.documentation ; string documenting code (e.g. Python docstrings)
		-- @string.regex         ; regular expressions
		['@string.regex'] = { link = 'String' },
		-- @string.escape        ; escape sequences
		['@string.escape'] = { link = 'SpecialChar' },
		-- @string.special       ; other special strings (e.g. dates)
		['@string.special'] = { link = 'SpecialChar' },

		-- @character            ; character literals
		['@character'] = { link = 'Character' },
		-- @character.special    ; special characters (e.g. wildcards)
		['@character.special'] = { link = 'SpecialChar' },

		-- @boolean              ; boolean literals
		['@boolean'] = { link = 'Boolean' },
		-- @number               ; numeric literals
		['@number'] = { link = 'Number' },
		-- @float                ; floating-point number literals
		['@float'] = { link = 'Float' },

		--
		-- Functions
		--
		-- @function         ; function definitions
		['@function'] = { link = 'Function' },
		-- @function.builtin ; built-in functions
		['@function.builtin'] = { link = 'Special' },
		-- @function.call    ; function calls
		['@function.call'] = { link = 'Function' },
		-- @function.macro   ; preprocessor macros
		['@function.macro'] = { link = 'Macro' },

		-- @method           ; method definitions
		['@method'] = { link = 'Function' },
		-- @method.call      ; method calls
		['@method.call'] = { link = 'Function' },

		-- @constructor      ; constructor calls and definitions
		['@constructor'] = { link = 'Special' },
		-- @parameter        ; parameters of a function
		['@parameter'] = { link = 'Identifier' },

		--
		-- Keywords
		--
		-- @keyword             ; various keywords
		['@keyword'] = { link = 'Keyword' },
		-- @keyword.coroutine   ; keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
		-- @keyword.function    ; keywords that define a function (e.g. `func` in Go, `def` in Python)
		['@keyword.function'] = { link = 'Keyword' },
		-- @keyword.operator    ; operators that are English words (e.g. `and` / `or`)
		['@keyword.operator'] = { link = 'GruvlukeRed' },
		-- @keyword.return      ; keywords like `return` and `yield`
		['@keyword.return'] = { link = 'Keyword' },

		-- @conditional         ; keywords related to conditionals (e.g. `if` / `else`)
		['@conditional'] = { link = 'Conditional' },
		-- @conditional.ternary ; ternary operator (e.g. `?` / `:`)

		-- @repeat              ; keywords related to loops (e.g. `for` / `while`)
		['@repeat'] = { link = 'Repeat' },
		-- @debug               ; keywords related to debugging
		['@debug'] = { link = 'Debug' },
		-- @label               ; GOTO and other labels (e.g. `label:` in C)
		['@label'] = { link = 'Label' },
		-- @include             ; keywords for including modules (e.g. `import` / `from` in Python)
		['@include'] = { link = 'Include' },
		-- @exception           ; keywords related to exceptions (e.g. `throw` / `catch`)
		['@exception'] = { link = 'Exception' },

		--
		-- Types
		--
		-- @type            ; type or class definitions and annotations
		['@type'] = { link = 'Type' },
		-- @type.builtin    ; built-in types
		['@type.builtin'] = { link = 'Type' },
		-- @type.definition ; type definitions (e.g. `typedef` in C)
		['@type.definition'] = { link = 'Typedef' },
		-- @type.qualifier  ; type qualifiers (e.g. `const`)
		['@type.qualifier'] = { link = 'Type' },

		-- @storageclass    ; modifiers that affect storage in memory or life-time
		['@storageclass'] = { link = 'StorageClass' },
		-- @attribute       ; attribute annotations (e.g. Python decorators)
		['@attribute'] = { link = 'PreProc' },
		-- @field           ; object and struct fields
		['@field'] = { link = 'Identifier' },
		-- @property        ; similar to `@field`
		['@property'] = { link = 'Identifier' },

		--
		-- Identifiers
		--
		-- @variable         ; various variable names
		['@variable'] = { link = 'GruvlukeFg1' },
		-- @variable.builtin ; built-in variable names (e.g. `this`)
		['@variable.builtin'] = { link = 'Special' },

		-- @constant         ; constant identifiers
		['@constant'] = { link = 'Constant' },
		-- @constant.builtin ; built-in constant values
		['@constant.builtin'] = { link = 'Special' },
		-- @constant.macro   ; constants defined by the preprocessor
		['@constant.macro'] = { link = 'Define' },

		-- @namespace        ; modules or namespaces
		['@namespace'] = { link = 'GruvlukeYellow' },
		-- @symbol           ; symbols or atoms
		['@symbol'] = { link = 'Identifier' },

		--
		-- Text
		--
		-- @text                  ; non-structured text
		['@text'] = { link = 'GruvlukeFg1' },
		-- @text.strong           ; bold text
		['@text.strong'] = { bold = true },
		-- @text.emphasis         ; text with emphasis
		['@text.emphasis'] = { italic = true },
		-- @text.underline        ; underlined text
		['@text.underline'] = { underline = true },
		-- @text.strike           ; strikethrough text
		['@text.strike'] = { strikethrough = true },
		-- @text.title            ; text that is part of a title
		['@text.title'] = { link = 'Title' },
		-- @text.literal          ; literal or verbatim text (e.g., inline code)
		['@text.literal'] = { link = 'String' },
		-- @text.quote            ; text quotations
		-- @text.uri              ; URIs (e.g. hyperlinks)
		['@text.uri'] = { link = 'Underlined' },
		-- @text.math             ; math environments (e.g. `$ ... $` in LaTeX)
		['@text.math'] = { link = 'Special' },
		-- @text.environment      ; text environments of markup languages
		['@text.environment'] = { link = 'Macro' },
		-- @text.environment.name ; text indicating the type of an environment
		['@text.environment.name'] = { link = 'Type' },
		-- @text.reference        ; text references, footnotes, citations, etc.
		['@text.reference'] = { link = 'Constant' },

		-- @text.todo             ; todo notes
		['@text.todo'] = { link = 'Todo' },
		-- @text.note             ; info notes
		['@text.note'] = { link = 'SpecialComment' },
		-- @text.note.comment     ; XXX in comments
		['@text.note.comment'] = { fg = colors.purple, bold = true },
		-- @text.warning          ; warning notes
		['@text.warning'] = { link = 'WarningMsg' },
		-- @text.danger           ; danger/error notes
		['@text.danger'] = { link = 'ErrorMsg' },
		-- @text.danger.comment   ; FIXME in comments
		['@text.danger.comment'] = { fg = colors.fg0, bg = colors.red, bold = true },

		-- @text.diff.add         ; added text (for diff files)
		['@text.diff.add'] = { link = 'diffAdded' },
		-- @text.diff.delete      ; deleted text (for diff files)
		['@text.diff.delete'] = { link = 'diffRemoved' },

		--
		-- Tags
		--
		-- @tag           ; XML tag names
		['@tag'] = { link = 'Tag' },
		-- @tag.attribute ; XML tag attributes
		['@tag.attribute'] = { link = 'Identifier' },
		-- @tag.delimiter ; XML tag delimiters
		['@tag.delimiter'] = { link = 'Delimiter' },

		--
		-- Conceal
		--
		-- @conceal ; for captures that are only used for concealing

		--
		-- Spell
		--
		-- @spell   ; for defining regions to be spellchecked
		-- @nospell ; for defining regions that should NOT be spellchecked

		-- Treesitter
		-- See `:help treesitter`
		-- Those are not part of the nvim-treesitter
		['@punctuation'] = { link = 'Comment' },
		['@macro'] = { link = 'Macro' },
		['@structure'] = { link = 'Structure' },

		-- Semantic token
		-- See `:help lsp-semantic-highlight`
		['@lsp.type.class'] = { link = '@type' },
		['@lsp.type.comment'] = {}, -- do not overwrite comments
		['@lsp.type.decorator'] = { link = '@macro' },
		['@lsp.type.enum'] = { link = '@type' },
		['@lsp.type.enumMember'] = { link = '@constant' },
		['@lsp.type.function'] = { link = '@function' },
		['@lsp.type.interface'] = { link = '@constructor' },
		['@lsp.type.macro'] = { link = '@macro' },
		['@lsp.type.method'] = { link = '@method' },
		['@lsp.type.namespace'] = { link = '@namespace' },
		['@lsp.type.parameter'] = { link = '@parameter' },
		['@lsp.type.property'] = { link = '@property' },
		['@lsp.type.struct'] = { link = '@type' },
		['@lsp.type.type'] = { link = '@type' },
		['@lsp.type.typeParameter'] = { link = '@type.definition' },
		['@lsp.type.variable'] = { link = '@variable' },

		-- gitcommit
		gitcommitSelectedFile = { link = 'GruvlukeGreen' },
		gitcommitDiscardedFile = { link = 'GruvlukeRed' },
		-- gitsigns.nvim
		GitSignsAdd = { link = 'GruvlukeGreenSign' },
		GitSignsChange = { link = 'GruvlukeAquaSign' },
		GitSignsDelete = { link = 'GruvlukeRedSign' },
		GitSignsTopdelete = { link = 'GitSignsDelete' },
		GitSignsAddLn = { link = 'GitSignsAdd' },
		GitSignsChangeLn = { link = 'GitSignsChange' },
		GitSignsDeleteLn = { link = 'GitSignsDelete' },
		GitSignsTopdeleteLn = { link = 'GitSignsTopdelete' },
		GitSignsAddNr = { link = 'GitSignsAdd' },
		GitSignsChangeNr = { link = 'GitSignsChange' },
		GitSignsDeleteNr = { link = 'GitSignsDelete' },
		GitSignsTopdeleteNr = { link = 'GitSignsTopdelete' },
		-- netrw
		netrwDir = { link = 'GruvlukeAqua' },
		netrwClassify = { link = 'GruvlukeAqua' },
		netrwLink = { link = 'GruvlukeGray' },
		netrwSymLink = { link = 'GruvlukeFg1' },
		netrwExe = { link = 'GruvlukeYellow' },
		netrwComment = { link = 'GruvlukeGray' },
		netrwList = { link = 'GruvlukeBlue' },
		netrwHelpCmd = { link = 'GruvlukeAqua' },
		netrwCmdSep = { link = 'GruvlukeFg3' },
		netrwVersion = { link = 'GruvlukeGreen' },
		-- telescope.nvim
		TelescopeNormal = { link = 'GruvlukeFg1' },
		TelescopeSelection = { link = 'Visual' },
		TelescopeSelectionCaret = { link = 'GruvlukeRed' },
		TelescopeMultiSelection = { link = 'GruvlukeGray' },
		TelescopeBorder = { link = 'TelescopeNormal' },
		TelescopePromptBorder = { link = 'TelescopeNormal' },
		TelescopeResultsBorder = { link = 'TelescopeNormal' },
		TelescopePreviewBorder = { link = 'TelescopeNormal' },
		TelescopeMatching = { link = 'GruvlukeRedBold' },
		TelescopePromptPrefix = { link = 'GruvlukeRed' },
		TelescopePrompt = { link = 'TelescopeNormal' },
		-- glace
		GlancePreviewMatch = { link = 'Visual' },
		GlanceListMatch = { link = 'GlancePreviewMatch' },
		-- nvim-cmp
		CmpItemAbbr = { link = 'GruvlukeFg0' },
		CmpItemAbbrDeprecated = { link = 'GruvlukeFg1' },
		CmpItemAbbrMatch = { link = 'GruvlukeBlueBold' },
		CmpItemAbbrMatchFuzzy = { link = 'GruvlukeBlueUnderline' },
		CmpItemMenu = { link = 'GruvlukeGray' },
		CmpItemKindText = { link = 'GruvlukeOrange' },
		CmpItemKindVariable = { link = 'GruvlukeOrange' },
		CmpItemKindMethod = { link = 'GruvlukeBlue' },
		CmpItemKindFunction = { link = 'GruvlukeBlue' },
		CmpItemKindConstructor = { link = 'GruvlukeYellow' },
		CmpItemKindUnit = { link = 'GruvlukeBlue' },
		CmpItemKindField = { link = 'GruvlukeBlue' },
		CmpItemKindClass = { link = 'GruvlukeYellow' },
		CmpItemKindInterface = { link = 'GruvlukeYellow' },
		CmpItemKindModule = { link = 'GruvlukeBlue' },
		CmpItemKindProperty = { link = 'GruvlukeBlue' },
		CmpItemKindValue = { link = 'GruvlukeOrange' },
		CmpItemKindEnum = { link = 'GruvlukeYellow' },
		CmpItemKindOperator = { link = 'GruvlukeYellow' },
		CmpItemKindKeyword = { link = 'GruvlukePurple' },
		CmpItemKindEvent = { link = 'GruvlukePurple' },
		CmpItemKindReference = { link = 'GruvlukePurple' },
		CmpItemKindColor = { link = 'GruvlukePurple' },
		CmpItemKindSnippet = { link = 'GruvlukeGreen' },
		CmpItemKindFile = { link = 'GruvlukeBlue' },
		CmpItemKindFolder = { link = 'GruvlukeBlue' },
		CmpItemKindEnumMember = { link = 'GruvlukeAqua' },
		CmpItemKindConstant = { link = 'GruvlukeOrange' },
		CmpItemKindStruct = { link = 'GruvlukeYellow' },
		CmpItemKindTypeParameter = { link = 'GruvlukeYellow' },
		diffAdded = { link = 'GruvlukeGreen' },
		diffRemoved = { link = 'GruvlukeRed' },
		diffChanged = { link = 'GruvlukeAqua' },
		diffFile = { link = 'GruvlukeOrange' },
		diffNewFile = { link = 'GruvlukeYellow' },
		diffOldFile = { link = 'GruvlukeOrange' },
		diffLine = { link = 'GruvlukeBlue' },
		diffIndexLine = { link = 'diffChanged' },
		-- navic (highlight icons)
		NavicIconsFile = { link = 'GruvlukeBlue' },
		NavicIconsModule = { link = 'GruvlukeOrange' },
		NavicIconsNamespace = { link = 'GruvlukeBlue' },
		NavicIconsPackage = { link = 'GruvlukeAqua' },
		NavicIconsClass = { link = 'GruvlukeYellow' },
		NavicIconsMethod = { link = 'GruvlukeBlue' },
		NavicIconsProperty = { link = 'GruvlukeAqua' },
		NavicIconsField = { link = 'GruvlukePurple' },
		NavicIconsConstructor = { link = 'GruvlukeBlue' },
		NavicIconsEnum = { link = 'GruvlukePurple' },
		NavicIconsInterface = { link = 'GruvlukeGreen' },
		NavicIconsFunction = { link = 'GruvlukeBlue' },
		NavicIconsVariable = { link = 'GruvlukePurple' },
		NavicIconsConstant = { link = 'GruvlukeOrange' },
		NavicIconsString = { link = 'GruvlukeGreen' },
		NavicIconsNumber = { link = 'GruvlukeOrange' },
		NavicIconsBoolean = { link = 'GruvlukeOrange' },
		NavicIconsArray = { link = 'GruvlukeOrange' },
		NavicIconsObject = { link = 'GruvlukeOrange' },
		NavicIconsKey = { link = 'GruvlukeAqua' },
		NavicIconsNull = { link = 'GruvlukeOrange' },
		NavicIconsEnumMember = { link = 'GruvlukeYellow' },
		NavicIconsStruct = { link = 'GruvlukePurple' },
		NavicIconsEvent = { link = 'GruvlukeYellow' },
		NavicIconsOperator = { link = 'GruvlukeRed' },
		NavicIconsTypeParameter = { link = 'GruvlukeRed' },
		NavicText = { link = 'GruvlukeWhite' },
		NavicSeparator = { link = 'GruvlukeWhite' },
		-- html
		htmlTag = { link = 'GruvlukeAquaBold' },
		htmlEndTag = { link = 'GruvlukeAquaBold' },
		htmlTagName = { link = 'GruvlukeBlue' },
		htmlArg = { link = 'GruvlukeOrange' },
		htmlTagN = { link = 'GruvlukeFg1' },
		htmlSpecialTagName = { link = 'GruvlukeBlue' },
		htmlLink = { fg = colors.fg4, underline = true },
		htmlSpecialChar = { link = 'GruvlukeRed' },
		htmlBold = { fg = colors.fg0, bg = colors.bg0, bold = true },
		htmlBoldUnderline = { fg = colors.fg0, bg = colors.bg0, bold = true, underline = true },
		htmlBoldItalic = { fg = colors.fg0, bg = colors.bg0, bold = true, italic = true },
		htmlBoldUnderlineItalic = {
			fg = colors.fg0,
			bg = colors.bg0,
			bold = true,
			italic = true,
			underline = true,
		},
		htmlUnderline = { fg = colors.fg0, bg = colors.bg0, underline = true },
		htmlUnderlineItalic = {
			fg = colors.fg0,
			bg = colors.bg0,
			italic = true,
			underline = true,
		},
		htmlItalic = { fg = colors.fg0, bg = colors.bg0, italic = true },
		-- xml
		xmlTag = { link = 'GruvlukeAquaBold' },
		xmlEndTag = { link = 'GruvlukeAquaBold' },
		xmlTagName = { link = 'GruvlukeBlue' },
		xmlEqual = { link = 'GruvlukeBlue' },
		docbkKeyword = { link = 'GruvlukeAquaBold' },
		xmlDocTypeDecl = { link = 'GruvlukeGray' },
		xmlDocTypeKeyword = { link = 'GruvlukePurple' },
		xmlCdataStart = { link = 'GruvlukeGray' },
		xmlCdataCdata = { link = 'GruvlukePurple' },
		dtdFunction = { link = 'GruvlukeGray' },
		dtdTagName = { link = 'GruvlukePurple' },
		xmlAttrib = { link = 'GruvlukeOrange' },
		xmlProcessingDelim = { link = 'GruvlukeGray' },
		dtdParamEntityPunct = { link = 'GruvlukeGray' },
		dtdParamEntityDPunct = { link = 'GruvlukeGray' },
		xmlAttribPunct = { link = 'GruvlukeGray' },
		xmlEntity = { link = 'GruvlukeRed' },
		xmlEntityPunct = { link = 'GruvlukeRed' },
		-- clojure
		clojureKeyword = { link = 'GruvlukeBlue' },
		clojureCond = { link = 'GruvlukeOrange' },
		clojureSpecial = { link = 'GruvlukeOrange' },
		clojureDefine = { link = 'GruvlukeOrange' },
		clojureFunc = { link = 'GruvlukeYellow' },
		clojureRepeat = { link = 'GruvlukeYellow' },
		clojureCharacter = { link = 'GruvlukeAqua' },
		clojureStringEscape = { link = 'GruvlukeAqua' },
		clojureException = { link = 'GruvlukeRed' },
		clojureRegexp = { link = 'GruvlukeAqua' },
		clojureRegexpEscape = { link = 'GruvlukeAqua' },
		clojureRegexpCharClass = { fg = colors.fg3, bold = true },
		clojureRegexpMod = { link = 'clojureRegexpCharClass' },
		clojureRegexpQuantifier = { link = 'clojureRegexpCharClass' },
		clojureParen = { link = 'GruvlukeFg3' },
		clojureAnonArg = { link = 'GruvlukeYellow' },
		clojureVariable = { link = 'GruvlukeBlue' },
		clojureMacro = { link = 'GruvlukeOrange' },
		clojureMeta = { link = 'GruvlukeYellow' },
		clojureDeref = { link = 'GruvlukeYellow' },
		clojureQuote = { link = 'GruvlukeYellow' },
		clojureUnquote = { link = 'GruvlukeYellow' },
		-- C
		cOperator = { link = 'GruvlukePurple' },
		cppOperator = { link = 'GruvlukePurple' },
		cStructure = { link = 'GruvlukeOrange' },
		-- python
		pythonBuiltin = { link = 'GruvlukeOrange' },
		pythonBuiltinObj = { link = 'GruvlukeOrange' },
		pythonBuiltinFunc = { link = 'GruvlukeOrange' },
		pythonFunction = { link = 'GruvlukeAqua' },
		pythonDecorator = { link = 'GruvlukeRed' },
		pythonInclude = { link = 'GruvlukeBlue' },
		pythonImport = { link = 'GruvlukeBlue' },
		pythonRun = { link = 'GruvlukeBlue' },
		pythonCoding = { link = 'GruvlukeBlue' },
		pythonOperator = { link = 'GruvlukeRed' },
		pythonException = { link = 'GruvlukeRed' },
		pythonExceptions = { link = 'GruvlukePurple' },
		pythonBoolean = { link = 'GruvlukePurple' },
		pythonDot = { link = 'GruvlukeFg3' },
		pythonConditional = { link = 'GruvlukeRed' },
		pythonRepeat = { link = 'GruvlukeRed' },
		pythonDottedName = { link = 'GruvlukeGreen' },
		-- CSS
		cssBraces = { link = 'GruvlukeBlue' },
		cssFunctionName = { link = 'GruvlukeYellow' },
		cssIdentifier = { link = 'GruvlukeOrange' },
		cssClassName = { link = 'GruvlukeGreen' },
		cssColor = { link = 'GruvlukeBlue' },
		cssSelectorOp = { link = 'GruvlukeBlue' },
		cssSelectorOp2 = { link = 'GruvlukeBlue' },
		cssImportant = { link = 'GruvlukeGreen' },
		cssVendor = { link = 'GruvlukeFg1' },
		cssTextProp = { link = 'GruvlukeAqua' },
		cssAnimationProp = { link = 'GruvlukeAqua' },
		cssUIProp = { link = 'GruvlukeYellow' },
		cssTransformProp = { link = 'GruvlukeAqua' },
		cssTransitionProp = { link = 'GruvlukeAqua' },
		cssPrintProp = { link = 'GruvlukeAqua' },
		cssPositioningProp = { link = 'GruvlukeYellow' },
		cssBoxProp = { link = 'GruvlukeAqua' },
		cssFontDescriptorProp = { link = 'GruvlukeAqua' },
		cssFlexibleBoxProp = { link = 'GruvlukeAqua' },
		cssBorderOutlineProp = { link = 'GruvlukeAqua' },
		cssBackgroundProp = { link = 'GruvlukeAqua' },
		cssMarginProp = { link = 'GruvlukeAqua' },
		cssListProp = { link = 'GruvlukeAqua' },
		cssTableProp = { link = 'GruvlukeAqua' },
		cssFontProp = { link = 'GruvlukeAqua' },
		cssPaddingProp = { link = 'GruvlukeAqua' },
		cssDimensionProp = { link = 'GruvlukeAqua' },
		cssRenderProp = { link = 'GruvlukeAqua' },
		cssColorProp = { link = 'GruvlukeAqua' },
		cssGeneratedContentProp = { link = 'GruvlukeAqua' },
		-- javascript
		javaScriptBraces = { link = 'GruvlukeFg1' },
		javaScriptFunction = { link = 'GruvlukeAqua' },
		javaScriptIdentifier = { link = 'GruvlukeRed' },
		javaScriptMember = { link = 'GruvlukeBlue' },
		javaScriptNumber = { link = 'GruvlukePurple' },
		javaScriptNull = { link = 'GruvlukePurple' },
		javaScriptParens = { link = 'GruvlukeFg3' },
		-- typescript
		typescriptReserved = { link = 'GruvlukeAqua' },
		typescriptLabel = { link = 'GruvlukeAqua' },
		typescriptFuncKeyword = { link = 'GruvlukeAqua' },
		typescriptIdentifier = { link = 'GruvlukeOrange' },
		typescriptBraces = { link = 'GruvlukeFg1' },
		typescriptEndColons = { link = 'GruvlukeFg1' },
		typescriptDOMObjects = { link = 'GruvlukeFg1' },
		typescriptAjaxMethods = { link = 'GruvlukeFg1' },
		typescriptLogicSymbols = { link = 'GruvlukeFg1' },
		typescriptDocSeeTag = { link = 'Comment' },
		typescriptDocParam = { link = 'Comment' },
		typescriptDocTags = { link = 'vimCommentTitle' },
		typescriptGlobalObjects = { link = 'GruvlukeFg1' },
		typescriptParens = { link = 'GruvlukeFg3' },
		typescriptOpSymbols = { link = 'GruvlukeFg3' },
		typescriptHtmlElemProperties = { link = 'GruvlukeFg1' },
		typescriptNull = { link = 'GruvlukePurple' },
		typescriptInterpolationDelimiter = { link = 'GruvlukeAqua' },
		-- ruby
		rubyStringDelimiter = { link = 'GruvlukeGreen' },
		rubyInterpolationDelimiter = { link = 'GruvlukeAqua' },
		rubyDefinedOperator = { link = 'rubyKeyword' },
		-- objc
		objcTypeModifier = { link = 'GruvlukeRed' },
		objcDirective = { link = 'GruvlukeBlue' },
		-- go
		goDirective = { link = 'GruvlukeAqua' },
		goConstants = { link = 'GruvlukePurple' },
		goDeclaration = { link = 'GruvlukeRed' },
		goDeclType = { link = 'GruvlukeBlue' },
		goBuiltins = { link = 'GruvlukeOrange' },
		-- lua
		luaIn = { link = 'GruvlukeRed' },
		luaFunction = { link = 'GruvlukeAqua' },
		luaTable = { link = 'GruvlukeOrange' },
		-- java
		javaAnnotation = { link = 'GruvlukeBlue' },
		javaDocTags = { link = 'GruvlukeAqua' },
		javaCommentTitle = { link = 'vimCommentTitle' },
		javaParen = { link = 'GruvlukeFg3' },
		javaParen1 = { link = 'GruvlukeFg3' },
		javaParen2 = { link = 'GruvlukeFg3' },
		javaParen3 = { link = 'GruvlukeFg3' },
		javaParen4 = { link = 'GruvlukeFg3' },
		javaParen5 = { link = 'GruvlukeFg3' },
		javaOperator = { link = 'GruvlukeOrange' },
		javaVarArg = { link = 'GruvlukeGreen' },
		-- elixir
		elixirDocString = { link = 'Comment' },
		elixirStringDelimiter = { link = 'GruvlukeGreen' },
		elixirInterpolationDelimiter = { link = 'GruvlukeAqua' },
		elixirModuleDeclaration = { link = 'GruvlukeYellow' },
		-- scala
		scalaNameDefinition = { link = 'GruvlukeFg1' },
		scalaCaseFollowing = { link = 'GruvlukeFg1' },
		scalaCapitalWord = { link = 'GruvlukeFg1' },
		scalaTypeExtension = { link = 'GruvlukeFg1' },
		scalaKeyword = { link = 'GruvlukeRed' },
		scalaKeywordModifier = { link = 'GruvlukeRed' },
		scalaSpecial = { link = 'GruvlukeAqua' },
		scalaOperator = { link = 'GruvlukeFg1' },
		scalaTypeDeclaration = { link = 'GruvlukeYellow' },
		scalaTypeTypePostDeclaration = { link = 'GruvlukeYellow' },
		scalaInstanceDeclaration = { link = 'GruvlukeFg1' },
		scalaInterpolation = { link = 'GruvlukeAqua' },
		-- markdown
		markdownItalic = { fg = colors.fg3, italic = true },
		markdownBold = { fg = colors.fg3, bold = true },
		markdownBoldItalic = { fg = colors.fg3, bold = true, italic = true },
		markdownH1 = { link = 'GruvlukeGreenBold' },
		markdownH2 = { link = 'GruvlukeGreenBold' },
		markdownH3 = { link = 'GruvlukeYellowBold' },
		markdownH4 = { link = 'GruvlukeYellowBold' },
		markdownH5 = { link = 'GruvlukeYellow' },
		markdownH6 = { link = 'GruvlukeYellow' },
		markdownCode = { link = 'GruvlukeAqua' },
		markdownCodeBlock = { link = 'GruvlukeAqua' },
		markdownCodeDelimiter = { link = 'GruvlukeAqua' },
		markdownBlockquote = { link = 'GruvlukeGray' },
		markdownListMarker = { link = 'GruvlukeGray' },
		markdownOrderedListMarker = { link = 'GruvlukeGray' },
		markdownRule = { link = 'GruvlukeGray' },
		markdownHeadingRule = { link = 'GruvlukeGray' },
		markdownUrlDelimiter = { link = 'GruvlukeFg3' },
		markdownLinkDelimiter = { link = 'GruvlukeFg3' },
		markdownLinkTextDelimiter = { link = 'GruvlukeFg3' },
		markdownHeadingDelimiter = { link = 'GruvlukeOrange' },
		markdownUrl = { link = 'GruvlukePurple' },
		markdownUrlTitleDelimiter = { link = 'GruvlukeGreen' },
		markdownLinkText = { fg = colors.gray, underline = true },
		markdownIdDeclaration = { link = 'markdownLinkText' },
		-- haskell
		haskellType = { link = 'GruvlukeBlue' },
		haskellIdentifier = { link = 'GruvlukeAqua' },
		haskellSeparator = { link = 'GruvlukeFg4' },
		haskellDelimiter = { link = 'GruvlukeOrange' },
		haskellOperators = { link = 'GruvlukePurple' },
		haskellBacktick = { link = 'GruvlukeOrange' },
		haskellStatement = { link = 'GruvlukePurple' },
		haskellConditional = { link = 'GruvlukePurple' },
		haskellLet = { link = 'GruvlukeRed' },
		haskellDefault = { link = 'GruvlukeRed' },
		haskellWhere = { link = 'GruvlukeRed' },
		haskellBottom = { link = 'GruvlukeRedBold' },
		haskellImportKeywords = { link = 'GruvlukePurpleBold' },
		haskellDeclKeyword = { link = 'GruvlukeOrange' },
		haskellDecl = { link = 'GruvlukeOrange' },
		haskellDeriving = { link = 'GruvlukePurple' },
		haskellAssocType = { link = 'GruvlukeAqua' },
		haskellNumber = { link = 'GruvlukeAqua' },
		haskellPragma = { link = 'GruvlukeRedBold' },
		haskellTH = { link = 'GruvlukeAquaBold' },
		haskellForeignKeywords = { link = 'GruvlukeGreen' },
		haskellKeyword = { link = 'GruvlukeRed' },
		haskellFloat = { link = 'GruvlukeAqua' },
		haskellInfix = { link = 'GruvlukePurple' },
		haskellQuote = { link = 'GruvlukeGreenBold' },
		haskellShebang = { link = 'GruvlukeYellowBold' },
		haskellLiquid = { link = 'GruvlukePurpleBold' },
		haskellQuasiQuoted = { link = 'GruvlukeBlueBold' },
		haskellRecursiveDo = { link = 'GruvlukePurple' },
		haskellQuotedType = { link = 'GruvlukeRed' },
		haskellPreProc = { link = 'GruvlukeFg4' },
		haskellTypeRoles = { link = 'GruvlukeRedBold' },
		haskellTypeForall = { link = 'GruvlukeRed' },
		haskellPatternKeyword = { link = 'GruvlukeBlue' },
		-- json
		jsonKeyword = { link = 'GruvlukeGreen' },
		jsonQuote = { link = 'GruvlukeGreen' },
		jsonBraces = { link = 'GruvlukeFg1' },
		jsonString = { link = 'GruvlukeFg1' },
		-- c#
		csBraces = { link = 'GruvlukeFg1' },
		csEndColon = { link = 'GruvlukeFg1' },
		csLogicSymbols = { link = 'GruvlukeFg1' },
		csParens = { link = 'GruvlukeFg3' },
		csOpSymbols = { link = 'GruvlukeFg3' },
		csInterpolationDelimiter = { link = 'GruvlukeFg3' },
		csInterpolationAlignDel = { link = 'GruvlukeAquaBold' },
		csInterpolationFormat = { link = 'GruvlukeAqua' },
		csInterpolationFormatDel = { link = 'GruvlukeAquaBold' },
		-- rust btw
		rustSigil = { link = 'GruvlukeOrange' },
		rustEscape = { link = 'GruvlukeAqua' },
		rustStringContinuation = { link = 'GruvlukeAqua' },
		rustEnum = { link = 'GruvlukeAqua' },
		rustStructure = { link = 'GruvlukeAqua' },
		rustModPathSep = { link = 'GruvlukeFg2' },
		rustCommentLineDoc = { link = 'Comment' },
		rustDefault = { link = 'GruvlukeAqua' },
		-- ocaml
		ocamlOperator = { link = 'GruvlukeFg1' },
		ocamlKeyChar = { link = 'GruvlukeOrange' },
		ocamlArrow = { link = 'GruvlukeOrange' },
		ocamlInfixOpKeyword = { link = 'GruvlukeRed' },
		ocamlConstructor = { link = 'GruvlukeOrange' },
		-- mason
		MasonHighlight = { link = 'GruvlukeAqua' },
		MasonHighlightBlock = { fg = colors.bg0, bg = colors.blue },
		MasonHighlightBlockBold = { fg = colors.bg0, bg = colors.blue, bold = true },
		MasonHighlightSecondary = { fg = colors.yellow },
		MasonHighlightBlockSecondary = { fg = colors.bg0, bg = colors.yellow },
		MasonHighlightBlockBoldSecondary = { fg = colors.bg0, bg = colors.yellow, bold = true },
		MasonHeader = { link = 'MasonHighlightBlockBoldSecondary' },
		MasonHeaderSecondary = { link = 'MasonHighlightBlockBold' },
		MasonMuted = { fg = colors.fg4 },
		MasonMutedBlock = { fg = colors.bg0, bg = colors.fg4 },
		MasonMutedBlockBold = { fg = colors.bg0, bg = colors.fg4, bold = true },
		-- lsp-inlayhints.nvim
		LspInlayHint = { link = 'comment' },
		-- vim-illuminate
		IlluminatedWordText = { link = 'LspReferenceText' },
		IlluminatedWordRead = { link = 'LspReferenceRead' },
		IlluminatedWordWrite = { link = 'LspReferenceWrite' },
		-- Notify
		NotifyERRORBorder = { link = 'GruvlukeRed' },
		NofityWARNBorder = { link = 'GruvlukeYellow' },
		NotifyINFOBorder = { link = 'GruvlukeGreen' },
		NofityDEBUGBorder = { link = 'GruvlukeFg4' },
		NofityTRACEBorder = { link = 'GruvlukePurple' },
		NofityERRORIcon = { link = 'NotifyERRORBorder' },
		NotifyWARNIcon = { link = 'NofityWARNBorder' },
		NotifyINFOIcon = { link = 'NotifyINFOBorder' },
		NofityDEBUGIcon = { link = 'NofityDEBUGBorder' },
		NofityTRACEIcon = { link = 'NofityTRACEBorder' },
		NotifyERRORTitle = { link = 'NotifyERRORBorder' },
		NotifyWARNTitle = { link = 'NofityWARNBorder' },
		NotifyINFOTitle = { link = 'NotifyINFOBorder' },
		NofityDEBUGTitle = { link = 'NofityDEBUGBorder' },
		NofityTRACETitle = { link = 'NofityTRACEBorder' },
		NotifyERRORBody = { link = 'Normal' },
		NotifyWARNBody = { link = 'Normal' },
		NotifyINFOBody = { link = 'Normal' },
		NofityDEBUGBody = { link = 'Normal' },
		NofityTRACEBody = { link = 'Normal' },
		-- Leap
		LeapBackdrop = { link = 'Comment' },
	}

	return groups
end

return M
