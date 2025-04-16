return {
	cmd = {
		'clangd',
		'--background-index',
		'--completion-style=detailed',
		'--function-arg-placeholders',
		'--header-insertion=never',
		'--pch-storage=memory',
		'--limit-references=100',
		'--limit-results=20',
		'-j=16',
	},
	settings = {
		clangd = {
			InlayHints = {
				Designators = true,
				Enabled = true,
				ParameterNames = true,
				DeducedTypes = true,
			},
		},
	},
}
