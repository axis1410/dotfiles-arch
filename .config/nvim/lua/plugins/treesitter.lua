return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	event = { "BufReadPost", "BufNewFile" }, -- Lazy load treesitter

	opts = {
		-- Only install parsers you actually use
		ensure_installed = {
			"lua",
			"python",
			"javascript",
			"typescript",
			"vimdoc",
			"vim",
			"bash",
			"json",
			"markdown",
			"markdown_inline",
			"css",
			"html",
			-- Remove rarely used parsers to speed up installation
			-- "regex",
			-- "terraform",
			-- "sql",
			-- "dockerfile",
			-- "toml",
			-- "java",
			-- "groovy",
			-- "go",
			-- "gitignore",
			-- "graphql",
			-- "yaml",
			-- "make",
			-- "cmake",
			-- "tsx",
			-- "rust",
		},

		auto_install = false, -- Disable auto-install for performance
		
		highlight = {
			enable = true,
			-- Performance: disable for large files
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
				-- Disable for very long lines
				local line_count = vim.api.nvim_buf_line_count(buf)
				if line_count > 10000 then
					return true
				end
			end,
			-- Disable additional regex highlighting for performance
			additional_vim_regex_highlighting = false,
		},
		
		indent = { 
			enable = true, 
			-- Disable indent for problematic languages
			disable = { "ruby", "python" } 
		},
		
		-- Disable incremental selection for performance
		incremental_selection = {
			enable = false,
		},
		
		-- Disable text objects for performance
		textobjects = {
			enable = false,
		},
	},
}
