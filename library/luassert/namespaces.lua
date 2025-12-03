---@meta

---@class luassert.namespaces
---@field assertion luassert.namespace
---@field modifier luassert.namespace
---@field matcher luassert.namespace
---@field [string] luassert.namespace
local namespaces = {}

---@alias luassert.namespace table<string, luassert.namespace.element>

---@class luassert.namespace.element
---@field name string
---@field callback function
---@field positive_message? string
---@field negative_message? string

return namespaces
