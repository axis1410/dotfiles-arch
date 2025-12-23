return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>gg",
        "<cmd>LazyGit<CR>",
        desc = "Open LazyGit",
      },
    },

    options = {
      lazygit_floating_window_winblend = 1,
    },
  },
}
