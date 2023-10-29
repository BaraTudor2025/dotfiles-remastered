return {
  colorscheme = "kanagawa",
  options = {
    opt = {
      cmdheight = 1,
      swapfile = false,
      guifont = { "FiraCode NF", ":h12" }, -- NFM
      gdefault = true,
    },
  },

  polish = function()
    vim.cmd "highlight LspReferenceText guibg=none"
    vim.api.nvim_create_user_command("W", "w", {})

    local path = vim.fn.stdpath "config" .. "/lua/user/"
    if vim.g.vscode == nil then vim.cmd.so(path .. "aucmd.vim") end

    vim.opt.path:append "**/*"
    vim.opt.path:append "**"
    vim.opt.path:append "*"
    vim.filetype.add {
      extension = {
        h = "c",
      },
    }
  end,
}
