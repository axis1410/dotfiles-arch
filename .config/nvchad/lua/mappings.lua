require "nvchad.mappings"

local opts = { noremap = true, silent = true }
local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end)

local ok_oil, oil = pcall(require, "oil")
if ok_oil then
  map("n", "<leader>e", oil.open, { desc = "Open Oil file explorer" })
end

local ok_zen, zen = pcall(require, "zen-mode")
if ok_zen then
  map("n", "<leader>zz", function()
    zen.toggle {
      window = {
        width = 0.80,
      },
    }
  end, opts)
end

local ok_fzf, fzf = pcall(require, "fzf-lua")
if ok_fzf then
  map("n", "<leader>fh", fzf.help_tags, { desc = "[S]earch [H]elp" })
  map("n", "<leader>fk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
  map("n", "<leader>ff", fzf.files, { desc = "[S]earch [F]iles" })
  map("n", "<leader>fs", fzf.builtin, { desc = "[S]earch [S]elect FZF" })
  map("n", "<leader>fw", fzf.grep_cword, { desc = "[S]earch current [W]ord" })
  map("n", "<leader>fg", fzf.live_grep_native, { desc = "[S]earch by [G]rep" })
  map("n", "<leader>fd", fzf.diagnostics_document, { desc = "[S]earch [D]iagnostics" })
  map("n", "<leader>fr", fzf.resume, { desc = "[S]earch [R]esume" })
  map("n", "<leader>f.", fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  map("n", "<leader><leader>", fzf.buffers, { desc = "[ ] Find existing buffers" })
  map("n", "<leader>/", fzf.blines, { desc = "[/] Fuzzily search in current buffer" })
end

map("i", "<C-Space>", function()
  require("cmp").complete()
end, { desc = "Trigger completion" })

-- map("i", "<C-Space>", function()
--   require("blink.cmp").complete()
-- end, { desc = "Blink: trigger completion" })

local ok_todo, _ = pcall(require, "todo-comments")
if ok_todo then
  map("n", "<leader>td", ":TodoFzfLua keywords=TODO,FIX<CR>", { noremap = true })
end

nomap("n", "<leader>n")
nomap("n", "<leader>rn")
nomap("n", "<leader>fz")
nomap("n", "<leader>fb")
nomap("n", "<leader>fa")
nomap("n", "<leader>cm")
nomap("n", "<leader>x")
