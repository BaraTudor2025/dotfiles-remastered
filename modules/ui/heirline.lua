--[[
--   *** HEIRLINE ***
--]]

---@class HeirlineComponent
---@field provider? string|function # fun(self?) -> string|number|nil
---@field condition? fun(self?): boolean # can return a 'truthy' value, should the component be evalueted or not
---@field init? fun(self): any # called every time at evaluation
---@field hl? HeirlineHlTable | string | function # fun(self) -> table|string|nil
---@field restrict? table #
---@field after? function #
---@field update? string | table | function # fun(self?) -> bool | autocommand event(s) as string(s) | {pattern: string, callback: function}
---@field on_click? function | table
---@field static? table # static variables are shared between children, accesed with 'self'
---@field id table<integer>
---@field winnr integer
---@field fallthrough boolean
---@field pick_child? table<integer>

---@class HeirlineHlTable
---@field fg string
---@field bg string
---@field sp string   # Underline/undercurl color if any.
---@field no-name table   # Style fields supported by synIDattrstyle(): Example: { bold = true, underline = true }.
---@field force boolean   # Control whether the parent's hl fields will override child's hl.
---@field cterm string | integer
---@field ctermfg string | integer
---@field ctermbg string | integer

return {}
