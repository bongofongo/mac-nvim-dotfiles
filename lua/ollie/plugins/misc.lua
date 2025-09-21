return {
  -- lua functions that many plugins use
  "nvim-lua/plenary.nvim", 
  -- tmux & split window navigation
  "christoomey/vim-tmux-navigator", 
  -- Allows cursor locations in the :e
  "lewis6991/fileline.nvim",
  --  Automatically jump to the last cursor position
  "farmergreg/vim-lastplace",
  -- Respects .editorconfig file
  "gpanders/editorconfig.nvim",

  "stevearc/dressing.nvim",
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      local comment = require("Comment")
      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
      comment.setup({
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    config = true,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      need = 1,
      branch = false,
    },
    init = function()
      vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
    end,
  },
  -- {
  --   "folke/ts-comments.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- import comment plugin safely
      local comment = require("Comment")

      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

      -- enable comment
      comment.setup({
        -- for commenting tsx, jsx, svelte, html files
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {
      options = {
        mode = "tabs",
        separator_style = "slant",
      },
    },
  },
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "skim"
    end
  },
  -- {
  --   "LuxVim/nvim-luxmotion",
  --   config = function()
  --     require("luxmotion").setup({
  --       cursor = {
  --         duration = 250,
  --         easing = "ease-out",
  --         enabled = true,
  --       },
  --       scroll = {
  --         duration = 400,
  --         easing = "ease-out",
  --         enabled = true,
  --       },
  --       performance = { enabled = false },
  --       keymaps = {
  --         cursor = true,
  --         scroll = true,
  --       },
  --     })
  --   end,
  -- },
  {
    'brianhuster/live-preview.nvim',
    dependencies = {
      -- You can choose one of the following pickers
      'nvim-telescope/telescope.nvim',
      -- 'ibhagwan/fzf-lua',
      -- 'echasnovski/mini.pick',
      -- 'folke/snacks.nvim',
    },
  },
}

