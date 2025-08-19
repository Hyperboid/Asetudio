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
        return print("Debug: Asetudio not active")
    end
    plugin:newMenuGroup({
        id = "asetudio",
        title="Asetudio",
        group = "file_export"
    })
    plugin:newCommand{
        id="AsetudioExport",
        title="Export Animation",
        group="asetudio",
        onclick=function()
            camexport(app.sprite)
            command("finishexport", "anim", (JSON.decode(app.sprite.data) or {}).audio)
        end
    }
    plugin:newCommand{
        id="AsetudioHotswapCommands",
        title="Hotswap Commands",
        group="asetudio",
        onclick=function()
            command("hotswap")
        end
    }

    require("aseprite_connector")
end

function exit(_plugin)
end