local config = function()
	local theme = require("lualine.themes.gruvbox")

	-- set bg transparency in all modes
	theme.normal.c.bg = nil
	theme.insert.c.bg = nil
	theme.visual.c.bg = nil
	theme.replace.c.bg = nil
	theme.command.c.bg = nil

	require("lualine").setup({
        options = {
            theme = theme,
            globalstatus = true,
            icons_enabled = true,
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
            disabled_filetypes = {}
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },
            lualine_c = { {
                'filename',
                file_status = true, -- displays file status (readonly status, modified status)
                path = 0,-- 0 = just filename, 1 = relative path, 2 = absolute path,
            }
            },
            lualine_y = {
                {
                    function()
                        local lsps = vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })
                        local icon = require("nvim-web-devicons").get_icon_by_filetype(
                            vim.api.nvim_buf_get_option(0, "filetype")
                        )
                        if lsps and #lsps > 0 then
                            local names = {}
                            for _, lsp in ipairs(lsps) do
                                -- filters out copilot nil
                                if string.find(lsp.name, "nil") == nil then
                                    table.insert(names, lsp.name)
                                end
                            end
                            return string.format("%s %s", table.concat(names, ", "), icon)
                        else
                            return icon or ""
                        end
                    end,
                    on_click = function()
                        vim.api.nvim_command("LspInfo")
                    end,
                    color = function()
                        local _, color = require("nvim-web-devicons").get_icon_cterm_color_by_filetype(
                            vim.api.nvim_buf_get_option(0, "filetype")
                        )
                        return { fg = color }
                    end,
                },
                "encoding",
                "progress",
            } ,
            lualine_x = {
                { 'diagnostics', sources = { "nvim_diagnostic" }, symbols = { error = ' ', warn = ' ', info = ' ',
                    hint = ' ' } },
            },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { {
                'filename',
                file_status = true, -- displays file status (readonly status, modified status)
                path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
            } },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = { 'fugitive' }
    })
end

return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = config,
}
