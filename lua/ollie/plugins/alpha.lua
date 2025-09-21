return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    math.randomseed(tonumber(tostring(vim.loop.hrtime()):sub(1,9)))
    math.random(); math.random(); math.random()

    local status_ok, alpha = pcall(require, "alpha")
    if not status_ok then
      return
    end

    local doggie = {
      [[                                                               ]],
      [[            ██████████                                         ]],
      [[        ▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒████████                ██████         ]],
      [[      ▓▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒██              ██▓▓▒▒██       ]],
      [[      ▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒████              ██▓▓▒▒██     ]],
      [[    ▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▓▓██            ██▓▓▒▒██     ]],
      [[    ▓▓▒▒  ▒▒▒▒▒▒▒▒▒▒  ██▓▓▓▓▒▒▒▒▒▒▒▒▓▓██            ██▓▓▒▒██   ]],
      [[    ▓▓▒▒██▒▒▒▒▒▒▒▒▒▒████▓▓▓▓▒▒▒▒▒▒▒▒▓▓██            ██▓▓▒▒██   ]],
      [[    ▓▓▒▒██▒▒▒▒▒▒▒▒▒▒████▓▓▓▓▒▒▒▒▒▒▒▒▓▓██            ██▓▓▒▒██   ]],
      [[      ▓▓░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒██            ██▓▓▓▓▒▒██   ]],
      [[      ▓▓▒▒▒▒▒▒▒▒░░░░▓▓▓▓▓▓▓▓▒▒▒▒▒▒██        ██████████▒▒██     ]],
      [[    ▓▓  ▒▒██▒▒░░░░░░░░░░░░▓▓▓▓▒▒██      ████▒▒▒▒▒▒▒▒▓▓██       ]],
      [[    ▓▓██████░░░░░░░░░░░░░░▒▒▓▓▓▓████████▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓██     ]],
      [[    ▓▓░░░░░░░░░░░░░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓██     ]],
      [[      ▓▓▓▓▓▓░░░░▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓██   ]],
      [[          ▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓██   ]],
      [[                ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒▓▓██   ]],
      [[                ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒▒▒▓▓██   ]],
      [[                  ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓████████▓▓██▒▒▒▒▒▒████ ]],
      [[                  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓██    ▓▓▓▓▓▓▓▓██▒▒▒▒▒▒██ ]],
      [[                  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    ▓▓▓▓▓▓████  ▒▒  ▒▒██ ]],
      [[                ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    ▓▓▓▓▓▓██    ▒▒  ░░██ ]],
      [[                ▒▒  ▒▒██    ▒▒▒▒▒▒▒▒█    ░░░░░░██     ▒▒  ░░█  ]],
      [[              ██      ▒▒  ░░██          ░░░░░░██     ▒▒   ░░█  ]],
      [[              ▒▒  ▒▒▒▒██    ▒▒  ▒▒██    ▒▒▒▒▒▒▒▒    ▒▒  ░░▒▒   ]],
      [[              ▒▒▒▒▒▒▒▒    ▒▒  ▒▒▒▒██                ▒▒▒▒▒▒▒▒   ]],
      [[                          ▒▒▒▒▒▒▒▒                             ]],
      }

    local function pickRandomElement(table)
      if #table == 0 then
        return nil
      end
      return table[ math.random(1, #table) ]
    end

    local function footer()
      return pickRandomElement {
        "Programming isn't about what you know; it's about what you can figure out.",
        "Code is like humor. When you have to explain it, it's bad.",
        "First, solve the problem. Then, write the code.",
        "Software is like sex: it’s better when it’s free.",
        "Talk is cheap. Show me the code.",
        "Theory and practice sometimes clash. And when that happens, theory loses.",
        "Intelligence is the ability to avoid doing work, yet getting the work done.",
        "The function of good software is to make the complex appear to be simple.",
      }
    end

    local dashboard = require "alpha.themes.dashboard"
    dashboard.section.buttons.val = {
      dashboard.button("Cmd-Q", "It's time to stop..."),
    }
    dashboard.section.header.val = doggie
    dashboard.section.footer.val = footer()

    dashboard.opts.layout = {
      { type = "padding", val = 8 },
      dashboard.section.header,
      { type = "padding", val = 3 },
      dashboard.section.buttons,
      dashboard.section.footer,
    }
    dashboard.opts.opts.noautocmd = true

    alpha.setup(dashboard.opts)
  end,
}
