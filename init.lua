require "paq" {
  "savq/paq-nvim",

  "LionC/nest.nvim",
  "anuvyklack/keymap-amend.nvim",

  "anuvyklack/hydra.nvim",

  "tpope/vim-sleuth",
  "tpope/vim-scriptease",
  "inkarkat/vim-enhancedjumps", -- c-o, c-i
  -- "ludovicchabant/vim-gutentags",

  "kana/vim-textobj-user",
  -- "kana/vim-textobj-entire",
  "julian/vim-textobj-variable-segment", -- iv, av for word segment
  "Rasukarusan/nvim-block-paste", -- :Block
  "terryma/vim-expand-region", -- visual: _+ / s-'-' or s-=

  "marklcrns/vim-smartq",
  "nacro90/numb.nvim", -- preview for ex-cmd :{line-num}
  "winston0410/cmd-parser.nvim",
  "winston0410/range-highlight.nvim", -- highlight :{line-num},{line-num}
  "mcauley-penney/tidy.nvim", -- remove whitespace on save
  "ethanholz/nvim-lastplace",
  "xiyaowong/accelerated-jk.nvim",
  "monaqa/dial.nvim", -- smart c-a, c-x
  "kylechui/nvim-surround",
  "yuki-yano/zero.nvim",
  "numToStr/Comment.nvim", -- gc, gb
  "tpope/vim-abolish", -- :Subvert, :Abolish, cr[case][text-object]

  "Vonr/align.nvim",
  "booperlv/nvim-gomove",
  "johmsalas/text-case.nvim", -- prefix ga

  "gbprod/yanky.nvim",
  -- "BaraTudor2025/substitute.nvim", -- r/R[x-exchange]{text-object},
  -- "BaraTudor2025/cutlass.nvim",

  "jinh0/eyeliner.nvim",
  {"https://gitlab.com/madyanov/svart.nvim", opt=true},
  "woosaaahh/sj.nvim",
  "rlane/pounce.nvim",
  "phaazon/hop.nvim",
  "ggandor/lightspeed.nvim",

  "ggandor/leap.nvim",
  "ggandor/flit.nvim",
  "ggandor/leap-spooky.nvim",

  "nvim-treesitter/nvim-treesitter",

  "Wansmer/treesj", -- <space>j/s
  "Wansmer/sibling-swap.nvim",
  "David-Kunz/treesitter-unit",
  -- "RRethy/nvim-treesitter-textsubjects",
  -- "ThePrimeagen/refactoring.nvim",

  -- "ziontee113/syntax-tree-surfer",
  -- "drybalka/tree-climber.nvim",

  {"wellle/targets.vim", opt=true},
  {"nvim-treesitter/nvim-treesitter-textobjects", opt=true},

  {"mbbill/undotree", opt=true},
  {"rebelot/kanagawa.nvim", opt=true },
  {"max397574/better-escape.nvim", opt=true},
  {"windwp/nvim-autopairs", opt=true},
  {"smjonas/live-command.nvim", opt=true},
}
vim.opt.packpath:append("~/Documents")

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamed"

vim.opt.gdefault = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.wildmode = {"longest", "full"}
vim.opt.pumheight = 15

vim.keymap.amend = require("keymap-amend")
local Hydra = require "hydra"

vim.g.lightspeed_no_default_keymaps = true

-- vim.opt.tabstop = 2
-- vim.opt.shiftwidth = 2
-- vim.opt.expandtab = true
-- vim.opt.copyindent = true
-- vim.opt.smartindent = true
-- vim.opt.smarttab = true

vim.api.nvim_create_user_command("Cdbuffer", "cd %:h", {})

vim.cmd [[
nmap  <C-a>  <Plug>(dial-increment)
nmap  <C-x>  <Plug>(dial-decrement)
vmap  <C-a>  <Plug>(dial-increment)
vmap  <C-x>  <Plug>(dial-decrement)
vmap g<C-a> g<Plug>(dial-increment)
vmap g<C-x> g<Plug>(dial-decrement)
]]

vim.cmd [[let mapleader="\<space>"]]

vim.cmd.packadd "targets.vim"

vim.api.nvim_create_autocmd("User", {
  pattern = "targets#mappings#user",
  group = vim.api.nvim_create_augroup("CustomTargets", {clear=true}),
  callback = function()
    local separators = {}
    for e in vim.gsplit(",.;:+-=~_*#/\\|&$", '.') do table.insert(separators, { d=e }) end
    vim.api.nvim_call_function("targets#mappings#extend", {{
      e = {
        argument = {
          { o = '[', c = ']', s = ',' },
          { o = '{', c = '}', s = ',' },
          { o = '(', c = ')', s = ',' },
        }
      },
      s = {
        separator = separators,
      },
      t = {
        separator = separators,
        quote = {{d="'"}, {d='"'}, {d='`'}},
        tag = {{}},
        pair = {
          {o='(', c=')'},
          {o='[', c=']'},
          {o='{', c='}'},
          {o='<', c='>'},
        },
      },
    }})
  end,
})

