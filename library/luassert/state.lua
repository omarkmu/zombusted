---@meta

---Manages the state of the assert engine.
---This includes formatters, parameters, spies, and stubs.
---
---This is mostly used internally.
---For most use cases, the methods on `luassert` can be used.
---@see luassert
local state = {} ---@class luassert.state

---@class luassert.state.snapshot
local snapshot = {}

---Reverts the state to the snapshot.
function snapshot:revert() end


---Reverts the state to the given snapshot.
---@param self luassert.state.snapshot
function state.revert(self) end

---Creates and returns a snapshot of the current state.
---@return luassert.state.snapshot
---@see luassert.snapshot
function state.snapshot() end

---Adds a formatter to the list of formatters.
---
---Formatters are added to the beginning of the list;
---a formatter added via this function will run before any built-in formatters.
---@param callback fun(value: any, fmtargs?: any): string? The format callback.
---@see luassert.add_formatter
function state.add_formatter(callback) end

---Removes a formatter from the list of formatters.
---@param callback function The callback of the formatter to remove.
---@param s? luassert.state.snapshot The state to remove the formatter from. Defaults to the current state.
---@see luassert.remove_formatter
function state.remove_formatter(callback, s) end

---Formats an argument using the formatters in the state.
---If no formatter that can handle the argument is found, the previous states will be checked.
---@param val any The value to format.
---@param s? luassert.state.snapshot The state to check for a formatter. Defaults to the current state.
---@param fmtargs? any Additional arguments to pass to the formatter.
---@return string?
function state.format_argument(val, s, fmtargs) end

---Sets the value of a parameter on the current state.
---@param name any The parameter name.
---@param value? any The parameter value.
---@see luassert.set_parameter
function state.set_parameter(name, value) end

---Gets the value of a parameter from the state.
---@param name any The parameter name.
---@param s? luassert.state.snapshot The state to retrieve the parameter from. Defaults to the current state.
---@see luassert.get_parameter
function state.get_parameter(name, s) end

---Registers a spy with the current state.
---This is called whenever a new spy is created.
---@param spy luassert.spy
---@see luassert.spy.new
function state.add_spy(spy) end


return state
