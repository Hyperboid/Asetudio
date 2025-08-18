---@meta
---@namespace love

--- Provides an interface for modifying and retrieving information about the program's window.
love.window = {}

--- Types of device display orientation.
---@alias DisplayOrientation
---| "unknown" -- Orientation cannot be determined.
---| "landscape" -- Landscape orientation.
---| "landscapeflipped" -- Landscape orientation (flipped).
---| "portrait" -- Portrait orientation.
---| "portraitflipped" -- Portrait orientation (flipped).

--- Types of fullscreen modes.
---@alias FullscreenType
---| "desktop" -- Sometimes known as borderless fullscreen windowed mode. A borderless screen-sized window is created which sits on top of all desktop UI elements. The window is automatically resized to match the dimensions of the desktop, and its size cannot be changed.
---| "exclusive" -- Standard exclusive-fullscreen mode. Changes the display mode (actual resolution) of the monitor.
---| "normal" -- Standard exclusive-fullscreen mode. Changes the display mode (actual resolution) of the monitor.

--- Types of message box dialogs. Different types may have slightly different looks.
---@alias MessageBoxType
---| "info" -- Informational dialog.
---| "warning" -- Warning dialog.
---| "error" -- Error dialog.

--- Closes the window. It can be reopened with love.window.setMode.
function love.window.close() end

--- Converts a number from pixels to density-independent units.
--- 
--- The pixel density inside the window might be greater (or smaller) than the 'size' of the window. For example on a retina screen in Mac OS X with the highdpi window flag enabled, the window may take up the same physical size as an 800x600 window, but the area inside the window uses 1600x1200 pixels. love.window.fromPixels(1600) would return 800 in that case.
--- 
--- This function converts coordinates from pixels to the size users are expecting them to display at onscreen. love.window.toPixels does the opposite. The highdpi window flag must be enabled to use the full pixel density of a Retina screen on Mac OS X and iOS. The flag currently does nothing on Windows and Linux, and on Android it is effectively always enabled.
--- 
--- Most LÖVE functions return values and expect arguments in terms of pixels rather than density-independent units.
---@param px number # The x-axis value of a coordinate in pixels.
---@param py number # The y-axis value of a coordinate in pixels.
---@return number, number
---@overload fun(pixelvalue:number):number
function love.window.fromPixels(px, py) end

--- Gets the DPI scale factor associated with the window.
--- 
--- The pixel density inside the window might be greater (or smaller) than the 'size' of the window. For example on a retina screen in Mac OS X with the highdpi window flag enabled, the window may take up the same physical size as an 800x600 window, but the area inside the window uses 1600x1200 pixels. love.window.getDPIScale() would return 2.0 in that case.
--- 
--- The love.window.fromPixels and love.window.toPixels functions can also be used to convert between units.
--- 
--- The highdpi window flag must be enabled to use the full pixel density of a Retina screen on Mac OS X and iOS. The flag currently does nothing on Windows and Linux, and on Android it is effectively always enabled.
---@return number
function love.window.getDPIScale() end

--- Gets the width and height of the desktop.
---@param displayindex number? # The index of the display, if multiple monitors are available. (Defaults to 1.)
---@return number, number
function love.window.getDesktopDimensions(displayindex) end

--- Gets the number of connected monitors.
---@return number
function love.window.getDisplayCount() end

--- Gets the name of a display.
---@param displayindex number? # The index of the display to get the name of. (Defaults to 1.)
---@return string
function love.window.getDisplayName(displayindex) end

--- Gets current device display orientation.
---@param displayindex number? # Display index to get its display orientation, or nil for default display index. (Defaults to nil.)
---@return DisplayOrientation
function love.window.getDisplayOrientation(displayindex) end

--- Gets whether the window is fullscreen.
---@return boolean, FullscreenType
function love.window.getFullscreen() end

--- Gets a list of supported fullscreen modes.
---@param displayindex number? # The index of the display, if multiple monitors are available. (Defaults to 1.)
---@return table
function love.window.getFullscreenModes(displayindex) end

--- Gets the window icon.
---@return ImageData
function love.window.getIcon() end

--- Gets the display mode and properties of the window.
---@return number, number, table
function love.window.getMode() end

--- Gets the position of the window on the screen.
--- 
--- The window position is in the coordinate space of the display it is currently in.
---@return number, number, number
function love.window.getPosition() end

--- Gets area inside the window which is known to be unobstructed by a system title bar, the iPhone X notch, etc. Useful for making sure UI elements can be seen by the user.
---@return number, number, number, number
function love.window.getSafeArea() end

--- Gets the window title.
---@return string
function love.window.getTitle() end

--- Gets current vertical synchronization (vsync).
---@return number
function love.window.getVSync() end

--- Checks if the game window has keyboard focus.
---@return boolean
function love.window.hasFocus() end

--- Checks if the game window has mouse focus.
---@return boolean
function love.window.hasMouseFocus() end

--- Gets whether the display is allowed to sleep while the program is running.
--- 
--- Display sleep is disabled by default. Some types of input (e.g. joystick button presses) might not prevent the display from sleeping, if display sleep is allowed.
---@return boolean
function love.window.isDisplaySleepEnabled() end

--- Gets whether the Window is currently maximized.
--- 
--- The window can be maximized if it is not fullscreen and is resizable, and either the user has pressed the window's Maximize button or love.window.maximize has been called.
---@return boolean
function love.window.isMaximized() end

