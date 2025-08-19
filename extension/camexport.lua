local MathUtils = require("shared.utils.mathutils")
---@module 'aseprite'

local module = {}
local function printt(text)
    io.write(text.."\n")
    io.flush()
end

local function exportFrame(sprite, frame_n, output)
    local tempsprite = Sprite(sprite)
    local comp_frame_n = frame_n
    while #tempsprite.frames ~= 1 do
        if comp_frame_n == 1 then
            tempsprite:deleteFrame(2)
        else
            tempsprite:deleteFrame(1)
            comp_frame_n = comp_frame_n - 1
        end 
    end
    -- sanity check (trust me it's more annoying with out this)
    if #tempsprite.frames ~= 1 then
        tempsprite:close()
        error("More than one frame left somehow?")
    end
    if tempsprite.layers[#tempsprite.layers].name == "cam" then
        local cel = tempsprite.layers[#tempsprite.layers]:cel(1)
        local bounds = Rectangle(cel.bounds)
        bounds.x = bounds.x + 1
        bounds.y = bounds.y + 1
        bounds.width = bounds.width - 2
        bounds.height = bounds.height - 2
        -- printt("Cropping frame "..frame_n.." to bounds " .. ("%sx%s@%sx%s"):format(bounds.x, bounds.y, bounds.width,bounds.height))
        sprite:crop(bounds)
    else
        -- printt("NOT Cropping frame "..frame_n)
    end
    tempsprite:saveCopyAs(output)
    tempsprite:close()
end

function module.interpolateCamera(sprite, layer)
    local last_keyframe = 1
    local next_keyframe = 1
    for frameid = 1, #sprite.frames do
        if layer:cel(frameid) then
            last_keyframe = frameid
            next_keyframe = frameid
            for nextframeid=frameid+1,#sprite.frames do
                if layer:cel(nextframeid) then
                    next_keyframe = nextframeid
                    break
                end
            end
        else
            local lastcel = layer:cel(last_keyframe)
            local nextcel = layer:cel(next_keyframe)
            local image = layer:cel(last_keyframe).image:clone()
            local t = MathUtils.remap(frameid, last_keyframe, next_keyframe, 0, 1)
            local coords = Point(
                MathUtils.lerp(lastcel.position.x, nextcel.position.x, t),
                MathUtils.lerp(lastcel.position.y, nextcel.position.y, t)
            )
            coords.x = math.floor(coords.x)
            coords.y = math.floor(coords.y)
            local cel = sprite:newCel(layer, frameid, image, coords)
        end
    end
end

---@param sprite aseprite.Sprite
function module.preprocessSprite(sprite)
    if sprite.layers[#sprite.layers].name == "cam" then
        module.interpolateCamera(sprite, sprite.layers[#sprite.layers])
    end
end

---@param sprite aseprite.Sprite
function module.export(sprite)
    local main_duplicate = Sprite(sprite)
    module.preprocessSprite(main_duplicate)
    local ffconcat = assert(io.open(os.getenv("ASETUDIO_DIRECTORY") .. "/tmp/" .. "anim"..".ffconcat", "w"))
    ffconcat:write("ffconcat version 1.0\n")
    local filename
    for i = 1, #main_duplicate.frames do
        filename = "anim".."_"..i..".png"
        local full_path = os.getenv("ASETUDIO_DIRECTORY") .. "/tmp/" .. filename
        exportFrame(main_duplicate, i, full_path)
        ffconcat:write("file "..filename.."\n")
        ffconcat:write("duration "..main_duplicate.frames[i].duration.."\n")
    end
    ffconcat:write("file "..filename.."\n")
    ffconcat:flush()
    ffconcat:close()
    
    main_duplicate:close()
end


---@param sprite aseprite.Sprite
function module.makePreview(sprite)
    local main_duplicate = Sprite(sprite)
    module.preprocessSprite(main_duplicate)
end

setmetatable(module, {__call = function(t, ...)
    return module.export(...)
end})

return module