require("zero").setup()
require("Comment").setup()
require("tidy").setup()
require("numb").setup()
require("range-highlight").setup()
require("nvim-lastplace").setup()
require("nvim-surround").setup()
require("ftFT").setup()
require("yanky").setup{
  preserve_cursor_position = { enabled = true },
  ring = { storage = "memory", timeout = 1500 },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 150,
  },
}

require('accelerated-jk').setup {
  mappings = { j = 'gj', k = 'gk' },
  acceleration_limit = 150,
  -- acceleration steps
  acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
  -- If you want to decelerate a cursor moving by time instead of reset. set it
  -- exampe:
  -- {
  --   { 200, 3 },
  --   { 300, 7 },
  --   { 450, 11 },
  --   { 600, 15 },
  --   { 750, 21 },
  --   { 900, 9999 },
  -- }
}

-- use gp to "gp
-- text substituted is copied in register "g
require "substitute".setup{
  on_substitute = require("yanky.integration").substitute(),
  yank_substituted_to_register = "g",
  -- yank_substituted_text = true,
}
require "cutlass".setup{
  cut_key = "m",
  exclude = {"s<bs>"},
  override_del = true,
}

vim.api.nvim_create_user_command("WipeRegs", function()
  vim.cmd[[
  for i in range(34, 122)
    silent! call setreg(nr2char(i), [])
  endfor
  ]]
end, {})

-- require("syntax-tree-surfer").setup()

local is_vscode = vim.g.vscode ~= nil
local ts_langs = {"json", "toml", "rust", "python", "julia"}

require "gomove".setup {
  map_defaults = false,
}
require('textcase').setup {
  prefix = "<leader>c",
  -- prob: alias go = gao?
  -- {prefix}o{conv}{object}
}
require "nvim-treesitter.configs".setup {
  ensure_instaled = {"c", "lua", "vim", "help", unpack(ts_langs)},
  highlight = { enable = not is_vscode },
}
-- require "sibling-swap".setup {
--   keymaps = {
--     ['<A-h>'] = 'swap_with_left_with_opp',
--     ['<A-l>'] = 'swap_with_right_with_opp',
--   },
-- }
require "treesj".setup { } -- <space> m/s/j
vim.api.nvim_del_keymap("n", "<space>m")

