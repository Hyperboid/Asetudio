---@class Utils
local StringUtils = {}

function StringUtils.split(str, pat)
    local t = {}
    if pat == "" then
        for i = 1, #str do
            table.insert(t, str:sub(i,i))
        end
        return t
    end
    local fpat = "(.-)" .. pat
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
          table.insert(t, cap)
       end
       last_end = e+1
       s, e, cap = str:find(fpat, last_end)
    end
    if last_end <= #str then
       cap = str:sub(last_end)
       table.insert(t, cap)
    end
    return t
end

return StringUtils