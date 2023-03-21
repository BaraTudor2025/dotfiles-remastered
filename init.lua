--
-- *** CONFIGVRVM PERSONALISAETVM ***
--
-- if true then return {} end

vim.keymap.set({ "n", "v", "o" }, ":", ";", {})
vim.keymap.set({ "n", "v", "o" }, ";", ":", {})

if vim.fn.exists "g:neovide" then
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_animation_length = 0 --secunde, def=0.13
  vim.g.neovide_cursor_trail_length = 0 --def=0.8

  -- vim.g.neovide_scroll_animation_length = 0
  -- vim.g.neovide_scroll_animation_length = 0.2 --def=0.3

  -- vim.g.neovide_cursor_antialiasing = true --default=true
  -- vim.g.neovide_cursor_animation_length = 0.13 --secunde, def=0.13
  -- vim.g.neovide_cursor_trail_length = 0.8 --def=0.8

  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  -- vim.g.neovide_cursor_vfx_opacity=200.0
  -- vim.g.neovide_cursor_vfx_particle_lifetime=1.0
  -- vim.g.neovide_cursor_vfx_particle_density=7.0
  -- vim.g.neovide_cursor_vfx_particle_speed=10.0
end

---@param tbl table nested table
---@param output? table optional value to assign the flattened result, if nil then return it
---@return table # the flattened table
function flatten_table(tbl, output)
  local result = output or {}
  for _, inner in ipairs(tbl) do
    for k, v in pairs(inner) do
      if type(k) == "number" then
        table.insert(result, v) --['plugin.nvim'] = {...}
      else
        result[k] = v -- {'plugin.nvim', ...}
      end
    end
  end
  return result
end

local function readFileSync(path)
  local uv = vim.loop
  local fd = assert(uv.fs_open(path, "r", 438))
  local stat = assert(uv.fs_fstat(fd))
  local data = assert(uv.fs_read(fd, stat.size, 0))
  assert(uv.fs_close(fd))
  return data
end

local maps = require "user.maps"
local plugins = require "user.plugins"

local tokyonight_style = {
  "storm",
  "night",
  "day",
}

local catppuccin_flavour = {
  "latte",
  "frappe",
  "macchiato",
  "mocha",
}
local gruvbox_flat_style = {
  "", --default
  "dark",
  "hard",
}
local gruvbox_material_background = {
  "soft",
  "medium",
  "hard",
}
local gruvbox_material_foreground = {
  "material",
  "mix",
  "original",
}

-- mai multe culor, vezi :help
local gruvbox_material_menu_selection_background = {}
local gruvbox_material_visual = {}

--[[
abbrev	ab	next	n	unabbrev	una
append	a	number	nu	undo	u
args	ar	open	o	unmap	unm
change	c	preserve	pre	version	ve
copy	co	print	p	visual	vi
delete	d	put	pu	write	w
edit	e	quit	q	xit	x
file	f	read	re	yank	ya
global	g	recover	rec	window	z
insert	i	rewind	rew	escape	!
join	j	set	se	lshift	<
list	l	shell	sh	print next	CR
mark	ma	stop	st	rshift	>
move	m	substitute	s	scroll	^D

source	so	resubst	&

n	line n	/pat	next with pat
&.	current	?pat	previous with pat
$	last	x-n	n before x
+	next	x,y	x through y
-	previous	'x	marked with x
+n	n forward	 -n previous context
%	1,$

--]]

local ok, last_color = pcall(require, "last-color")
local theme = "kanagawa"
if ok then theme = last_color.recall() or theme end

