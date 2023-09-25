vim.api.nvim_create_autocmd("User", {
  pattern = "targets#mappings#user",
  group = vim.api.nvim_create_augroup("CustomTargets", { clear = true }),
  callback = function()
    local separators = {}
    for e in vim.gsplit(",.;:+-=~_*#/\\|&$", ".") do
      table.insert(separators, { d = e })
    end
    vim.api.nvim_call_function("targets#mappings#extend", {
      {
        e = {
          argument = {
            { o = "[", c = "]", s = "," },
            { o = "{", c = "}", s = "," },
            { o = "(", c = ")", s = "," },
          },
        },
        s = {
          separator = separators,
        },
        t = {
          separator = separators,
          quote = { { d = "'" }, { d = '"' }, { d = "`" } },
          tag = { {} },
          pair = {
            { o = "(", c = ")" },
            { o = "[", c = "]" },
            { o = "{", c = "}" },
            { o = "<", c = ">" },
          },
        },
      },
    })
  end,
})

return {
  {
    "echasnovski/mini.nvim",
    cond = true,
    event = "VeryLazy",
    config = function() require("mini.ai").setup {} end,
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    cond = true,
    lazy = false,
    -- event = "VeryLazy",
    opts = { useDefaultKeymaps = true },
  },
}
