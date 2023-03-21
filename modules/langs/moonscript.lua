local moonpick = require("moonpick")
local moon_parse = require("moonscript.parse")
local moon_compile = require("moonscript.compile")

local function get_curr_buf_contents()
  local bufnr = vim.api.nvim_get_current_buf()
  local code = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
  return bufnr, table.concat(code, '\n')
end

local function set_diagnostics(ns, bufnr, diags, opts)
  opts = vim.tbl_extend('force', {virtual_text=true}, opts or {})
  ns = vim.api.nvim_create_namespace(ns)
  vim.diagnostic.set(ns, bufnr, diags, opts)
end

local function moon_lint()
  if vim.bo.filetype ~= 'moon' then return end
  local bufnr, code = get_curr_buf_contents()
  local warnings = moonpick.lint(code, {})
  if warnings then
    local diags = {}
    for _, x in ipairs(warnings) do
      table.insert(diags, {
        -- bufnr = bufnr,
        lnum = x.line - 1,
        col = x.pos,
        message = x.msg,
        code = x.code,
        severity = vim.diagnostic.severity.WARN,
      })
    end
    set_diagnostics('moonpick', bufnr, diags)
  end
end

local function moon_report_errors()
  local bufnr, moon_code = get_curr_buf_contents()
  ---@type table, string
  local tree, err = moon_parse.string(moon_code)
  local errors = {}

  local function add_err(line, msg)
    table.insert(errors, {lnum=line-1, col=0, message=msg, code='', severity=vim.diagnostic.severity.ERROR})
  end
  if not tree then
    local msg, pos = err:match('^(.*):\n %[(%d*)%]')
    add_err(tonumber(pos), msg)
    set_diagnostics('moonscript-error', bufnr, errors)
  end

  local lua_code, err, pos = moon_compile.tree(tree)
  if not lua_code then
    vim.pretty_print(errors)
    add_err(pos, err)
    set_diagnostics('moonscript-error', bufnr, errors)
    return
  end
  -- vim.pretty_print(posmap)

  -- inca nu este gata
  if true then return end
  local lua_bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(lua_bufnr, 0, 0, false, lua_code)
  -- *** wait for lua server somehow ***
  local diags = vim.diagnostic.get(lua_bufnr)
  if #diags > 0 then
    local posmap = err
    local moon_util = require('moonscript.util')
    -- local moon_line = {}
    -- local output = '' -- ceva Job:start(redirect out)
    -- for lual, moonl in output:gmatch('(%d+):%[ .* %] >> (%d+):') do
    --   moon_line[lual] = moonl
    -- end
    local function moon_lnum_from(lua_lnum)
      local moon_pos = posmap[lua_lnum]
      return moon_util.pos_to_line(moon_code, moon_pos)
    end
    for d in ipairs(diags) do
      d.bufnr = bufnr
      d.lnum = moon_lnum_from(d.lnum)
      d.col = 0
      d.end_col = nil
      d.message = 'Lua: ' .. d.message
      if d.end_lnum then
        d.end_lnum = moon_lnum_from(d.end_lnum)
      end
    end
    set_diagnostics('moon-from-lua', bufnr, diags, {virtual_text={prefix='Lua:'}})
  end
end

local au = vim.api.nvim_create_augroup('MoonScript', {clear=true})
vim.api.nvim_create_autocmd('BufWrite', {group=au, pattern = '*.moon', callback=moon_lint})
vim.api.nvim_create_autocmd('BufWrite', {group=au, pattern = '*.moon', callback=moon_report_errors})
