local StringUtils = require("utils.stringutils")
ACTIVE_SOURCE = nil ---@type love.Source?
CURRENT_TIME = 0 ---@type number
require("commands")

function love.run()
    love.filesystem.createDirectory("output")
    love.filesystem.createDirectory("audio")
    local aseprite_stdout = io.popen(
        "\"" .. table.concat(
            {
                "env", "ASETUDIO_DIRECTORY="..love.filesystem.getSaveDirectory(),
                "aseprite",
                unpack(love.arg.parseGameArguments(arg))
            }, "\" \"") .. "\"")
    for full_line in aseprite_stdout:lines() do
        if full_line:sub(1,#"AsetudioCommand:") == "AsetudioCommand:" then
            local line_unprefixed = full_line:sub(#"AsetudioCommand:"+1, #full_line)
            local command_args = StringUtils.split(line_unprefixed, "\t")
            local command = table.remove(command_args, 1)
            if not COMMANDS[command] then
                print("Unknown command: "..command)
                print("- Arguments: "..table.concat(command_args, ", "))
            else
                -- print("Processing command: "..command .. " " .. table.concat(command_args, " "))
                for i = 1, #command_args do
                    command_args[i] = tonumber(command_args[i]) or command_args[i]
                    if command_args[i] == "true" then
                        command_args[i] = true
                    elseif command_args[i] == "false" then
                        command_args[i] = false
                    end
                end
                COMMANDS[command](unpack(command_args))
            end
        else
            print(full_line)
        end
    end
end
