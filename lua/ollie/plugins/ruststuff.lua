return {
  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function()
      vim.g.rustgmt_autosave = 1
    end
  },
  {
    'saecki/crates.nvim',
    ft = { "toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" } }
      })
    end
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            local name = vim.api.nvim_buf_get_name(bufnr):lower()
            if name:find("leetcode") then
              client.stop()
              return
            end
            -- your normal on_attach stuff here (keymaps, etc.)
          end,
        },
      }
    end,
  },
}