local config = {

  colorscheme = theme,
  -- set key-maps
  mappings = maps.mappings,
  ["which-key"] = maps.which_key,

  plugins = plugins,

  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
  },

  options = {
    g = {
      -- ts_highlight_lua = true,
      catppuccin_flavour = catppuccin_flavour[4],
      gruvbox_flat_style = gruvbox_flat_style[2],
      tokyonight_style = tokyonight_style[1],
      gruvbox_material_background = gruvbox_material_background[2],
      gruvbox_material_foreground = gruvbox_material_foreground[2],
    },
    o = {
      -- foldcolumn = '1',
      -- foldlevel = 99,
      -- foldlevelstart = 99,
      -- shellslash = true,
      ruler = false,
      foldenable = true,
      background = "dark",
      -- autochdir = true,
      cdpath = "**/*",
      undofile = false,
      mouse = "a",
      wildmenu = true,
      gdefault = true,
      guifont = "FiraCode Nerd Font Mono:h10",
      -- guifont = "CaskaydiaCove NF:h13"
      -- guifont = "FiraCode NF,Cascadia Code:h13",
      -- guifont = "DejaVuSansMono NF:h12",
      --guifont=Consolas:h14
      --guifont=Cascadia\ Code:h14
    },
    opt = {
      -- backspace = { "indent", "eol" },
      cmdheight = 1,
      completeopt = { "menu", "menuone", "noselect" },
    },
  },
  lsp = {
    mappings = {
      n = {
        ["gl"] = false,
      },
    },
  },

  -- *** Polish ***
  polish = function()
    local config_path = vim.fn.stdpath "config" .. "/lua/user/"
    -- vim.cmd("AniseedEvalFile " .. config_path .. "fennel-au.fnl")
    require("aniseed.eval").str(readFileSync(config_path .. "fennel-au.fnl"))
    vim.cmd [[let maplocalleader=","]]
    local diag_active = true
    vim.keymap.set("n", "<leader>ll", function()
      diag_active = not diag_active
      if diag_active then
        vim.diagnostic.show()
      else
        vim.diagnostic.hide()
      end
    end, { desc = "Toggle buffer Diagnostics" })

    vim.keymap.set({ "i", "c" }, "<c-v>", "<c-r>+", {})
    vim.keymap.set("v", ".", ":normal .<cr>")
    vim.keymap.set({ "n", "v", "o" }, ":", ";", {})
    vim.keymap.set({ "n", "v", "o" }, ";", ":", {})
    vim.keymap.set("n", "<leader>r", "<cmd>SnipRun<cr>", { desc = "Run Snippet" })
    vim.keymap.set("v", "<leader>r", ":SnipRun<cr>", { desc = "Run Snippet" })
    vim.keymap.set("n", "<leader>R", "<cmd>SnipClose<cr>", {})

    -- vim.cmd [[xnoremap <leader>r <cmd>'<,'>so %<cr>]]
    vim.keymap.set("n", "H", "<cmd>tabprev<cr>", { silent = true, noremap = true })
    vim.keymap.set("n", "L", "<cmd>tabnext<cr>", { silent = true, noremap = true })

    -- _IsToggleQuickWords = true
    -- vim.api.nvim_create_user_command("ToggleInnerWordMotion", function()
    --   if _IsToggleQuickWords then
    --     vim.cmd [[
    --      map <Plug>(smartword-basic-w)  w
    --      map <Plug>(smartword-basic-b)  b
    --      map <Plug>(smartword-basic-e)  e
    --      map <Plug>(smartword-basic-ge)  ge
    --      ]]
    --   else
    --     vim.cmd [[
    --      map <Plug>(smartword-basic-w)  <Plug>WordMotion_w
    --      map <Plug>(smartword-basic-b)  <Plug>WordMotion_b
    --      map <Plug>(smartword-basic-e)  <Plug>WordMotion_e
    --      map <Plug>(smartword-basic-ge)  <Plug>WordMotion_ge
    --      ]]
    --   end
    --   _IsToggleQuickWords = not _IsToggleQuickWords
    -- end, {})

    -- vim.api.nvim_create_autocmd(
    --   "ColorScheme",
    --   { pattern = "*", callback = function() require("leap").init_highlight(true) end }
    -- )
    -- declare_maps()
  end,

  -- *** cmp Config ***
  cmp = {
    source_priority = {
      -- cand lua-dev este disabled, foloseste nvim_lua, altfel foloseste *lsp*
      -- nvim_lua = DisableLuaDev and 1000 or 1,
      -- nvim_lsp = DisableLuaDev and 950 or 1000,
      nvim_lua = false,
      nvim_lsp = 900,

      conjure = 910,
      luasnip = 750,

      -- neorg = 700,
      buffer = 500,

      emoji = 400,
      greek = 400,

      path = 260,

      cmdline = 500,
    },

    setup = function()
      ---@diagnostic disable-next-line: different-requires
      local cmp = require "cmp"

      return {
        cmdline = {
          [":"] = {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
          },

          ["/"] = {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = "buffer" },
            },
          },
        },
      }
    end,
  },

  -- lsp = {
  --   server_registration = function(server, opts)
  --     local lspconfig = require('lspconfig')
  --     lspconfig[server].setup(opts)
  -- if server == 'sumneko_lua' then
  --   local dev = require('lua-dev').setup {
  --     -- lspconfig = {
  --     --   cmd = {'lua-language-server'},
  --     -- },
  --   }
  --   lspconfig.sumneko_lua.setup(dev)
  -- else
  --   lspconfig[server].setup(opts)
  -- end
  --   end,
  -- },
}

return config
