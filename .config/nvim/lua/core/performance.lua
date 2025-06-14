local M = {}

-- Track startup time
local start_time = vim.fn.reltime()

function M.print_startup_time()
  local startup_time = vim.fn.reltimestr(vim.fn.reltime(start_time))
  print("Neovim startup time: " .. startup_time .. " seconds")
end

-- Add command to check startup time
vim.api.nvim_create_user_command("StartupTime", M.print_startup_time, {})

-- Add keymap to check startup time
vim.keymap.set("n", "<leader>st", M.print_startup_time, { desc = "Show startup time" })

-- Profile plugin loading times
function M.profile_plugins()
  require("lazy.view").show()
end

vim.api.nvim_create_user_command("ProfilePlugins", M.profile_plugins, {})
vim.keymap.set("n", "<leader>pp", M.profile_plugins, { desc = "Profile plugins" })

-- Performance tips
function M.performance_tips()
  local tips = {
    "• Disable unused language servers in lsp.lua",
    "• Remove unused treesitter parsers",
    "• Use lazy loading with 'event' for plugins",
    "• Disable semantic tokens for faster syntax highlighting",
    "• Reduce updatetime for faster completion",
    "• Use native LSP instead of heavy plugins when possible",
    "• Disable cursorline for large files (>10k lines)",
    "• Use 'rg' for faster grep searches",
  }
  
  print("Performance Tips:")
  for _, tip in ipairs(tips) do
    print(tip)
  end
end

vim.api.nvim_create_user_command("PerformanceTips", M.performance_tips, {})

return M 