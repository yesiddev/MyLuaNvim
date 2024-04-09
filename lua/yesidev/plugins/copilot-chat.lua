return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {},

		vim.keymap.set(
			"n",
			"<leader>ccq",
			"<cmd>lua require('CopilotChat').ask(vim.fn.input('Quick chat: '), { selection = require('CopilotChat.select').buffer })<CR>",
			{ noremap = true, silent = true, desc = "CopilotChat - Quick chat" }
		),
	},
}
