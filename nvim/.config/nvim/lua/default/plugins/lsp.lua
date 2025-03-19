return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"stevearc/conform.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"j-hui/fidget.nvim",
		},
		event = { "BufReadPre", "BufNewFile", "BufEnter" },
		config = function()
			require("mason-tool-installer").setup({
				auto_update = false,
				run_on_start = true,
				start_delay = 3000, -- 3 second delay
				debounce_hours = 5, -- at least 5 hours between attempts to install/update
				integrations = {
					["mason-lspconfig"] = true,
					["mason-nvim-dap"] = true,
				},
			})

			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_installation = true,
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
					["ts_ls"] = function()
						require("lspconfig").ts_ls.setup({
							capabilities = capabilities,
							settings = {
								javascript = {
									inlayHints = {
										includeInlayEnumMemberValueHints = true,
										includeInlayFunctionLikeReturnTypeHints = true,
										includeInlayFunctionParameterTypeHints = true,
										includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
										includeInlayParameterNameHintsWhenArgumentMatchesName = true,
										includeInlayPropertyDeclarationTypeHints = true,
										includeInlayVariableTypeHints = false,
									},
								},

								typescript = {
									inlayHints = {
										includeInlayEnumMemberValueHints = true,
										includeInlayFunctionLikeReturnTypeHints = true,
										includeInlayFunctionParameterTypeHints = true,
										includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
										includeInlayParameterNameHintsWhenArgumentMatchesName = true,
										includeInlayPropertyDeclarationTypeHints = true,
										includeInlayVariableTypeHints = false,
									},
								},
							},
						})
					end,
					["basedpyright"] = function()
						require("lspconfig").basedpyright.setup({
							capabilities = capabilities,
							settings = {
								basedpyright = {
									analysis = {
										-- diagnosticSeverityOverrides = {},
										-- autoSearchPaths = true,
										useLibraryCodeForTypes = true,
										diagnosticMode = "workspace", -- "openFilesOnly" | "workspace" | "disabled"
										typeCheckingMode = "basic", -- "basic" | "standard" | "strict"
									},
								},
							},
						})
					end,
					["pyright"] = function()
						require("lspconfig").pyright.setup({
							capabilities = capabilities,
							settings = {
								pyright = {
									analysis = {
										-- diagnosticSeverityOverrides = {},
										-- autoSearchPaths = true,
										useLibraryCodeForTypes = true,
										diagnosticMode = "workspace", -- "openFilesOnly" | "workspace" | "disabled"
										typeCheckingMode = "basic", -- "basic" | "standard" | "strict"
									},
								},
							},
						})
					end,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = { version = "Lua 5.1" },
									diagnostics = {
										globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
									},
								},
							},
						})
					end,
					["yamlls"] = function()
						require("lspconfig").yamlls.setup({
							capabilities = capabilities,
							filetypes_exclude = { "helm" },
							settings = {
								yaml = {
									schemas = {
										kubernetes = "/*.yaml",
										-- Add the schema for gitlab piplines
										["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*.gitlab-ci.yml",
									},
								},
							},
						})
					end,
					["helm_ls"] = function()
						require("lspconfig").helm_ls.setup({
							capabilities = capabilities,
							settings = {
								["helm-ls"] = {
									yamlls = {
										path = "yaml-language-server",
									},
								},
							},
						})
					end,
				},
			})

			if vim.lsp.inlay_hint then
				vim.lsp.inlay_hint.enable(true, { 0 })
			end

			local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
			local function prefix_format(diagnostic)
				if diagnostic.severity == vim.diagnostic.severity.ERROR then
					return signs["Error"]
				elseif diagnostic.severity == vim.diagnostic.severity.WARN then
					return signs["Warning"]
				elseif diagnostic.severity == vim.diagnostic.severity.INFO then
					return signs["Hint"]
				else
					return signs["Info"]
				end
			end
			vim.diagnostic.config({
				update_in_insert = false,
				virtual_text = {
					source = "if_many",
					prefix = prefix_format,
				},
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					prefix = prefix_format,
					header = "",
				},
				severity_sort = true,
			})
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = "", texthl = hl, linehl = "", numhl = hl })
			end
		end,
	},
}
