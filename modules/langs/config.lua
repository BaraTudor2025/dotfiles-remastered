local moonpick = require("moonpick")
local parse = require("moonscript.parse")
local compile = require("moonscript.compile")

local function get_curr_buf_contents()
  local bufnr = vim.api.nvim_get_current_buf()
  local code = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
  return bufnr, table.concat(code, '\n')
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
    local ns = vim.api.nvim_create_namespace('moonpick')
    vim.diagnostic.set(ns, bufnr, diags, {virtual_text=true, })
  end
end

local function moon_report_errors()
  local bufnr, code = get_curr_buf_contents()
  local tree, err = parse.string(code)
  local errors = {}
  local function add_err(line, msg)
    table.insert(errors, {lnum=line-1, col=0, message=msg, code='', severity=vim.diagnostic.severity.ERROR})
  end
  if not tree then
    -- ceva regex pt 'err'
    add_err(-1, err)
  else
    local lua_code, err, pos = compile.tree(tree)
    if not lua_code then
      add_err(pos, err)
    end
  end
  if #errors > 0 then
    local ns = vim.api.nvim_create_namespace('moonscript-error')
    vim.diagnostic.set(ns, bufnr, errors, {virtual_text=true, })
  end
end

local au = vim.api.nvim_create_augroup('MoonScript', {clear=true})
vim.api.nvim_create_autocmd('BufWrite', {group=au, pattern = '*.moon', callback=moon_lint})
-- vim.api.nvim_create_autocmd('BufWrite', {group=au, pattern = '*.moon', callback=moon_report_errors})

return {}
