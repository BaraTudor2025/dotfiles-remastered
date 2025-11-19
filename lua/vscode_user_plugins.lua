if not vim.g.vscode then return {} end -- don't do anything in non-vscode instances

local enabled = {}
vim.tbl_map(function(plugin) enabled[plugin] = true end, {
  -- core plugins
  "lazy.nvim",
  "AstroNvim",
  "astrocore",
  "astroui",
  "nvim-lastplace",

  "Comment.nvim",
  "nvim-autopairs",
  "nvim-treesitter",
  "nvim-ts-autotag",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",

  "nvim-gomove",
  "iswap.nvim",
  "treesj",
  "nvim-surround",
  "text-case.nvim",

  "nest.nvim",
  "yanky.nvim",
  "substitute.nvim",
  "cutlass.nvim",
--   "boole.nvim",
  "dial.nvim",

  -- more known working

--   "flash.nvim",
  "flit.nvim",
  "leap.nvim",
  "mini.ai",
  "nvim-various-textobjs",
  "nap.nvim",
  "zero.nvim",
  "nvim-spider",

--   "mini.comment",
--   "mini.surround",
--   "vim-easy-align",
  "vim-repeat",
--   "vim-sandwich",
  -- feel free to open PRs to add more support!
})

local Config = require "lazy.core.config"
vim.cmd "set nomodeline"
-- disable plugin update checking
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
-- replace the default `cond`
Config.options.defaults.cond = function(plugin) return enabled[plugin.name] end

---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>ff"] = "<Cmd>Find<CR>",
          ["<Leader>fw"] = "<Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>",
          ["<Leader>ls"] = "<Cmd>call VSCodeNotify('workbench.action.gotoSymbol')<CR>",
        },
      },
    },
  },
  -- disable colorscheme setting
  { "AstroNvim/astroui", opts = { colorscheme = false } },
  -- disable treesitter highlighting
  { "nvim-treesitter/nvim-treesitter", opts = { highlight = { enable = false } } },
}

