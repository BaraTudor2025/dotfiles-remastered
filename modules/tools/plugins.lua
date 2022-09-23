local conf = require('user.modules.tools.config')

--[[
--    *** Editing ***
--]]
local editing = {
  { 'mbbill/undotree' },
  { 'takac/vim-hardtime', disable = true },
  { 'AndrewRadev/sideways.vim', disable = true }, -- nishte comenzi
  { 'AndrewRadev/splitjoin.vim' }, -- gJ, gS

  { 'junegunn/vim-easy-align', config = function() vim.cmd [[map ga <Plug>(EasyAlign)]] end }, -- TODO:, add hydra
  { 'matze/vim-move', disable = true }, -- move lines

  { 'tommcdo/vim-exchange' }, -- cx
  ['cappyzawa/trim.nvim'] = {
    event = 'BufRead',
    config = function() require('trim').setup() end,
  },

  -- { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },

  { 'editorconfig/editorconfig-vim', disable = true }, -- TODO: editor config

  --default mappings, replaces 'w', 'e', etc.
  { 'chaoren/vim-wordmotion', config = function() vim.g.wordmotion_prefix = ',' end },
  { 'anuvyklack/vim-smartword', after = 'vim-wordmotion', config = function()
    local map = function(lhs, rhs) vim.keymap.set({ 'n', 'v' }, lhs, rhs, {}) end
    map("w", "<Plug>(smartword-w)")
    map("b", "<Plug>(smartword-b)")
    map("e", "<Plug>(smartword-e)")
    map("ge", "<Plug>(smartword-ge)")
    -- vim.cmd[[
    -- map <Plug>(smartword-basic-w)  <Plug>WordMotion_w
    -- map <Plug>(smartword-basic-b)  <Plug>WordMotion_b
    -- map <Plug>(smartword-basic-e)  <Plug>WordMotion_e
    -- map <Plug>(smartword-basic-ge)  <Plug>WordMotion_ge
    -- ]]
  end },

  ['kylechui/nvim-surround'] = {
    config = function() require('nvim-surround').setup() end
  },

  { 'nvim-neorg/neorg',
    disable = true,
    ft = 'norg',
    -- command = 'NeorgStart',
    after = { 'nvim-treesitter' },
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {},
          ['core.norg.concealer'] = {},
          ['core.norg.dirman'] = {
            config = {
              workspaces = {
                code = "~/Documents/Code/notes",
                nvim = "~/Documents/Code/Neovim",
              }
            }
          },
          -- ['core.norg.completion'] = {
          --   config = {
          --     engine = 'nvim-cmp'
          --   }
          -- },
          -- ['core.integrations.nvim-cmp'] = {},
        }
      }
      -- astronvim.add_user_cmp_source('neorg')
    end
  },

  { 'nvim-orgmode/orgmode', config = function()
    require('orgmode').setup_ts_grammar()
    require('orgmode').setup {
      org_agenda_files = {
        '~/Documents/Code/notes/org/**/*',
      },
      org_default_notes_file = {
        '~/Documents/Code/notes/org/acasa.org'
      }
    }
    astronvim.add_user_cmp_source('orgmode')
  end
  },

  ["AckslD/nvim-neoclip.lua"] = {
    requires = 'nvim-telescope/telescope.nvim',
    config = function()
      require('neoclip').setup {
        keys = {
          telescope = {
            i = {
              -- era ctrl-k, care tre sa fie *up*
              paste_behind = '<~~~>',
            }
          }
        }
      }
    end,
  },
}

--[[
--    *** Motions & Navigation ***
--]]
local motions_navigations = {
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-repeat' },
  { 'yuki-yano/zero.nvim', config = function() require('zero').setup() end },
  -- {'ggandor/lightspeed.nvim', config=function() end},
  -- zZ pt operator pending-mode
  { 'ggandor/flit.nvim', disable = true }, -- TODO:leap for 'f'
  { 'ggandor/leap.nvim', config = function()
    require('leap').setup {
      safe_labels = {
        'h', 'j', 'k', 'l', "s", "f", "n", "u", "t", "q", "r", "m", "'",

      },
    }
    require('leap').set_default_keymaps()
  end },
  -- {'phaazon/hop.nvim', config = function () require('hop').setup() end },

  { 'ThePrimeagen/harpoon', config = function()
    vim.api.nvim_create_user_command('Mark',
      function()
        -- local bufname = vim.api.nvim_buf_get_name(0)
        require('harpoon.mark').add_file()
      end, {})
    vim.api.nvim_create_user_command('Harpoon', require('harpoon.ui').toggle_quick_menu, {})
    -- require("telescope").load_extension('harpoon')
  end
  },

  -- nu cred ca merge?
  -- ['abecodes/tabout.nvim'] = {
  --   after = 'nvim-cmp',
  --   config = function ()
  --     require('tabout').setup()
  --   end
  -- },
}

local stuff = {
  { 'Hvassaa/sterm.nvim' }, -- TODO: sterm

  { 'anuvyklack/hydra.nvim', config = function() require('user.config_hydra').setup() end },

  -- Git
  { 'TimUntersberger/neogit', command = 'Neogit', config = function() require('neogit').setup {} end },
  { 'sindrets/diffview.nvim' },
  { 'tpope/vim-fugitive' },

  -- *** Telescope ***
  { 'nvim-telescope/telescope-packer.nvim', after = 'telescope.nvim',
    config = function() require('telescope').load_extension 'packer' end },

  { 'nvim-telescope/telescope-symbols.nvim' },

  { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    after = 'telescope.nvim',
    -- config = function()
    --   require('telescope').load_extension('fzf')
    -- end
  },

  { 'LinArcX/telescope-command-palette.nvim', commit = '1944d63', after = 'telescope.nvim',
    config = function() require('telescope').load_extension('command_palette') end },

  { 'sudormrfbin/cheatsheet.nvim',
    after = 'telescope.nvim',
    requires = {
      -- {'nvim-telescope/telescope.nvim'},
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      require("cheatsheet").setup {
        include_only_installed_plugins = false,
      }
    end,
  },

  -- *** Nice Touches ***
  -- the cursor stays in place when doing visual selection stuff (yank, indent, etc.)
  { 'gbprod/stay-in-place.nvim', config = function() require("stay-in-place").setup() end },
}

return flatten_table({editing, stuff, motions_navigations})
