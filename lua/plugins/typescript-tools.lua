local on_attach = require("util.lsp").on_attach

return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {},
	root_dir = require("lspconfig").util.root_pattern("nx.json", "tsconfig.json", "package.json", ".git"),
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = on_attach,
    ft = { "typescript", "typescriptreact", "typescript.tsx" },
	config = function()
		require("typescript-tools").setup({
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
                on_attach(client, bufnr)
			end,
			settings = {
				jsx_close_tag = {
					enable = true,
					filetypes = { "javascriptreact", "typescriptreact" },
				},
                settings = {
                    tsserver_plugins = { "@monodon/typescript-nx-imports-plugin" },
                },
			},
		})
	end,
}

	-- typescript
	-- require("typescript-tools").setup({
	-- 	root_dir = lspconfig.util.root_pattern("nx.json", "tsconfig.json", "package.json", ".git"),
	-- 	on_attach = on_attach,
	-- 	capabilities = capabilities,
	-- 	settings = {
	-- 		tsserver_plugins = { "@monodon/typescript-nx-imports-plugin" },
	-- 	},
	-- })

