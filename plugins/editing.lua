return {
  { "kylechui/nvim-surround", cond = true, event = "VeryLazy", config = true },

  -- gau(current_word), gaU(lsp_rename), geu(operator)
  -- u/upper, l/lower, s/snake, d/dash, n/constant, a/phrase, c/camel, p/pascal, t/title, f/path
  {
    "johmsalas/text-case.nvim",
    cond = true,
    event = "VeryLazy",
    config = true,
    dependencies = { "folke/which-key.nvim" },
  },

  {
    "nat-418/boole.nvim",
    cond = true,
    event = "VeryLazy",
    opts = {
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
      additions = {},
      allow_caps_additions = {
        -- { "true",   "false" },
      },
    },
  },
  { "numToStr/Comment.nvim", cond = true, opts = function(_, opts) return opts end },

  -- <A-(h/j/k/l)> smart move
  -- <A-S-(h/j/k/l)> duplicates
  { "booperlv/nvim-gomove", cond = true, event = "VeryLazy", opts = { map_defaults = true } },

  {
    "mizlan/iswap.nvim",
    cond = true,
    cmd = {
      "ISwap",
      "ISwapNode",
      "ISwapNodeWith",
      "ISwapNodeWithLeft",
      "ISwapNodeWithRight",
      "ISwapWith",
      "ISwapWithLeft",
      "ISwapWithRight",
    },
    opts = { move_cursor = true },
  },

  {
    "Wansmer/treesj",
    cond = true,
    keys = {
      { "<space>m", desc = "TS Toggle split/join" },
      { "<space>j", desc = "TS Join" },
      { "<space>s", desc = "TS Split" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = true },
  },

  {
    "nvim-pack/nvim-spectre",
    enable = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      {
        "<leader>R",
        function() require("spectre").open() end,
        mode = "n",
        desc = "Open Spectre",
      },
      {
        "<leader>rw",
        function() require("spectre").open_visual { select_word = true } end,
        mode = "n",
        desc = "Search current word",
      },
      {
        "<leader>rp",
        function() require("spectre").open_file_search { select_word = true } end,
        mode = "n",
        desc = "Search on current file",
      },
      {
        "<leader>rw",
        function()
          -- vim.input "<esc>"
          require("spectre").open_visual()
        end,
        mode = "v",
        desc = "Search current word",
      },
    },
  },
}
