return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			interactions = {
				chat = {
					adapter = {
						name = "opencode",
						model = "claude-sonnet-4",
					},
				},
			},
		})
	end,
}
