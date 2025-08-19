local StringUtils = require("utils.stringutils")
ACTIVE_SOURCE = nil ---@type love.Source?
CURRENT_TIME = 0 ---@type number
require("commands")
local Thread = require("utils.thread")
---@type Thread[]
THREADS = {}


function love.load()
    love.filesystem.createDirectory("output")
    love.filesystem.createDirectory("audio")
    local aseprite_thread = Thread("processthread.lua",{
        commandline = {
            "env", "ASETUDIO_DIRECTORY="..love.filesystem.getSaveDirectory(),
            "aseprite",
            unpack(love.arg.parseGameArguments(arg))
        }
    })
    aseprite_thread.line_callback = function (full_line)
        ---@cast full_line string
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
    aseprite_thread.end_callback = function ()
        love.draw = nil
        love.event.quit()
    end
    table.insert(THREADS, aseprite_thread)
end

function love.update()
    for i = 1, #THREADS do
        THREADS[i]:update()
    end
    for i = #THREADS, 1, -1 do
        if THREADS[i].removed then
            table.remove(THREADS, i)
        end
    end
end

function love.draw()
    love.graphics.print("PROCESSING")
end