require "paq" {
	"savq/paq-nvim",

	"mbbill/undotree",
	"maxbrunsfeld/vim-yankstack",
	-- add change-case, tpope?

	"kylechui/nvim-surround",
	"yuki-yano/zero.nvim",
	"numToStr/Comment.nvim",
	"smjonas/live-command.nvim",

	{"rebelot/kanagawa.nvim", opt=true },

	{"wellle/targets.vim", opt=true},

	{"nvim-treesitter/nvim-treesitter"},
	{"nvim-treesitter/nvim-treesitter-textobjects", opt=true},
	{"RRethy/nvim-treesitter-textsubjects"},
	{"ziontee113/syntax-tree-surfer"},

	{"max397574/better-escape.nvim", opt=true},
	{"windwp/nvim-autopairs", opt=true},
} 

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamed"

vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.wildmode = {"longest", "full"}
vim.opt.pumheight = 15

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.copyindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true


vim.cmd [[let mapleader="\<space>"]]

vim.cmd [[map K <nop>]] -- 0.8 freeze, neovide, wtf
vim.keymap.set({"n"}, ";", ":", {})
--vim.keymap.set({"n", "v"}, "gh", "0", {})
-- vim.keymap.set({"n", "v"}, "gl", "$", {remap=true})
-- vim.keymap.set({"n", "v"}, "-", "0", {remap=true})
vim.keymap.set({"n", "v"}, "H", "0", {remap=true})
vim.keymap.set({"n", "v"}, "L", "$", {remap=true})
vim.keymap.set("n", "<leader>u", ":UndotreeShow<cr>", {})
vim.keymap.set("n", "<leader>h", ":noh<cr>", {})

require "zero".setup()
require "Comment".setup{}
require "nvim-surround".setup{}
require("live-command").setup {
	commands = {
		Norm = { cmd = "norm" },
		G = {cmd = "g"},
	},
}
require("syntax-tree-surfer").setup()

-- Syntax Tree Surfer

local set_surfer_swap = function (keys, func)
	vim.keymap.set("n", keys, function()
		vim.opt.opfunc = func
		return "g@l"
	end, {silent=true, expr=true})
end

-- Normal Mode Swapping:
-- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
set_surfer_swap("<M-k>", "v:lua.STSSwapUpNormal_Dot") -- vd, vu, vD, vU
set_surfer_swap("<M-j>", "v:lua.STSSwapDownNormal_Dot")

-- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
set_surfer_swap("<M-h>", "v:lua.STSSwapCurrentNodePrevNormal_Dot")
set_surfer_swap("<M-l>", "v:lua.STSSwapCurrentNodeNextNormal_Dot")


local opts = {noremap = true, silent = true}
-- Visual Selection from Normal Mode
vim.keymap.set("n", "vx", '<cmd>STSSelectMasterNode<cr>', opts)
vim.keymap.set("n", "vn", '<cmd>STSSelectCurrentNode<cr>', opts)

-- Select Nodes in Visual Mode
vim.keymap.set("x", "L", '<cmd>STSSelectNextSiblingNode<cr>', opts)
vim.keymap.set("x", "H", '<cmd>STSSelectPrevSiblingNode<cr>', opts)
vim.keymap.set("x", "K", '<cmd>STSSelectParentNode<cr>', opts)
vim.keymap.set("x", "J", '<cmd>STSSelectChildNode<cr>', opts)

-- Swapping Nodes in Visual Mode
vim.keymap.set("x", "<M-k>", '<cmd>STSSwapPrevVisual<cr>', opts)
vim.keymap.set("x", "<M-j>", '<cmd>STSSwapNextVisual<cr>', opts)

vim.cmd.packadd "targets.vim"
vim.cmd.packadd "nvim-treesitter-textobjects"
require "nvim-treesitter.configs".setup {
	ensure_instaled = {"c", "lua", "vim", "help", "json", "toml", "rust", "python", "julia"},
	-- highlight = { enable = true },
	highlight = { enable = not vim.g.vscode },
	textsubjects = {
		enable = true,
		prev_selection = ',',
		keymaps = {
			['.'] = 'textsubjects-smart',
			[';'] = 'textsubjects-container-outer',
			['i;'] = 'textsubjects-container-inner',
		},
	},
	textobjects = {
		select = {
			enable = false,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				-- You can optionally set descriptions to the mappings (used in the desc parameter of
				-- nvim_buf_set_keymap) which plugins like which-key display
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
			},
			-- You can choose the select mode (default is charwise 'v')
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * method: eg 'v' or 'o'
			-- and should return the mode ('v', 'V', or '<c-v>') or a table
			-- mapping query_strings to modes.
			selection_modes = {
				['@parameter.outer'] = 'v', -- charwise
				['@function.outer'] = 'V', -- linewise
				['@class.outer'] = '<c-v>', -- blockwise
			},
			-- If you set this to `true` (default is `false`) then any textobject is
			-- extended to include preceding or succeeding whitespace. Succeeding
			-- whitespace has priority in order to act similarly to eg the built-in
			-- `ap`.
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * selection_mode: eg 'v'
			-- and should return true of false
			include_surrounding_whitespace = true,
		},
	},
}


--- *** Not for VSCode: colorschemes and insert stuff ***
if not vim.g.vscode then 
	vim.opt.showtabline = 2
	vim.opt.number = true

	vim.cmd.packadd "kanagawa.nvim"
	vim.cmd.colorscheme "kanagawa"

	vim.cmd.packadd "better-escape.nvim"
	require "better_escape".setup {
		mapping = {"jk"},
		keys = "<esc>`^",
	}
	vim.cmd.packadd "nvim-autopairs"
	require "nvim-autopairs".setup {} 
end
