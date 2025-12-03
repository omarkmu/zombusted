---@meta

---Helpers for defining and registering assertions.
---@class zombusted.helpers
local helpers = {}

---@alias zombusted.lua.operation
---| '#'
---| '<'
---| '>'
---| '<='
---| '>='
---| '..'

---Asserts that at least `n` arguments were passed to the assertion.
---@param n integer The expected number of arguments.
---@param received integer The received number of arguments.
---@param name string The name of the assertion.
---@param level integer The level for the assert.
function helpers.argCount(n, received, name, level) end

---Asserts that an argument is a number and returns it.
---@param argument any The argument value.
---@param idx integer The index of the argument.
---@param name string The name of the assertion.
---@param level integer The level for the assert.
---@param typestring? string The type description to use in the error message.
---@return number
function helpers.argIsNumber(argument, idx, name, level, typestring) end

---Asserts that an argument is a number or nil and returns it.
---@param argument any The argument value.
---@param idx integer The index of the argument.
---@param name string The name of the assertion.
---@param level integer The level for the assert.
---@return number?
function helpers.argIsNumberOrNil(argument, idx, name, level) end

---Asserts that an argument is a string and returns it.
---@param argument any The argument value.
---@param idx integer The index of the argument.
---@param name string The name of the assertion.
---@param level integer The level for the assert.
---@param typestring? string The type description to use in the error message.
---@return string
function helpers.argIsString(argument, idx, name, level, typestring) end

---Asserts that an argument is a string or nil and returns it.
---@param argument any The argument value.
---@param idx integer The index of the argument.
---@param name string The name of the assertion.
---@param level integer The level for the assert.
---@return string?
function helpers.argIsStringOrNil(argument, idx, name, level) end

---Asserts that an argument is a table and returns it.
---@param argument any The argument value.
---@param idx integer The index of the argument.
---@param name string The name of the assertion.
---@param level integer The level for the assert.
---@param typestring? string The type description to use in the error message.
---@return table
function helpers.argIsTable(argument, idx, name, level, typestring) end

---Asserts that an argument is a table or nil and returns it.
---@param argument any The argument value.
---@param idx integer The index of the argument.
---@param name string The name of the assertion.
---@param level integer The level for the assert.
---@return table?
function helpers.argIsTableOrNil(argument, idx, name, level) end

---Asserts that an argument supports operations and returns it.
---@param argument any The argument value.
---@param idx integer The index of the argument.
---@param name string The name of the assertion.
---@param level integer The level for the assert.
---@param ... zombusted.lua.operation The operations to check for.
---@return any
function helpers.argSupportsOps(argument, idx, name, level, ...) end

---Returns an error message for a bad argument type.
---@param argument any The argument value.
---@param idx integer The index of the argument.
---@param name string The name of the assertion.
---@param typestring string The type description to use in the error message.
function helpers.badArg(argument, idx, name, typestring) end

---Registers an assertion with positive and negative strings matching its name.
---@param name string
---@param func fun(state: table, args: table): boolean
---@param idName? string
function helpers.register(name, func, idName) end

---Sets the failure message to the given string if it is not `nil`.
---@param state table
---@param message? string
function helpers.setFailureMessage(state, message) end

---Checks whether a value supports all of the given operations.
---@param value any
---@param ... zombusted.lua.operation
---@return boolean
function helpers.supportsOperations(value, ...) end

return helpers
