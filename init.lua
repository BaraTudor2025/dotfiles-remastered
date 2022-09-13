--
--
-- *** CONFIGVRVM PERSONALISAETVM ***
--

if vim.fn.exists('g:neovide') then
  vim.g.neovide_remember_window_size = true

  -- vim.g.neovide_scroll_animation_length = 0.2 --def=0.3

  -- vim.g.neovide_cursor_antialiasing = true --default=true
  vim.g.neovide_cursor_animation_length = 0 --secunde, def=0.13
  vim.g.neovide_cursor_trail_length = 0 --def=0.8

  -- vim.g.neovide_cursor_vfx_mode = "pixiedust"
  -- vim.g.neovide_cursor_vfx_opacity=200.0
  -- vim.g.neovide_cursor_vfx_particle_lifetime=1.0
  -- vim.g.neovide_cursor_vfx_particle_density=7.0
  -- vim.g.neovide_cursor_vfx_particle_speed=10.0
end

local keys = require('user.keys')
local plugins = require('user.plugins')

local tokyonight_style = {
  'storm',
  'night',
  'day',
}

local catppuccin_flavour = {
  'latte',
  'frappe',
  'macchiato',
  'mocha',
}
local gruvbox_flat_style = {
  '', --default
  'dark',
  'hard',
}
local gruvbox_material_background = {
  'soft',
  'medium',
  'hard',
}
local gruvbox_material_foreground = {
  'material',
  'mix',
  'original',
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

-- apple   =red
-- grass+=green
-- sky-=   blue

--]]

_IsToggleQuickWords = true
vim.api.nvim_create_user_command('ToggleInnerWordMotion', function()
  if _IsToggleQuickWords then
    vim.cmd [[
	  map <Plug>(smartword-basic-w)  w
	  map <Plug>(smartword-basic-b)  b
	  map <Plug>(smartword-basic-e)  e
	  map <Plug>(smartword-basic-ge)  ge
	  ]]
  else
    vim.cmd [[
	  map <Plug>(smartword-basic-w)  <Plug>WordMotion_w
	  map <Plug>(smartword-basic-b)  <Plug>WordMotion_b
	  map <Plug>(smartword-basic-e)  <Plug>WordMotion_e
	  map <Plug>(smartword-basic-ge)  <Plug>WordMotion_ge
	  ]]
  end
  _IsToggleQuickWords = not _IsToggleQuickWords
end, {})

vim.api.nvim_create_autocmd('ColorScheme', { pattern = "*",
  callback = function() require('leap').init_highlight(true) end })

local config = {

  colorscheme = "kanagawa",

  -- set key-maps
  mappings = keys.mappings,
  ["which-key"] = keys.which_key,

  plugins = plugins,

  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    -- version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    -- branch = "v2", -- branch name (NIGHTLY ONLY)
    -- commit = nil, -- commit hash (NIGHTLY ONLY)
    -- pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    -- skip_prompts = false, -- skip prompts about breaking changes
    -- show_changelog = true, -- show the changelog after performing an update
    -- auto_reload = false, -- automatically reload and sync packer after a successful update
    -- auto_quit = false, -- automatically quit the current session after a successful update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  options = {
    g = {
      -- do_legacy_filetype = 0,
      --do_filetype_lua = 1,
      --did_load_filetypes = 1,
      ts_highlight_lua = true,
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
      background = 'dark',
      -- autochdir = true,
      cdpath = '**/*',
      undofile = false,
      mouse = 'a',
      wildmenu = true,
      gdefault = true,
      guifont = "CaskaydiaCove NF:h13"
      -- guifont = "FiraCode NF,Cascadia Code:h13",
      -- guifont = "DejaVuSansMono NF:h12",
      --guifont=Consolas:h14
      --guifont=Cascadia\ Code:h14

    },
    opt = {
      cmdheight = 1,
      completeopt = { 'menu', 'menuone', 'noselect' },
    }
  },

  -- *** Polish ***
  polish = function()
    vim.opt.path:append('**/*')
    vim.keymap.set({ 'i', 'c' }, '<c-v>', '<c-r>+', {})
    vim.api.nvim_create_user_command('ExModeEnter', function() vim.fn.feedkeys('gQ', 'n') end, {})
    vim.api.nvim_create_user_command('ExModeExit', function() vim.cmd 'visual' end, {})
    vim.cmd 'command! Redir Bufferize'
    -- vim.cmd [[xnoremap <leader>r <cmd>'<,'>so %<cr>]]
    vim.cmd [[
    augroup relative_num
        autocmd! InsertEnter * set norelativenumber
        autocmd! InsertLeave * set relativenumber
    augroup END
    ]]
    vim.keymap.set('n', 'H', '<cmd>tabprev<cr>', { silent = true, noremap = true })
    vim.keymap.set('n', 'L', '<cmd>tabnext<cr>', { silent = true, noremap = true })
    -- setup_cmd_output_history()

    local general_au = vim.api.nvim_create_augroup("general_au", { clear = true })
    -- face un *blink* cand dau copy
    vim.api.nvim_create_autocmd('TextYankPost', {
      group = general_au,
      callback = function()
        -- vim.highlight.on_yank {higroup='TabLineSel', timeout=200}
        vim.highlight.on_yank { higroup = 'Search', timeout = 200 }
      end,
    })
    vim.api.nvim_create_autocmd('FileType', {
      group = general_au,
      pattern = 'qf',
      command = 'set nobuflisted'
    })
    vim.api.nvim_create_autocmd('FileType', {
      group = general_au,
      pattern = { 'qf', 'help', 'man', 'lspinfo' },
      command = 'nnoremap <silent> <buffer> q <cmd>close<cr>'
    })

    local PackerHooks = vim.api.nvim_create_augroup('PackerHooks', { clear = true })
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PackerCompileDone',
      callback = function()
        vim.notify('Compile Done!', vim.log.levels.INFO, { title = 'Packer' })
      end,
      group = PackerHooks,
    })

    local this_file = 'C:/Users/BaraTudor/AppData/Local/nvim/lua/user/init.lua' --vim.fn.expand('<sfile>:p') --
    vim.api.nvim_create_user_command(
      "EditUserConfig",
      "edit " .. this_file,
      {}
    )
    -- declare_maps()
  end,

  -- *** cmp Config ***
  cmp = {
    source_priority = {
      -- cand lua-dev este disabled, foloseste nvim_lua, altfel foloseste *lsp*
      -- nvim_lua = DisableLuaDev and 1000 or 1,
      -- nvim_lsp = DisableLuaDev and 950 or 1000,
      nvim_lua = false,
      nvim_lsp = 1000,

      luasnip = 750,

      -- neorg = 700,
      buffer = 500,
      -- fuzzy_buffer = 500,

      emoji = 400,
      greek = 400,

      path = 260,
      -- fuzzy_path = 250,

      cmdline = 1000,
      cmdline_history = 10,
      -- calc = 400,
      -- dap = false,
    },

    setup = function()
      ---@diagnostic disable-next-line: different-requires
      local cmp = require 'cmp'

      return {
        cmdline = {
          [':'] = {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
              { { name = 'fuzzy_path' } },
              -- { { name = 'cmdline' } },
              -- { { name = 'cmdline_history' } }
              { { name = 'cmdline' }, { name = 'cmdline_history' } }
            ),
          },

          ['/'] = {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = 'fuzzy_buffer' },
            },
          }
        }
      }
    end
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
