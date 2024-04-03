local keymap = vim.keymap

local layout_strategy = "flex"
local layout_config = {
    prompt_position = "top",
    height = 0.9,
    width = 0.9,
    bottom_pane = {
        height = 25,
        preview_cutoff = 120,
    },
    center = {
        height = 0.4,
        preview_cutoff = 40,
        width = 0.5,
    },
    cursor = {
        preview_cutoff = 40,
    },
    horizontal = {
        preview_cutoff = 120,
        preview_width = 0.6,
    },
    vertical = {
        preview_cutoff = 40,
    },
    flex = {
        flip_columns = 150,
    },
}

local config = function()
	local telescope = require("telescope")

    local builtin = require('telescope.builtin')
    keymap.set('n', '<leader>pf', builtin.find_files, {})
    keymap.set('n', '<leader>os', builtin.resume, {})
    keymap.set('n', '<C-p>', builtin.git_files, {})
    keymap.set('n', '<leader>gs', builtin.git_status, {})
    keymap.set('n', '<leader>gcl', builtin.git_commits, {})
    keymap.set('n', '<leader>gbl', builtin.git_branches, {})
    keymap.set('n', '<C-f>', builtin.live_grep, {})
    keymap.set('n', '<leader>s', builtin.current_buffer_fuzzy_find, {})
    keymap.set('n', '<leader>of', builtin.oldfiles, {})
    keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)

    -- LSP
    keymap.set('n', '<leader>dw', builtin.diagnostics, {})
    keymap.set('n', '<leader>df', ':Telescope diagnostics bufnr=0<CR>', {})
    keymap.set('n', '<leader>vrr', builtin.lsp_references, {})

    -- Quickfix (cdo)
    local actions = require('telescope.actions')
    keymap.set('n', '<C-q>', function()
        actions.smart_send_to_qflist()
        actions.open_qflist()
    end)

    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("lazygit")

    local telescopeConfig = require("telescope.config")

    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    -- Use smart case
    table.insert(vimgrep_arguments, "--smart-case")

    telescope.setup({
        defaults = {
            hidden = true,
            path_display = { "truncate" },
            vimgrep_arguments = vimgrep_arguments,
            mappings = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                },
            },
            layout_strategy = layout_strategy,
            layout_config = layout_config,
            sorting_strategy = "ascending"
        },
    })
end

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    lazy = false,
    config = config,
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        'nvim-telescope/telescope-ui-select.nvim',
        "kdheepak/lazygit.nvim"
    },
}
