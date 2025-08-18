---@module 'aseprite'

JSON = require("json")

local camexport = require("camexport")


---@param plugin aseprite.Plugin
function init(plugin)
    -- we can use "plugin.preferences" as a table with fields for
    -- our plugin (these fields are saved between sessions)
    if plugin.preferences.count ~= nil then
      plugin.preferences.count = nil
    end
    --
    if not os.getenv("ASETUDIO_DIRECTORY") then
        for k, v in pairs(app.params) do
            print(k,v)
        end
        return print("Debug: Asetudio not active")
    end
    plugin:newCommand{
        id="Export",
        title="My First Command",
        group="file_new",
        onclick=function()
            camexport(app.sprite)
        end
    }

    require("aseprite_connector")
end

function exit(_plugin)
end