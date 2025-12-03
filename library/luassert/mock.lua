---@meta

---@alias luassert.mock table<any, luassert.mock | luassert.spy>

---A mock wraps an entire table's functions in spies or mocks
---@class luassert.mock.factory
---@overload fun(object: table, doStubs?: boolean, func?: function, self?: table, key?: string): luassert.mock
local mock = {}

---Create a new mock from a table, wrapping all of it's functions in spies or mocks.
---@param object table<any, any> The table to wrap.
---@param doStubs? boolean If the table should be wrapped with stubs instead of spies.
---@param func? function Callback function used for stubs.
---@param self? table Table to replace with a spy.
---@param key? string The key of the method to replace in `self`.
---@return luassert.mock
function mock.new(object, doStubs, func, self, key) end

---Clears the call history for all spies in the mock.
---@param object luassert.mock
---@return luassert.mock
function mock.clear(object) end

---Reverts all spies in the mock.
---@param object luassert.mock
---@return luassert.mock
function mock.revert(object) end

return mock
