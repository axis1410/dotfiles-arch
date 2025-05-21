return {
	-- Auto close HTML/JSX tags
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		event = { "InsertEnter" },
		ft = { "html", "javascript", "typescript", "jsx", "tsx", "vue" },
		config = function()
			require("nvim-ts-autotag").setup({
				autotag = {
					enable = true,
					enable_rename = true,
					enable_close = true,
					enable_close_on_slash = true,
					filetypes = {
						"html",
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
						"vue",
						"tsx",
						"jsx",
						"xml",
					},
				},
			})
		end,
	},

	-- Tailwind colors inline
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				filetypes = {
					"*",
					"!vim",
				},
				user_default_options = {
					tailwind = true,
					mode = "background",
					css = true,
					css_fn = true,
				},
			})
		end,
	},
}
