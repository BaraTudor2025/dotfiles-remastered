vim.cmd [[
augroup relative_num
autocmd! InsertEnter * set norelativenumber
autocmd! InsertLeave * set relativenumber
augroup END
]]

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
