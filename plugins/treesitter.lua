return {
  {
    "nvim-treesitter/nvim-treesitter",
    cond = true,
    opts = function(_, opts)
      -- opts.ensure_installed = {"lua", "c", "vim", "vimdoc", "query", "json", "toml", "python", "yaml"}
      -- add more things to the ensure_installed table protecting against community packs modifying it
      -- opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
      --   "lua", "c", "vim", "vimdoc", "query"
      -- })
      opts.highlight = { enable = vim.g.vscode == nil }
      return opts
    end,
  },

  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
      },
    },
  },

  {
    "Wansmer/sibling-swap.nvim",
    cond = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    opts = {
      use_default_keymaps = false,
    },
    config = function(_, opts) require("sibling-swap").setup(opts) end,
  },
}
