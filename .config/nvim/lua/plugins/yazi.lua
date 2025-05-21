return {
	"DreamMaoMao/yazi.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	lazy = false,
	priority = 100,
	keys = {
		{
			"<leader>e",
			"<cmd>Yazi<CR>",
			desc = "Open Yazi file manager",
		},
	},
}
