---@meta

---@class luassert.compatibility
local compatibility = {}

---@deprecated Use 'luassert.util.unpack' instead
---@return any ...
---@see luautils.util.unpack
function compatibility.unpack(t, i, j) end

return compatibility
