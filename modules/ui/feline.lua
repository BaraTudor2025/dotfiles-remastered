local feline_to_heirline
feline_to_heirline = function(fe)
  local heir = { }
  heir.feline = fe
  local err_head = 'feline to heirline: '
  local transform
  transform = function(args)
    if not (args.pass_self) then
      args.pass_self = false
    end
    if not (args.handle_tbl) then
      args.handle_tbl = function()
        return error(err_head .. 'table case not handled')
      end
    end
    if not (args.opts) then
      args.opts = { }
    end
    local _exp_0 = type(heir.feline[args.prop])
    if 'nil' == _exp_0 then
      return nil
    elseif 'boolean' == _exp_0 or 'string' == _exp_0 then
      return function(self)
        return self.feline[args.prop]
      end
    elseif 'table' == _exp_0 then
      return args.handle_tbl()
    elseif 'function' == _exp_0 then
      if args.handle_fn then
        return args.handle_fn()
      elseif args.pass_self then
        return function(self)
          return self.feline[args.prop](self.feline)
        end
      else
        return function(self)
          return self.feline[args.prop]()
        end
      end
    else
      return error(err_head .. 'type ' .. type(heir.feline[args.prop]) .. ' not recognized by converter')
    end
  end
  local comp_condition = {
    update = transform({
      prop = 'enabled'
    })
  }
  local comp_provider = { }
  comp_provider.short_provider = transform({
    prop = 'short_provider',
    pass_self = true,
    handle_tbl = function()
      return function()
        return nil
      end
    end
  })
  comp_provider.provider = transform({
    prop = 'provider',
    pass_self = true,
    handle_tbl = function()
      comp_provider.update = transform({
        prop = 'provider.update'
      })
      return function(self)
        local name = self.feline.provider.name
        local opts = self.feline.propvider.opts
      end
    end
  })
  local conv_hl_tbl
  conv_hl_tbl = function(hl)
    return {
      fg = hl.fg,
      bg = hl.bg,
      cterm = hl.style
    }
  end
  heir.hl = transform({
    prop = 'hl',
    handle_tbl = function()
      return function(self)
        return conv_hl_tbl(self.feline.hl)
      end
    end,
    handle_fn = function()
      return function(self)
        local ret = self.feline.hl()
        local _exp_0 = type(ret)
        if 'string' == _exp_0 then
          return ret
        elseif 'table' == _exp_0 then
          return conv_hl_tbl(ret)
        else
          return error(err_head .. 'invalind hl type' .. type(ret) .. 'returned from function')
        end
      end
    end
  })
  local transform_icon
  transform_icon = function(sep, fun)
    if fun == nil then
      fun = nil
    end
    local _exp_0 = type(sep)
    if 'string' == _exp_0 then
      return {
        provider = sep
      }
    elseif 'table' == _exp_0 then
      return {
        provider = sep.str,
        hl = conv_hl_tbl(sep.hl)
      }
    elseif 'function' == _exp_0 then
      return fun()
    end
  end
  local transform_sep
  transform_sep = function(self, prop)
    do
      local opts = self.feline[prop]
      if opts then
        if not (opts[1]) then
          return transform_icon(opts)
        else
          local _accum_0 = { }
          local _len_0 = 1
          for _index_0 = 1, #opts do
            local sep = opts[_index_0]
            _accum_0[_len_0] = transform_icon(sep)
            _len_0 = _len_0 + 1
          end
          return _accum_0
        end
      else
        return nil
      end
    end
  end
  local comp_left_sep = transform_sep('left_sep')
  local comp_right_sep = transform_sep('right_sep')
  local comp_icon
  comp_icon = function(self)
    do
      local icon = self.feline.icon
      if icon then
        return transform_icon(icon, function()
          return transform_icon(icon)
        end)
      else
        return nil
      end
    end
  end
  table.insert(heir, {
    comp_left_sep,
    comp_icon,
    comp_provider,
    comp_right_sep
  })
  return heir
end
