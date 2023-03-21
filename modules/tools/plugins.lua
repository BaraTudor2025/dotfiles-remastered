local config = require "user.modules.tools.config"

--[[
--    *** Editing ***
--]]

local editing = {
  { "mbbill/undotree" },
  { "AndrewRadev/sideways.vim", disable = true }, -- nishte comenzi
  { "AndrewRadev/splitjoin.vim" }, -- gJ, gS
  { "tpope/vim-abolish", event = "VimEnter", config = config.abolish },

  { "junegunn/vim-easy-align", disable = true, config = function() vim.cmd "map ga <Plug>(EasyAlign)" end }, -- TODO:, add hydra
  { "matze/vim-move", disable = true }, -- move lines

  { "tommcdo/vim-exchange" }, -- cx
  { "cappyzawa/trim.nvim", event = "BufRead", config = function() require("trim").setup() end },
  { "smjonas/live-command.nvim", config = config.live_command },

  { "kana/vim-textobj-user" },
  { "Julian/vim-textobj-variable-segment" }, -- av, iv for snake_case, cammelCase
  { "kana/vim-textobj-indent" },
  {
    "maxbrunsfeld/vim-yankstack",
    config = function() vim.g.yankstack_yank_keys = { "c", "C", "d", "D", "y", "Y" } end,
  }, -- <M-p> <M-P>

  { "editorconfig/editorconfig-vim", disable = true }, -- TODO: editor, config

  --default mappings, replaces 'w', 'e', etc.
  -- { "chaoren/vim-wordmotion", config = function() vim.g.wordmotion_prefix = "," end },
  {
    "anuvyklack/vim-smartword",
    disable = true,
    -- after = "vim-wordmotion",
    config = config.smart_words,
  },

  { "kylechui/nvim-surround", config = function() require("nvim-surround").setup() end },

  { "nvim-pack/nvim-spectre", config = function() require("spectre").setup() end },

  {
    "nvim-neorg/neorg",
    ft = "norg",
    after = { "nvim-treesitter" },
    config = config.neorg,
  },
}

--[[
--    *** Motions & Navigation ***
--]]
local motions_navigations = {
  { "tpope/vim-unimpaired" },
  { "tpope/vim-repeat" },
  --- Pentru begining of line 0 si ^
  { "yuki-yano/zero.nvim", config = function() require("zero").setup() end },
  -- {'ggandor/lightspeed.nvim', config=function() end},
  { "ggandor/leap.nvim", config = config.leap, after = "flit.nvim" },
  { "ggandor/flit.nvim", config = config.flit },
  -- zZ pt operator pending-mode

  { "ThePrimeagen/harpoon", config = config.harpoon },

  -- nu cred ca merge?
  -- ['abecodes/tabout.nvim'] = {
  --   after = 'nvim-cmp',
  --   config = function ()
  --     require('tabout').setup()
  --   end
  -- },
}

local stuff = {
  -- { "Hvassaa/sterm.nvim" },
  -- { "echasnovski/mini.nvim", config = config.mini },

  { "anuvyklack/hydra.nvim", config = function() require("user.config_hydra").setup() end },

  -- Git
  { "TimUntersberger/neogit", command = "Neogit", config = function() require("neogit").setup {} end },
  { "sindrets/diffview.nvim" },
  { "tpope/vim-fugitive" },

  -- *** Telescope ***
  {
    "nvim-telescope/telescope-packer.nvim",
    after = "telescope.nvim",
    config = function() require("telescope").load_extension "packer" end,
  },

  { "nvim-telescope/telescope-symbols.nvim" },
  { "Zane-/cder.nvim", after = "telescope.nvim", config = function() require("telescope").load_extension "cder" end },

  {
    "LinArcX/telescope-command-palette.nvim",
    commit = "1944d63",
    after = "telescope.nvim",
    config = function() require("telescope").load_extension "command_palette" end,
  },

  {
    "sudormrfbin/cheatsheet.nvim",
    after = "telescope.nvim",
    requires = {
      -- {'nvim-telescope/telescope.nvim'},
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function() require("cheatsheet").setup { include_only_installed_plugins = false } end,
  },

  -- *** Nice Touches ***
  -- the cursor stays in place when doing visual selection stuff (yank, indent, etc.)
  { "gbprod/stay-in-place.nvim", config = function() require("stay-in-place").setup() end },
}

return flatten_table { editing, stuff, motions_navigations }
