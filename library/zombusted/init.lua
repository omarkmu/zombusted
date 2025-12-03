---Zombusted type definitions.
---@meta

zomboid = require 'zombusted.zomboid'

---Removes a required module from the loaded cache and requires it again.
---@param mod string The name of the module, as passed to `require`.
---@return ...any
function reload_module(mod) end

---Sets up helpers and additional assertions.
---
---This is called automatically when used as a busted helper script.
---If using a custom helper script with `zombusted`, it should call
---`require 'zombusted' (...)` at the top of its function return value.
---### Example
---```lua
----- test helper script
---
---return function(...)
---    require 'zombusted' (...) -- set up zombusted
---
---    -- custom helper logic here
---end
---```
---@param busted busted.instance
---@return true
local function init(busted) end

return init
