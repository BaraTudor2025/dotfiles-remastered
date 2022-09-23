local cmd = function (arg)
  return ':'..arg
end

--[[
--  Diff commit='1944d63' / codul meu
--  now accepts functions, also the string is by default an ex-command
  local cmd = selection.value[2]
  if type(cmd) == "string" then
    vim.api.nvim_command(selection.value[2])
  elseif type(cmd) == "function" then
    cmd()
  end
--]]

-- to add?
-- todo-comments
-- Harpoon
-- SearchBox?
-- Trouble
-- Packer + AstroReload + Mason + TS? + OpenUserConfig / Config Session
-- Vim/Options? like Hydra options
-- GitSigns?
-- vim.lsp.buf.document_symbol()
-- vim.lsp.buf.implementation()
-- vim.lsp.buf.incoming_calls()
-- vim.lsp.buf.outgoing_calls()
-- vim.lsp.buf.signature_help()
-- vim.lsp.buf.hover()
-- vim.lsp.rename()
-- vim.lsp.buf.rename()
-- vim.lsp.codelens.run()

return {
  {"LSP",
    {"Format All Sync", "vim.lsp.buf.formatting_seq_sync()"},
    {"Format Sync", "vim.lsp.buf.formatting_sync()"},
    {"Format Async", "vim.lsp.buf.formatting()"},
    {"Hover", "lua vim.lsp.buf.hover()"},
    {"Signature Help", "lua vim.lsp.buf.signature_help()"},
    {"Code Action", "lua vim.lsp.buf.code_action()"},
    {"In calls", "lua vim.lsp.buf.incoming_calls()"},
    {"In calls", "Telescope lsp_incoming_calls"},
    {"Out calls", "lua vim.lsp.buf.outgoing_calls()"},
    {"Out calls", "Telescope lsp_outgoing_calls"},
    {"Buffer tags", "Telescope current_buffer_tags"},
    {"Doc symbols", "Telescope lsp_document_symbols"},
    {"Doc symbols", "lua vim.lsp.buf.document_symbol()"},
    {"Work symbols", "Telescope lsp_workspace_symbols"},
    {"Dynamic workspace symbols", "Telescope lsp_dynamic_workspace_symbols"},
    {"Definitions", "Telescope lsp_definitions"},
    {"Definitions", "Trouble lsp_definitions"},
    {"Goto Definition", "lua vim.lsp.buf.definition()"},
    {"Type definitions", "Telescope lsp_type_definitions"},
    {"Type definitions", "Trouble lsp_type_definitions"},
    {"Goto Type Definition", "lua vim.lsp.buf.type_definition()"},
    {"Implementations", "Trouble lsp_implementations"},
    {"Implementations", "Telescope lsp_implementations"},
    {"Implementations", "lua vim.lsp.buf.implementation()"},
    {"References", "Telescope lsp_references"},
    {"References", "Trouble lsp_references"},
  },
  {"Diagnostics",
    {"Refresh", "TroubleRefresh"},
    {"Trouble loclist", "Trouble loclist"},
    {"Trouble quickfix", "Trouble quickfix"},
    {"Native loclist", "lua vim.diagnostic.setloclist()"},
    {"Native quickfix", "lua vim.diagnostic.setqflist()"},
    {"All", "Telescope diagnostics"},
    {"Open Float", "lua vim.diagnostic.open_float()"},
    {"Workpace", "Trouble workspace_diagnostics"},
    {"Document", "Trouble document_diagnostics"},
  },
  {"Git",
    {"Commits", "Telescope git_commits"},
    {"Buffer commits", "Telescope git_bcommits"},
    {"Stash", "Telescope git_stash"},
    {"Files", "Telescope git_files"},
    {"Diff", "DiffviewOpen"},
    {"Branches", "Telescope git_branches"},
    {"Status", "Telescope git_status"},
  },
  {"Util & Mix",
    {"Unicode & symbols", "Telescope symbols"},
    {"Cwd to file absolute path", "cd %:p:h"},
    {"Cwd to file relative path", "cd %:h"},
  },
  {"TodoComments",
    {"Loclist", "TodoLocList"},
    {"Quickfix", "TodoQuickFix"},
    {"Telescope", "TodoTelescope"},
    {"Trouble", "TodoTrouble"},
  },
  {"Help",
    { ":help", "Telescope help_tags"},
    { "Tips", "help tips"},
    { "Summary", "help summary" },
    { "Quick reference", "help quickref" },
    { "Cheatsheet", "help index" },
    { "Telescope cheatsheet", "Cheatsheet"},
    { "Tutorial", "help tutor" },
    { "Man pages", "Telescope man_pages"},
  },
  {"Vim",
    { "autocommands", "Telescope autocommands"},
    { "options", "Telescope autocommands"},
    { ":help", "Telescope help_tags"},
    { "highlights", "Telescope highlights"},
    { "registers", "Telescope registers"},
    { "marks", "Telescope marks"},
    { "commands", "Telescope commands"},
    { "tags", "Telescope tags"},
    { "tagstack", "Telescope tagstack"},
    { "loclist", "Telescope loclist"},
    { "quickfix", "Telescope quickfix"},
    { "quickfix history", "Telescope quickfixhistory"},
    { "search history", "Telescope search_history"},
    { "command history", "Telescope command_history"},
    { "jumplist", "Telescope jumplist"},
    { "keymaps", "Telescope keymaps"},
  },
  {"Regexplainer",
    { "Toggle", "RegexplainerToggle"},
    { "Show", "RegexplainerShow"},
    { "ShowPopup", "RegexplainerShowPopup"},
    { "Hide", "RegexplainerHide"},
  },
  {"Zen",
    {'Narrow', "TZNarrow"},
    {'Focus', "TZFocus"},
    {'Minimalist', "TZMinimalist"},
    {'Only Window', "TZAtaraxis"},
  },
  {"Dap",
    { "pause", ":lua require'dap'.pause()" },
    { "step into", ":lua require'dap'.step_into()" },
    { "step back", ":lua require'dap'.step_back()" },
    { "step over", ":lua require'dap'.step_over()" },
    { "step out", ":lua require'dap'.step_out()" },
    { "frames", ":lua require'telescope'.extensions.dap.frames{}" },
    { "current scopes", ":lua ViewCurrentScopes(); vim.cmd(\"wincmd w|vertical resize 40\")" },
    { "current scopes floating window", ":lua ViewCurrentScopesFloatingWindow()" },
    { "current value floating window", ":lua ViewCurrentValueFloatingWindow()" },
    { "commands", ":lua require'telescope'.extensions.dap.commands{}" },
    { "configurations", ":lua require'telescope'.extensions.dap.configurations{}" },
    { "repl", ":lua require'dap'.repl.open(); vim.cmd(\"wincmd w|resize 12\")" },
    { "close", ":lua require'dap'.close(); require'dap'.repl.close()" },
    { "run to cursor", ":lua require'dap'.run_to_cursor()" },
    { "continue", ":lua require'dap'.continue()" },
    { "clear breakpoints", ":lua require('dap.breakpoints').clear()" },
    { "brakpoints", ":lua require'telescope'.extensions.dap.list_breakpoints{}" },
    { "toggle breakpoint", ":lua require'dap'.toggle_breakpoint()" },
  },
}
