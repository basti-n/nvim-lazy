return {
	"jose-elias-alvarez/typescript.nvim",
	lazy = false,
	config = function()
		local map = vim.keymap.set
		map({ "n", "v" }, "<leader>fix", ":TypescriptFixAll<CR>")
		map({ "n", "v" }, "<leader>amp", ":TypescriptAddMissingImports<CR>")
		map({ "n", "v" }, "<leader>rui", ":TypescriptRemoveUnused<CR>")
	end,
}
