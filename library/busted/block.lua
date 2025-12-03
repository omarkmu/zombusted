---@meta

---@class busted.block
local block = {}

---Executes all blocks of the given type in the parent of the given context.
---Propagation to ancestors is performed *after* executing each block, rather than before.
---
---@param descriptor string
---@param current busted.context
---@param propagate? boolean
---@param err? fun(descriptor: string)
function block.dexecAll(descriptor, current, propagate, err) end

---Executes a context block.
---@param descriptor string
---@param element busted.context
function block.execute(descriptor, element) end

---Executes all blocks of the given type in the parent of the given context.
---@param descriptor string
---@param current busted.context
---@param propagate? boolean
---@param err? fun(descriptor: string)
---@return boolean? success
---@return busted.context? failedContext
function block.execAll(descriptor, current, propagate, err) end

---Executes all blocks of the given type in the parent of the given context.
---Returns a cached result if the block type has already been run.
---@param descriptor string
---@param current busted.context
---@param err? fun(descriptor: string)
---@return boolean? success
function block.execAllOnce(descriptor, current, err) end

---Executes `lazy_setup` blocks in the parent of the given context.
---@param current busted.context
---@param err? fun(descriptor: string)
---@return boolean? success
---@return busted.context? failedContext
function block.lazySetup(current, err) end

---Executes `lazy_teardown` blocks in the parent of the given context.
---@param current busted.context
---@param err? fun(descriptor: string)
---@return boolean? success
---@return busted.context? failedContext
function block.lazyTeardown(current, err) end

---Sets a context to reject the given block type.
---@param descriptor string
---@param element busted.context
function block.reject(descriptor, element) end

---Sets a context to reject all block types.
---@param element busted.context
function block.rejectAll(element) end

---Executes `strict_setup` blocks in the parent of the given context.
---@param current busted.context
---@param err? fun(descriptor: string)
---@return boolean? success
---@return busted.context? failedContext
function block.setup(current, err) end

---Executes `strict_teardown` blocks in the parent of the given context.
---@param current busted.context
---@param err? fun(descriptor: string)
---@return boolean? success
---@return busted.context? failedContext
function block.teardown(current, err) end


---@param busted busted.core
---@return busted.block
local function init(busted) end

return init
