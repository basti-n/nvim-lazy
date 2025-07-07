local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")

	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = { -- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	-- json
	lspconfig.jsonls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "json", "jsonc" },
	})


	local root_dir = lspconfig.util.root_pattern("nx.json", "package.json")
	-- angular
	lspconfig.angularls.setup({
		root_dir = root_dir,
	})

	-- eslint
	lspconfig.eslint.setup({
		root_dir = root_dir,
		flags = { debounce_text_changes = 500 },
		on_attach = function(client)
			client.server_capabilities.document_formatting = true
		end,
	})

	-- bash
	lspconfig.bashls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "sh" },
	})

	-- solidity
	lspconfig.solidity.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "solidity" },
	})

    -- html
    lspconfig.html.setup({
		capabilities = capabilities,
		on_attach = on_attach,
        filetypes = { "html" },
    })

	-- eslint
	require("lspconfig").eslint.setup({
        root_dir = lspconfig.util.root_pattern("eslint.config.cjs", "package.json", ".git"),
		settings = {
			packageManager = "npm",
		},
        filetypes = {
            "javascript", "javascriptreact", "javascript.jsx",
            "typescript", "typescriptreact", "typescript.tsx",
            "vue", "svelte", "astro",
            "html", "htmlangular"
        },
		on_attach = function(_client, bufnr)
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				command = "EslintFixAll",
			})
		end,
	})

	-- html, typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
	lspconfig.emmet_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"html",
			"typescriptreact",
			"javascriptreact",
			"javascript",
			"css",
			"sass",
			"scss",
			"less",
			"svelte",
			"vue",
		},
	})

	-- css
	lspconfig.cssls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"css",
			"sass",
			"scss",
			"less",
		},
	})

	-- docker
	lspconfig.dockerls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "dockerfile", "dockerfile_template", "Dockerfile-*" },
	})

	-- rust
	lspconfig.rust_analyzer.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local prettier = require("efmls-configs.formatters.prettier_d")
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local hadolint = require("efmls-configs.linters.hadolint")
	local solhint = require("efmls-configs.linters.solhint")
	local stylelint = require("efmls-configs.linters.stylelint")
	local rustfmt = require("efmls-configs.formatters.rustfmt")
    local eslint = require("efmls-configs.linters.eslint")

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"json",
			"jsonc",
			"sh",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"svelte",
			"vue",
			"markdown",
			"docker",
			"solidity",
			"html",
			"css",
			"scss",
			"less",
			"rust",
            "htmlangular"
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				typescript = { prettier, eslint },
                sh = { shellcheck, shfmt },
                javascript = { prettier, eslint },
                javascriptreact = { prettier, eslint },
                typescriptreact = { prettier, eslint },
                svelte = { prettier },
				vue = { prettier },
				markdown = { prettier },
				docker = { hadolint, prettier },
				solidity = { solhint },
				html = { prettier, eslint },
                htmlangular = { prettier, eslint },
                css = { prettier },
				scss = { prettier, stylelint },
				rust = { rustfmt },
			},
            rootMarkers = { "eslint.config.cjs", "package.json" },
		},
	})

	vim.cmd([[autocmd BufRead,BufNewFile Dockerfile-* set filetype=dockerfile]])
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "htmlangular",
        callback = function()
            vim.bo.filetype = "html"
        end,
    })
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
