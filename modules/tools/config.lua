-- The following example showcases a custom action, using `multiselect`. We're
-- executing a `normal!` command at each selected position (this could be even
-- more useful if we'd pass in custom targets too).
local M = {}

local function paranormal(targets)
  -- Get the :normal sequence to be executed.
  local input = vim.fn.input "normal! "
  if #input < 1 then return end

  local ns = vim.api.nvim_create_namespace ""

  -- Set an extmark as an anchor for each target, so that we can also execute
  -- commands that modify the positions of other targets (insert/change/delete).
  for _, target in ipairs(targets) do
    ---@diagnostic disable-next-line: deprecated
    local line, col = unpack(target.pos)
    local id = vim.api.nvim_buf_set_extmark(0, ns, line - 1, col - 1, {})
    target.extmark_id = id
  end

  -- Jump to each extmark (anchored to the "moving" targets), and execute the
  -- command sequence.
  for _, target in ipairs(targets) do
    local id = target.extmark_id
    local pos = vim.api.nvim_buf_get_extmark_by_id(0, ns, id, {})
    vim.fn.cursor(pos[1] + 1, pos[2] + 1)
    vim.cmd("normal! " .. input)
  end

  -- Clean up the extmarks.
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

function M.leap()
  require("leap").setup {
    safe_labels = { "f", "j", "k", "l", "h", "s", "n", "u", "t", "q", "r", "m", "'" },
    labels = {},
  }
  require("leap").set_default_keymaps()
  local leap_fn = require("leap").leap
  vim.cmd [[
    nunmap s
    nunmap S
    vunmap s
    vunmap S
    unmap gs
  ]]
  vim.keymap.set({ "n", "v" }, "s", function() leap_fn { target_windows = { vim.fn.win_getid() } } end)
  vim.keymap.set({ "n", "v" }, "S", function()
    leap_fn {
      target_windows = vim.tbl_filter(
        function(win) return vim.api.nvim_win_get_config(win).focusable end,
        vim.api.nvim_tabpage_list_wins(0)
      ),
    }
  end)
  vim.keymap.set(
    "n",
    "gs",
    function()
      leap_fn {
        target_windows = { vim.fn.win_getid() },
        action = paranormal,
        multiselect = true,
      }
    end
  )
end

function M.flit()
  require("flit").setup {
    labeled_modes = "nvo",
  }
end

function M.live_command()
  -- vim.cmd [[delcommand G]]
  require("live-command").setup {
    commands = {
      Norm = {
        cmd = "norm",
      },
      Reg = {
        cmd = "norm",
        -- This will transform ":5Reg a" into ":norm 5@a"
        args = function(opts) return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args end,
        range = "",
      },
      G = { cmd = "g" },
      Sort = { cmd = "sort" },
      -- S = {
      --   -- cmd = "Abolish -search",
      --   cmd = "%Subvert",
      --   -- args = function (opts)
      --   --
      --   -- end,
      -- },
      -- -- Grep = {
      -- --   cmd = "Abolish ",
      -- -- },
      -- Sub = {
      --   cmd = "Abolish -substitute -flags=g ",
      -- },
    },
  }
end

function M.abolish()
  local ab = function(str) vim.cmd("Abolish " .. str) end

  vim.cmd.cnoreabbrev "hv vert bot h" -- vertical bot[tom]right help
  -- general
  ab "fi if"
  ab "w{hi,ih}{el,le} while"
  ab "fro for"
  ab "s{wi,iw}{thc,tch}{,es,se} switch{,}{,}{,es,es}"
  ab "mat{hc,ch}{,es,se} match{,}{,es,es}"
  ab "re{tu,ut,t}{rn,nr}{,s} re{tu}{rn}{,s}"
  ab "elt let"
  ab "s{itr,tri,irt,tir}{gn,ng}{,s} s{tri}{ng}{,s}" -- string
  ab "ture true"
  ab "flase false"
  ab "defautl{,s} default{,s}"
  ab "calss class"
  ab "as{si,is}{ng,gn,g}{,emet,emt,ment}{,s} as{si}{gn}{,ment,ment,ment}{,s}"
  ab "assret assert"
  vim.cmd.inoreabbrev "edn end"
  vim.cmd.inoreabbrev "adn and"
  vim.cmd.inoreabbrev "cdm cmd"

  -- tech
  ab "f{unc,nuc,ncu}{ti,it}o{an,na,n}{,s} f{unc}{ti}o{n}{,s}"
  ab "c{on,no}{gif,fig} config"
  ab "fiel file"
  ab "l{ado,oda,aod} load"
  ab "fi{tl,lt}{er,re}{,s} filter{,}{,}{,s}"
  ab "sqe seq"
  ab "scirpt script"

  -- vim lua
  ab "t{eh,h}{n,ne} then"
  ab "lc{oa,ao}l{,s} local{,}{,s}"
  ab "loacl{,s} local{,s}"
  ab "r{que,euq}ire{,s} require{,}{,s}"
  ab "comand{,s} command{,s}"

  -- english
  ab "c{aer,rae,era}{te,et}{,s} c{rea}{te}{,s}" -- create
  ab "hei{gth,thg,tgh}{,s} height{,,}{,s}"
  ab "widht width"
  ab "len{tgh,thg,ght}{,s} length{,,}{,s}"
  ab "d{on,no}t don't"
  ab "d{oe,eo}s{,nt} does{,}{,n't}"
end

function M.harpoon()
  vim.api.nvim_create_user_command("Mark", function() require("harpoon.mark").add_file() end, {})
  vim.api.nvim_create_user_command("Harpoon", require("harpoon.ui").toggle_quick_menu, {})
  -- require("telescope").load_extension('harpoon')
end

function M.smart_words()
  local map = function(lhs, rhs) vim.keymap.set({ "n", "v" }, lhs, rhs, {}) end
  -- map("w", "<Plug>(smartword-w)")
  -- map("b", "<Plug>(smartword-b)")
  -- map("e", "<Plug>(smartword-e)")
  -- map("ge", "<Plug>(smartword-ge)")
  -- vim.cmd[[
  -- map <Plug>(smartword-basic-w)  <Plug>WordMotion_w
  -- map <Plug>(smartword-basic-b)  <Plug>WordMotion_b
  -- map <Plug>(smartword-basic-e)  <Plug>WordMotion_e
  -- map <Plug>(smartword-basic-ge)  <Plug>WordMotion_ge
  -- ]]
end

function M.neorg()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {},
      ["core.norg.dirman"] = {
        config = {
          -- workspaces = {
          --   code = "~/Documents/Code/notes",
          --   nvim = "~/Documents/Code/Neovim",
          -- },
        },
      },
      -- ['core.norg.completion'] = {
      --   config = {
      --     engine = 'nvim-cmp'
      --   }
      -- },
      -- ['core.integrations.nvim-cmp'] = {},
    },
  }
  -- astronvim.add_user_cmp_source('neorg')
end

return M
