return {
	{

		"christoomey/vim-tmux-navigator",
	},
	{

		"tpope/vim-sleuth",
	},
	{

		"tpope/vim-fugitive",
	},
	{

		"tpope/vim-rhubarb",
	},
	{

		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},

	{
		"folke/todo-comments.nvim",
		event = { "VimEnter", "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({
				keys = {
					{
						"<leader>pt",
						function()
							require("snacks").picker.todo_comments()
						end,
						desc = "Todo",
					},
					{
						"<leader>pT",
						function()
							require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
						end,
						desc = "Todo/Fix/Fixme",
					},
				},
			})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"sindrets/diffview.nvim",
	},
}