require "nest".applyKeymaps {
  { mode = "nv", {
    { ";", ":", options={ silent=false } },

    {
      {
        { "gh", "0" },
        { "gl", "$" },
        { "H", "0" },
        { "L", "$" },
      },
      options={ noremap=false },
      mode = "nvo",
    },

    { "p", "<Plug>(YankyPutAfter)" },
    { "P", "<Plug>(YankyPutBefore)" },
    { "=p", "<Plug>(YankyPutAfterFilter)" },
    { "=P", "<Plug>(YankyPutBeforeFilter)" },
    { "]p", "<Plug>(YankyPutIndentAfterLinewise)" },
    { "[p", "<Plug>(YankyPutIndentBeforeLinewise)" },
    { ">p", "<Plug>(YankyPutIndentAfterShiftRight)" },
    { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)" },
    { "gp", '"gp' , options={ noremap=false } },
    { "y", "<Plug>(YankyYank)" },
  }},

  {
    {'rp', '"rp'},
    {'rP', '"rP'},
    {'r=p', '"r=p'},
    {'r=P', '"r=P'},
    {'dp', '"dp'},
    {'dP', '"dP'},
    {'d=p', '"d=p'},
    {'d=P', '"d=P'},
    {'cp', '"cp'},
    {'cP', '"cP'},
    {'c=p', '"c=p'},
    {'c=P', '"c=P'},
    options={noremap=false},
  },

  {mode='x', 'iu', ':lua require"treesitter-unit".select()<CR>'},
  {mode='x', 'au', ':lua require"treesitter-unit".select(true)<CR>'},
  {mode='o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>'},
  {mode='o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>'},

  -- substitute/exchange
  { mode = "n", options={ silent=false, desc="substitute/exchange" }, {
    -- yank deleted text to "r register
    { "r", function() require"substitute".operator({ yank="r" }) end },
    { "rr", require"substitute".line },
    -- yank deleted text to default register
    { "R", function() require"substitute".operator({ yank=true }) end },
    {
      {"rd", '"dr'},
      {"rc", '"cr'},
      {"rx", '"xr'},
      options={noremap=false},
    },
    -- { "rp", "<Plug>(YankyCycleBackward)"},
    -- { "rn", "<Plug>(YankyCycleForward)"},

    { "cx", require"substitute.exchange".operator },
    { "cxx", require"substitute.exchange".line },
    { "cxc", require"substitute.exchange".cancel },
  }},
  {
    mode = "x",
    { "r", require"substitute".visual },
    { "x", require"substitute.exchange".visual },
  },

  { mode = "x", options = { noremap = true, silent = false, desc="align" },
  "<leader>a", {
    {'a', function() require'align'.align_to_char(1, true)             end }, -- Aligns to 1 character, looking left
    {'s', function() require'align'.align_to_char(2, true, true)       end }, -- Aligns to 2 characters, looking left and with previews
    {'w', function() require'align'.align_to_string(false, true, true) end }, -- Aligns to a string, looking left and with previews
    {'r', function() require'align'.align_to_string(true, true, true)  end }, -- Aligns to a Lua pattern, looking left and with previews
  }},
  { "<leader>a", mode = "n", options = { desc="align" },
    -- Example gawip to align a paragraph to a string, looking left and with previews
    { "w", function()
      local a = require'align'
      a.operator(a.align_to_string, { is_pattern = false, reverse = true, preview = true })
    end },
    -- Example gaaip to aling a paragraph to 1 character, looking left
    { "a", function()
      local a = require'align'
      a.operator(a.align_to_char, { length = 1, reverse = true })
    end },
  },

  {"<leader>", options={silent=false}, {
    { "h", ":noh<cr>", options={silent=true, desc="search highlight off"} },
    -- { "r", require"substitute.range".operator, mode = "n" },
    -- { "rr", require"substitute.range".word, mode = "n" },
    -- { "S", function() require"substitute.range".operator{prefix="Subvert"} end, mode = "n"},
    -- { "r", require"substitute.range".visual, mode = "x" },
  }},
}

local yanky = require("yanky")
vim.keymap.amend("n", "J", function(orig)
  if yanky.can_cycle() then
    yanky.cycle(-1)
  else
    orig()
  end
end)
vim.keymap.amend("n", "K", function(orig)
  if yanky.can_cycle() then
    yanky.cycle(1)
  else
    orig()
  end
end)

-- move

Hydra {
  body = "<leader>m",
  mode = "n",
  name = "-- NORMAL Move/Duplicate --",
  config = {
    color = "red",
    invoke_on_body = true,
    hint = { type = "cmdline" },
    timeout = 2000,
  },
  heads = {
    {"h", "<Plug>GoNSMLeft"},
    {"j", "<Plug>GoNSMDown"},
    {"k", "<Plug>GoNSMUp"},
    {"l", "<Plug>GoNSMRight"},

    {"H", "<Plug>GoNSDLeft"},
    {"J", "<Plug>GoNSDDown"},
    {"K", "<Plug>GoNSDUp"},
    {"L", "<Plug>GoNSDRight"},
    {"q", nil, { exit=true }},
  }
}

Hydra {
  body = "<leader>m",
  mode = "x",
  name = "-- VISUAL Move/Duplicate --",
  config = {
    color = "red",
    invoke_on_body = true,
    hint = { type = "cmdline" },
    timeout = 2000,
  },
  heads = {
    {"h", "<Plug>GoVSMLeft"},
    {"j", "<Plug>GoVSMDown"},
    {"k", "<Plug>GoVSMUp"},
    {"l", "<Plug>GoVSMRight"},

    {"H", "<Plug>GoVSDLeft"},
    {"J", "<Plug>GoVSDDown"},
    {"K", "<Plug>GoVSDUp"},
    {"L", "<Plug>GoVSDRight"},
    {"q", nil, { exit=true }},
  }
}

-- vim.g.yankstack_map_keys = 1
-- nmap <leader>p <Plug>yankstack_substitute_older_paste
-- nmap <leader>P <Plug>yankstack_substitute_newer_paste

-- Syntax Tree Surfer

local set_surfer_swap = function (keys, func)
  vim.keymap.set("n", keys, function()
    vim.opt.opfunc = func
    return "g@l"
  end, {silent=true, expr=true})
end

