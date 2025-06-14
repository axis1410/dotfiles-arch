return {
	{
		"saghen/blink.cmp",
		lazy = false, -- Load immediately for completion
		event = "InsertEnter", -- Also trigger on insert
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "1.*",
		build = "cargo build --release",
		opts = {
			snippets = {
				expand = function(snippet)
					-- More robust snippet expansion with better error handling
					if snippet then
						local body = snippet.body or snippet
						if body and type(body) == "string" and body ~= "" then
							vim.snippet.expand(body)
						end
					end
				end,
			},
			completion = {
				documentation = {
					auto_show = true,
				},
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
			},
			fuzzy = {
				implementation = "rust",
				prebuilt_binaries = {
					ignore_version_mismatch = true,
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			keymap = {
				preset = "default",
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
		opts_extend = { "sources.default" },
	},
}
