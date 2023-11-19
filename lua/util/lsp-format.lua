local M = {}

M.format = function()
	local rust = vim.lsp.get_active_clients({ name = "rust_analyzer" })
	local efm = vim.lsp.get_active_clients({ name = "efm" })

	if not vim.tbl_isempty(rust) then
		vim.lsp.buf.format({ name = "rust_analyzer", async = true })
	elseif not vim.tbl_isempty(efm) then
		vim.lsp.buf.format({ name = "efm", async = true })
	end
end

return M
