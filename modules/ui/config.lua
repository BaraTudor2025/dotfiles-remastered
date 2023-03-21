local M = {}

function M.gui_font_resize()
  require("gui-font-resize").setup()
  vim.keymap.set("n", "<a-->", "<cmd>GUIFontSizeDown<cr>")
  vim.keymap.set("n", "<a-=>", "<cmd>GUIFontSizeUp<cr>")
end

function M.galaxyline()
  -- require('user.modules.ui.galaxyline').galaxyline()
  -- require('user.modules.ui.gal_conf')
end

function M.hlslens()
  require("hlslens").setup {
    calm_down = true,
  }
  local kopts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap(
    "n",
    "n",
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts
  )
  vim.api.nvim_set_keymap(
    "n",
    "N",
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts
  )
  vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
  vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
  vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
  vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
end

-- buffers
function M.jabs()
  require("jabs").setup {
    position = "corner",
    -- width = 80, -- default 50
    -- height = 20, -- default 10
    border = "rounded",
    preview = {
      border = "rounded",
    },
    keymap = {
      preview = "p",
      close = "D",
      h_split = "s",
      v_split = "v",
    },
  }
end

function M.noice()
  require("noice").setup {
    cmdline = {
      view = "cmdline_popup", -- cmdline[_popup]
    },
    popupmenu = {
      enabled = false, -- has already cmp-cmdline
    },
    notify = {
      enabled = false,
    },
    views = {
      split = {
        enter = true,
      },
    },
  }
end

function M.Ranger()
  vim.keymap.set("n", "<m-o>", ":RnvimrToggle<cr>")
  vim.keymap.set("t", "<m-o>", "<c-\\><c-n>:RnvimrToggle<cr>")
  vim.g.rnvimr_enable_picker = 1
end

return M
