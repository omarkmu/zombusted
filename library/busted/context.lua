---@meta

--#region Factory

---@class busted.context.factory
local factory = {}

---Returns a new context reference.
---@return busted.context.ref
function factory.ref() end

--#endregion

--#region Context

---@class busted.context.ref
local ref = {}

---@class busted.context
---@field descriptor string The descriptor for the context level.
---@field attributes table<string, any> Attributes of the context.
---@field env? table The environment for the context.

---Attaches a child to the current context table.
---@param child busted.context
function ref.attach(child) end

---Gets the child contexts of a context table.
---@param parent busted.context
---@return busted.context[] children
function ref.children(parent) end

---Resets the context.
---This clears all context tables and resets to the initial state.
function ref.clear() end

---Returns the current context table, or an element of the table if given a key.
---@param key? any The key to retrieve from the table.
---@return any | nil
---@overload fun(): busted.context
---@overload fun(key: any): any | nil
function ref.get(key) end

---Gets the parent context of a context table.
---@param child busted.context
---@return busted.context? parent
function ref.parent(child) end

---Sets the current context table to the last element in the stack
---and removes the current context table.
---
---Throws an error if the context stack is empty.
function ref.pop() end

---Sets the context table to the given element
---and pushes the current context table to the stack.
---
---Throws an error if the given context has no parent and is not the top-level context table.
---@param current busted.context
function ref.push(current) end

---Sets a value on the current context table.
---@param key any The key to set.
---@param value any? The value to associate with the key.
function ref.set(key, value) end

--#endregion


---@return busted.context.factory
local function init() end


return init
