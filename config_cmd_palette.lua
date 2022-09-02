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
    {"in calls", "Telescope lsp_incoming_calls"},
    {"out calls", "Telescope lsp_outgoing_calls"},
    {"buffer tags", "Telescope current_buffer_tags"},
    {"doc symbols", "Telescope lsp_document_symbols"},
    {"work symbols", "Telescope lsp_workspace_symbols"},
    {"dynamic workspace symbols", "Telescope lsp_dynamic_workspace_symbols"},
    {"definitions", "Telescope lsp_definitions"},
    {"definitions", "Trouble lsp_definitions"},
    {"type definitions", "Telescope lsp_type_definitions"},
    {"type definitions", "Trouble lsp_type_definitions"},
    {"implementations", "Trouble lsp_implementations"},
    {"implementations", "Telescope lsp_implementations"},
    {"references", "Telescope lsp_references"},
    {"references", "Trouble lsp_references"},
  },
  {"Diagnostics",
    {"refresh", "TroubleRefresh"},
    {"trouble loclist", "Trouble loclist"},
    {"trouble quickfix", "Trouble quickfix"},
    {"native loclist", "lua vim.diagnostic.setloclist()"},
    {"native quickfix", "lua vim.diagnostic.setqflist()"},
    {"All", "Telescope diagnostics"},
    {"workpace", "Trouble workspace_diagnostics"},
    {"document", "Trouble document_diagnostics"},
  },
  {"Git",
    {"commits", "Telescope git_commits"},
    {"buffer commits", "Telescope git_bcommits"},
    {"stash", "Telescope git_stash"},
    {"files", "Telescope git_files"},
    {"diff", "DiffviewOpen"},
    {"branches", "Telescope git_branches"},
    {"status", "Telescope git_status"},
  },
  {"Util & Mix",
    {"unicode & symbols", "Telescope symbols"},
    {"cwd to file absolute path", "cd %:p:h"},
    {"cwd to file relative path", "cd %:h"},
  },
  {"TodoComments",
    {"loclist", "TodoLocList"},
    {"quickfix", "TodoQuickFix"},
    {"Telescope", "TodoTelescope"},
    {"Trouble", "TodoTrouble"},
  },
  {"Help",
    { ":help", "Telescope help_tags"},
    { "tips", "help tips"},
    { "summary", "help summary" },
    { "quick reference", "help quickref" },
    { "cheatsheet", "help index" },
    { "telescope cheatsheet", "Cheatsheet"},
    { "tutorial", "help tutor" },
    { "man pages", "Telescope man_pages"},
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
