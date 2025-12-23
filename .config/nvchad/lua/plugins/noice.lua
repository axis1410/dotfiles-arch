return {
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },

      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = false,
        inc_rename = false,
        lsp_doc_border = false,
      },

      views = {
        cmdline_popup = {
          position = {
            row = "50%",
            col = "50%",
          },
          size = {
            width = 70, -- wider popup
            height = "auto",
          },
          border = {
            style = "rounded", -- rounded corners
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = {
              Normal = "Normal",
              FloatBorder = "FloatBorder", -- or "DiagnosticInfo" if themed
            },
          },
        },

        popupmenu = {
          relative = "editor",
          position = {
            row = 4,
            col = "50%",
          },
          size = {
            width = 40,
            height = 8,
          },
          border = {
            style = "none", -- keep popupmenu borderless for contrast
          },
          win_options = {
            winhighlight = {
              Normal = "Normal",
              FloatBorder = "None",
            },
          },
        },
      },

      cmdline = {
        enabled = true,
        view = "cmdline_popup",
      },

      messages = {
        enabled = true,
        view = "mini",
      },
    },
  },
}
