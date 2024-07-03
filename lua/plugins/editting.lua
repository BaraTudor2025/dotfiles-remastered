
return {
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },

  -- gau(current_word), gaU(lsp_rename), geu(operator)
  -- u/upper, l/lower, s/snake, d/dash, n/constant, a/phrase, c/camel, p/pascal, t/title, f/path
  { "johmsalas/text-case.nvim", dependencies = { "folke/which-key.nvim" } },

  {
    "nat-418/boole.nvim",
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

  -- <A-(h/j/k/l)> smart move
  -- <A-S-(h/j/k/l)> duplicates
  { "booperlv/nvim-gomove", opts = { map_defaults = true } },

  {
    "mizlan/iswap.nvim",
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

  -- {
  --   "Wansmer/sibling-swap.nvim",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   opts = {
  --     use_default_keymaps = false,
  --   },
  --   keys = {
  --     ["<A-p>"] = { require("sibling-swap").swap_with_left, desc = "swap left" },
  --     ["<A-n>"] = { require("sibling-swap").swap_with_right, desc = "swap right" },
  --   }
  -- },

  {
    "Wansmer/treesj",
    keys = {
      { "<space>m", desc = "TS Toggle split/join" },
      { "<space>j", desc = "TS Join" },
      { "<space>s", desc = "TS Split" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = true },
  },

  {
    "gbprod/yanky.nvim",
    keys = {
      { "y",  "<Plug>(YankyYank)",            mode = { "n", "v" } },
      { "p",  "<Plug>(YankyPutAfter)",        mode = { "n", "v" } },
      { "P",  "<Plug>(YankyPutBefore)",       mode = { "n", "v" } },
      { "=p", "<Plug>(YankyPutAfterFilter)",  mode = { "n", "v" } },
      { "=P", "<Plug>(YankyPutBeforeFilter)", mode = { "n", "v" } },
      { "dp", '"dp' },
      { "dP", '"dP' },
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

  { "LionC/nest.nvim", lazy = false, cond = true },
  {
    "BaraTudor2025/substitute.nvim",
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
    dependencies = { "gbprod/yanky.nvim", { "LionC/nest.nvim" } },
  },

  {
    "BaraTudor2025/cutlass.nvim",
    event = "VeryLazy",
    opts = {
      cut_key = "m",
      exclude = { "s<bs>" },
      override_del = true,
    },
  },
}