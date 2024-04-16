return {
	"nvimtools/none-ls.nvim", -- configure formatters & linters
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local mason_null_ls = require("mason-null-ls")

		local null_ls = require("null-ls")

		local null_ls_utils = require("null-ls.utils")

		mason_null_ls.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"mypy", -- python linter
				"shfmt", -- bash formatter

				-- Deprecated LSPs in none-ls

				"eslint_d", -- js linter
				"ruff", -- python linter
			},
		})

		-- for conciseness
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters

		-- to setup format on save
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- configure null_ls
		null_ls.setup({
			-- add package.json as identifier for root (for typescript monorepos)
			root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
			-- setup formatters & linters
			sources = {
				--  to disable file types use
				--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
				formatting.prettier.with({
					extra_filetypes = { "svelte" },
					extra_args = { "--single-quote", "--no-semi" },
				}), -- js/ts formatter

				-- formatters
				formatting.stylua, -- lua formatter
				formatting.isort,
				formatting.black.with({
					extra_args = { "--line-length", "80" },
				}), -- python formatter
				formatting.shfmt,

				-- linters
				require("none-ls.diagnostics.ruff"),
				require("none-ls.diagnostics.eslint_d").with({ -- js/ts linter
					condition = function(utils)
						return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
					end,
				}),
			},

			-- configure format on save
			--[[ on_attach = function(current_client, bufnr)
				if current_client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								filter = function(client)
									--  only use null-ls for formatting instead of lsp server
									return client.name == "null-ls"
								end,
								bufnr = bufnr,
							})
						end,
					})
				end
			end, ]]
		})

		local opts = { noremap = true, silent = true }
		local callback = function(bufnr)
			vim.lsp.buf.format({
				filter = function(client)
					--  only use null-ls for formatting instead of lsp server
					return client.name == "null-ls"
				end,
				bufnr = bufnr,
			})
		end

		opts.desc = "format file"
		vim.keymap.set("n", "ff", callback, opts)

		opts.desc = "format selected"
		vim.keymap.set("v", "f", callback, opts)
		-- vim.keymap.set("v", "f", "<cmd>lua vim.lsp.buf.format{async=true}<CR>", opts)
	end,
}
