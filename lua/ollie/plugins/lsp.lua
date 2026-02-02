return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      require('mason').setup()
      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup {
        ensure_installed = { "pyright", "ruff" }
      }
      vim.lsp.config('pyright', {
        capabilities = capabilities,

        settings = {
          python = {
            formatting = { provider = "black" } -- or just disable pyright formatting
          }
        }
      })
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
      })

      vim.lsp.config('ruff', {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end,
        init_options = {
          settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
          }
        }
      })
      -- require("lspconfig").pyright.setup {
      --   capabilities = capabilities,
      -- }
      -- require("lspconfig").lua_ls.setup {
      --   capabilities = capabilities,
      -- }
      -- require("lspconfig").rust_analyzer.setup {
      --     capabilities = capabilities,
      -- }
    end
  },
}
