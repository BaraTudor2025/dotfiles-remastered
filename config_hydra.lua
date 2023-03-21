--- *** Hail Hydra *** ---
local Hydra = require "hydra"
local splits = require "smart-splits"

local cmd = require("hydra.keymap-util").cmd
local pcmd = require("hydra.keymap-util").pcmd

local window_hint_old = [[
 ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split     ^^  ^^  Bufs ^^  ^^ Tabs
 ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------^^  ^^ ------^^  ^^------
 ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally^^  ^  _u_  _i_    _e_  _r_
 _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically  ^^  ^  _T_  ^I^    _E_  _R_
 ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _z_: maximize    ^^  ^   _b_uf   ^^ _n_ewtab
 focus^^^^^^  window^^^^^^  ^_=_: equalize^   _q_uit/remain-_o_nly ^   _d_el   ^^_c_lose
                          _<ESC>_
]]

local window_hint_big = [[
 ^^^^^^^^^^^^Resize  MoveW  ^^   Focus   ^^   ^^     Split     ^^  ^^  Bufs ^^  ^^ Tabs  ^^
 ^^^^^^^^^^^^------ ------- ^^-----------^^   ^^---------------^^  ^^ ------^^  ^^------ ^^
 ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^  ^   _<C-k>_   ^   _s_: horizontally^^  ^  _u_  _i_    _e_  _r_^
 _h_ ^ ^ _l_   _H_ ^ ^ _L_  _<C-h>_ _<C-l>_   _v_: vertically  ^^  ^  _T_  ^I^    _E_  _R_^
  ^ ^_j_ ^ ^   ^ ^ _J_ ^ ^  ^   _<C-j>_   ^   _z_: maximize    ^^  ^   _b_uf   ^^new_t_ab ^
   _=_ equalize^^^^^^            ^^^^^^  ^^   _c_lose/_o_nly win ^     _d_el   ^^_C_lose ^^
                      _<ESC>_ / _q_ / _;_
]]

-- *** Window Hydra ***
local window_hydra = Hydra {
  name = "Windows",
  hint = window_hint_big,
  mode = "n",
  config = {
    hint = {
      border = "rounded",
      offset = -1,
    },
    timeout = 5000,
  },
  heads = {
    -- Buffers
    { "u", "[b" },
    { "i", "]b" },
    { "T", "<c-w>T" },
    { "b", cmd "JABSOpen", { exit = true } },

    -- Tabs
    { "e", cmd "tabprev" },
    { "r", cmd "tabnext" },
    { "E", cmd "-tabmove" },
    { "R", cmd "+tabmove" },
    {
      "t",
      function()
        vim.cmd "tab split"
        -- vim.bo.bufhidden = 'wipe'
        -- vim.bo.buftype = 'nofile'
        -- vim.bo.buflisted = false
        -- vim.bo.swapfile = false
      end,
    },

    -- closing
    { "d", cmd "Bdelete" },
    { "c", pcmd("close", "E444") },
    { "C", pcmd("tabclose", "E784") },

    -- Move Between Windows
    { "<C-h>", "<C-w>h" },
    { "<C-j>", "<C-w>j" },
    { "<C-k>", pcmd("wincmd k", "E11", "close") },
    { "<C-l>", "<C-w>l" },

    -- Shift
    { "H", cmd "WinShift left" },
    { "J", cmd "WinShift down" },
    { "K", cmd "WinShift up" },
    { "L", cmd "WinShift right" },

    -- Resize
    { "h", function() splits.resize_left(3) end },
    { "j", function() splits.resize_down(3) end },
    { "k", function() splits.resize_up(3) end },
    { "l", function() splits.resize_right(3) end },
    { "=", "<C-w>=" },

    { "s", pcmd("split", "E36") },
    { "v", pcmd("vsplit", "E36") },

    { "z", cmd "MaximizerToggle!" },

    { "o", "<C-w>o", { exit = true } },

    { "<ESC>", nil, { exit = true } },
    { "q", nil, { exit = true } },
    { ";", nil, { exit = true } },
    { ":", nil, { exit = true, desc = false } },
  },
}

local horiz_scroll = Hydra {
  name = "Horizontal Scroll",
  mode = "n",
  body = "z",
  config = {
    -- hint = {
    --   type = 'statusline'
    -- },
    timeout = 1500,
    color = "pink", --run foreign keys, <ESC> to exit
  },
  heads = {
    { "h", "6zh" },
    { "l", "6zl" },
    { "H", "zH" },
    { "L", "zL" },
    { "<ESC>", nil, { exit = true } },
  },
}

local gitsigns = require "gitsigns"

local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
]]

local gitsigns_hydra = Hydra {
  name = "Git",
  hint = hint,
  mode = { "n", "x" },
  config = {
    -- buffer = bufnr,
    color = "pink",
    invoke_on_body = true,
    hint = {
      border = "rounded",
    },
    on_enter = function()
      vim.cmd "mkview"
      vim.cmd "silent! %foldopen!"
      vim.bo.modifiable = false
      gitsigns.toggle_signs(true)
      gitsigns.toggle_linehl(true)
    end,
    on_exit = function()
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      vim.cmd "loadview"
      vim.api.nvim_win_set_cursor(0, cursor_pos)
      vim.cmd "normal zv"
      gitsigns.toggle_signs(false)
      gitsigns.toggle_linehl(false)
      gitsigns.toggle_deleted(false)
    end,
  },
  heads = {
    {
      "J",
      function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() gitsigns.next_hunk() end)
        return "<Ignore>"
      end,
      { expr = true, desc = "next hunk" },
    },
    {
      "K",
      function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() gitsigns.prev_hunk() end)
        return "<Ignore>"
      end,
      { expr = true, desc = "prev hunk" },
    },
    { "s", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "stage hunk" } },
    { "u", gitsigns.undo_stage_hunk, { desc = "undo last stage" } },
    { "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
    { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
    { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
    { "b", gitsigns.blame_line, { desc = "blame" } },
    { "B", function() gitsigns.blame_line { full = true } end, { desc = "blame show full" } },
    { "/", gitsigns.show, { exit = true, desc = "show base file" } }, -- show the base of the file
    { "<Enter>", "<Cmd>Neogit<CR>", { exit = true, desc = "Neogit" } },
    { "q", nil, { exit = true, nowait = true, desc = "exit" } },
  },
}

-- local quick_words_hydra = Hydra({
--    name = 'Quick words',
--    hint = "_w_,_e_,_b_,_ge_, toggle",
--    config = {
--       color = 'pink',
--       buffer = false,
--       exit = false,
--       -- hint = 'statusline',
--    },
--    mode = {'n','x','o'},
--    body = ',',
--    heads = {
--       { 'w',  '<Plug>(smartword-w)'  },
--       { 'b',  '<Plug>(smartword-b)'  },
--       { 'e',  '<Plug>(smartword-e)'  },
--       { 'ge', '<Plug>(smartword-ge)' },
--       { '<Esc>', nil, { exit = false, mode = 'n', desc = false } }
--    }
-- })

-- vim.api.nvim_create_user_command("ToggleQuickWords", function() quick_words_hydra:activate() end, {})

vim.api.nvim_create_user_command("HydraWindow", function() window_hydra:activate() end, {})

vim.api.nvim_create_user_command("GitHydra", function() gitsigns_hydra:activate() end, {})

vim.api.nvim_create_user_command("HydraSideScroll", function() horiz_scroll:activate() end, {})

return {
  setup = function() --[[lmao]]
  end,
}
