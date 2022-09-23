-- local hrcond = require('heirline.conditions')
-- local hrutils = require('heirline.utils')
-- local galaxyline_condition = require('galaxyline.condition')
-- local galaxyline_providers = require('galaxyline.provider')
local M = {}
-- local galaxyline_colors = require('galaxyline')
-- require("galaxyline").galaxyline_augroup()

-- require('mini.statusline').setup{}
require('user.modules.ui.heirline')

---@class GalaxyComponent
---@field provider string | function
---@field condition function      # Must return a boolean. If it returns true then it will load the component.
---@field icon string | function  # Will be added to the head of the provider result.
---@field event string            # Event that will reload the statusline.
---@field highlight string | function | table             # {fg, bg, NeovimFontStyle}, highlight group as a string
---@field separator string | function | table             # notice that table type only work in mid section, Any statusline item can be defined here, like %<,%{},%n, and so on.
---@field separator_highlight string | table | function   # same as highlight.

---@param gal GalaxyComponent
---@return HeirlineComponent
local function galaxy_to_heirline(gal)
  ---@type HeirlineComponent
  local heir = {}
  heir.condition = gal.condition -- function
  heir.update = gal.event -- string
  heir.provider = function ()
    local icon = ''
    if gal.icon ~= nil then
      ---@diagnostic disable-next-line: cast-local-type
      icon = type(gal.icon) == 'string' and gal.icon or gal.icon()
    end
    return icon .. gal.provider
  end

  local handle_highlight_table = function(galaxy_hi)
    if type(galaxy_hi) == 'string' then  -- autocommand event
      return galaxy_hi
    elseif type(galaxy_hi) == 'function' then
      return function ()
        local tbl_str = galaxy_hi() -- string or string[]
        return type(tbl_str) == 'string' and tbl_str or { fg = tbl_str[1], bg = tbl_str[2], cterm = tbl_str[3] }
      end
    else -- type table
      local function handle_element(hl_elem)
        if hl_elem == nil then return nil end
        return type(hl_elem) == 'string' and hl_elem or hl_elem()
      end
      return function ()
        return {
          fg = handle_element(galaxy_hi[1]), -- individual element may be string or function to be called
          bg = handle_element(galaxy_hi[2]),
          cterm = handle_element(galaxy_hi[3])
        }
      end
    end
  end

  if gal.highlight ~= nil then
    heir.hi = handle_highlight_table(gal.highlight)
  end

  -- TODO: check if separator can be appended in provider
  -- TODO: Check if component is at left edge or right edge of screen
  if gal.separator ~= nil then
    local sep = gal.separator
    if type(gal.separator) == 'function' then
      sep = gal.separator()
      -- if type(sep) == 'string' then
      --   sep = {sep, sep}
      -- else
      --   assert(type(sep) == 'table', '*** Return value of function for galaxy-line separator should be string or table')
      -- end
    end
    local left_sep = nil
    local right_sep = nil
    if type(sep) == 'string' then
      left_sep, right_sep = gal.separator, gal.separator
    end
    if type(sep) == 'table' then
      left_sep, right_sep = gal.separator[1], gal.separator[2]
    end
    -- sep =  == 'string' and {gal.separator, gal.separator}
    -- sep = type(gal.separator) == 'table' and gal.separator
    local sep_hi = heir.hi -- default to innder component hightlight
    if gal.separator_highlight ~= nil then
      sep_hi = handle_highlight_table(gal.separator_highlight)
    else
      sep_hi = heir.hi
    end
    assert(sep ~= nil, 'Bro wtf? galaxy-line separator should be string | table | function')
    local heir_left = { provider = left_sep, hl = sep_hi }
    local heir_right = { provider = right_sep, hl = sep_hi }
    heir = {heir_left, heir, heir_right}
  end

  return heir
end

local colors = {
  bg = '#282c34',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#afd700',
  orange = '#FF8800',
  purple = '#5d4d7a',
  magenta = '#d16d9e',
  grey = '#c0c0c0',
  blue = '#0087d7',
  red = '#ec5f67'
}

local buffer_not_empty = function()
---@diagnostic disable-next-line: missing-parameter
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

function M.galaxyline()
  local gl = require("galaxyline")

  ViMode = {
    provider = function()
      local alias = {n = 'NORMAL',i = 'INSERT',c= 'COMMAND',v= 'VISUAL',V= 'VISUAL LINE', [''] = 'VISUAL BLOCK'}
      return alias[vim.fn.mode()]
    end,
    separator = '',
    separator_highlight = {colors.purple,function()
      if not buffer_not_empty() then
        return colors.purple
      end
      return colors.darkblue
    end},
    highlight = {colors.darkblue,colors.purple,'bold'},
  }
  -- gl.section.left[1] = { ViMode }

  -- HeirViMode = require('user.modules.ui.galaxy').galaxy_to_heirline(ViMode)
  -- vim.pretty_print(HeirViMode)
  -- vim.pretty_print(HeirViMode[1].hl())
end

return M