--- Gets whether the Window is currently minimized.
---@return boolean
function love.window.isMinimized() end

--- Checks if the window is open.
---@return boolean
function love.window.isOpen() end

--- Checks if the game window is visible.
--- 
--- The window is considered visible if it's not minimized and the program isn't hidden.
---@return boolean
function love.window.isVisible() end

--- Makes the window as large as possible.
--- 
--- This function has no effect if the window isn't resizable, since it essentially programmatically presses the window's 'maximize' button.
function love.window.maximize() end

--- Minimizes the window to the system's task bar / dock.
function love.window.minimize() end

--- Causes the window to request the attention of the user if it is not in the foreground.
--- 
--- In Windows the taskbar icon will flash, and in OS X the dock icon will bounce.
---@param continuous boolean? # Whether to continuously request attention until the window becomes active, or to do it only once. (Defaults to false.)
function love.window.requestAttention(continuous) end

--- Restores the size and position of the window if it was minimized or maximized.
function love.window.restore() end

--- Sets whether the display is allowed to sleep while the program is running.
--- 
--- Display sleep is disabled by default. Some types of input (e.g. joystick button presses) might not prevent the display from sleeping, if display sleep is allowed.
---@param enable boolean # True to enable system display sleep, false to disable it.
function love.window.setDisplaySleepEnabled(enable) end

--- Enters or exits fullscreen. The display to use when entering fullscreen is chosen based on which display the window is currently in, if multiple monitors are connected.
---@param fullscreen boolean # Whether to enter or exit fullscreen mode.
---@param fstype FullscreenType # The type of fullscreen mode to use.
---@return boolean
---@overload fun(fullscreen:boolean):boolean
function love.window.setFullscreen(fullscreen, fstype) end

--- Sets the window icon until the game is quit. Not all operating systems support very large icon images.
---@param imagedata ImageData # The window icon image.
---@return boolean
function love.window.setIcon(imagedata) end

--- Sets the display mode and properties of the window.
--- 
--- If width or height is 0, setMode will use the width and height of the desktop. 
--- 
--- Changing the display mode may have side effects: for example, canvases will be cleared and values sent to shaders with canvases beforehand or re-draw to them afterward if you need to.
---@param width number # Display width.
---@param height number # Display height.
---@param flags table # The flags table with the options:
---@return boolean
function love.window.setMode(width, height, flags) end

--- Sets the position of the window on the screen.
--- 
--- The window position is in the coordinate space of the specified display.
---@param x number # The x-coordinate of the window's position.
---@param y number # The y-coordinate of the window's position.
---@param displayindex number? # The index of the display that the new window position is relative to. (Defaults to 1.)
function love.window.setPosition(x, y, displayindex) end

--- Sets the window title.
---@param title string # The new window title.
function love.window.setTitle(title) end

--- Sets vertical synchronization mode.
---@param vsync number # VSync number: 1 to enable, 0 to disable, and -1 for adaptive vsync.
function love.window.setVSync(vsync) end

--- Displays a message box dialog above the love window. The message box contains a title, optional text, and buttons.
---@param title string # The title of the message box.
---@param message string # The text inside the message box.
---@param buttonlist table # A table containing a list of button names to show. The table can also contain the fields enterbutton and escapebutton, which should be the index of the default button to use when the user presses 'enter' or 'escape', respectively.
---@param type MessageBoxType? # The type of the message box. (Defaults to 'info'.)
---@param attachtowindow boolean? # Whether the message box should be attached to the love window or free-floating. (Defaults to true.)
---@return number
---@overload fun(title:string, message:string, type:MessageBoxType?, attachtowindow:boolean?):boolean
function love.window.showMessageBox(title, message, buttonlist, type, attachtowindow) end

--- Converts a number from density-independent units to pixels.
--- 
--- The pixel density inside the window might be greater (or smaller) than the 'size' of the window. For example on a retina screen in Mac OS X with the highdpi window flag enabled, the window may take up the same physical size as an 800x600 window, but the area inside the window uses 1600x1200 pixels. love.window.toPixels(800) would return 1600 in that case.
--- 
--- This is used to convert coordinates from the size users are expecting them to display at onscreen to pixels. love.window.fromPixels does the opposite. The highdpi window flag must be enabled to use the full pixel density of a Retina screen on Mac OS X and iOS. The flag currently does nothing on Windows and Linux, and on Android it is effectively always enabled.
--- 
--- Most LÖVE functions return values and expect arguments in terms of pixels rather than density-independent units.
---@param x number # The x-axis value of a coordinate in density-independent units to convert to pixels.
---@param y number # The y-axis value of a coordinate in density-independent units to convert to pixels.
---@return number, number
---@overload fun(value:number):number
function love.window.toPixels(x, y) end

--- Sets the display mode and properties of the window, without modifying unspecified properties.
--- 
--- If width or height is 0, updateMode will use the width and height of the desktop. 
--- 
--- Changing the display mode may have side effects: for example, canvases will be cleared. Make sure to save the contents of canvases beforehand or re-draw to them afterward if you need to.
---@param width number # Window width.
---@param height number # Window height.
---@param settings table # The settings table with the following optional fields. Any field not filled in will use the current value that would be returned by love.window.getMode.
---@return boolean
function love.window.updateMode(width, height, settings) end

