-- Performance optimizations
vim.loader.enable() -- Enable Neovim's module loader cache

-- Basic settings
vim.wo.number = true
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.o.wrap = false
vim.o.linebreak = true
vim.o.mouse = "a"
vim.o.autoindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.scrolloff = 4
vim.o.sidescrolloff = 8
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.hlsearch = false
vim.o.showmode = false
vim.opt.termguicolors = true
vim.o.whichwrap = "bs<>[]hl"
vim.o.numberwidth = 4
vim.o.swapfile = false
vim.o.smartindent = true
vim.o.showtabline = 2
vim.o.backspace = "indent,eol,start"
vim.o.pumheight = 10
vim.o.conceallevel = 0
vim.wo.signcolumn = "yes"
vim.o.fileencoding = "utf-8"
vim.o.breakindent = true
vim.opt.colorcolumn = "120"

-- Performance optimizations
vim.o.updatetime = 200          -- Faster completion and diagnostics
vim.o.timeoutlen = 300          -- Faster which-key popup
vim.o.ttimeoutlen = 5           -- Faster escape key response
vim.o.redrawtime = 1500         -- Syntax highlighting timeout
vim.o.synmaxcol = 1000          -- Limit syntax highlighting for long lines
vim.o.lazyredraw = false        -- Don't redraw during macros (can cause issues with some plugins)
vim.o.ttyfast = true            -- Faster terminal connection
vim.o.regexpengine = 1          -- Use old regex engine (sometimes faster)

-- Memory and file handling
vim.o.backup = false            -- No backup files
vim.o.writebackup = false      -- No backup before overwriting
vim.o.undofile = true           -- Enable persistent undo
vim.o.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.o.directory = vim.fn.stdpath("cache") .. "/swap"
vim.o.shadafile = vim.fn.stdpath("cache") .. "/shada"

-- Folding performance
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false        -- Start with folds open
vim.o.foldlevel = 99

-- Completion performance
vim.o.complete = ".,w,b,u,t"    -- Limit completion sources
vim.o.completeopt = "menu,menuone,noselect"

-- Search performance
vim.o.inccommand = "nosplit"    -- Live substitution preview
vim.o.grepprg = "rg --vimgrep --smart-case --follow"

-- Disable unused built-in plugins for faster startup
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Faster syntax highlighting for large files
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.fn.line("$") > 10000 then
      vim.opt_local.syntax = "off"
      vim.opt_local.cursorline = false
      vim.opt_local.cursorcolumn = false
    end
  end,
})
