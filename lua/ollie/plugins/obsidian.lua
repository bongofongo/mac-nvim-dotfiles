local function new_note()
  local folders = { "inbox", "notes", "source", "maps", "projects", "thoughts" }
  vim.ui.select(folders, { prompt = "Folder" }, function(dir)
    if not dir then
      return
    end
    vim.ui.input({ prompt = "Title: " }, function(title)
      if not title or title == "" then
        return
      end
      vim.cmd("Obsidian new " .. dir .. "/" .. title)
    end)
  end)
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  cmd = "Obsidian",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>on", new_note,                           desc = "New note (pick folder)" },
    { "<leader>oo", "<cmd>Obsidian quick_switch<CR>",   desc = "Quick switch note" },
    { "<leader>og", "<cmd>Obsidian search<CR>",         desc = "Grep vault" },
    { "<leader>ob", "<cmd>Obsidian backlinks<CR>",      desc = "Backlinks" },
    { "<leader>op", "<cmd>Obsidian paste_img<CR>",      desc = "Paste clipboard image" },
    { "<leader>od", "<cmd>Obsidian today<CR>",          desc = "Daily note (today)" },
    { "<leader>oy", "<cmd>Obsidian yesterday<CR>",      desc = "Daily note (yesterday)" },
    { "<leader>ox", "<cmd>e ~/vault/scratchpad.md<CR>", desc = "Scratchpad" },
    { "<leader>or", "<cmd>Obsidian rename<CR>",         desc = "Rename note (update links)" },
    { "<leader>ot", "<cmd>Obsidian template<CR>",       desc = "Insert template" },
    { "<leader>oa", "<cmd>Obsidian open<CR>",           desc = "Open in Obsidian app" },
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      { name = "vault", path = "~/vault" },
    },
    new_notes_location = "current_dir",
    -- filename is exactly the title you type
    note_id_func = function(title)
      return title
    end,
    note = { template = "note.md" },
    templates = { folder = "templates" },
    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      default_tags = {},
    },
    attachments = {
      folder = "assets",
      img_name_func = function()
        return os.date("%Y%m%d%H%M%S")
      end,
      confirm_img_paste = false,
    },
    completion = { min_chars = 2, create_new = true },
    picker = { name = "telescope.nvim" },
    ui = { enable = false }, -- render-markdown.nvim handles visuals
    callbacks = {
      enter_note = function(_)
        vim.keymap.set("n", "gf", "<cmd>Obsidian follow_link<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "<CR>", function()
          return require("obsidian.api").smart_action()
        end, { buffer = true, expr = true, desc = "Follow link / toggle checkbox" })
      end,
    },
  },
}
