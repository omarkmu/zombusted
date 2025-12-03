---@meta _

--#region Instance

---An instance of a stub.
---@class luassert.stub : luassert.spy
local stub = {}

---Sets the default implementation to invoke when calling the stub.
---This will be used if not matched by a more specific implementation specified by `on_call_with`.
---@param callback function The function to invoke when the stub is called.
---@return luassert.stub
function stub.invokes(callback) end

---Sets the default implementation to a function which returns the given values.
---This will be used if not matched by a more specific implementation specified by `on_call_with`.
---@param ... any Return values for the stub function.
---@return luassert.stub
function stub.returns(...) end

---Returns an object that can be used to set an implementation for the stub based on given arguments.
---
---If the stub is called with arguments matching the argument list, the implementation set on the
---return value will be used.
---@param ... any Argument values or matchers that should call the implementation for matched calls.
---@return luassert.stub.implementation
function stub.on_call_with(...) end

stub.by_default = {
    invokes = stub.invokes,
    returns = stub.returns,
}

--#endregion

--#region Stub Implementations

---@class luassert.stub.implementation
local stub_implementation = {}

---Sets the stub function for the matched arguments to a function which returns the given values.
---@param ... any Return values for the implementation.
---@return luassert.stub
function stub_implementation.returns(...) end

---Sets the callback to invoke when calling the stub with matching arguments.
---@param callback function The function to invoke when the stub implementation is called.
---@return luassert.stub
function stub_implementation.invokes(callback) end

--#endregion
