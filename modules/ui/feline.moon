feline_to_heirline = (fe) ->
  heir = {}
  -- hold a reference to original feline component
  -- so it can be passed to feline component methods
  heir.feline = fe
  -- NOTE: maybe make feline a static?
  -- heir.static.feline = fe
  err_head = 'feline to heirline: '

  transform = (args) ->
    args.pass_self = false unless args.pass_self
    unless args.handle_tbl
      args.handle_tbl = -> error(err_head .. 'table case not handled')
    args.opts = {} unless args.opts
    switch type heir.feline[args.prop]
      when 'nil' then nil
      when 'boolean' then () => @feline[args.prop]
      when 'string' then () => @feline[args.prop]
      when 'table' then args.handle_tbl()
      when 'function'
        if args.handle_fn
          args.handle_fn()
        elseif args.pass_self
          () => @feline[args.prop](@feline) -- opts
        else
          () => @feline[args.prop]()
      else
        error(err_head .. 'type ' .. type(heir.feline[args.prop]) .. ' not recognized by converter')

  comp_condition = update: transform prop: 'enabled'

  -- short and long providers
  comp_provider = {}

  comp_provider.short_provider = transform prop: 'short_provider', pass_self: true, handle_tbl: () ->
    return -> return nil

  comp_provider.provider = transform prop: 'provider', pass_self: true, handle_tbl: () ->
    comp_provider.update = transform prop: 'provider.update'
    return () =>
      -- TODO: call registered provider
      name = @feline.provider.name
      opts = @feline.propvider.opts

  conv_hl_tbl = (hl) ->
    -- hl.name = string highlight group created by Feline
    -- create hl-group here?
    fg: hl.fg, bg: hl.bg, cterm: hl.style

  heir.hl = transform
    prop: 'hl',
    handle_tbl: -> => conv_hl_tbl(@feline.hl),
    handle_fn: -> =>
      ret = @feline.hl()
      switch type ret
        when 'string' then ret
        when 'table' then conv_hl_tbl(ret)
        else error(err_head .. 'invalind hl type'.. type(ret) .. 'returned from function')

  transform_icon = (sep, fun=nil) ->
    switch type sep
      when 'string' then { provider: sep }
      when 'table' then { provider: sep.str, hl: conv_hl_tbl(sep.hl) } -- TODO: handle sep.always_visible
      when 'function' then fun()

  transform_sep = (prop) =>
    if opts = @feline[prop]
      unless opts[1]
        transform_icon opts
      else -- array
        [transform_icon sep for sep in *opts]
    else
      nil

  comp_left_sep = transform_sep 'left_sep'
  comp_right_sep = transform_sep 'right_sep'
  comp_icon = =>
    if icon = @feline.icon
      transform_icon icon, -> transform_icon icon
    else
      nil

  -- TODO: feline.priority
  table.insert(heir, { comp_left_sep, comp_icon, comp_provider, comp_right_sep})

  return heir
