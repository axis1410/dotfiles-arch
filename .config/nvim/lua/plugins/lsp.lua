return {

	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" }, -- Lazy load LSP
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"SmiteshP/nvim-navic",
		-- Remove cmp-nvim-lsp dependency since we're using blink.cmp
		-- "hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- Optimized diagnostic configuration
		vim.diagnostic.config({
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			signs = true,
			underline = true,
			update_in_insert = false, -- Don't update diagnostics in insert mode for performance
			severity_sort = true,
			float = {
				source = "always",
				focusable = false,
				style = "minimal",
				border = "rounded",
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)

				-- Performance: Only attach navic if document symbols are supported
				if client and client.server_capabilities.documentSymbolProvider then
					require("nvim-navic").attach(client, event.buf)
				end

				-- Performance: Disable semantic tokens for faster syntax highlighting
				if client then
					client.server_capabilities.semanticTokensProvider = nil
				end

				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				-- map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				-- map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				-- map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				-- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				-- map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				-- map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				-- map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				-- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Use fzf-lua for faster searching
				local fzf = require("fzf-lua")
				map("gd", fzf.lsp_definitions, "[G]oto [D]efinition")
				map("gr", fzf.lsp_references, "[G]oto [R]eferences")
				map("gI", fzf.lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", fzf.lsp_typedefs, "Type [D]efinition")
				map("<leader>ds", fzf.lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", fzf.lsp_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Optimized document highlighting with debounce
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>tH", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- Optimized auto-formatting
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = {
				"*.js",
				"*.jsx",
				"*.ts",
				"*.tsx",
				-- "*.json",
				"*.css",
				"*.scss",
				"*.html",
				"*.vue",
				"*.py",
				"*.go",
			},
			callback = function()
				-- Only format if LSP is attached and supports formatting
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				for _, client in ipairs(clients) do
					if client.supports_method("textDocument/formatting") then
						vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
						break
					end
				end
			end,
		})
		vim.g.prettier = {
			tabWidth = 4,
			useTabs = false,
			singleQuote = false,
			trailingComma = "es5",
			semi = true,
			printWidth = 120,
		}

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- Use blink.cmp capabilities instead of cmp-nvim-lsp
		capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

		-- Performance: Reduce capabilities for faster responses
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = { "documentation", "detail", "additionalTextEdits" },
		}

		-- Only configure essential servers for performance
		local servers = {
			dockerls = {},
			terraformls = {},
			yamlls = {},
			rust_analyzer = {},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
						},
						diagnostics = {
							globals = {
								"vim",
								"require",
								"pcall",
								"ipairs",
								"pairs",
								"table",
								"string",
								"math",
								"os",
								"print",
								"type",
								"tostring",
								"tonumber",
								"error",
								"assert",
								"unpack",
								"select",
							},
							disable = {
								"missing-fields",
							},
						},
						format = {
							enable = false,
						},
						telemetry = { enable = false }, -- Disable telemetry for performance
					},
				},
			},
		}

		require("mason").setup()

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
			"ruff",
			"prettier",
			"pyproject-fmt",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