-- -- Normal Mode Swapping:
-- -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
-- set_surfer_swap("<M-k>", "v:lua.STSSwapUpNormal_Dot") -- vd, vu, vD, vU
-- set_surfer_swap("<M-j>", "v:lua.STSSwapDownNormal_Dot")
--
-- -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
-- set_surfer_swap("<M-h>", "v:lua.STSSwapCurrentNodePrevNormal_Dot")
-- set_surfer_swap("<M-l>", "v:lua.STSSwapCurrentNodeNextNormal_Dot")
--
--
-- local opts = {noremap = true, silent = true}
-- -- Visual Selection from Normal Mode
-- vim.keymap.set("n", "vx", '<cmd>STSSelectMasterNode<cr>', opts)
-- vim.keymap.set("n", "vn", '<cmd>STSSelectCurrentNode<cr>', opts)
--
-- -- Select Nodes in Visual Mode
-- vim.keymap.set("x", "L", '<cmd>STSSelectNextSiblingNode<cr>', opts)
-- vim.keymap.set("x", "H", '<cmd>STSSelectPrevSiblingNode<cr>', opts)
-- vim.keymap.set("x", "K", '<cmd>STSSelectParentNode<cr>', opts)
-- vim.keymap.set("x", "J", '<cmd>STSSelectChildNode<cr>', opts)
--
-- -- Swapping Nodes in Visual Mode
-- vim.keymap.set("x", "<M-k>", '<cmd>STSSwapPrevVisual<cr>', opts)
-- vim.keymap.set("x", "<M-j>", '<cmd>STSSwapNextVisual<cr>', opts)


-- vim.cmd.packadd "targets.vim"
-- vim.cmd.packadd "nvim-treesitter-textobjects"
-- require "nvim-treesitter.configs".setup {
  -- 	ensure_instaled = {"c", "lua", "vim"},
  -- 	-- highlight = { enable = true },
  -- 	highlight = { enable = not is_vscode },
  -- 	textsubjects = {
    -- 		enable = false,
    -- 		prev_selection = ',',
    -- 		keymaps = {
      -- 			['.'] = 'textsubjects-smart',
      -- 			[';'] = 'textsubjects-container-outer',
      -- 			['i;'] = 'textsubjects-container-inner',
      -- 		},
      -- 	},
      -- 	textobjects = {
      -- 		select = {
        -- 			enable = false,
        --
        -- 			-- Automatically jump forward to textobj, similar to targets.vim
        -- 			lookahead = true,
        --
        -- 			keymaps = {
          -- 				-- You can use the capture groups defined in textobjects.scm
          -- 				["af"] = "@function.outer",
          -- 				["if"] = "@function.inner",
          -- 				["ac"] = "@class.outer",
          -- 				-- You can optionally set descriptions to the mappings (used in the desc parameter of
          -- 				-- nvim_buf_set_keymap) which plugins like which-key display
          -- 				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          -- 			},
          -- 			-- You can choose the select mode (default is charwise 'v')
          -- 			--
          -- 			-- Can also be a function which gets passed a table with the keys
          -- 			-- * query_string: eg '@function.inner'
          -- 			-- * method: eg 'v' or 'o'
          -- 			-- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- 			-- mapping query_strings to modes.
          -- 			selection_modes = {
            -- 				['@parameter.outer'] = 'v', -- charwise
            -- 				['@function.outer'] = 'V', -- linewise
            -- 				['@class.outer'] = '<c-v>', -- blockwise
            -- 			},
            -- 			-- If you set this to `true` (default is `false`) then any textobject is
            -- 			-- extended to include preceding or succeeding whitespace. Succeeding
            -- 			-- whitespace has priority in order to act similarly to eg the built-in
            -- 			-- `ap`.
            -- 			--
            -- 			-- Can also be a function which gets passed a table with the keys
            -- 			-- * query_string: eg '@function.inner'
            -- 			-- * selection_mode: eg 'v'
            -- 			-- and should return true of false
            -- 			include_surrounding_whitespace = true,
            -- 		},
            -- 	},
            -- }


--- *** Not for VSCode: colorschemes and insert stuff ***
if not is_vscode then
  vim.opt.showtabline = 2
  vim.opt.number = true

  vim.cmd.packadd "kanagawa.nvim"
  vim.cmd.colorscheme "kanagawa"

  vim.cmd.packadd "undotree"
  vim.keymap.set("n", "<leader>u", ":UndotreeShow<cr>", {})

  vim.cmd.packadd "better-escape.nvim"
  require "better_escape".setup {
    mapping = {"jk"},
    keys = "<esc>`^",
  }
  vim.cmd.packadd "nvim-autopairs"
  require "nvim-autopairs".setup {}

  -- vim.cmd.packadd "live-command.nvim"
  -- require("live-command").setup {
    -- 	commands = {
      -- 		Norm = { cmd = "norm" },
      -- 		G = {cmd = "g"},
      -- 	},
      -- }
end
