---@meta
---@namespace love

--- Provides an interface to the user's clock.
love.timer = {}

--- Returns the average delta time (seconds per frame) over the last second.
---@return number
function love.timer.getAverageDelta() end

--- Returns the time between the last two frames.
---@return number
function love.timer.getDelta() end

--- Returns the current frames per second.
---@return number
function love.timer.getFPS() end

--- Returns the value of a timer with an unspecified starting time.
--- 
--- This function should only be used to calculate differences between points in time, as the starting time of the timer is unknown.
---@return number
function love.timer.getTime() end

--- Pauses the current thread for the specified amount of time.
---@param s number # Seconds to sleep for.
function love.timer.sleep(s) end

--- Measures the time between two frames.
--- 
--- Calling this changes the return value of love.timer.getDelta.
---@return number
function love.timer.step() end

