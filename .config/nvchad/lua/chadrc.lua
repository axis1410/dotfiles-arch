-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "ashes",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },

    StFilePath = {
      fg = "#7fbbb3",
      bg = "statusline_bg",
      italic = true,
    },

    StFilePathModified = {
      fg = "#e67e80",
      bg = "statusline_bg",
      bold = true,
    },
  },
}

-- M.nvdash = {
--   load_on_startup = true,
--   buttons = {
--     { txt = "  Find File", keys = "ff", cmd = "FzfLua files" },
--     { txt = "󰈚  Recent Files", keys = "fo", cmd = "FzfLua oldfiles" },
--     { txt = "󰈭  Find Word", keys = "fw", cmd = "FzfLua live_grep_native" },
--     { txt = "  Themes", keys = "th", cmd = "FzfLua colorschemes" },
--     { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
--     { txt = "Q  Quit", keys = "q", cmd = "quit" },
--
--     { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
--
--     {
--       txt = function()
--         local stats = require("lazy").stats()
--         return "  Loaded "
--           .. stats.loaded
--           .. "/"
--           .. stats.count
--           .. " plugins in "
--           .. math.floor(stats.startuptime)
--           .. " ms"
--       end,
--       hl = "NvDashFooter",
--       no_gap = true,
--       content = "fit",
--     },
--
--     { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
--   },
-- }

M.lsp = {
  signature = true,
}

M.ui = {
  tabufline = {
    lazyload = false,
  },

  statusline = {
    enabled = true,
    theme = "minimal",
    separator_style = "round",
    modules = {
      filepath = function()
        local path = vim.api.nvim_buf_get_name(0)
        if path == "" then
          return ""
        end

        path = vim.fn.fnamemodify(path, ":~:.")

        local hl = vim.bo.modified and "StFilePathModified" or "StFilePath"

        return "%#" .. hl .. "# " .. path .. " "
      end,
    },

    order = {
      "mode",
      "file",
      "filepath",
      "git",
      "%=",
      "lsp",
      "diagnostics",
      "cwd",
      "cursor",
    },
  },
}

M.term = {
  base46_colors = false,
  winopts = {},
  sizes = {},
  float = {},
}

return M
