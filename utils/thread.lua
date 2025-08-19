---@class Thread
---@field removed boolean
---@overload fun(source, options): Thread
local Thread = {}

Thread.__index = Thread
Thread.SETUP_CHANNEL = love.thread.getChannel("threadsetup")

function Thread:init(source, options, line_callback, end_callback)
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
    self.removed = false
    self.line_callback = line_callback or function() end
    self.end_callback = end_callback or function() end

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

function Thread:update()
    if self.removed then
        return
    end
    if not self.managed_thread:isRunning() then
        self.removed = true
        self.end_callback()
        return
    end
    while self.out_channel:getCount() > 0 do
        self.line_callback(self.out_channel:pop())
    end
end

setmetatable(Thread, { __call = function(_,...)
    local tbl = {}
    setmetatable(tbl, Thread)
    tbl:init(...)
    return tbl
end })

return Thread