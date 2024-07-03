return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<C-v>"] = function() vim.cmd.normal "P" end,
          gh = { "0", remap = true },
          gl = { "$", remap = true },
          H = { "0", remap = true },
          L = { "$", remap = true },
        },
        v = {
          gh = { "0", remap = true },
          gl = { "$", remap = true },
          H = { "0", remap = true },
          L = { "$", remap = true },
        },
        -- o = {
        --   ["w"] = function() vim.cmd ":execute 'normal! '.v:count1.'w'<CR>" end,
        -- }
      },
    }
  }
}