local keymap = vim.keymap

keymap.set('n', '<leader>ex', ':NvimTreeToggle<CR>', {
    noremap = true
})
keymap.set('n', '<leader>ef', ':NvimTreeFindFileToggle<CR>', {
    noremap = true
})
keymap.set('n', '<leader>ff', ':NvimTreeFindFile<CR>', {
    noremap = true
})
keymap.set('n', '<leader>fx', ':NvimTreeFocus<CR>', {
    noremap = true
})

keymap.set('n', '<leader>fs+', ':NvimTreeResize +20<CR>', {
    noremap = true
})
keymap.set('n', '<leader>fs-', ':NvimTreeResize -20<CR>', {
    noremap = true
})
keymap.set('n', '<leader>fsb', ':NvimTreeResize 40<CR>', {
    noremap = true
})

return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
        vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=None]])
        require("nvim-tree").setup({
            filters = {
                dotfiles = false,
            },
        })
    end,
}
