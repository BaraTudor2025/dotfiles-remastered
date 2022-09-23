galaxy_to_heirline = (gal) ->
  heir = {}
  heir.condition = gal.condition -- function
  heir.update = gal.event -- string

  handle_type_cases = (elem, nil_val=nil) ->
    switch type elem
      when 'string' then elem
      when 'function' then elem()
      when 'nil' then nil_val

  heir.provider = -> handle_type_cases(gal.icon, '') .. handle_type_cases(gal.provider)

  handle_highlight_table = (galaxy_hi) -> switch type galaxy_hi
    when 'string' -- autocommand event
      galaxy_hi
    when 'function' then ->
        tbl_str = galaxy_hi() -- string or string[]
        return switch type tbl_str
          when 'string' then tbl_str
          else { fg: tbl_str[1], bg: tbl_str[2], cterm: tbl_str[3] }
    when 'table' -> {
          fg: handle_type_cases(galaxy_hi[1]) -- individual element may be string or function to be called
          bg: handle_type_cases(galaxy_hi[2])
          cterm: handle_type_cases(galaxy_hi[3])
        }
  if gal.highlight
    heir.hi = handle_highlight_table(gal.highlight)

  -- TODO: check if separator can be appended in provider
  -- TODO: Check if component is at left edge or right edge of screen
  if gal.separator == nil
    sep = handle_type_cases(gal.separator)
    if sep == nil then error('Bro wtf? galaxy-line separator should be string | table | function')
    left_sep, right_sep = switch type sep
      when 'string' then gal.separator, gal.separator
      when 'table' then gal.separator[1], gal.separator[2]

    sep_hi = if gal.separator_highlight
      handle_highlight_table(gal.separator_highlight)
    else
      heir.hi

    heir_left = provider: left_sep, hl: sep_hi
    heir_right = provider: right_sep, hl: sep_hi
    heir = {heir_left, heir, heir_right}
  return heir

return :galaxy_to_heirline
