---@meta _

---@class luassert.spy
local spy = {}

---@class luassert.stub
local stub = {}

---@class luassert.state.snapshot
local snapshot = {}

---@class luassert.stub.factory
local stub_factory = {}

---Automatically reverts the spy at the end of the current context.
---@param enable? boolean Whether auto-reverting should be enabled for the spy. Defaults to `true`.
---@return luassert.spy
function spy:auto_revert(enable) end

---Automatically reverts the stub at the end of the current context.
---@param enable? boolean Whether auto-reverting should be enabled for the stub. Defaults to `true`.
---@return luassert.stub
function stub:auto_revert(enable) end

---Automatically reverts to the snapshot at the end of the current context.
---@param enable? boolean Whether auto-reverting should be enabled for the snapshot. Defaults to `true`.
---@return luassert.state.snapshot
function snapshot:auto_revert(enable) end

---Creates a stub for the return value of `require` when given a require path.
---Returns the stub that can be used for implementations and assertions.
---@param mod string The require path to stub. This must match the expected require exactly.
---@param ... any Return values from the require, or a function to invoke on require.
---@return luassert.stub
---@overload fun(mod: string, callback: function): luassert.stub
function stub_factory.module(mod, ...) end
