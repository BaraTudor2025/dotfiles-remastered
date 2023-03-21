local conf = require "user.modules.langs.config"

return {
  --- *** Language Support ***
  { "leafo/moonscript-vim" },
  { "pigpigyyy/Yuescript-vim" },
  { "Olical/aniseed" },
  { "Olical/conjure" },
  {
    "~/nvim-plugs/hibiscus.nvim", --[[ run = "git rebase master" ]]
  },

  {
    "guns/vim-sexp",
    require = "tpope/vim-repeat",
    config = function()
      vim.g.sexp_enable_insert_mode_mappings = 1
      vim.g.sexp_insert_after_wrap = 0
      vim.g.sexp_filetypes = "lisp,scheme,clojure,fennel"
      vim.g.sexp_mappings = {
        sexp_flow_to_next_open = "<M-]>",
        sexp_flow_to_prev_open = "<M-[>",
        sexp_flow_to_next_close = "<M-}>",
        sexp_flow_to_prev_close = "<M-{>",
        -- sexp_flow_to_next_open = "]",
        -- sexp_flow_to_prev_open = "[",
        -- sexp_flow_to_next_close = "}",
        -- sexp_flow_to_prev_close = "{",
        -- sexp_flow_to_prev_leaf_head = 'B',
        -- sexp_flow_to_next_leaf_head = 'W',
        -- sexp_flow_to_prev_leaf_tail = 'G',
        -- sexp_flow_to_next_leaf_tail = 'E',
      }
      -- vim.cmd [[let maplocalleader='\\']]
    end,
  },
  { "tpope/vim-sexp-mappings-for-regular-people", require = "guns/vim-sexp" },

  --- *** Completion ***
  -- { "tzachar/cmp-fuzzy-buffer", after = "nvim-cmp", requires = { "tzachar/fuzzy.nvim" }, config = function () astronvim.add_user_cmp_source("fuzzy_buffer") end },
  -- { "tzachar/cmp-fuzzy-path", after = "nvim-cmp", requires = { "tzachar/fuzzy.nvim" }, config = function () astronvim.add_user_cmp_source("fuzzy_path") end },
  {
    "PaterJason/cmp-conjure",
    after = { "nvim-cmp", "conjure" },
    config = function() astronvim.add_user_cmp_source "conjure" end,
  },
  { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
  -- config = function () astronvim.add_user_cmp_source('fuzzy_buffer') end},
  -- config = function () astronvim.add_user_cmp_source('fuzzy_path') end},
  -- { "hrsh7th/cmp-emoji", after = "nvim-cmp", config = function() astronvim.add_user_cmp_source "emoji" end },
  -- { "max397574/cmp-greek", after = "nvim-cmp", config = function() astronvim.add_user_cmp_source "greek" end },
  -- { "dmitmel/cmp-cmdline-history", after = "nvim-cmp" },
  -- { 'delphinus/cmp-ctags' },
  -- { 'hrsh7th/cmp-calc', requires = 'nvim-cmp', config = astronvim_cmp 'calc'},
  -- { 'rcarriga/cmp-dap', after = 'nvim-cmp', config = astronvim_cmp 'dap'},
  -- { 'hrsh7th/cmp-omni', after = 'nvim-cmp'},
  -- { 'f3fora/cmp-spell', after = 'nvim-cmp'},
  -- also: zsh, tmux, fish
  -- {
  --   "hrsh7th/cmp-nvim-lua",
  --   after = "nvim-cmp",
  --   ft = "lua",
  --   config = function() --[[ astronvim.add_user_cmp_source('nvim_lua')  ]]
  --   end,
  -- },

  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup {
        floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
        hint_prefix = "> ",
        select_signature_key = "<M-n>",
      }
    end,
  },

  --- *** Debugger ***
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } },

  --- *** LSP ***
  ["folke/trouble.nvim"] = {
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("trouble").setup {} end,
  },

  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup {
        default_mappings = true,
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = nil,
          -- disable din cauza lazy-loading
          -- telescope = telescope.themes.get_dropdown({ hide_preview = false })
        },
      }
    end,
    keys = { "gp" },
  },

  -- ["ray-x/lsp_signature.nvim"] = {
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },

  {
    "folke/lua-dev.nvim",
    command = "StartLuaDev",
    -- after = { 'nvim-lspconfig', 'mason-lspconfig.nvim' },
    config = function()
      if true then return end
      if DisableLuaDev == true then return end
      local luadev = require("lua-dev").setup {
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
              },
            },
          },
        },
      }
      local lspconfig = require "lspconfig"
      lspconfig.sumneko_lua.setup(luadev)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    end,
  },

  -- {'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp',
  --   config = function() astronvim.add_user_cmp_source('nvim_lsp_signature_help') end},

  {
    "gbrlsnchs/telescope-lsp-handlers.nvim",
    disable = true,
    after = "telescope.nvim",
    config = function()
      -- require('telescope').load_extension('lsp_handlers')
    end,
  },

  --- *** Code Runners ***
  {
    "michaelb/sniprun",
    run = "bash ./install.sh",
    config = function()
      require("sniprun").setup_display()
      require("sniprun").setup {
        selected_interpreters = { "Lua_nvim" },
        display = {
          "TerminalWithCode",
          "VirtualTextOk",
          -- "Classic",
          -- "LongTempFloatingWindow",
        },
      }
    end,
  },
  {
    "hkupty/iron.nvim",
    config = function()
      require("iron.core").setup {
        config = {
          scratch_repl = true,
          repl_open_cmd = require("iron.view").bottom(40),
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
    end,
  },
  { "metakirby5/codi.vim", disable = true }, --interactive scratch pad/buffer
  { "jpalardy/vim-slime", disable = true }, -- repl in terminal
  { "ledesmablt/vim-run", disable = true }, -- run cmds in shell
  { "CRAG666/code_runner.nvim", disable = true }, --run code from shell
}
