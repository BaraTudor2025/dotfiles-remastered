--[[

Bummed that the lua status line plugins are incompatible with one another?

Story time:
I learned Vim7 several years ago, around Neovim 0.4, but then stopped, still continued to used emulators. Stated again this summer with Neovim, learned lua and got sucked into the rabit hole.
Discover that the cool kids don't use Airline anymore but there are DOZENS of lua plugins, all with different levels of customizability.
Thinking about why there isn't a low level lua api for creating status lines. Discover that heirline exists.
So then, if Heirline's features superseeds that of the other plugins, doesn't that mean that we could rewrite them as Heirline components?
So I kind of did.

What is this?
I have 3 function

What?

Why?

--]]

---@diagnostic disable: unused-function, lowercase-global
---@diagnostic disable: unused-local
local status_ok, feline = pcall(require, "feline")
local hrcond = require('heirline.conditions')
local hrutils = require('heirline.utils')

-- local prov = require('feline.providers.vi_mode')

if not status_ok then return end

local C = require "default_theme.colors"
local hl = require("core.status").hl
local provider = require("core.status").provider
local conditional = require("core.status").conditional

---@alias NeovimFontStyle
---| '"bold"'
---| '"underline"'
---| '"underlineline"'	# double underline
---| '"undercurl"'	# curly underline
---| '"underdot"'	# dotted underline
---| '"underdash"'	# dashed underline
---| '"strikethrough"'
---| '"reverse"'
---| '"inverse"'		# same as reverse
---| '"italic"'
---| '"standout"'
---| '"nocombine"'	# override attributes instead of combining them
---| '"NONE"'		# no attributes used (used to reset it)

--[[
--   *** FELINE ***
--]]

---@class FelineComponent
---@field provider string | FelineProviderTable | function # fun(component: FelineComponent, opts: table) -> string
---@field short_provider string | table | function
---@field enabled boolean | function
---@field left_sep _FelineSepOption
---@field right_sep _FelineSepOption
---@field hl _FelineHighlightOption
---@field priority number
---@field icon string | function | FelineIconTable

---@class FelineProviderTable
---@field name string
---@field update string | string[] | function # fun(component, opts?)
---@field opts? table maybe if it's default provider

---@class FelineIconTable
---@field str string
---@field hl FelineHighlightTable
---@field always_visible boolean

--[[
--   *** SEPARATOR ***
--]]

---@alias _FelineSepOption
---| string
---| FelineIconTable
---| (FelineIconTable | string)[]

-- *** HIGHLIGHT ***

---@alias _FelineHighlightOption
---| FelineHighlightTable
---| string
---| fun(): (FelineHighlightTable | string)

---@class FelineHighlightTable
---@field name? string highlight group created by Feline
---@field fg? string
---@field bg? string
---@field style? NeovimFontStyle font style, see :h attr-list

---@param fe FelineComponent
---@return HeirlineComponent
local function feline_to_heirline_facotry(fe)
  ---@type HeirlineComponent
  local h = {
    condition = function()
      if fe.enabled then
      end
    end,
  }
  return h
end

---@param fe FelineComponent
---@return HeirlineComponent
local function feline_to_heirline(fe)
  ---@type HeirlineComponent
  local h = {}
  -- hold a reference to original feline component so it can be passed to functions that take 'self'
  h.feline_component = fe

  if fe.enabled ~= nil then
    if type(fe.enabled) == 'boolean' then
      h.condition = function(self) return self.feline_component.enabled end
    else
      h.condition = function(self) return self.feline_component.enabled() end
    end
  end

  if fe.provider ~= nil then
    local p = fe.provider
    if type(p) == 'string' then
      -- h.provider = p
      h.provider = function(self) return self.feline_component.provider end
    elseif type(p) == 'function' then
      h.provider = function(self)
        return self.feline_component.provider(self.feline_component)
      end
    else -- table
      if p.update ~= nil then
        if type(p.update) == 'boolean' then
          h.update = function (self) return self.feline_component.update end
        else
          h.update = function (self) return self.feline_component.update() end
        end
      end

      -- TODO: get registered provider
      local function todo(_, _) end
      h.provider = function(self)
        return todo(self.feline_component, self.feline_component.provider.opts)
      end
    end
  end

  if fe.short_provider ~= nil then
  end
  if fe.right_sep ~= nil then
  end
  if fe.left_sep ~= nil then
  end

  if fe.icon ~= nil then
  end
  if fe.hl ~= nil then
  end
  if fe.priority ~= nil then
  end

  return h
end

-- stylua: ignore
feline.setup(astronvim.user_plugin_opts("plugins.feline", {
  disable = { filetypes = { "^NvimTree$", "^neo%-tree$", "^dashboard$", "^Outline$", "^aerial$" } },
  theme = hl.group("StatusLine", { fg = C.fg, bg = C.bg_1 }),
  components = {
    active = {
      {
        { provider = provider.spacer(), hl = hl.mode() },
        { provider = provider.spacer(2) },
        { provider = "git_branch", hl = hl.fg("Conditional", { fg = C.purple_1, style = "bold" }), icon = " " },
        { provider = provider.spacer(3), enabled = conditional.git_available },
        { provider = { name = "file_type", opts = { filetype_icon = true, case = "lowercase" } }, enabled = conditional.has_filetype },
        { provider = provider.spacer(2), enabled = conditional.has_filetype },
        { provider = "git_diff_added", hl = hl.fg("GitSignsAdd", { fg = C.green }), icon = "  " },
        { provider = "git_diff_changed", hl = hl.fg("GitSignsChange", { fg = C.orange_1 }), icon = " 柳" },
        { provider = "git_diff_removed", hl = hl.fg("GitSignsDelete", { fg = C.red_1 }), icon = "  " },
        { provider = provider.spacer(2), enabled = conditional.git_changed },
        { provider = "diagnostic_errors", hl = hl.fg("DiagnosticError", { fg = C.red_1 }), icon = "  " },
        { provider = "diagnostic_warnings", hl = hl.fg("DiagnosticWarn", { fg = C.orange_1 }), icon = "  " },
        { provider = "diagnostic_info", hl = hl.fg("DiagnosticInfo", { fg = C.white_2 }), icon = "  " },
        { provider = "diagnostic_hints", hl = hl.fg("DiagnosticHint", { fg = C.yellow_1 }), icon = "  " },
      },
      {
        { provider = provider.lsp_progress, enabled = conditional.bar_width() },
        { provider = provider.lsp_client_names(true), short_provider = provider.lsp_client_names(), enabled = conditional.bar_width(), icon = "   " },
        { provider = provider.spacer(2), enabled = conditional.bar_width() },
        { provider = provider.treesitter_status, enabled = conditional.bar_width(), hl = hl.fg("GitSignsAdd", { fg = C.green }) },
        { provider = provider.spacer(2) },
        { provider = "position" },
        { provider = provider.spacer(2) },
        { provider = "line_percentage" },
        { provider = provider.spacer() },
        { provider = "scroll_bar", hl = hl.fg("TypeDef", { fg = C.yellow }) },
        { provider = provider.spacer(2) },
        { provider = provider.spacer(), hl = hl.mode() },
      },
    },
  },
}))

return {}
