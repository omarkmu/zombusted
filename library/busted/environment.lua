---@meta

---@class busted.environment
local environment = {}


---Sets the value of `key` in the environment to `value`.
---@param key any
---@param value? any
function environment.set(key, value) end

---Wraps the function environment to get and set values on this environment.
---@param fn function
function environment.wrap(fn) end


---@param context busted.context.ref
local function init(context) end

return init
