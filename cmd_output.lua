-- [[
--     *** Ex-Commands Output History
-- ]]

local telescope = require('telescope.actions')

--- @class CmdHistoryEntry
--- @field command string
--- @field output string

--- @type CmdHistoryEntry[]
CmdHistoryList = {}

-- @param opts table {output_max_len: int, history_max_len: int}
local function setup_cmd_output_history()
    local opts = {}
    opts.output_max_len = opts.output_max_len or 1000
    opts.history_max_len = opts.history_max_len or 100
    -- exclude lines that match this patterns
    --- @type CmdHistoryEntry[]
    opts.exclude_output = {'DevIconLua', 'Error', 'E%d%d%d:'}

    -- ?
    -- local exclude_command = {'w'}

    local augroup = vim.api.nvim_create_augroup("CmdHistory", {clear = true})

    -- local msgs = vim.fn.eval(':messages')

    -- starts recording
    vim.api.nvim_create_autocmd({"CmdlineEnter"}, {
        group = augroup,
        desc = "Start redirecting output to register",
        callback = function ()
            vim.g.cmd_output = ''
            -- go
            vim.cmd('redir => g:cmd_output')
        end,
    })

    vim.api.nvim_create_autocmd({"CmdlineLeave"}, {
        group = augroup,
        desc = "Save output of command in a history",
        callback = function ()
            local command = vim.fn.getcmdline()

            -- add delay because the ex-command is actually run after the event CmdlineLeave
            vim.fn.timer_start(200, function ()
                -- end recording
                vim.cmd 'redir end'

                -- enforce a limit on history len
                if #CmdHistoryList > opts.history_max_len then
                    table.remove(CmdHistoryList) -- pop_back
                end

                --- @type string[]
                local out_split = vim.split(vim.g.cmd_output, '\n')

                -- remove lines from output that match excluded patterns
                local out_filtered = vim.tbl_filter(function(str)
                    for _, ex in ipairs(opts.exclude_output) do
                        if str:match(ex) ~= nil then
                            return false
                        end
                    end
                    return true
                end, out_split)
                -- remove empty lines
                out_filtered = vim.tbl_filter(function (str) return str ~= '' end, out_filtered)

                if #out_filtered > 0 then
                    -- push_front
                    local out = table.concat(out_filtered, '\n')
                    if #out > opts.output_max_len then
                        -- out = vim.list_slice(out, 1, opts.output_max_len)
                        out = out:sub(1, opts.output_max_len)
                    end
                    table.insert(CmdHistoryList, 1, { command = command, output = out })
                end
            end)
        end,
    })
end
