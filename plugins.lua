-- *** Utils ***
local utils = {
  { 'echasnovski/mini.nvim', config = function () require('user.config_mini') end},
  -- {'kevinhwang91/nvim-bqf', ft = 'qf'},
  { 'AndrewRadev/bufferize.vim' },
  { 'bennypowers/nvim-regexplainer', config = function() require('regexplainer').setup() end },
}

vim.api.nvim_create_user_command('StartLuaDev', function()
  -- TODO: sa fac autocompletion la argumente: plugin-uri pe care sa le incarc
  -- dar atunci sa fac conditia de packer-loading cu o variabila (conda = vim.g.bla/func)
  -- pt ca comanda poate fi executata? dupa ce a fost configurat lua-dev
  print("-- 'Neata, si bine ai venit! --")
end, {})
DisableLuaDev = false

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
    ['nvim-telescope/telescope-fzy-native.nvim'] = { disable = true },

    ['s1n7ax/nvim-window-picker'] = { disable = true },
    ['stevearc/aerial.nvim'] = { disable = true },
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
  utils,
  require('user.modules.ui.plugins'),
  require('user.modules.langs.plugins'),
  require('user.modules.tools.plugins'),
}

flatten_table(groups, config.init)

return config
