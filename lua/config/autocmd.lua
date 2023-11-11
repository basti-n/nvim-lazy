-- auto-format on save
local formatFn = require("util.lsp-format").format
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = formatFn,
})
