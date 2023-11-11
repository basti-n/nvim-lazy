return {
	"f-person/git-blame.nvim",
	lazy = false,
	config = function()
		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>", opts)
		vim.keymap.set("n", "<leader>gbo", ":GitBlameOpenFileURL<CR>", opts)
	end,
}
