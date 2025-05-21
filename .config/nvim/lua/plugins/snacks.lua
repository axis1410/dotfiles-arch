return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,

		opts = {
			indent = {
				enabled = true,
			},

			input = {
				enabled = true,
				win = {
					relative = "cursor",
					backdrop = true,
				},
			},

			image = {
				enabled = true,
				doc = {
					float = false,
					inline = true,
					max_width = 50,
					max_height = 30,
					wo = {
						wrap = true,
					},
				},
				convert = {
					notify = true,
				},
				img_dirs = {
					"img",
					"images",
					"assets",
					"static",
					"public",
					"media",
					"attachments",
					"sethVault",
					"~/Library",
					"~/Downloads",
				},
			},
			dashboard = {
				enabled = true,
				sections = {
					{
						title = "🔍  Recent Files",
						icon = "",
						section = "recent_files",
						max_items = 6,
						padding = 1,
						with_icon = true,
					},
					{
						title = "📂  Projects",
						icon = "",
						section = "projects",
						max_items = 4,
						padding = 1,
						with_icon = true,
					},
					{
						pane = 2,
						title = "⚡ Quick Actions",
						section = "keys",
						max_items = 5,
						padding = 1,
						with_icon = true,
						keys = {
							{ key = "ff", icon = "🔎", desc = "Find Files", action = "Telescope find_files" },
							{ key = "fg", icon = "📝", desc = "Live Grep", action = "Telescope live_grep" },
							{ key = "e", icon = "🌲", desc = "File Explorer", action = "Yazi" },
							{ key = "gg", icon = "📊", desc = "Git Status", action = "LazyGit" },
							{ key = "qq", icon = "🚪", desc = "Quit Neovim", action = "qa" },
						},
					},
					{
						pane = 2,
						title = "📊  Git Status",
						section = "terminal",
						enabled = function()
							return require("snacks").git and require("snacks").git.get_root() ~= nil
						end,
						cmd = "git status --short --branch",
						height = 6,
						padding = 1,
						ttl = 5 * 60,
					},
					{ section = "startup" },
				},
				options = {
					layout = {
						size = { width = 0.8, height = 0.8 },
						border = "rounded",
						backdrop = true,
					},
				},
			},
		},
		keys = {},
	},
}
