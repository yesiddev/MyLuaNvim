return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
			})
			-- load the colorscheme here
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
