vim.filetype.add {
	extension = {
		cls = 'tex',
	},
}

vim.filetype.add {
	extension = {
		smd = 'markdown',
	},
}

vim.filetype.add {
	extension = {
		shtml = 'html',
	},
}

vim.filetype.add {
	pattern = {
		['.*'] = {
			function(path, buf)
				return vim.bo[buf]
						and vim.bo[buf].filetype ~= 'bigfile'
						and path
						and vim.fn.getfsize(path) > 1.5 * 1024 * 1024 -- 1.5MB
						and 'bigfile'
					or nil
			end,
		},
	},
}
