local Thread = require("utils.thread")
---@enum (key) COMMAND
COMMANDS = {
    setframe = function(frame, time)
        if ACTIVE_SOURCE and (not ACTIVE_SOURCE:isPlaying() or math.abs(ACTIVE_SOURCE:tell() - CURRENT_TIME) > MAX_DESYNC) then
            ACTIVE_SOURCE:seek(time)
        end
        CURRENT_TIME = time
    end;
    setaudio = function(name)
        if ACTIVE_SOURCE then
            ACTIVE_SOURCE:stop()
            ---@type love.Source?
            ACTIVE_SOURCE = nil
        end
        if name == "" or not name then return end
        print("Setting audio: "..name)
        ACTIVE_SOURCE = love.audio.newSource("audio/"..name, "stream")
        ACTIVE_SOURCE:setVolume(0.3)
    end;
    setfirstframe = function(_firstframe)
        -- I don't know what this is supposed to do
    end;
    setplaying = function(isplaying)
        if not ACTIVE_SOURCE then
            return
        end
        if isplaying then
            ACTIVE_SOURCE:play()
        else
            ACTIVE_SOURCE:pause()
        end
    end;
    hotswap = function()
        package.preload.commands=nil
        package.loaded.commands=nil
        require("commands")
    end;
    finishexport = function(name, audio)
        local full_input_prefix = love.filesystem.getSaveDirectory().."/tmp/"..name
        local full_output_path = love.filesystem.getSaveDirectory().."/output/"..name..".mp4"
        local full_audio_path = love.filesystem.getSaveDirectory().."/audio/"..audio
        local commandline = {
            "ffmpeg", "-y", "-start_number", "1", "-i", full_input_prefix.."_%d.png", "-i", full_audio_path, "-vcodec", "mpeg4", full_output_path
        }
        print("$ "..table.concat(commandline, " "))
        local thread = Thread("processthread.lua", { commandline = commandline})
        thread.end_callback = function ()
            love.window.close()
            print("Finished!")
        end
        thread.message_callback = print
        love.window.setMode(400,100, {
            resizable = true;
        })
        thread:register()
    end
}
