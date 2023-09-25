return {
  { "liangxianzhe/nap.nvim", event = "VeryLazy", config = true },

  {
    "chrisgrieser/nvim-spider",
    cond = true,
    keys = {
      { "w",  function() require("spider").motion "w" end,  desc = "Spider-w",  mode = { "n", "o", "x" } },
      { "e",  function() require("spider").motion "e" end,  desc = "Spider-e",  mode = { "n", "o", "x" } },
      { "b",  function() require("spider").motion "b" end,  desc = "Spider-b",  mode = { "n", "o", "x" } },
      { "ge", function() require("spider").motion "ge" end, desc = "Spider-ge", mode = { "n", "o", "x" } },
    },
  },
  { "yuki-yano/zero.nvim",   cond = true,        event = "VeryLazy", config = true }, -- quality of life: (normal-mode) 0 toggles between 0 and ^
  -- { "jinh0/eyeliner.nvim",   enable = false,     event = "VeryLazy", config = true },
  {
    "ggandor/leap.nvim",
    cond = true,
    event = "VeryLazy",
    dependencies = { "tpope/vim-repeat", lazy = false, cond = true },
    config = function()
      local leap = require "leap"
      leap.add_default_mappings()
    end,
  },
  {
    "ggandor/flit.nvim",
    cond = true,
    event = "VeryLazy",
    dependencies = { "ggandor/leap.nvim" },
    opts = { labeled_modes = "nvo" },
  },
}
