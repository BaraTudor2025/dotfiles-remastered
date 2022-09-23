---@diagnostic disable: unused-local, lowercase-global
-- *** TOC ***
local function custom_toc(pattern)
  -- local path = vim.fn.expand('%:p')
  -- vim.cmd("lvimgrep /\\*\\*\\*/ "..path.." |lopen")
  if pattern == nil then
    pattern = '%*%*%*.*%*%*%*'
  end
  local bufnr = vim.api.nvim_get_current_buf()
  ---@type string[]
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local locs = {}
  for nr, line in ipairs(lines) do
    local m = line:match(pattern)
    if m ~= nil then
      table.insert(locs, {
        lnum = nr,
        text = m,
        bufnr = bufnr,
      })
    end
  end
  vim.fn.setloclist(0, locs, 'r')
  vim.cmd 'vertical lopen'
  vim.api.nvim_win_set_width(0, 40)
  vim.wo.conceallevel=2
  vim.wo.concealcursor='nc'
  vim.wo.relativenumber = false
  vim.wo.cursorline = false
  vim.bo.buflisted = false
  for i = 1, 9 do
    vim.keymap.set('n', tostring(i), function()
      vim.cmd('ll'..tostring(i))
      vim.cmd('normal zt')
      vim.cmd('lclose')
    end, {buffer=true})
  end
  vim.cmd 'syntax match qfFileName /^[^|]*/ transparent conceal'
  vim.cmd 'syntax match qfLineNr /[0-9]*/ transparent conceal'
  vim.cmd 'syntax match qfSeparator /[|]/ transparent conceal'
  vim.cmd 'set winhighlight=Normal:Keyword'
end

function all_toc()
  local path = vim.fn.stdpath('config') .. '/lua/user/'
  vim.cmd('vimgrepadd /\\*\\*\\*.*\\*\\*\\*/j '..path)
  vim.cmd 'vertical copen'
  vim.api.nvim_win_set_width(0, 40)
  vim.wo.conceallevel=2
  vim.wo.concealcursor='nc'
  vim.wo.relativenumber = false
  vim.bo.buflisted = false
  vim.cmd 'syntax match qfLineNr /[0-9]*/ transparent conceal'
end

local group_map = function (opts, decls)
  -- handels strings of type 'n' or 'nx'
  local modes
  if #opts.modes == 1 then
    modes = opts.modes
  else
    modes = {}
    for c in opts.modes do
      table.insert(modes, c)
    end
  end
  -- declare helper functions
  local helpers = {
    cmd = function (key, cmd, desc)
      vim.keymap.set(modes, opts.prefix..key, function () vim.cmd(cmd) end, {desc = desc})
    end,
    key = function (key, existing_map, desc)
      vim.keymap.set(modes, opts.prefix..key, existing_map, {desc=desc})
    end
  }

  decls(helpers)
end

-- ilocal nush = vmkbim.kb. kbkb.ü 	(jkghj
-- akbkbkbjk

local plenary = require("plenary.async")

-- vim.keymap.set('n', ';', ':', {})

function replay_macro_async(reg, delay_a)
  ---@diagnostic disable-next-line: missing-parameter
  local keys = vim.fn.getreg(reg)
  local delay = delay_a or 50
  local run = plenary.void(function()
    local i = 1
    while i <= #keys do
      plenary.util.sleep(delay)
      plenary.util.scheduler() -- safe to call *api*
      if keys:byte(i) == 0x80 then -- mizerie de backspace ? sau altele
        local seq = keys:sub(i, i+2)
        vim.fn.feedkeys(seq)
        i = i + 3
      else
        vim.fn.feedkeys(keys:sub(i,i))
        -- vim.api.nvim_input(keys:sub(i,i))
        i = i + 1
      end
    end
  end)
  run()
end

function replay_macro(reg, delay_a)
  ---@type string
  ---@diagnostic disable-next-line: missing-parameter
  local keys = vim.fn.getreg(reg)
  local delay = delay_a or 50
  local feed_key = function (i, j)
    vim.api.nvim_feedkeys(keys:sub(i, j), vim.api.nvim_get_mode().mode, false)
  end

  local function next_key(index)
    if index <= #keys then
      vim.defer_fn(function ()
        -- mode 'm' for
        vim.api.nvim_feedkeys(keys:sub(index, index), 'm', false)
        print(index)
        if index == #keys then
          return
        end
        next_key(index + 1)
      end, delay)
    end
  end
  next_key(1)

  -- local timer = vim.loop.new_timer()
  -- timer:start(10, delay, vim.schedule_wrap(function()
  --   if i <= #keys then
  --     vim.api.nvim_feedkeys(keys:sub(i, i), vim.api.nvim_get_mode().mode, false)
  --     i = i + 1
  --   else
  --     timer:close()
  --   end
  -- end))
end

-- instead of:  function() fun(arg1, arg2) end
-- write: cacat  lambda(fun, arg1, arg2)
local lambda = function(fun, ...)
  local args = {...}
  return function()
    return fun(unpack(args))
  end
end

local function run_lua_selection()
  vim.fn.getmarklist()
  local s = vim.api.nvim_buf_get_mark(0, '<')
  local e = vim.api.nvim_buf_get_mark(0, '>')
  local lines = vim.api.nvim_buf_get_lines(0, s[1]-1, e[1], true) -- use row
  lines = table.concat(lines, '\n')
  lines = "lockmarks lua << EOF\n" .. lines .. '\nEOF'
  print(lines)
  vim.cmd(lines)
end

function select_sniprun_output()
  vim.ui.select({
      "Classic",
      "Terminal",
      "TerminalWithCode",
      "VirtualTextOk",
      "VirtualTextErr",
      "LongTempFloatingWindow",
    }, {prompt = "Select output method for SnipRun"},
    function (choice)
      require('sniprun').config_values.display = { choice }
    end
  )
end

-- local function mama()
--   print('tata')
-- end
-- vim.keymap.set('v', '<leader>r', mama, {})

-- print('mama')

-- vim.keymap.set('v', '<leader>r', , {})

-- print('1')
-- print('2')
-- print('3')

-- for i=1,10 do
--   print(0)
-- end

-- local file = io.open('./schema2.lua', 'w')
-- file:write(vim.inspect(vim.lsp.get_active_clients()))
-- file:close()

return {
  custom_toc = custom_toc,
  run_lua_selection = run_lua_selection,
}
