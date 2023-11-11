local M = {}

M.format = function()
	local efm = vim.lsp.get_active_clients({ name = "efm" })

	if vim.tbl_isempty(efm) then
		return
	end

	vim.lsp.buf.format({ name = "efm", async = true })
end

return M