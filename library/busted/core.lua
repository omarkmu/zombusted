---@meta

---@class busted.core : busted.api.core
---@field api busted.api
---@field context busted.context.ref
---@field randomseed integer
---@field executors table<string, function>
local core = {}

---@class busted.fileinfo
---@field name string
---@field getTrace function
---@field rewriteMessage function

--#region Core

core.status = require 'busted.status'

---Executes a busted block.
---@param current? busted.context The context for the block to execute. Defaults to the current context.
function core.execute(current) end

---Adds an item to the environment used for tests. Also adds the item to the API.
---@param key string The item name.
---@param value any The item value.
function core.export(key, value) end

---Adds an item to the API table.
---@param key string The item name.
---@param value any The item value.
function core.exportApi(key, value) end

---Gets information about the file associated with a context.
---@param element busted.context
---@return busted.fileinfo?
function core.getFile(element) end

---Gets a traceback for a context.
---@param element busted.context
---@param level integer?
---@param msg string?
function core.getTrace(element, level, msg) end

---Removes an item from the API and the environment used for tests.
---@param key string The item name.
function core.hide(key) end

---Raises an error that indicates that a test is pending.
---@param msg? string The error message.
function core.pending(msg) end

---Registers a new block type.
---@param descriptor string The name of the block.
---@param executor string | fun(context: busted.context)
---@param attributes? table Additional attributes for the block type.
function core.register(descriptor, executor, attributes) end

---Internal `require` that uses a separate table for `package.loaded`.
---@param path string
---@return any
function core.require(path) end

---Rewrites the message for the traceback of the given element.
---@param element busted.context
---@param message string?
---@param trace string?
function core.rewriteMessage(element, message, trace) end

---Runs a block, handling errors.
---@param descriptor string
---@param run function
---@param element busted.context
function core.safe(descriptor, run, element) end

---Publishes an event, handling errors.
---@param descriptor string
---@param channel string[]
---@param element busted.context
---@param ... any
function core.safe_publish(descriptor, channel, element, ...) end

---Wraps a function environment to use the test environment.
---@param callable function
function core.wrap(callable) end

--#endregion

--#region Core API Exports

---@class busted.api.core
---@field version string The busted version.
local api = {}

api.children = core.context.children
api.parent = core.context.parent

---Sets the value of an item in a function environment.
---@param callable function
---@param var string
---@param value any
function api.bindfenv(callable, var, value) end

---Raises an error that indicates that a test failed.
---@param msg? string
---@param level? integer
function api.fail(msg, level) end

---Gets the system time as seconds since the Unix epoch.
---@return number
function api.gettime() end

---Sleeps without a busy loop.
---@param seconds number Seconds to sleep.
---@param precision? integer Minimum stepsize in milliseconds (Windows only, ignored elsewhere). Defaults to 16.
---@return true? success
---@return string? error
function api.sleep(seconds, precision) end

---Subscribes to an event.
---@param ... any
function api.subscribe(...) end

---Gets the monotonic time, as seconds since system start.
---@return number
function api.monotime() end

---Publishes an event.
---@param ... any
function api.publish(...) end

---Unsubscribes from an event.
---@param ... any
function api.unsubscribe(...) end

--#endregion

---@return busted.core
local function init() end

return init
