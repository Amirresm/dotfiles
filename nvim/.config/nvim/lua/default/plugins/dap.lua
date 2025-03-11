return {
	{ "mfussenegger/nvim-dap-python" },
	{ "theHamsta/nvim-dap-virtual-text" },
	{
		"LiadOz/nvim-dap-repl-highlights",
		config = true,
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
		build = function()
			if not require("nvim-treesitter.parsers").has_parser("dap_repl") then
				vim.cmd(":TSInstall dap_repl")
			end
		end,
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = {
				"williamboman/mason.nvim",
				"mfussenegger/nvim-dap",
				"neovim/nvim-lspconfig",
			},
			config = function()
				require("mason-nvim-dap").setup({
					ensure_installed = {},
					automatic_installation = true,
					handlers = {
						function(config)
							require("mason-nvim-dap").default_setup(config)
						end,
					},
				})
			end,
		},
	},
	{

		"mfussenegger/nvim-dap",
		lazy = false,
		config = function()
			local dap = require("dap")
			dap.set_log_level("DEBUG")

			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
			vim.keymap.set("n", "<F6>", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<F7>", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<F8>", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<leader>dd", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dc", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Conditional Breakpoint" })
			vim.keymap.set("n", "<leader>dl", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log: "))
			end, { desc = "Debug: Set Log Point" })
			vim.keymap.set("n", "<leader>dh", function()
				dap.run_to_cursor()
			end, { desc = "Debug: Run Till Here (to cursor)" })
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap = require("dap")
			local dap_utils = require("dap.utils")
			local dapui = require("dapui")
			local dap_vt = require("nvim-dap-virtual-text")

			-- ╭──────────────────────────────────────────────────────────╮
			-- │ DAP Virtual Text Setup                                   │
			-- ╰──────────────────────────────────────────────────────────╯
			dap_vt.setup({
				enabled = true, -- enable this plugin (the default)
				enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
				highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
				highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
				show_stop_reason = true, -- show stop reason when stopped for exceptions
				commented = false, -- prefix virtual text with comment string
				only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
				all_references = false, -- show virtual text on all all references of the variable (not only definitions)
				filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
				-- Experimental Features:
				virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
				all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
				virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
				virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
			})
			-- ╭──────────────────────────────────────────────────────────╮
			-- │ DAP UI Setup                                             │
			-- ╰──────────────────────────────────────────────────────────╯
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸" },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				-- Expand lines larger than the window
				-- Requires >= 0.7
				expand_lines = true,
				-- Layouts define sections of the screen to place windows.
				-- The position can be "left", "right", "top" or "bottom".
				-- The size specifies the height/width depending on position. It can be an Int
				-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
				-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
				-- Elements are the elements shown in the layout (in order).
				-- Layouts are opened in order so that earlier layouts take priority in window sizing.
				layouts = {
					{
						elements = {
							-- Elements can be strings or table with id and size keys.
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"watches",
						},
						size = 40, -- 40 columns
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 0.25, -- 25% of total lines
						position = "bottom",
					},
				},
				floating = {
					max_height = nil, -- These can be integers or a float between 0 and 1.
					max_width = nil, -- Floats will be treated as percentage of your screen.
					border = "rounded", -- Border style. Can be "single", "double" or "rounded"
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil, -- Can be integer or nil.
				},
			})

			-- ╭──────────────────────────────────────────────────────────╮
			-- │ DAP Setup                                                │
			-- ╰──────────────────────────────────────────────────────────╯
			dap.set_log_level("TRACE")

			-- Automatically open UI
			dap.listeners.before.attach["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.launch["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			-- Enable virtual text
			vim.g.dap_virtual_text = true

			-- ╭──────────────────────────────────────────────────────────╮
			-- │ Icons                                                    │
			-- ╰──────────────────────────────────────────────────────────╯
			vim.fn.sign_define("DapBreakpoint", { text = "🔵", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "🔴", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapConditionalBreakpoint", { text = "🟡", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })

			local exts = {
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"vue",
				"svelte",
			}
			-- ╭──────────────────────────────────────────────────────────╮
			-- │ Adapters                                                 │
			-- ╰──────────────────────────────────────────────────────────╯
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					-- command = "node",
					command = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug-adapter",
					args = {
						-- vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						-- vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src",
						"${port}",
					},
				},
			}

			dap.adapters["pwa-chrome"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			-- ╭──────────────────────────────────────────────────────────╮
			-- │ Configurations                                           │
			-- ╰──────────────────────────────────────────────────────────╯

			for i, ext in ipairs(exts) do
				dap.configurations[ext] = {
					{
						type = "pwa-chrome",
						request = "launch",
						name = 'Launch Chrome with "localhost"',
						url = function()
							local co = coroutine.running()
							return coroutine.create(function()
								vim.ui.input(
									{ prompt = "Enter URL: ", default = "http://localhost:3000" },
									function(url)
										if url == nil or url == "" then
											return
										else
											coroutine.resume(co, url)
										end
									end
								)
							end)
						end,
						webRoot = "${workspaceFolder}",
						protocol = "inspector",
						sourceMaps = true,
						userDataDir = false,
						skipFiles = { "<node_internals>/**", "node_modules/**", "${workspaceFolder}/node_modules/**" },
						resolveSourceMapLocations = {
							"${webRoot}/*",
							"${webRoot}/apps/**/**",
							"${workspaceFolder}/apps/**/**",
							"${webRoot}/packages/**/**",
							"${workspaceFolder}/packages/**/**",
							"${workspaceFolder}/*",
							"!**/node_modules/**",
						},
					},
					{
						name = "Next.js: debug server-side (pwa-node)",
						type = "pwa-node",
						request = "attach",
						port = 9231,
						skipFiles = { "<node_internals>/**", "node_modules/**" },
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File (pwa-node)",
						cwd = vim.fn.getcwd(),
						args = { "${file}" },
						sourceMaps = true,
						protocol = "inspector",
						runtimeExecutable = "node",
						-- runtimeArgs = {
						-- 	"run-script",
						-- 	"dev",
						-- },
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch npm dev (pwa-node)",
						cwd = vim.fn.getcwd(),
						args = { "${file}" },
						sourceMaps = true,
						protocol = "inspector",
						runtimeExecutable = "npm",
						runtimeArgs = {
							"run-script",
							"dev",
						},
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File (pwa-node with ts-node)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "--loader", "ts-node/esm" },
						runtimeExecutable = "node",
						args = { "${file}" },
						sourceMaps = true,
						protocol = "inspector",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Test Current File (pwa-node with jest)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
						runtimeExecutable = "node",
						args = { "${file}", "--coverage", "false" },
						rootPath = "${workspaceFolder}",
						sourceMaps = true,
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Test Current File (pwa-node with vitest)",
						cwd = vim.fn.getcwd(),
						program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
						args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
						autoAttachChildProcesses = true,
						smartStep = true,
						console = "integratedTerminal",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Test Current File (pwa-node with deno)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
						runtimeExecutable = "deno",
						attachSimplePort = 9229,
					},
                    -- references:
                    -- https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md
                    -- https://code.visualstudio.com/docs/nodejs/debugging-recipes#_debug-clientside-javascript-in-browsers
                    -- https://github.com/gonstoll/dotfiles/blob/cb995c5b798ffc007f05336d33b5242803f4b173/.config/nvim/lua/plugins/dap.lua#L195
                    -- https://github.com/gonstoll/dotfiles/blob/a424e168ea62b7458903e53f84223e9bf709fe9f/nvim/lua/plugins/dap.lua#L192C1-L212C11
                    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript
					{
						type = "pwa-chrome",
						request = "attach",
						name = "Attach Program (pwa-chrome, select port)",
                        address = "localhost",
						port = function()
							return vim.fn.input("Select port: ", 9222)
						end,
						url = function()
							local co = coroutine.running()
							return coroutine.create(function()
								vim.ui.input(
									{ prompt = "Enter URL: ", default = "http://localhost:3000" },
									function(url)
										if url == nil or url == "" then
											return
										else
											coroutine.resume(co, url)
										end
									end
								)
							end)
						end,
						webRoot = "${workspaceFolder}/src",
						protocol = "inspector",
						userDataDir = false,
						skipFiles = { "<node_internals>/**", "node_modules/**", "${workspaceFolder}/node_modules/**" },
                        browserAttachLocation = "workspace",
                        disableNetworkCache = false,
                        stopOnEntry = true,
                        restart = true,
                        sourceMaps = true,
						-- resolveSourceMapLocations = {
						-- 	"${webRoot}/*",
						-- 	"${webRoot}/apps/**/**",
						-- 	"${workspaceFolder}/apps/**/**",
						-- 	"${webRoot}/packages/**/**",
						-- 	"${workspaceFolder}/packages/**/**",
						-- 	"${workspaceFolder}/*",
						-- 	"!**/node_modules/**",
						-- },
						-- pathMapping = {
						-- 	["/"] = "${workspaceFolder}",
						-- },

						-- rootPath = "${workspaceFolder}",
						-- cwd = "${workspaceFolder}",
						-- console = "integratedTerminal",
						-- internalConsoleOptions = "neverOpen",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach Program (pwa-node, select pid)",
						cwd = vim.fn.getcwd(),
						processId = dap_utils.pick_process,
						skipFiles = { "<node_internals>/**" },
					},
				}
			end
			-- local function layout(name)
			-- 	return {
			-- 		elements = {
			-- 			{ id = name },
			-- 		},
			-- 		enter = true,
			-- 		size = 40,
			-- 		position = "right",
			-- 	}
			-- end
			-- local name_to_layout = {
			-- 	repl = { layout = layout("repl"), index = 0 },
			-- 	stacks = { layout = layout("stacks"), index = 0 },
			-- 	scopes = { layout = layout("scopes"), index = 0 },
			-- 	console = { layout = layout("console"), index = 0 },
			-- 	watches = { layout = layout("watches"), index = 0 },
			-- 	breakpoints = { layout = layout("breakpoints"), index = 0 },
			-- }
			-- local layouts = {}
			--
			-- for name, config in pairs(name_to_layout) do
			-- 	table.insert(layouts, config.layout)
			-- 	name_to_layout[name].index = #layouts
			-- end
			--
			-- local function toggle_debug_ui(name)
			-- 	dapui.close()
			-- 	local layout_config = name_to_layout[name]
			--
			-- 	if layout_config == nil then
			-- 		error(string.format("bad name: %s", name))
			-- 	end
			--
			-- 	local uis = vim.api.nvim_list_uis()[1]
			-- 	if uis ~= nil then
			-- 		layout_config.size = uis.width
			-- 	end
			--
			-- 	pcall(dapui.toggle, layout_config.index)
			-- end
			--
			-- vim.keymap.set("n", "<leader>dr", function()
			-- 	toggle_debug_ui("repl")
			-- end, { desc = "Debug: toggle repl ui" })
			-- vim.keymap.set("n", "<leader>ds", function()
			-- 	toggle_debug_ui("stacks")
			-- end, { desc = "Debug: toggle stacks ui" })
			-- vim.keymap.set("n", "<leader>dw", function()
			-- 	toggle_debug_ui("watches")
			-- end, { desc = "Debug: toggle watches ui" })
			-- vim.keymap.set("n", "<leader>db", function()
			-- 	toggle_debug_ui("breakpoints")
			-- end, { desc = "Debug: toggle breakpoints ui" })
			-- vim.keymap.set("n", "<leader>dS", function()
			-- 	toggle_debug_ui("scopes")
			-- end, { desc = "Debug: toggle scopes ui" })
			-- vim.keymap.set("n", "<leader>dc", function()
			-- 	toggle_debug_ui("console")
			-- end, { desc = "Debug: toggle console ui" })
			--
			-- vim.keymap.set("n", "<leader>du", '<cmd>lua require"dapui".toggle()<CR>', { desc = "Debug: Toggle UI" })
			--
			-- vim.api.nvim_create_autocmd("BufEnter", {
			-- 	group = "DapGroup",
			-- 	pattern = "*dap-repl*",
			-- 	callback = function()
			-- 		vim.wo.wrap = true
			-- 	end,
			-- })
			--
			-- vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("dap-repl"))
			-- vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("DAP Watches"))
			--
			-- dapui.setup({
			-- 	layouts = layouts,
			-- 	enter = true,
			-- })
			--
			-- dap.listeners.before.event_terminated.dapui_config = function()
			-- 	dapui.close()
			-- end
			-- dap.listeners.before.event_exited.dapui_config = function()
			-- 	dapui.close()
			-- end
			--
			-- dap.listeners.after.event_output.dapui_config = function(_, body)
			-- 	if body.category == "console" then
			-- 		dapui.eval(body.output) -- Sends stdout/stderr to Console
			-- 	end
			-- end
		end,
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"delve",
				},
				automatic_installation = true,
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
					delve = function(config)
						table.insert(config.configurations, 1, {
							args = function()
								return vim.split(vim.fn.input("args> "), " ")
							end,
							type = "delve",
							name = "file",
							request = "launch",
							program = "${file}",
							outputMode = "remote",
						})
						table.insert(config.configurations, 1, {
							args = function()
								return vim.split(vim.fn.input("args> "), " ")
							end,
							type = "delve",
							name = "file args",
							request = "launch",
							program = "${file}",
							outputMode = "remote",
						})
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})
		end,
	},
}
