return {
  "ethanholz/nvim-lastplace",

  -- next and previous
  { "liangxianzhe/nap.nvim" },

  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = { useDefaultKeymaps = true },
  },

  {
    "chrisgrieser/nvim-spider",
    keys = {
      { "w",  function() require("spider").motion "w" end,  desc = "Spider-w",  mode = { "n", "o", "x" } },
      { "e",  function() require("spider").motion "e" end,  desc = "Spider-e",  mode = { "n", "o", "x" } },
      { "b",  function() require("spider").motion "b" end,  desc = "Spider-b",  mode = { "n", "o", "x" } },
      { "ge", function() require("spider").motion "ge" end, desc = "Spider-ge", mode = { "n", "o", "x" } },
    },
  },

  { "yuki-yano/zero.nvim", opts = {} },

  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies = { "tpope/vim-repeat", lazy = false },
    config = function()
      local leap = require "leap"
      leap.add_default_mappings()
    end,
  },
}