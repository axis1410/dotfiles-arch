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
vim.o.cursorline = false
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

-- Performance related
vim.o.updatetime = 100             -- Faster completion
vim.o.timeoutlen = 250             -- Speed up timeout for keymaps
vim.o.backup = false               -- No backup files
vim.o.writebackup = false          -- No backup while editing
vim.o.undofile = true              -- Persistent undo history
vim.o.lazyredraw = true            -- Don't redraw while executing macros
vim.opt.redrawtime = 1500          -- Allow more time for redrawing
vim.o.ttyfast = true               -- Faster terminal connection
vim.o.completeopt = "menuone,noselect"
vim.opt.shortmess:append("c")
vim.opt.iskeyword:append("-")
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")
vim.opt.cmdheight = 0              -- Hide command line when not in use
vim.opt.cursorline = true

-- Disable plugins we don't need
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
vim.g.loaded_netrw = 1       -- We use our own file explorer
vim.g.loaded_netrwPlugin = 1 -- We use our own file explorer
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
