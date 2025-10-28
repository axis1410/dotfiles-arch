return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",

			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "debugloop/telescope-undo.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = " ",
				entry_prefix = "  ",
				sorting_strategy = "ascending",
				layout_strategy = "flex",
				layout_config = {
					prompt_position = "top",
					height = 0.9,
					width = 0.95,
					horizontal = { preview_width = 0.75 },
					vertical = { preview_height = 0.8 },
				},
				border = true,
				results_title = false,
				dynamic_preview_title = true,
				path_display = { "smart" },
				winblend = 0,
				mappings = {
					i = {
						["<C-k>"] = require("telescope.actions").move_selection_previous,
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-l>"] = require("telescope.actions").select_default,
					},
				},
			},
			pickers = {
				find_files = {
					file_ignore_patterns = { "node_modules", ".git", "venv", ".venv" },
					hidden = true,
					previewer = false,
					theme = "dropdown",
					layout_config = { width = 0.7, height = 0.6 },
				},
				live_grep = {
					file_ignore_patterns = { "node_modules", ".git", ".venv" },
					additional_args = function(_)
						return { "--hidden" }
					end,
				},
				buffers = {
					previewer = false,
					initial_mode = "normal",
					sort_mru = true,
					show_all_buffers = true,
					ignore_current_buffer = false,
					theme = "dropdown",
					layout_config = { width = 0.7, height = 0.6 },
					mappings = {
						i = { ["<C-d>"] = require("telescope.actions").delete_buffer },
						n = { ["dd"] = require("telescope.actions").delete_buffer },
					},
				},
				colorscheme = {
					enable_preview = true,
					previewer = false,
					theme = "dropdown",
					layout_config = { width = 0.45, height = 0.5 },
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				live_grep_args = {
					auto_quoting = true,
				},
				file_browser = {
					theme = "dropdown",
					hijack_netrw = true,
				},
				undo = {
					side_by_side = true,
					layout_strategy = "vertical",
					layout_config = { preview_height = 0.8 },
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "live_grep_args")
		pcall(require("telescope").load_extension, "file_browser")
		pcall(require("telescope").load_extension, "undo")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		vim.keymap.set(
			"n",
			"<leader>fG",
			require("telescope").extensions.live_grep_args.live_grep_args,
			{ desc = "Live grep (args)" }
		)
		vim.keymap.set(
			"n",
			"<leader>fe",
			require("telescope").extensions.file_browser.file_browser,
			{ desc = "[F]ile [E]xplorer" }
		)
		vim.keymap.set("n", "<leader>fu", require("telescope").extensions.undo.undo, { desc = "[F]ind [U]ndo history" })

		vim.keymap.set("n", "<leader>th", function()
			builtin.colorscheme({
				enable_preview = true,
				attach_mappings = function(prompt_bufnr, map)
					local actions = require("telescope.actions")
					actions.select_default:replace(function()
						local selection = require("telescope.actions.state").get_selected_entry()
						actions.close(prompt_bufnr)
						vim.cmd.colorscheme(selection.value)

						local theme_file = vim.fn.stdpath("config") .. "/lua/core/theme.lua"
						local file = io.open(theme_file, "w")
						if file then
							file:write("local M = {}\n\n")
							file:write("M.set_theme = function()\n")
							file:write(string.format('    vim.cmd.colorscheme("%s")\n', selection.value))
							file:write("end\n\n")
							file:write("return M")
							file:close()
						end
					end)
					return true
				end,
			})
		end, { desc = "Select [Th]eme" })

		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- vim.keymap.set("n", "<leader>fg/", function()
		-- 	builtin.live_grep({
		-- 		grep_open_files = true,
		-- 		prompt_title = "Live Grep in Open Files",
		-- 	})
		-- end, { desc = "[F]ind [G]rep in Open Files" })
	end,
}
