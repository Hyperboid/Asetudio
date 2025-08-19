---@alias Variant.__ENCODABLE string|number|boolean|love.Object|nil
---@alias Variant table<Variant.__ENCODABLE, Variant.__ENCODABLE>|Variant.__ENCODABLE[]|Variant.__ENCODABLE

---@return love.Channel
---@return love.Channel
---@param initializer fun(options:table,in_channel:love.Channel,out_channel:love.Channel)
return function (initializer)
    local setupchannel = love.thread.getChannel("threadsetup")
    local msg = setupchannel:demand()

    local ok, result = xpcall(function()
        initializer(msg.options, msg.in_channel, msg.out_channel)
    end, debug.traceback)
    if not ok then
        setupchannel:supply({error = result})
        error(result)
    end

    setupchannel:supply("success")
    return msg.in_channel, msg.out_channel
end
