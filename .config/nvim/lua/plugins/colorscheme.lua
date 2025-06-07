return {
	{ "folke/tokyonight.nvim", lazy = false },
	{ "neanias/everforest-nvim" },
	{ "rose-pine/neovim", lazy = false, name = "rose-pine" },
	{ "vague2k/vague.nvim" },
	{ "nickkadutskyi/jb.nvim", lazy = false, priority = 1000 },
	{ "catppuccin/nvim", name = "catppuccin", lazy = false },
	{ "Mofiqul/vscode.nvim", lazy = false, priority = 1000 },
	{

		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "warmer",
				code_style = {
					comments = "italic",
					keywords = "none",
					functions = "none",
					strings = "none",
					variables = "none",
				},
			})
		end,
	},

	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_background = "medium"
		end,
	},
}
