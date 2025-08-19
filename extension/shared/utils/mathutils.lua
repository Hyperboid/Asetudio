---@class MathUtils
local MathUtils = {}

function MathUtils.lerp(a, b, t, oob)
    if type(a) == "table" and type(b) == "table" then
        local o = {}
        for k,v in ipairs(a) do
            table.insert(o, MathUtils.lerp(v, b[k] or v, t, oob))
        end
        return o
    else
        return a + (b - a) * ((oob) and t or MathUtils.clamp(t, 0, 1))
    end
end

function MathUtils.clamp(val, min, max)
    return math.max(min, math.min(max, val))
end

function MathUtils.remap(val, min_a, max_a, min_b, max_b)
    if min_a > max_a then
        -- Swap min and max
        min_a, max_a = max_a, min_a
        min_b, max_b = max_b, min_b
    end
    local t = (val - min_a) / (max_a - min_a)
    return MathUtils.lerp(min_b, max_b, t)
end

return MathUtils