---@module 'aseprite'

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


return function(sprite)
    local main_duplicate = Sprite(sprite)
    -- TODO: Interpolate camera

    for i = 1, #main_duplicate.frames do
        exportFrame(main_duplicate, i, os.getenv("ASETUDIO_DIRECTORY") .. "/output/" .. "anim_"..i..".png")
    end
    
    main_duplicate:close()
end