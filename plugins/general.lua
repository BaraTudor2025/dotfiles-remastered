return {
  { "rebelot/kanagawa.nvim", cond = true },
  { "LionC/nest.nvim", lazy = false, cond = true },

  {
    "mbbill/undotree",
    cmd = {
      "UndotreeShow",
      "UndotreeHide",
      "UndotreeFocus",
      "UndotreeToggle",
    },
  },

  -- {
  --   "ecthelionvi/NeoComposer.nvim",
  --   enabled = false,
  --   dependencies = {
  --     { "kkharji/sqlite.lua" },
  --     {
  --       "nvim-telescope/telescope.nvim",
  --       config = function(_, _) require("telescope").load_extension "macros" end,
  --     },
  --   },
  --   opts = {},
  -- },

  -- {"kana/vim-textobj-user", lazy=false},
  -- {"julian/vim-textobj-variable-segment", lazy=false}, -- iv, av for word segment bla_bla

  { "ethanholz/nvim-lastplace", cond = true, event = "VeryLazy", opts = {} },
  { "nacro90/numb.nvim", event = "VeryLazy", opts = {} }, -- preview for ex-cmd :{line-num}
  {
    "winston0410/range-highlight.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = { "winston0410/cmd-parser.nvim" },
  }, -- highlight :{line-num},{line-num}
}
