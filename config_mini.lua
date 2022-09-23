--[[
--   MINI CONFIG
--]]

require('mini.ai').setup{}

require('mini.bufremove').setup{}
-- NOTE: + buffer 'unshow_[in_window]'
vim.api.nvim_create_user_command('Bdelete', function() MiniBufremove.delete() end, {})

-- require('mini.cursorword').setup{}
require('mini.indentscope').setup{
  draw = {
    delay = 0,
    animation = require('mini.indentscope').gen_animation('none', {}),
  },
  options = {
    try_as_border = true,
  },
}
vim.g.miniindentscope_disable = true

-- require('mini.surround').setup{
--   mappings = {
--     add = 'ys', -- Add surrounding in Normal and Visual modes
--     delete = 'ds', -- Delete surrounding
--     find = '', -- Find surrounding (to the right)
--     find_left = '', -- Find surrounding (to the left)
--     highlight = '', -- Highlight surrounding
--     replace = 'cs', -- Replace surrounding
--     update_n_lines = '', -- Update `n_lines`
--
--     suffix_last = 'l', -- Suffix to search with "prev" method
--     suffix_next = 'n', -- Suffix to search with "next" method
--   },
-- }

-- require('mini.trailspace').setup{}

-- require('mini.tabline').setup{}

require('mini.jump').setup{}

-- require('mini.comment').setup{}
-- require('mini.pairs').setup{}
-- require('mini.sessions').setup{}
-- require('mini.starter').setup{}
