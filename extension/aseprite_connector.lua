---@module 'aseprite'

local ase = _G ---@cast ase table
-- stupid ass hack since you can't just check if it's playing for some reason
local playing = {}

---@param cmd COMMAND
---@param ... string
local function command(cmd, ...)
    local argstr = ""
    for i,v in ipairs({...}) do
        argstr = argstr .. tostring(v) .. "\t"
    end
    io.write("AsetudioCommand:"..cmd.."\t"..argstr.."\n")
    io.flush()
end

local dlg = Dialog("Asetudio - Warning");
dlg:label{ id="t1", label="Hello!" }
dlg:label{ id="t2", label="This instance of Aseprite is being monitored" }
dlg:label{ id="t3", label="by Asetudio." }
dlg:label{ id="t4", label="" }
dlg:label{ id="t5", label="All data is handled locally." }
dlg:label{ id="t6", label="" }
dlg:label{ id="t7", label="Asetudio is based on the lua component of Aseprite Audio Extension." }
dlg:label{ id="t8", label="" }
dlg:label{ id="t9", label="Thank you for using Asetudio!" }

local lastSprite = "";
local lastFrame = -1;
local lastTime = 0

local function updatePlayingState()
    command('setframe',(lastFrame-1), lastTime)
    command("setplaying", playing[lastSprite] or false)
end

app.events:on('sitechange', function()
    if(app ~= nil) then
        if(app.frame ~= nil and lastFrame ~= app.frame.frameNumber) then
            lastFrame = app.frame.frameNumber
            local time = 0
            for i = 1, lastFrame-1 do
                time = time + app.sprite.frames[i].duration
            end
            lastTime = time
            command('setframe',(lastFrame-1), time)
        end

        if(app.sprite ~= nil and lastSprite ~= app.sprite.filename) then
            lastSprite = app.sprite.filename;
            local data = JSON.decode(app.sprite.data) or {}
            -- TODO: actually parse it lol
            command('setaudio', data.audio or "")
            command('setfirstframe', (app.preferences.document(app.sprite).timeline.first_frame))
            updatePlayingState()
        end
    end
end)

app.events:on('beforecommand', function(ev)
    if ev.name == "PlayAnimation" then
        playing[lastSprite] = not playing[lastSprite]
        updatePlayingState()
    end
    if ev.name == "CloseFile" then
        playing[lastSprite] = nil
        command('setaudio', '')
        updatePlayingState()
    end
end)
