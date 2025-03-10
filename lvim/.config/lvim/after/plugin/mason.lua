local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

require("mason-lspconfig").setup_handlers {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup {
			capabilities = capabilities,
		}
	end,
	["yamlls"] = function()
		require("lspconfig").yamlls.setup {
			capabilities = capabilities,
			settings = {
				yaml = {
					schemas = {
						kubernetes = "/*.yaml",
						-- Add the schema for gitlab piplines
						["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*.gitlab-ci.yml",
					},
				},
			},
		}
	end,
	["helm_ls"] = function()
		require("lspconfig").helm_ls.setup {
			capabilities = capabilities,
			settings = {
				['helm-ls'] = {
					yamlls = {
						path = "yaml-language-server",
					}
				}
			}
		}
	end,
}
