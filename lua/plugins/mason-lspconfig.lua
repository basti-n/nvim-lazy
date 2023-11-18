local opts = {
	ensure_installed = {
		"efm",
		"bashls",
		"tsserver",
		"solidity",
		"tailwindcss",
		"html",
		"cssls",
		"lua_ls",
		"emmet_ls",
		"jsonls",
		"rust_analyzer",
		"angularls",
		"prettierd",
		"eslint_d",
		"eslint",
	},
	automatic_installation = true,
}

return {
	"williamboman/mason-lspconfig.nvim",
	opts = opts,
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
}
