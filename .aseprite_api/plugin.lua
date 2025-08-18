---@meta
---@namespace aseprite

---@class Plugin
---@field name string Name of the extension
---@field displayName string Display name of the extension.
---@field version string Version of the extension.
---@field path string Path where the extension is installed.
---@field preferences table It's a Lua table where you can load/save any kind of Lua value here and they will be saved/restored automatically on each session.
local Plugin = {}

-- See https://github.com/aseprite/api/blob/main/api/plugin.md#pluginnewcommand
function Plugin:newCommand(c) end
-- See https://github.com/aseprite/api/blob/main/api/plugin.md#pluginnewmenugroup
function Plugin:newMenuGroup(g) end
-- See https://github.com/aseprite/api/blob/main/api/plugin.md#pluginnewmenuseparator
function Plugin:newMenuSeparator(g) end
