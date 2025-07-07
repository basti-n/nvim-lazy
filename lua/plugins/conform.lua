return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				html = { { "prettier" } },
				javascript = { { "prettier" } },
				javascriptreact = { { "prettier" } },
				markdown = { { "prettier" } },
				typescript = { { "prettier" } },
				typescriptreact = { { "prettier" } },
				["*"] = { "trim_whitespace" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters = {
				prettier = {
					condition = function()
						return vim.loop.fs_realpath(".prettierrc.js") ~= nil
							or vim.loop.fs_realpath(".prettierrc.mjs") ~= nil
							or vim.loop.fs_realpath(".prettierrc") ~= nil
					end,
				},
			},
		})
	end,
}
