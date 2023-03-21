-- [[
--     ** CONFIG **
-- ]]
local config = {
  -- *** Init Packer ***
  init = {
    ["hrsh7th/nvim-cmp"] = {
      event = { "VimEnter" },
      config = function() require "configs.cmp" end,
    },
    ["nvim-telescope/telescope-fzy-native.nvim"] = { disable = true },
  },

  -- *** Config AstroBuiltIn ***
  ["better_escape"] = {
    mapping = { "jk" },
    clear_empty_lines = false,
    keys = "<esc>`^",
  },

  ["telescope"] = function(config)
    return vim.tbl_deep_extend("force", config, {
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
        -- command_palette = require('user.config_cmd_palette'),
      },
    })
  end,

  { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },

  ["treesitter"] = function(config)
    config = vim.tbl_deep_extend("force", config, {
      ensure_installed = {
        "make",
        "cmake",
        "cpp",
        "rust",
        "toml",
        "python",
        "fennel",
        "regex",
        "bash",
        "fish",
        "gitignore",
        "json",
        "json5",
        "jsonc",
        "markdown",
        "markdown_inline",
      },
      -- highlight = {
      --   additional_vim_regex_highlighting = false, --default=false
      -- },
      -- indent = {
      --   enable = false, -- default=false
      -- },
      textobjects = {
        select = {
          enable = true,
          lookbehind = true,
          lookahead = true,
          keymaps = {
            ["if"] = { query = "@function.inner", desc = "Function Inner" },
            ["af"] = { query = "@function.outer", desc = "Function Outter" },
            ["iC"] = { query = "@class.inner", desc = "Class Inner" },
            ["aC"] = { query = "@class.outer", desc = "Class Outer" },
            ["ia"] = { query = "@parameter.inner", desc = "Parameter Inner" },
            ["aa"] = { query = "@parameter.outer", desc = "Parameter Outer" },
            ["ic"] = { query = "@call.inner", desc = "Call Inner" },
            ["ac"] = { query = "@call.outer", desc = "Call Outer" },
            ["il"] = { query = "@loop.inner", desc = "Loop Inner" },
            ["al"] = { query = "@loop.outer", desc = "Loop Outer" },
            -- ["ib"] = {query = "@block.inner", desc = "Block Inner"},
            -- ["ab"] = {query = "@block.outer", desc = "Block Outer"},
          },
          selection_modes = {
            ["@function.outer"] = "V", -- linewise
          },
        },
        swap = {
          enable = false,
          -- swap_next = {
          --   ['<leader>a'] = '@parameter.inner',
          -- },
          -- swap_previous = {
          --   ['<leader>A'] = '@parameter.inner',
          -- },
        },
        --- [[paragraph like, cursor jumps]]
        move = {
          enable = false,
          set_jumps = false, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        lsp_interop = {
          enable = false,
          border = "none",
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      },
    })
    return config
  end,
}

-- *** Return ***
local groups = {
  require "user.modules.ui.plugins",
  require "user.modules.langs.plugins",
  require "user.modules.tools.plugins",
}

flatten_table(groups, config.init)

return config
