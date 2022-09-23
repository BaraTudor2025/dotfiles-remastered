local galaxy_to_heirline
galaxy_to_heirline = function(gal)
  local heir = { }
  heir.condition = gal.condition
  heir.update = gal.event
  local handle_type_cases
  handle_type_cases = function(elem, nil_val)
    if nil_val == nil then
      nil_val = nil
    end
    local _exp_0 = type(elem)
    if 'string' == _exp_0 then
      return elem
    elseif 'function' == _exp_0 then
      return elem()
    elseif 'nil' == _exp_0 then
      return nil_val
    end
  end
  heir.provider = function()
    return handle_type_cases(gal.icon, '') .. handle_type_cases(gal.provider)
  end
  local handle_highlight_table
  handle_highlight_table = function(galaxy_hi)
    local _exp_0 = type(galaxy_hi)
    if 'string' == _exp_0 then
      return galaxy_hi
    elseif 'function' == _exp_0 then
      return function()
        local tbl_str = galaxy_hi()
        local _exp_1 = type(tbl_str)
        if 'string' == _exp_1 then
          return tbl_str
        else
          return {
            fg = tbl_str[1],
            bg = tbl_str[2],
            cterm = tbl_str[3]
          }
        end
      end
    elseif 'table' == _exp_0 then
      return function()
        return {
          fg = handle_type_cases(galaxy_hi[1]),
          bg = handle_type_cases(galaxy_hi[2]),
          cterm = handle_type_cases(galaxy_hi[3])
        }
      end
    end
  end
  if gal.highlight then
    heir.hi = handle_highlight_table(gal.highlight)
  end
  if gal.separator == nil then
    local sep = handle_type_cases(gal.separator)
    if sep == nil then
      error('Bro wtf? galaxy-line separator should be string | table | function')
    end
    local left_sep, right_sep
    local _exp_0 = type(sep)
    if 'string' == _exp_0 then
      left_sep, right_sep = gal.separator, gal.separator
    elseif 'table' == _exp_0 then
      left_sep, right_sep = gal.separator[1], gal.separator[2]
    end
    local sep_hi
    if gal.separator_highlight then
      sep_hi = handle_highlight_table(gal.separator_highlight)
    else
      sep_hi = heir.hi
    end
    local heir_left = {
      provider = left_sep,
      hl = sep_hi
    }
    local heir_right = {
      provider = right_sep,
      hl = sep_hi
    }
    heir = {
      heir_left,
      heir,
      heir_right
    }
  end
  return heir
end
return {
  galaxy_to_heirline = galaxy_to_heirline
}
