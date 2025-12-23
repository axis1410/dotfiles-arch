return {

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require "configs.treesitter"
    end,
  },

  { import = "plugins.oil" },
  { import = "plugins.mini" },
  { import = "plugins.fzf" },
  { import = "plugins.snacks" },
  { import = "plugins.misc" },
  { import = "plugins.flash" },
  { import = "plugins.noice" },
  { import = "plugins.lazygit" },
  { import = "plugins.color-highlight" },
  { import = "plugins.disabled" },
  { import = "plugins.dashboard" },
  { import = "plugins.trouble" },
  { import = "plugins.cursorline" },
  { import = "plugins.log-highlight" },
  -- { import = "plugins.zen" },

  -- { import = "nvchad.blink.lazyspec" },
}
