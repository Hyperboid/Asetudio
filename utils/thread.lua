---@class Thread
---@overload fun(source, options): Thread
local Thread = {}

Thread.__index = Thread
Thread.SETUP_CHANNEL = love.thread.getChannel("threadsetup")

function Thread:init(source, options)
    self.managed_thread = love.thread.newThread(source)
    self.in_channel = love.thread.newChannel()
    self.out_channel = love.thread.newChannel()
    self.managed_thread:start()
    Thread.SETUP_CHANNEL:supply({
        in_channel = self.in_channel,
        out_channel = self.out_channel,
        options = options,
    })
    local res = Thread.SETUP_CHANNEL:demand()
    if res.error then
        error(res.error)
    else
        assert(res == "success")
    end

end

---@param value Variant
function Thread:push(value)
    return self.in_channel:push(value)
end


---@param value Variant
function Thread:supply(value, timeout)
    return self.in_channel:supply(value, timeout)
end

function Thread:demand(timeout)
    return self.out_channel:demand(timeout)
end

setmetatable(Thread, { __call = function(_,...)
    local tbl = {}
    setmetatable(tbl, Thread)
    tbl:init(...)
    return tbl
end })

return Thread