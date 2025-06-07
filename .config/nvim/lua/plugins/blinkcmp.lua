return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "1.*",
		build = "cargo +nightly build --release",
		opts = {
			snippets = {
				expand = function(snippet)
					vim.snippet.expand(snippet.body)
				end,
			},
			completion = {
				documentation = {
					auto_show = true,
				},
			},
			fuzzy = {
				implementation = "prefer_rust",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			keymap = {
				-- use the same keybinds as your nvim-cmp configuration
				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-Space>"] = { "show" },
				["<C-y>"] = { "select_and_accept" },
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-h>"] = { "snippet_backward", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},
		},
	},
}
