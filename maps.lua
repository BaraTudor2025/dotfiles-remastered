--- *** Config Mappings ***

local cmd = function(arg) return "<cmd>" .. arg .. "<cr>" end

local scripts = require "user.scripts"

--- *** REMINTER <c-o> pentru Normal-Insert ***

-- use [I for <cword> search  si dupa selecteaza la care dai jump
-- :map <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " .. nr .. "[\t"<CR>

_BaraHlSet = nil
-- *** Mappings ***
local mappings = {
  i = {
    -- ["<c-cr>"] = { "<end><cr>" },
    -- ['<c-v>'] = {'<c-r>+', remap=false},
  },
  x = {
    -- Run Selection
    -- ["<leader>r"] = {scripts.run_lua_selection, desc="Run Lua Selection"},
  },
  n = {
    -- ["<c-cr>"] = { "m'i<CR><Esc>`'" },
    zh = { cmd "HydraSideScroll", desc = "Hydra Side Scroll" },
    zl = { cmd "HydraSideScroll", desc = "Hydra Side Scroll" },
    zH = { cmd "HydraSideScroll", desc = "Hydra Side Scroll" },
    zL = { cmd "HydraSideScroll", desc = "Hydra Side Scroll" },

    gh = { "^", desc = "Goto Beginning of Line" },
    gl = { "$", desc = "Goto End of Line" },
    go = { scripts.custom_toc, desc = "Show ** TOC ** for this file" },
    gm = {
      function()
        ---@diagnostic disable-next-line: missing-parameter
        vim.cmd("vertical botright help " .. vim.fn.expand "<cword>")
      end,
      desc = "goto help <word under cursor>",
    },

    ["<leader>c"] = { cmd "Bdelete", desc = "Buffer Del" },
    -- ['<c-/>'] = { '<leader>/', remap = true},

    -- ["<leader>pr"] = { cmd "AstroReload", desc = "Astro Reload" },
    -- ["<leader>pe"] = { cmd "EditUserConfig", desc = "Open user config" },
    -- ["<leader>pf"] = { cmd "Telescope packer", desc = "Packer in Telescope" },

    -- Windows & Buffers & Tabs
    ["<leader>w"] = { cmd "HydraWindow", desc = "Windows" },
    ["<c-w>"] = { cmd "HydraWindow", desc = "Windows" },
    ["<leader>b"] = { cmd "JABSOpen", desc = "Buffers" },
    H = { cmd "tabprev", desc = "Prev Tab" },
    L = { cmd "tabnext", desc = "Next Tab" },

    -- NeoGit
    ["<leader>gn"] = { cmd "Neogit", desc = "->> NeoGIT <<-" },

    -- TreeSitter Swap
    -- ["<a-h>"] = { cmd "TSTextobjectSwapPrevious @parameter.inner", desc = "swap prev Param" },
    -- ["<a-l>"] = { cmd "TSTextobjectSwapNext @parameter.inner", desc = "swap next Param" },
    -- ["<a-b>"] = { cmd "TSTextobjectSwapPrevious @block.inner", desc = "swap prev Block" },
    -- ["<a-n>"] = { cmd "TSTextobjectSwapNext @block.inner", desc = "swap next Block" },
    -- ['<a-h>'] = { cmd "TSTextobjectSwapPrevious @", desc = "swap prev " },
    -- ['<a-l>'] = { cmd "TSTextobjectSwapNext @", desc = "swap next " },

    -- True Zen
    ["<leader>zn"] = { cmd "TZNarrow", desc = "True-Zen Narrow" },
    ["<leader>zf"] = { cmd "TZFocus", desc = "True-Zen Focus" },
    ["<leader>zm"] = { cmd "TZMinimalist", desc = "True-Zen Minimalist" },
    ["<leader>za"] = { cmd "TZAtaraxis", desc = "True-Zen Only Window" },

    -- Telescope
    ["<leader>ss"] = { cmd "Telescope", desc = "Open Telescope" },
    ["<leader>sb"] = { cmd "Telescope current_buffer_fuzzy_find", desc = "Fuzzy find inside buffer" },

    ["<leader>?"] = { cmd "Cheatsheet", desc = "Cheat-Sheet" },

    -- Command Palette
    ["<c-p>"] = { cmd "Telescope command_palette", desc = "Command Palette" },

    -- LSP
    -- gt = { "<c-]>" },
    -- ['<c-n>'] = { function () vim.diagnostic.goto_next() end, desc = 'Next diagnostic' },
    -- ['<c-p>'] = { function () vim.diagnostic.goto_prev() end, desc = 'Prev diagnostic' },

    ["<leader>H"] = { ":set hlsearch<cr>", desc = "Enable Highlight" },

    ["<leader>mm"] = "<cmd>Harpoon<cr>",
    ["<leader>ma"] = "<cmd>Mark<cr>",
    ["<leader>mj"] = { function() require("harpoon.ui").nav_prev() end, desc = "Prev" },
    ["<leader>mk"] = { function() require("harpoon.ui").nav_next() end, desc = "Next" },

    -- ["<leader>"] = {},

    -- vim.cmd [[
    -- nnoremap <leader>S <cmd>lua require('spectre').open()<CR>
    --
    -- "search current word
    -- nnoremap <leader>sw <cmd>lua require('spectre').open_visual({select_word=true})<CR>
    -- vnoremap <leader>s <esc>:lua require('spectre').open_visual()<CR>
    -- "  search in current file
    -- nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>
    -- ]]
  },
}

-- *** Which Key ***
local which_key = {
  register = {
    n = {
      ["<leader>"] = {
        z = { name = "True Zen" },
        m = { name = "Harpoon" },

        -- p = {
        --   -- Reload Astro
        --   r = { cmd "AstroReload", desc = "Astro Reload" },
        --   f = { cmd "Telescope packer", desc = "Packer in Telescope" },
        -- },
      },
      -- f = "search 1 char in window",
      -- s = "search 2 chars in window",
      -- F = "Fuzzy find inside buffer",
      g = {
        a = "Easy Align",
        J = "Join (language syntax)",
        S = "Split (language syntax)",
        R = "RegexPlainer Toggle",
        P = "Close GoTo Preview",
        p = {
          name = "GoTo Preview",
          d = "GoTo Definition / gP Close",
          i = "GoTo Implementation",
          r = "GoTo References",
          t = "GoTo Type Definition",
        },
      },
    },
  },
}

return { mappings = mappings, which_key = which_key }
