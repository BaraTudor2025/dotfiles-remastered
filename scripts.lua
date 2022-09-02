-- [[
-- %l		line number (finds a number)
-- %e		end line number (finds a number)
-- %c		column number (finds a number representing character column of the error, byte index, a <tab> is 1 character column)
-- %v		virtual column number (finds a number representing screen column of the error (1 <tab> == 8 screen columns))
-- %k		end column number (finds a number representing the character column of the error, byte index, or a
-- 		number representing screen end column of the error if it's used with %v)
-- %t		error type (finds a single character):
-- 		    e - error message
-- 		    w - warning message
-- 		    i - info message
-- 		    n - note message
-- %n		error number (finds a number)
-- %m		error message (finds a string)
-- %r		matches the "rest" of a single-line file message %O/P/Q
-- %p		pointer line (finds a sequence of '-', '.', ' ' or tabs and uses the length for the column number)
-- %*{conv}	any scanf non-assignable conversion
-- %%		the single '%' character
-- %s		search text (finds a string)
-- ]]

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

-- foloseste [I pt keyword seach under cursor si dupa selecteaza la care dai jump
-- :map <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " .. nr .. "[\t"<CR>

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

-- local tele = require('telescope.actions.state')

-- instead of:  function() fun(arg1, arg2) end
-- write: cacat  lambda(fun, arg1, arg2)
local lambda = function(fun, ...)
  local args = {...}
  return function()
    return fun(unpack(args))
  end
end

local function run_lua_selection()
  local s = vim.api.nvim_buf_get_mark(0, '<')
  local e = vim.api.nvim_buf_get_mark(0, '>')
  local lines = vim.api.nvim_buf_get_lines(0, s[1]-1, e[1], true) -- use row
  lines = table.concat(lines, '\n')
  lines = "lua << EOF\n" .. lines .. '\nEOF'
  vim.cmd(lines)
end

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
