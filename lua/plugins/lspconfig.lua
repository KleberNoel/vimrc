return {
	"neovim/nvim-lspconfig",
	config = function()
		require("neoconf").setup({})

		-- Shared on_attach for keymaps
		local function on_attach(client, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then
					return
				end
				on_attach(client, args.buf)
				-- Ruff: disable hover so it doesn't conflict with Pyright
				if client.name == "ruff" then
					client.server_capabilities.hoverProvider = false
				end
			end,
		})

		-- Configure servers using the new vim.lsp.config API
		vim.lsp.config("ruff", {})
		vim.lsp.config("pyright", {})

		vim.lsp.enable({ "ruff", "pyright" })
	end,
	-- in your Lazy spec (e.g. lua/plugins/lsp.lua)
	event = { "BufReadPre", "BufNewFile" }, -- load LSP when opening files
	--#event = "VeryLazy",
	lazy = true,
	dependencies = {
		"folke/neoconf.nvim",
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				ensure_installed = {
					"angularls",
					"bashls",
					"cssls",
					"cssmodules_ls",
					"diagnosticls",
					"docker_compose_language_service",
					"dockerls",
					"emmet_ls",
					"eslint",
					"golangci_lint_ls",
					"gopls",
					"html",
					"jsonls",
					"lua_ls",
					"marksman",
					"powershell_es",
					"sqlls",
					"tailwindcss",
					"yamlls",
				},
				automatic_installation = true,
				automatic_enable = false,
			},
			dependencies = {
				"mason-org/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
				cmd = "Mason",
				lazy = true,
			},
		},
		{
			"jubnzv/virtual-types.nvim",
			event = "LspAttach",
		},
		{
			"dmmulroy/ts-error-translator.nvim",
			config = true,
			event = "LspAttach",
			ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
			lazy = true,
		},
		{
			"chrisgrieser/nvim-lsp-endhints",
			event = "LspAttach",
			opts = {
				icons = {
					type = "󰋙 ",
					parameter = " ",
				},
				label = {
					padding = 1,
					marginLeft = 0,
					bracketedParameters = false,
				},
				autoEnableHints = false,
			},
			lazy = true,
		},
	},
}
