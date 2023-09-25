return {
  {
    "hrsh7th/nvim-cmp",
    keys = { ":", "/", "?", ";" },
    dependencies = {
      "hrsh7th/cmp-cmdline",
      { "ray-x/cmp-treesitter", dependencies = { "nvim-treesitter/nvim-treesitter" } },
    },
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "treesitter", priority = 700 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      }
      return opts
    end,

    config = function(_, opts)
      local cmp = require "cmp"
      cmp.setup(opts)

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
}
