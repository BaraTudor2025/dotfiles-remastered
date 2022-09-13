--[[
--    *** Color-schemes ***
--]]

local colorschemes = {
  { 'catppuccin/nvim', as = 'catppuccin', config = function() require('catppuccin').setup {} end },
  { 'EdenEast/nightfox.nvim' },
  { 'eddyekofo94/gruvbox-flat.nvim' },
  { 'sainnhe/gruvbox-material' },
  -- require('colorbuddy').colorscheme('cobalt2')
  { 'lalitmee/cobalt2.nvim', requires = 'tjdevries/colorbuddy.nvim' },
  { 'rebelot/kanagawa.nvim', config = function()
    require('kanagawa').setup {
      globalStatus = true,
      commentStyle = { italic = false },
      statementStyle = { bold = false },
      dimInactive = true,
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

--[[
--    *** Editting ***
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
      --[[ {{{
      local multi_select = function(opts)
        -- value.entry.contents
        print(vim.inspect(opts))
        local handlers = require('neoclip.handlers')
        handlers.paste(opts.entry, 'p')
      end
      require('neoclip').setup {
        history = 100,
        keys = {
          telescope = {
            -- i = {
            --   custom = {
            --   }
            -- },
            n = {
              custom = {
                ['m'] = multi_select
              }
            }
          }
        }
      }
      -- }}} ]]
      -- require('telescope').load_extension('neoclip')
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
  { 'folke/todo-comments.nvim', config = function() require('todo-comments').setup {} end, },

  -- for Hydra + smart-split
  { 'sindrets/winshift.nvim', config = function() require('winshift').setup {} end },
  { 'szw/vim-maximizer', config = function() vim.g.maximizer_set_default_mapping = 0 end },

  { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    after = 'telescope.nvim',
    config = function()
      require('telescope').load_extension('fzf')
    end
  },

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

  { 'ThePrimeagen/harpoon', config = function()
    -- require('harpoon').setup {}
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

--[[
--    *** Visual ***
--]]
local visual = {
  { 'kevinhwang91/nvim-ufo', requires = { 'kevinhwang91/promise-async', 'nvim-treesitter' },
    config = function()
      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end
      }
    end
  },

  { 'petertriho/nvim-scrollbar', config = function()
    require("scrollbar").setup()
    -- require("scrollbar.handlers.search").setup()
  end
  },

  -- h, l simplu pentru preview
  { 'anuvyklack/fold-preview.nvim', requires = 'anuvyklack/keymap-amend.nvim',
    config = function() require('fold-preview').setup() end },

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

  { 'nvim-telescope/telescope-symbols.nvim' },
  { "nanozuki/tabby.nvim", event = 'VimEnter', config = function() require("tabby").setup() end, },
  { 'VonHeikemen/searchbox.nvim', disable = true, config = function() require('searchbox').setup {} end },
  { "Pocco81/true-zen.nvim", config = function() require("true-zen").setup {} end },

  -- tabs own buffers, DAR e cam buggy
  -- {'tiagovla/scope.nvim', config = function() require('scope').setup() end},

  { 'justinhj/battery.nvim', config = function()
    require('battery').setup {
      update_rate_seconds = 60 * 2,
    }
  end, disable = true
  },

  -- ['TC72 /telescope-tele-tabby.nvim'] = {
  --   config = function ()
  --     require('')
  --   end
  -- },
}

-- *** Utils ***
local utils = {
  { 'echasnovski/mini.nvim', config = function () require('user.config_mini') end},
  -- {'kevinhwang91/nvim-bqf', ft = 'qf'},
  { 'AndrewRadev/bufferize.vim' },
  { 'bennypowers/nvim-regexplainer', config = function() require('regexplainer').setup() end },
  { 'anuvyklack/hydra.nvim', config = function() require('user.config_hydra').setup() end },
  { 'gbprod/stay-in-place.nvim', config = function() require("stay-in-place").setup() end },
  { 'TimUntersberger/neogit', command = 'Neogit', config = function() require('neogit').setup {} end },
  { 'sindrets/diffview.nvim' },
  { 'tpope/vim-fugitive' },
  { 'Hvassaa/sterm.nvim' }, -- TODO: sterm

  { 'LinArcX/telescope-command-palette.nvim', commit = '1944d63', after = 'telescope.nvim',
    config = function() require('telescope').load_extension('command_palette') end },
  { 'nvim-telescope/telescope-packer.nvim', after = 'telescope.nvim',
    config = function() require('telescope').load_extension 'packer' end },
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

--[[
--    *** cmp - Completion ***
--]]
local completion = {
  { 'tzachar/cmp-fuzzy-buffer', after = 'nvim-cmp', requires = { 'tzachar/fuzzy.nvim' } },
  { 'tzachar/cmp-fuzzy-path', after = 'nvim-cmp', requires = { 'nvim-cmp', 'tzachar/fuzzy.nvim' } },
  -- config = function () astronvim.add_user_cmp_source('fuzzy_buffer') end},
  -- config = function () astronvim.add_user_cmp_source('fuzzy_path') end},
  { 'hrsh7th/cmp-emoji', after = 'nvim-cmp', config = function() astronvim.add_user_cmp_source('emoji') end },
  { 'max397574/cmp-greek', after = 'nvim-cmp', config = function() astronvim.add_user_cmp_source('greek') end },
  { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
  { 'dmitmel/cmp-cmdline-history', after = 'nvim-cmp' },
  -- { 'delphinus/cmp-ctags' },
  -- { 'hrsh7th/cmp-calc', requires = 'nvim-cmp', config = astronvim_cmp 'calc'},
  -- { 'rcarriga/cmp-dap', after = 'nvim-cmp', config = astronvim_cmp 'dap'},
  -- { 'hrsh7th/cmp-omni', after = 'nvim-cmp'},
  -- { 'f3fora/cmp-spell', after = 'nvim-cmp'},
  -- also: zsh, tmux, fish
}

--[[
--    *** LSP & IDE ***
--]]

vim.api.nvim_create_user_command('EnterLuaDev', function()
  -- TODO: sa fac autocompletion la argumente: plugin-uri pe care sa le incarc
  -- dar atunci sa fac conditia de packer-loading cu o variabila (conda = vim.g.bla/func)
  -- pt ca comanda poate fi executata? dupa ce a fost configurat lua-dev
  print("-- 'Neata, si bine ai venit! --")
end, {})

DisableLuaDev = true

local lsp = {

  { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp', ft = 'lua',
    config = function() --[[ astronvim.add_user_cmp_source('nvim_lua')  ]] end },

  { 'ray-x/lsp_signature.nvim', config = function()
    require("lsp_signature").setup {
      floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
      hint_prefix = "> ",
      select_signature_key = '<M-n>',
    }
  end },

  -- code Runners
  { 'hkupty/iron.nvim', config = function()
    require("iron.core").setup {
      config = {
        scratch_repl = true,
        repl_open_cmd = require('iron.view').bottom(40),
      },
      keymaps = {
        -- send_motion = "<space>sc",
        -- visual_send = "<space>sc",
        -- send_file = "<space>sf",
        -- send_line = "<space>sl",
        -- send_mark = "<space>sm",
        -- mark_motion = "<space>mc",
        -- mark_visual = "<space>mc",
        -- remove_mark = "<space>md",
        -- cr = "<space>s<cr>",
        -- interrupt = "<space>s<space>",
        -- exit = "<space>sq",
        -- clear = "<space>cl",
      },
    }
  end },
  { 'michaelb/sniprun', disable = true, run = 'bash ./install.sh' },
  { '0x100101/lab.nvim', disable = true },
  { 'metakirby5/codi.vim', disable = true },
  { 'ledesmablt/vim-run', disable = true },
  { 'CRAG666/code_runner.nvim', disable = true },
  { 'jpalardy/vim-slime', disable = true, config = function()
    vim.g.slime_target = 'neovim'
    vim.g.slime_no_mappings = 1
    -- [[
    -- <Plug>SlimeRegionSend
    -- <Plug>SlimeParagraphSend
    -- <Plug>SlimeConfig
    -- ]]
  end },

  -- {'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp',
  --   config = function() astronvim.add_user_cmp_source('nvim_lsp_signature_help') end},

  { 'gbrlsnchs/telescope-lsp-handlers.nvim', disable = true, after = 'telescope.nvim', config = function()
    -- require('telescope').load_extension('lsp_handlers')
  end
  },

  { 'mfussenegger/nvim-dap' },
  { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } },

  { 'rmagatti/goto-preview', config = function()
    require('goto-preview').setup {
      default_mappings = true,
      references = { -- Configure the telescope UI for slowing the references cycling window.
        telescope = nil,
        -- disable din cauza lazy-loading
        -- telescope = telescope.themes.get_dropdown({ hide_preview = false })
      },
    }
  end, keys = { 'gp' },
  },

  ['folke/trouble.nvim'] = {
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require('trouble').setup {} end
  },

  -- ["ray-x/lsp_signature.nvim"] = {
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },

  { 'folke/lua-dev.nvim', after = { 'nvim-lspconfig', 'mason-lspconfig.nvim' }, config = function()
    if DisableLuaDev == true then
      return
    end
    local luadev = require('lua-dev').setup {
      library = {
        vimruntime = true,
        types = true,
        plugins = true,
      },
      lspconfig = {
        settings = {
          Lua = {
            diagnostics = {
              libraryFiles = "Disable",
            }
          }
        }
      }
    }
    local lspconfig = require('lspconfig')
    lspconfig.sumneko_lua.setup(luadev)
  end
  },

}

-- [[
--     ** CONFIG **
-- ]]
local config = {
  -- *** Init Packer ***
  init = {
    ['hrsh7th/nvim-cmp'] = {
      event = { 'VimEnter' },
      config = function() require('configs.cmp') end
    },

    ['akinsho/bufferline.nvim'] = { disable = true },
    ['nvim-telescope/telescope-fzy-native.nvim'] = { disable = true },
    ['s1n7ax/nvim-window-picker'] = { disable = true },
    ['declancm/cinnamon.nvim'] = { disable = true },
    ['stevearc/aerial.nvim'] = { disable = true },
    ['famiu/bufdelete.nvim'] = {disable = true},
    -- ['lukas-reineke/indent-blankline.nvim'] = {disable=true},
    ['rebelot/heirline.nvim'] = {disable=true},
    ['feline-nvim/feline.nvim'] = {disable=true},
  },

  ['telescope'] = function(config)
    return vim.tbl_deep_extend('force', config, {
      pickers = {
        colorscheme = { enable_preview = true },
        find_files = { hidden = false },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        command_palette = require('user.config_cmd_palette'),
      },
    })
  end,

  -- *** Config AstroBuiltIn ***
  ['better_escape'] = {
    mapping = { 'jk' },
    clear_empty_lines = false,
    keys = '<esc>`^'
  },

  ['treesitter'] = function(config)

    config = vim.tbl_deep_extend('force', config, {

      ensure_installed = {
        'regex', 'lua', 'norg', 'c', 'cpp', 'rust', 'python', 'org', 'vim'
      },
      highlight = {
        additional_vim_regex_highlighting = true, --default=false
      },
      indent = {
        enable = false, -- default=false
      },
      -- textobjects = {
      --   select = {
      --     enable = true,
      --     lookbehind = true,
      --     lookahead = true,
      --     keymaps = {
      --       ["if"] = { query = "@function.inner", desc = "Function Inner" },
      --       ["af"] = { query = "@function.outer", desc = "Function Outter" },
      --       ["iC"] = { query = "@class.inner", desc = "Class Inner" },
      --       ["aC"] = { query = "@class.outer", desc = "Class Outer" },
      --       ["ia"] = { query = "@parameter.inner", desc = "Parameter Inner" },
      --       ["aa"] = { query = "@parameter.outer", desc = "Parameter Outer" },
      --       ["ic"] = { query = "@call.inner", desc = "Call Inner" },
      --       ["ac"] = { query = "@call.outer", desc = "Call Outer" },
      --       ["il"] = { query = "@loop.inner", desc = "Loop Inner" },
      --       ["al"] = { query = "@loop.outer", desc = "Loop Outer" },
      --       -- ["ib"] = {query = "@block.inner", desc = "Block Inner"},
      --       -- ["ab"] = {query = "@block.outer", desc = "Block Outer"},
      --     },
      --     selection_modes = {
      --       ['@function.outer'] = 'V', -- linewise
      --     },
      --   },
      --   swap = {
      --     enable = true,
      --     -- swap_next = {
      --     --   ['<leader>a'] = '@parameter.inner',
      --     -- },
      --     -- swap_previous = {
      --     --   ['<leader>A'] = '@parameter.inner',
      --     -- },
      --   },
      --   move = {
      --     enable = false,
      --     set_jumps = false, -- whether to set jumps in the jumplist
      --     goto_next_start = {
      --       ["]m"] = "@function.outer",
      --       ["]]"] = "@class.outer",
      --     },
      --     goto_next_end = {
      --       ["]M"] = "@function.outer",
      --       ["]["] = "@class.outer",
      --     },
      --     goto_previous_start = {
      --       ["[m"] = "@function.outer",
      --       ["[["] = "@class.outer",
      --     },
      --     goto_previous_end = {
      --       ["[M"] = "@function.outer",
      --       ["[]"] = "@class.outer",
      --     },
      --   },
      --   lsp_interop = {
      --     enable = false,
      --     border = 'none',
      --     peek_definition_code = {
      --       ["<leader>df"] = "@function.outer",
      --       ["<leader>dF"] = "@class.outer",
      --     },
      --   },
      -- }
    })
    return config
  end,

  --[[
    ['bufferline'] = function(config)
      local path_config = function ()
        local path = vim.fn.getcwd()
        -- split, vreau sa iau doar ultimele foldere
        if vim.fn.has('win32') then
          path = vim.split(path, '\\')
        else
          path = vim.split(path, '/')
        end
        -- ultimele doua, poate-s mai putin de 2?
        local start = 0
        if #path >= 2 then
          start = #path - 2
        end
        path = vim.list_slice(path, start, #path)
        return '/'..vim.fn.join(path, '/')
      end

      -- local groups = require('bufferline.groups')
      -- groups.set_manual_group(0, "name")

      config.options = vim.tbl_deep_extend('force', config.options, {
        offsets = {
          { filetype = "neo-tree",
            text = path_config,
            highlight = 'Directory',
            text_align = 'left',
          },
          { filetype = "NvimTree", text = "", padding = 1 },
          { filetype = "Outline", text = "", padding = 1 },
        },
        numbers = function (opts)
          return opts.ordinal .. opts.raise(opts.id)
        end,
        separator_style = 'slant',
        close_command = 'Bdelete',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or ""
          return " " .. icon .. count
        end,
        right_mouse_command = 'vertical sbuffer %d'
      })
      return config
    end,
    --]]
}

-- *** Return ***
local groups = {
  colorschemes,
  motions_navigations,
  completion,
  editing,
  utils,
  visual,
  lsp,
}

for _, group in ipairs(groups) do
  for k, plug in pairs(group) do
    if type(k) == "number" then
      table.insert(config.init, plug)
    else
      config.init[k] = plug
    end
  end
end

return config
