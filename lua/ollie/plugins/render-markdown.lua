return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ---@module 'render-markdown'
  opts = {
    completions = { blink = { enabled = true } },
    file_types = { "markdown" },
    render_modes = { "n", "c" },
  },
}
