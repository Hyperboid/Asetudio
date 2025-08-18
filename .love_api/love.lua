---@meta
---@namespace love

love = {}

--region Data

--- The superclass of all data.
---@class Data : Object
local Data = {}
--- Creates a new copy of the Data object.
---@return Data
function Data:clone() end

--- Gets an FFI pointer to the Data.
--- 
--- This function should be preferred instead of Data:getPointer because the latter uses light userdata which can't store more all possible memory addresses on some new ARM64 architectures, when LuaJIT is used.
---@return cdata
function Data:getFFIPointer() end

--- Gets a pointer to the Data. Can be used with libraries such as LuaJIT's FFI.
---@return light userdata
function Data:getPointer() end

--- Gets the Data's size in bytes.
---@return number
function Data:getSize() end

--- Gets the full Data as a string.
---@return string
function Data:getString() end

--endregion Data

--region Object

--- The superclass of all LÖVE types.
---@class Object
local Object = {}
--- Destroys the object's Lua reference. The object will be completely deleted if it's not referenced by any other LÖVE object or thread.
--- 
--- This method can be used to immediately clean up resources without waiting for Lua's garbage collector.
---@return boolean
function Object:release() end

--- Gets the type of the object as a string.
---@return string
function Object:type() end

--- Checks whether an object is of a certain type. If the object has the type with the specified name in its hierarchy, this function will return true.
---@param name string # The name of the type to check for.
---@return boolean
function Object:typeOf(name) end

--endregion Object

---@type love.audio
love.audio = nil

---@type love.data
love.data = nil

---@type love.event
love.event = nil

---@type love.filesystem
love.filesystem = nil

---@type love.font
love.font = nil

---@type love.graphics
love.graphics = nil

---@type love.image
love.image = nil

---@type love.joystick
love.joystick = nil

---@type love.keyboard
love.keyboard = nil

---@type love.math
love.math = nil

---@type love.mouse
love.mouse = nil

---@type love.physics
love.physics = nil

---@type love.sound
love.sound = nil

---@type love.system
love.system = nil

---@type love.thread
love.thread = nil

---@type love.timer
love.timer = nil

---@type love.touch
love.touch = nil

---@type love.video
love.video = nil

---@type love.window
love.window = nil

--- Gets the current running version of LÖVE.
---@return number, number, number, string
function love.getVersion() end

--- Gets whether LÖVE displays warnings when using deprecated functionality. It is disabled by default in fused mode, and enabled by default otherwise.
--- 
--- When deprecation output is enabled, the first use of a formally deprecated LÖVE API will show a message at the bottom of the screen for a short time, and print the message to the console.
---@return boolean
function love.hasDeprecationOutput() end

--- Gets whether the given version is compatible with the current running version of LÖVE.
---@param major number # The major version to check (for example 11 for 11.3 or 0 for 0.10.2).
---@param minor number # The minor version to check (for example 3 for 11.3 or 10 for 0.10.2).
---@param revision number # The revision of version to check (for example 0 for 11.3 or 2 for 0.10.2).
---@return boolean
---@overload fun(version:string):boolean
function love.isVersionCompatible(major, minor, revision) end

--- Sets whether LÖVE displays warnings when using deprecated functionality. It is disabled by default in fused mode, and enabled by default otherwise.
--- 
--- When deprecation output is enabled, the first use of a formally deprecated LÖVE API will show a message at the bottom of the screen for a short time, and print the message to the console.
---@param enable boolean # Whether to enable or disable deprecation output.
function love.setDeprecationOutput(enable) end

