local opts = {
	ensure_installed = {
        "efm",
        "bashls",
        "ts_ls",
        "solidity",
        "tailwindcss",
        "html",
        "cssls",
        "lua_ls",
        "emmet_ls",
        "jsonls",
        "rust_analyzer",
        "angularls@15.2.0",
        "prettierd",
        "eslint_d",
        "eslint",
        "dockerls",
	},
	automatic_installation = true,
}

return {
	"williamboman/mason-lspconfig.nvim",
	opts = opts,
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
}
