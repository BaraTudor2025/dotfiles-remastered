local config = require('user.modules.ui.config')

local status_lines = {
  ['akinsho/bufferline.nvim'] = { disable = true },
  ['declancm/cinnamon.nvim'] = { disable = true },
  ['famiu/bufdelete.nvim'] = { disable = true},
  ['rebelot/heirline.nvim'] = { disable=true, opt=true, config = function ()  end },
  ['feline-nvim/feline.nvim'] = { disable=true, opt=true, config = function() end },
  {'glepnir/galaxyline.nvim', requires='kyazdani42/nvim-web-devicons', config=config.galaxyline},

  { 'justinhj/battery.nvim', config = function()
      require('battery').setup {
        update_rate_seconds = 60 * 2,
      }
    end, disable = true
  },
  { "nanozuki/tabby.nvim", event = 'VimEnter', config = function() require("tabby").setup() end, },
}

local stuff = {
  -- *** Stuff ***
  { "Pocco81/true-zen.nvim", config = function() require("true-zen").setup {} end },
  { 'glepnir/mcc.nvim', config = function()
      require('mcc').setup {
        c = { '-', '->', '-' },
        rust = { ';;', '::' },
      }
    end, disable = true
  },

  -- buffer name
  { 'b0o/incline.nvim', disable=true, config = function()
      require('incline').setup {
        hide = {
          cursorline = false,
          only_win = false,
          focused_win = false,
        }
      }
    end
  },

  -- *** Visual ***
  { 'folke/todo-comments.nvim', config = function() require('todo-comments').setup {} end, },

  { 'kevinhwang91/nvim-hlslens', config = function()
    require('hlslens').setup {
      calm_down=true,
    }
    local kopts = {noremap = true, silent = true}
    vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
    vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
    vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
  end},

  -- h, l simplu pentru preview
  { 'anuvyklack/fold-preview.nvim', requires = 'anuvyklack/keymap-amend.nvim',
    config = function() require('fold-preview').setup() end },

  { 'kevinhwang91/nvim-ufo', requires = { 'kevinhwang91/promise-async', 'nvim-treesitter' },
    config = function()
      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end
      }
    end
  },

  { 'petertriho/nvim-scrollbar', after = 'nvim-hlslens', config = function()
      require("scrollbar").setup()
      require("scrollbar.handlers.search").setup({calm_down=true})
      -- require("scrollbar.handlers.search").handler.show()
    end
  },

  -- *** Management ***
  -- for Hydra + smart-split
  { 'sindrets/winshift.nvim', config = function() require('winshift').setup {} end },
  { 'szw/vim-maximizer', config = function() vim.g.maximizer_set_default_mapping = 0 end },
  -- just contextual menu when switching buffers
  { 'ghillb/cybu.nvim', config = function()
      require('cybu').setup {
        position = {
          relative_to = 'editor',
        },
        style = {
          path = 'tail', -- relative/tail
          border = 'rounded',
        },
        display_time = 750,
        -- exclude = {
        -- },
      }
    end
  },
  -- buffers
  { 'matbme/JABS.nvim', commit = '', config = function()
      require('jabs').setup {
        position = 'corner',
        -- width = 80, -- default 50
        -- height = 20, -- default 10
        border = 'rounded',
        preview = {
          border = 'rounded',
        },
        keymap = {
          preview = 'p',
          close = 'D',
          h_split = "s",
          v_split = "v",
        },
      }
    end
  },
}

local colorschemes = {
  -- *** Color Schemes
  { 'catppuccin/nvim', as = 'catppuccin', config = function() require('catppuccin').setup {} end },
  { 'EdenEast/nightfox.nvim' },
  { 'eddyekofo94/gruvbox-flat.nvim' },
  { 'sainnhe/gruvbox-material' },
  -- require('colorbuddy').colorscheme('cobalt2')
  { 'lalitmee/cobalt2.nvim', requires = 'tjdevries/colorbuddy.nvim' },
  { 'rebelot/kanagawa.nvim', config = function()
    require('kanagawa').setup {
      globalStatus = false,
      commentStyle = { italic = false },
      statementStyle = { bold = false },
      dimInactive = false,
    }
  end
  },
  { 'rose-pine/neovim', config = function()
    -- main / moon
    require('rose-pine').setup { dark_variant = 'main' }
  end
  },
  { 'folke/tokyonight.nvim' },
  { 'sam4llis/nvim-tundra' },
  -- { 'Mofiqul/vscode.nvim', config =
  --     function () require('vscode').setup {
  --       -- sa-mi bag pula-n italic ca imi omoara tot configu
  --       -- italic_comments = true,
  --       -- transparent e de cacat ca face background-ul negru de tot
  --       -- transparent = true,
  --     }
  --   end
  -- },
}

return flatten_table({colorschemes, status_lines, stuff})
