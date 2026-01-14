return {
	{
		"christoomey/vim-tmux-navigator",
		lazy = true,
	},
	{ "wsdjeg/vim-lua" },
	{ "preservim/tagbar" }, -- view python objects
	{ "anuvyklack/windows.nvim" }, -- window resizer
	{ "numToStr/Comment.nvim" },
	{ "sheerun/vim-polyglot" },
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "pylint", "ruff" },
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"rshkarin/mason-nvim-lint",
		dependencies = {
			"mfussenegger/nvim-lint",
			"williamboman/mason.nvim",
		},
		setup = function()
			require("mason-nvim-lint").setup({
				ensure_installed = { "bacon", "flake8", "shellharden" },
			})
		end,
	},
	{
		"stsewd/isort.nvim",
		build = ":UpdateRemotePlugins", -- requires the python package isort
	},
}
