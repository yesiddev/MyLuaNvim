return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	config = function()
		local bufferline = require("bufferline")
		require("bufferline").setup({
			options = {
				mode = "buffers",
				-- separator_style = "slope",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " 󰅙" or " "
					return " " .. count .. icon
				end,
				style_preset = {
					bufferline.style_preset.no_bold,
				},
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
				show_buffer_close_icons = false,
				diagnostics_update_in_insert = false,
			},
		})

		local keymap = vim.keymap -- for conciseness
		local opts = { noremap = true, silent = true }

		opts.desc = "Tab next"
		keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<CR>", opts)

		opts.desc = "Tab prev"
		keymap.set("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>", opts)

		opts.desc = "close all tabs"
		keymap.set("n", "tt", "<cmd>BufferLineCloseOthers<CR>", opts)

		opts.desc = "close all tabs"
		keymap.set("n", "te", "<cmd>bd<CR>", opts)
	end,
}
