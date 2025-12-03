---@meta

---@alias busted.status
---| 'success'
---| 'failure'
---| 'pending'
---| 'error'

---@class busted.helper.status
local status = {}


---Checks whether the status is `'error'`.
---@return boolean
function status:error() end

---Checks whether the status is `'failure'`.
---@return boolean
function status:failure() end

---Returns the status value.
---@return busted.status
function status:get() end

---Checks whether the status is `'pending'`.
---@return boolean
function status:pending() end

---Sets the status value.
---@param status? busted.status | any
function status:set(status) end

---Checks whether the status is `'success'`.
---@return boolean
function status:success() end

---Sets the status value if the current status is success,
---or if the new status is a failure and the current status is pending.
---@param status? busted.status | any
function status:update(status) end


---@param initial_status? busted.status | any
---@return busted.helper.status
local function init(initial_status) end

return init
