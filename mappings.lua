local function flat_maps(maps)
  local flattened = {}
  for modes, key_map in pairs(maps) do
    for mode in modes:gmatch "." do
      flattened[mode] = vim.tbl_extend("error", flattened[mode] or {}, key_map)
    end
  end
  return flattened
end

return flat_maps {
  n = {
    -- [";"] = ":",
    ["<C-/>"] = "<leader>/",
    ["<A-p>"] = { require("sibling-swap").swap_with_left, desc = "swap left" },
    ["<A-n>"] = { require("sibling-swap").swap_with_right, desc = "swap right" },

    ["dp"] = { '"dp' },
    ["dP"] = { '"dP' },
  },
  i = {
    ["<C-v>"] = function() vim.cmd.normal "P" end,
  },
  o = {
    ["w"] = function() vim.cmd ":execute 'normal! '.v:count1.'w'<CR>" end,
  },
  nv = {
    ["gh"] = { "0", remap = true },
    ["gl"] = { "$", remap = true },
    ["H"] = { "0", remap = true },
    ["L"] = { "$", remap = true },
  },
}
