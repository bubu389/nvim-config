-- ============================================================================
--  lsp.lua : Language Server Protocol -> "IDE brains"
--  A language server (gopls for Go) gives you: errors as you type,
--  go-to-definition, hover docs, rename, auto-imports, formatting...
--
--   mason.nvim            installs language servers for you (:Mason)
--   mason-lspconfig.nvim  auto-installs + auto-starts the servers listed below
--   nvim-lspconfig        ready-made settings for each server
-- ============================================================================

return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- load when you open a file
    dependencies = {
      { "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp", -- completion engine (see completion.lua)
    },
    opts = {
      -- Servers to install automatically. Add more later, e.g. "pyright", "clangd".
      ensure_installed = {
        "gopls",  -- Go
        "lua_ls", -- Lua (so editing this config is pleasant too)
        "marksman", -- Markdown: heading/link completion, jump to headings
      },
      automatic_enable = true, -- start installed servers automatically
    },
    config = function(_, opts)
      -- Tell every server what our completion engine can do.
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- ── gopls (Go) settings ───────────────────────────────────────────────
      -- Docs: https://go.dev/gopls/settings
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            completeUnimported = true, -- suggest packages you haven't imported yet
            usePlaceholders = true,    -- fill in function arguments when completing
            staticcheck = true,        -- extra checks that catch real bugs
            semanticTokens = true,     -- richer highlighting from the compiler itself
            analyses = {
              unusedparams = true,     -- warn about unused function parameters
              unusedwrite = true,      -- warn about writes that are never read
              nilness = true,          -- catch obvious nil pointer mistakes
              shadow = true,           -- warn when a variable hides another
            },
            -- Inlay hints: little grey labels showing types / parameter names.
            -- Toggle them on/off with <Space>uh.
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })

      -- ── lua_ls settings (so `vim` isn't flagged as an unknown global) ─────
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim", "Snacks" } },
            workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
          },
        },
      })

      require("mason-lspconfig").setup(opts)

      -- ── How errors/warnings are displayed ─────────────────────────────────
      vim.diagnostic.config({
        severity_sort = true,                 -- errors before warnings
        underline = true,                     -- squiggle under the problem
        update_in_insert = false,             -- don't nag while typing
        virtual_text = { spacing = 2, prefix = "●" }, -- message at line end
        float = { border = "rounded", source = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵 ",
          },
        },
      })

      -- ── Shortcuts that only exist when a language server is attached ──────
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("scriptorium-lsp", { clear = true }),
        callback = function(args)
          local buf = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local function map(keys, fn, desc, mode)
            vim.keymap.set(mode or "n", keys, fn, { buffer = buf, desc = desc, nowait = true })
          end

          -- Navigation (results open in a searchable picker)
          map("gd", function() Snacks.picker.lsp_definitions() end, "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gr", function() Snacks.picker.lsp_references() end, "Find references")
          map("gI", function() Snacks.picker.lsp_implementations() end, "Go to implementation")
          map("gy", function() Snacks.picker.lsp_type_definitions() end, "Go to type definition")
          -- K (built in)  -> hover docs for the word under the cursor
          -- <C-s> (built in, insert mode) -> function signature help

          -- Code actions
          map("<leader>ca", vim.lsp.buf.code_action, "Code action (quick fix)", { "n", "v" })
          map("<leader>cr", vim.lsp.buf.rename, "Rename symbol everywhere")
          map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format file")
          map("<leader>cs", function() Snacks.picker.lsp_symbols() end, "Symbols in file")
          map("<leader>cS", function() Snacks.picker.lsp_workspace_symbols() end, "Symbols in project")

          -- Go: on every save, organise imports (add/remove) and gofmt the file.
          if client and client.name == "gopls" then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = buf,
              group = vim.api.nvim_create_augroup("scriptorium-gofmt-" .. buf, { clear = true }),
              callback = function()
                local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
                params.context = { only = { "source.organizeImports" }, diagnostics = {} }
                local res = client:request_sync("textDocument/codeAction", params, 1000, buf)
                for _, action in ipairs((res and res.result) or {}) do
                  if action.edit then
                    vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
                  end
                end
                vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
    end,
  },
}
