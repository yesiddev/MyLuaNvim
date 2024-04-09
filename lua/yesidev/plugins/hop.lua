return {
	"phaazon/hop.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- import hop plugin
		local hop = require("hop")

		-- enable hop
		hop.setup()

		-- keybind options
		local opts = { noremap = true, silent = true }

		-- set keybinds
		opts.desc = "HopChar before cursor"
		vim.keymap.set("n", "<leader>m", "<cmd>HopChar2<CR>", opts)
	end,
}
