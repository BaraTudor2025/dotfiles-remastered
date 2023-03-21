local config = require "user.modules.ui.config"

local status_lines = {
  ["akinsho/bufferline.nvim"] = { disable = true },
  ["famiu/bufdelete.nvim"] = { disable = true },
  -- ["rebelot/heirline.nvim"] = { disable = false, opt = true, config = function() end },
  ["feline-nvim/feline.nvim"] = { disable = true, opt = true, config = function() end },
  -- { "glepnir/galaxyline.nvim", requires = "kyazdani42/nvim-web-devicons", config = config.galaxyline },

  { "nanozuki/tabby.nvim", event = "VimEnter", config = function() require("tabby").setup() end },
  {
    "justinhj/battery.nvim",
    config = function()
      require("battery").setup {
        update_rate_seconds = 60 * 2,
      }
    end,
    disable = true,
  },
}

local stuff = {
  -- *** Stuff ***
  -- { "Pocco81/true-zen.nvim", config = function() require("true-zen").setup {} end },
  { "MunifTanjim/nui.nvim" },
  {
    "folke/noice.nvim",
    disable = true,
    event = "VimEnter",
    config = config.noice,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  { "ktunprasert/gui-font-resize.nvim", config = config.gui_font_resize },

  {
    "glepnir/mcc.nvim",
    disable = true,
    config = function()
      require("mcc").setup {
        c = { "-", "->", "-" },
        rust = { ";;", "::" },
      }
    end,
  },

  -- *** Visual ***
  { "folke/todo-comments.nvim", config = function() require("todo-comments").setup {} end },

  { "kevinhwang91/nvim-hlslens", config = config.hlslens },

  -- h, l simplu pentru preview
  {
    "anuvyklack/fold-preview.nvim",
    requires = "anuvyklack/keymap-amend.nvim",
    config = function() require("fold-preview").setup() end,
  },

  { "kevinhwang91/rnvimr", config = config.Ranger },

  {
    "kevinhwang91/nvim-ufo",
    requires = { "kevinhwang91/promise-async", "nvim-treesitter" },
    config = function()
      require("ufo").setup {
        provider_selector = function(bufnr, filetype, buftype) return { "treesitter", "indent" } end,
      }
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    after = "nvim-hlslens",
    config = function()
      require("scrollbar").setup()
      require("scrollbar.handlers.search").setup { calm_down = true }
      -- require("scrollbar.handlers.search").handler.show()
    end,
  },

  -- *** Management ***
  -- for Hydra + smart-split
  { "sindrets/winshift.nvim", config = function() require("winshift").setup {} end },
  { "szw/vim-maximizer", config = function() vim.g.maximizer_set_default_mapping = 0 end },

  -- buffers
  { "matbme/JABS.nvim", config = config.jabs },
}

local colorschemes = {
  -- *** Color Schemes ***
  { "raddari/last-color.nvim" },
  { "catppuccin/nvim", as = "catppuccin", config = function() require("catppuccin").setup {} end },
  { "EdenEast/nightfox.nvim" },
  -- { "eddyekofo94/gruvbox-flat.nvim" },
  -- { "sainnhe/gruvbox-material" },
  -- require('colorbuddy').colorscheme('cobalt2')
  { "lalitmee/cobalt2.nvim", requires = "tjdevries/colorbuddy.nvim" },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup {
        globalStatus = false,
        commentStyle = { italic = false },
        statementStyle = { bold = false },
        dimInactive = false,
      }
    end,
  },
  {
    "rose-pine/neovim",
    config = function()
      -- main / moon
      require("rose-pine").setup { dark_variant = "main" }
    end,
  },
  { "folke/tokyonight.nvim" },
  { "sam4llis/nvim-tundra" },
  -- { 'Mofiqul/vscode.nvim' },
}

return flatten_table { colorschemes, status_lines, stuff }
