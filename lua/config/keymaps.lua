local mapkey = require("util.keymapper").mapkey
local keymap = vim.keymap
local opts = require("util.keymapper").opts
--
-- Copilot
keymap.set("i", "<C-j>", "copilot#Next()", { expr = true, silent = true })
keymap.set("i", "<C-k>", "copilot#Previous()", { expr = true, silent = true })

-- Pane Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts) -- Navigate Left
keymap.set("n", "<C-j>", "<C-w>j", opts) -- Navigate Down
keymap.set("n", "<C-k>", "<C-w>k", opts) -- Navigate Up
keymap.set("n", "<C-l>", "<C-w>l", opts) -- Navigate Right

-- Window Navigation
keymap.set("n", "<leader>sv", "<cmd>:vsplit<CR>", opts) -- Split Vertically
keymap.set("n", "<leader>sh", "<cmd>:split<CR>", opts) -- Split Horizontally

-- Git
mapkey("<leader>lg", ":LazyGit<CR>", "n")

-- Indenting
keymap.set("v", "<", "<gv") -- Shift Indentation to Left
keymap.set("v", ">", ">gv") -- Shift Indentation to Right

-- Show Full File-Path
mapkey("<leader>pa", "echo expand('%:p')", "n") -- Show Full File Path

-- LSP
local formatFn = require("util.lsp-format").format
keymap.set("n", "<leader>f", formatFn, opts) -- Format LSP
keymap.set({ "n", "v" }, "<leader>fix", ":TypescriptFixAll<CR>", opts)
keymap.set({ "n", "v" }, "<leader>amp", ":TypescriptAddMissingImports<CR>", opts)
keymap.set({ "n", "v" }, "<leader>rui", ":TypescriptRemoveUnused<CR>", opts)
