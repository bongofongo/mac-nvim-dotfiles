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
  },
}

