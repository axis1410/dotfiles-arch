require("nvchad.configs.lspconfig").defaults()

local lsp = vim.lsp

local servers = {
  "ts_ls",
  "pyright",
  -- "basedpyright",
  "ruff",
  "html",
  "jinja_lsp",
  "cssls",
  "dockerls",
  "sqlls",
  "terraformls",
  "yamlls",
  "tailwindcss",
  "rust_analyzer",
  "lua_ls",
}

lsp.config("ruff", {
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil then
        return
      end
      if client.name == "ruff" then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
      end
    end,
    desc = "LSP: Disable hover capability from Ruff",
  }),

  init_options = {
    settings = {},
  },
})

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
