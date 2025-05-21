return {
	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup({
				groups = {
					"Normal",
					"NormalNC",
					"Comment",
					"Constant",
					"Special",
					"Identifier",
					"Statement",
					"PreProc",
					"Type",
					"Underlined",
					"Todo",
					"String",
					"Function",
					"Conditional",
					"Repeat",
					"Operator",
					"Structure",
					"LineNr",
					"NonText",
					"SignColumn",
					"CursorLine",
					"CursorLineNr",
					"StatusLine",
					"StatusLineNC",
					"EndOfBuffer",
				},
				extra_groups = {

					"NormalFloat",
					"FloatBorder",
					"NvimTreeNormal",
					"NvimTreeNormalNC",
					"NvimTreeEndOfBuffer",
					"NvimTreeVertSplit",
					"NvimTreeStatusLine",
					"NvimTreeStatuslineNC",

					"TelescopeNormal",
					"TelescopeBorder",
					"WhichKeyFloat",
					"BufferLineFill",
					"BufferLineBackground",

					"Pmenu",
					"PmenuSbar",
					"PmenuThumb",
					"CmpPmenu",
					"CmpDocumentationBorder",

					"DiagnosticVirtualTextError",
					"DiagnosticVirtualTextWarn",
					"DiagnosticVirtualTextInfo",
					"DiagnosticVirtualTextHint",

					"GitSignsAdd",
					"GitSignsChange",
					"GitSignsDelete",
				},
				exclude_groups = {},
				ignore_linked_group = true,

				enable_terminal_transparency = true,
				transparency_amount = 0.8,

				allow_transparency_in_unfocused = true,
			})

			vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = "#6e738d" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", blend = 10 })

			vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2a2e36", blend = 15 })

			vim.keymap.set(
				"n",
				"<leader>tt",
				":TransparentToggle<CR>",
				{ desc = "Toggle Transparency", noremap = true, silent = true }
			)
		end,
	},
}
