---@meta
---@namespace love

--- Provides an interface to touch-screen presses.
love.touch = {}

--- Gets the current position of the specified touch-press, in pixels.
---@param id light userdata # The identifier of the touch-press. Use love.touch.getTouches, love.touchpressed, or love.touchmoved to obtain touch id values.
---@return number, number
function love.touch.getPosition(id) end

--- Gets the current pressure of the specified touch-press.
---@param id light userdata # The identifier of the touch-press. Use love.touch.getTouches, love.touchpressed, or love.touchmoved to obtain touch id values.
---@return number
function love.touch.getPressure(id) end

--- Gets a list of all active touch-presses.
---@return table
function love.touch.getTouches() end

