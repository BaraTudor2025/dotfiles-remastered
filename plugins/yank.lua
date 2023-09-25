return {
  {
    "gbprod/yanky.nvim",
    cond = true,
    keys = {
      { "y",  "<Plug>(YankyYank)",            mode = { "n", "v" } },
      { "p",  "<Plug>(YankyPutAfter)",        mode = { "n", "v" } },
      { "P",  "<Plug>(YankyPutBefore)",       mode = { "n", "v" } },
      { "=p", "<Plug>(YankyPutAfterFilter)",  mode = { "n", "v" } },
      { "=P", "<Plug>(YankyPutBeforeFilter)", mode = { "n", "v" } },
    },
    opts = {
      preserve_cursor_position = { enabled = true },
      ring = { storage = "memory", timeout = 1500 },
      highlight = {
        on_put = false,
        on_yank = false,
        -- timer = 150,
      },
    },
  },
  {
    "BaraTudor2025/substitute.nvim",
    cond = true,
    event = "VeryLazy",
    config = function()
      require("substitute").setup {
        on_substitute = require("yanky.integration").substitute,
      }
      require("nest").applyKeymaps {
        -- substitute/exchange
        {
          mode = "n",
          options = { silent = false, desc = "substitute/exchange" },
          {
            -- yank deleted text to "r register
            { "r",   function() require("substitute").operator { yank = "r" } end },
            { "rr",  require("substitute").line },
            -- yank deleted text to default register
            { "R",   function() require("substitute").operator { yank = true } end },
            { "cx",  require("substitute.exchange").operator },
            { "cxx", require("substitute.exchange").line },
            { "cxc", require("substitute.exchange").cancel },
          },
        },
        {
          mode = "x",
          { "r", require("substitute").visual },
          { "x", require("substitute.exchange").visual },
        },
      }
    end,
    dependencies = { "gbprod/yanky.nvim" },
  },
  {
    "BaraTudor2025/cutlass.nvim",
    cond = true,
    event = "VeryLazy",
    opts = {
      cut_key = "m",
      exclude = { "s<bs>" },
      override_del = true,
    },
  },
}
