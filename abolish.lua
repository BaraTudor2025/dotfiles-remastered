local fn = vim.fn
local expand = fn.expand
local substitute = fn.substitute
local matchstr = fn.matchstr
local extend = fn.extend
local deepcopy = fn.deepcopy
local copy = fn.copy
local exists = fn.exists
local isdirectory = fn.isdirectory
local has = fn.has
local match = fn.match
local line = fn.line
local getline = fn.getline
local remove = fn.remove
local get = fn.get
local type = fn.type
local tolower = fn.tolower
local toupper = fn.toupper
local items = fn.items
local split = fn.split
local range = fn.range
local len = fn.len
local join = fn.join
local map = fn.map
local strpart = fn.strpart
local has_key = fn.has_key
local strlen = fn.strlen
local sort = fn.sort
local keys = fn.keys
local histdel = fn.histdel
local submatch = fn.submatch
local filter = fn.filter
local empty = fn.empty
local fnamemodify = fn.fnamemodify
local mkdir = fn.mkdir
local filereadable = fn.filereadable
local readfile = fn.readfile
local writefile = fn.writefile
local getreg = fn.getreg
local getregtype = fn.getregtype
local getcurpos = fn.getcurpos
local setreg = fn.setreg
local setpos = fn.setpos
local nr2char = fn.nr2char
local getchar = fn.getchar
local g = vim.g

if not exists "g:abolish_save_file" then
  if isdirectory(expand "~/.vim") then
    g.abolish_save_file = expand "~/.vim/after/plugin/abolish.vim"
  elseif isdirectory(expand "~/vimfiles") or has "win32" then
    g.abolish_save_file = expand "~/vimfiles/after/plugin/abolish.vim"
  else
    g.abolish_save_file = expand "~/.vim/after/plugin/abolish.vim"
  end
end

vim.cmd [[
function! Remove_viml()
  %Subvert/{a,s,l}://
endfunction

function! Replace_viml()
  %s/function!/local function/
  %Subvert/function!/local function/e
  %Subvert/end{function,if,while}/end/e
  %Subvert/{while,if,elseif} \(.*\)/{while,if,elseif} \1 then/e
  %Subvert/{&&,||}/{and,or}/e
endfunction

xnoremap <leader>ie <cmd>Subvert/end{function,if,while}/end<end>
xnoremap <leader>ir <cmd>call Remove_viml()<cr>
xnoremap <leader>is <cmd>call Replace_viml()<cr>
]]

vim.keymap.set({"v", "n"}, "<leader>ie", function ()
  vim.cmd [[
  %s/function!/local function/
  %Subvert/function!/local function/e
  %Subvert/end{function,if,while}/end/e
  %Subvert/{while,if,elseif} \(.*\)/{while,if,elseif} \1 then/e
  %Subvert/{&&,||}/{and,or}/e
  ]]
end)

vim.cmd [[
s/a://
s/endfunction/end
s/endif/end
s/endwhile/end
s/function!/local function/
s/s://
s/l://
s/&&/ and /
s/||/or/
s/while \(.*\)/while \1 then/
s/if \(.*\)/if \1 then/
s/elseif \(.*\)/elseif \1 then/
s///

csq[
ysa[]
]]

vim.api.nvim_create_user_command("VimLReplace", function (opts)
  local function s(str)
    vim.cmd(opts.line1 .. "," .. opts.line2 .. "s" .. str .. "e")
  end
  local function sub(str)
    vim.cmd(opts.line1 .. "," .. opts.line2 .. "Subvert" .. str .. "e")
  end
  s[[/function!/local function/]]
  s[[/while \(.*\)/while \1 then/]]
  s[[/\<if\> \(.*\)/if \1 then/]]
  s[[/elseif \(.*\)/elseif \1 then/]]
  s[[/&&/and/]]
  s[[/||/or/]]
  sub[[/end{function,if,while}/end/]]
end, {range=true})

local function s:send(self,func,...)
  if type(a:func) == type('') or type(a:func) == type(0) then
    let l:Func = get(a:self,a:func,'')
  else
    let l:Func = a:func
  end
  let s = type(a:self) == type({}) ? a:self : {}
  if type(Func) == type(function('tr')) then
    return call(Func,a:000,s)
  elseif type(Func) == type({}) and has_key(Func,'apply') then
    return call(Func.apply,a:000,Func)
  elseif type(Func) == type({}) and has_key(Func,'call') then
    return call(Func.call,a:000,s)
  elseif type(Func) == type('') and Func == '' and has_key(s,'function missing') then
    return call('s:send',[s,'function missing',a:func] + a:000)
  else
    return Func
  end
end
