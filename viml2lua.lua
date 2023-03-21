-- vim.cmd [[
-- function! Remove_viml()
--   %Subvert/{a,s,l}://
-- endfunction
--
-- function! Replace_viml()
--   %s/function!/local function/
--   %Subvert/function!/local function/e
--   %Subvert/end{function,if,while}/end/e
--   %Subvert/{while,if,elseif} \(.*\)/{while,if,elseif} \1 then/e
--   %Subvert/{&&,||}/{and,or}/e
-- endfunction
--
-- xnoremap <leader>ie <cmd>Subvert/end{function,if,while}/end<end>
-- xnoremap <leader>ir <cmd>call Remove_viml()<cr>
-- xnoremap <leader>is <cmd>call Replace_viml()<cr>
-- ]]
--
-- vim.keymap.set(
--   { "v", "n" },
--   "<leader>ie",
--   function()
--     vim.cmd [[
--   %s/function!/local function/
--   %Subvert/function!/local function/e
--   %Subvert/end{function,if,while}/end/e
--   %Subvert/{while,if,elseif} \(.*\)/{while,if,elseif} \1 then/e
--   %Subvert/{&&,||}/{and,or}/e
--   ]]
--   end
-- )
--
-- vim.cmd [[
-- s/a://
-- s/endfunction/end
-- s/endif/end
-- s/endwhile/end
-- s/function!/local function/
-- s/s://
-- s/l://
-- s/&&/ and /
-- s/||/or/
-- s/while \(.*\)/while \1 then/
-- s/if \(.*\)/if \1 then/
-- s/elseif \(.*\)/elseif \1 then/
-- s///
--
-- csq[
-- ysa[]
-- ]]
--
-- vim.api.nvim_create_user_command("VimLReplace", function(opts)
--   local function s(str) vim.cmd(opts.line1 .. "," .. opts.line2 .. "s" .. str .. "e") end
--
--   local function sub(str) vim.cmd(opts.line1 .. "," .. opts.line2 .. "Subvert" .. str .. "e") end
--
--   s [[/function!/local function/]]
--   s [[/while \(.*\)/while \1 then/]]
--   s [[/\<if\> \(.*\)/if \1 then/]]
--   s [[/elseif \(.*\)/elseif \1 then/]]
--   s [[/&&/and/]]
--   s [[/||/or/]]
--   sub [[/end{function,if,while}/end/]]
-- end, { range = true })

local function replace(text, patterns)
  local flags = "g"
  local s = vim.fn.substitute(text, "function!", "local function", flags)
  s = vim.fn.substitute(s, "&&", "and", flags)
  s = vim.fn.substitute(s, "||", "or", flags)
  s = vim.fn.substitute(s, [[endfunciton\endfun\|endfor\|endif\|endwhile]], [[end]], flags)
  s = vim.fn.substitute(s, [[fun!]], [[local function]], flags)
  s = vim.fn.substitute(s, [[elseif \(.*\)]], [[elseif \1 then]], flags)
  s = vim.fn.substitute(s, [[while \(.*\)]], [[while \1 then]], flags)
  s = vim.fn.substitute(s, [[\<if\> \(.*\)]], [[if \1 then]], flags)
  s = vim.fn.substitute(s, "call", "", flags)
  s = vim.fn.substitute(s, "a:", "", flags)
  s = vim.fn.substitute(s, "l:", "", flags)
  s = vim.fn.substitute(s, "v:", "vim\\.v", flags)
  s = vim.fn.substitute(s, "b:", "vim\\.b", flags)
  s = vim.fn.substitute(s, "g:", "vim\\.g", flags)
  s = vim.fn.substitute(s, [[\<let\> g:]], "vim\\.g", flags)
  s = vim.fn.substitute(s, [[\<let\>]], "local", flags)
  s = vim.fn.substitute(s, "local s:", "M\\.", flags) -- locale la modul
  s = vim.fn.substitute(s, "s:", "", flags)
  return s
end

function conv_viml(path)
  local text = vim.fn.readfile(path)
  text = table.concat(text, "\n")
  return replace(text)
end

local scan_dir = require("plenary.scandir").scan_dir

function conv_files(dir)
  local files = scan_dir(dir, { search_pattern = ".*%.vim" })
  for index, file in ipairs(files) do
    local dir = vim.fs.dirname(file):sub(2)
    -- print("./lua" .. dir)
    vim.fn.mkdir("./lua" .. dir, "p")
    local text = conv_viml(file)
  end
  -- return files
end

vim.pretty_print(conv_files ".")
