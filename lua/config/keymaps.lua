local mapkey = require("util.keymapper").mapkey
local keymap = vim.keymap
local opts = require("util.keymapper").opts

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
keymap.set({ "n", "v" }, "<leader>fix", ":TSToolsFixAll<CR>", opts)
keymap.set({ "n", "v" }, "<leader>amp", ":TSToolsAddMissingImports<CR>", opts)
keymap.set({ "n", "v" }, "<leader>rui", ":TSToolsRemoveUnusedImports<CR>", opts)

-- Experimental
keymap.set({ "i", "v" }, "jk", "<Esc>", opts) -- Exit Insert Mode

-- Move Lines (Up/Down)
keymap.set("n", "K", ":m .-2<CR>==", { noremap = true, silent = true })
keymap.set("n", "J", ":m .+1<CR>==", { noremap = true, silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
