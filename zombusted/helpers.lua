---Assertion helpers.

local s = require 'say'
local assert = require 'luassert'
local util = require 'luassert.util'


---Helpers for defining and registering assertions.
---@class zombusted.helpers
local helpers = {}

local opMeta = {
    ['#'] = '__len',
    ['<'] = '__lt',
    ['<='] = '__le',
    ['>'] = '__le',
    ['>='] = '__lt',
    ['..'] = '__concat',
}

local opName = {
    ['#'] = 'length',
    ['..'] = 'concatenation',
}

---Gets the type string to use for `supportsOps`.
---@return string
local function opTypeString(...)
    local operations = {}

    local hasConcat = false
    for i = 1, select('#', ...) do
        local op = select(i, ...)
        hasConcat = hasConcat or op == '..'

        operations[#operations + 1] = opName[op] or op
    end

    local prefix = hasConcat and 'string, number, or' or 'number or'

    local last = operations[#operations]
    operations[#operations] = nil

    local opString = #operations == 0 and last or (table.concat(operations, ', ') .. ' and ' .. last)
    return prefix .. ' object that supports ' .. opString
end

---Asserts that at least `n` arguments were passed to the assertion.
---@param n integer
---@param received integer
---@param name string
---@param level integer
function helpers.argCount(n, received, name, level)
    local msg = s('assertion.internal.argtolittle', { name, n, tostring(received) })
    assert(received >= n, msg, level + 1)
end

---Asserts that an argument is a number and returns it.
---@param argument any
---@param idx integer
---@param name string
---@param level integer
---@param typestring? string
---@return number
function helpers.argIsNumber(argument, idx, name, level, typestring)
    local value = tonumber(argument)
    typestring = typestring or 'number or object convertible to a number'

    assert(value, helpers.badArg(argument, idx, name, typestring or 'table'), level + 1)
    return value
end

---Asserts that an argument is a number or nil and returns it.
---@param argument any
---@param idx integer
---@param name string
---@param level integer
---@return number?
function helpers.argIsNumberOrNil(argument, idx, name, level)
    if argument == nil then
        return
    end

    return helpers.argIsNumber(argument, idx, name, level + 1, 'nil, number, or object convertible to number')
end

---Asserts that an argument is a string and returns it.
---@param argument any
---@param idx integer
---@param name string
---@param level integer
---@param typestring? string
---@return string
function helpers.argIsString(argument, idx, name, level, typestring)
    typestring = typestring or 'string or object convertible to a string'
    local msg = helpers.badArg(argument, idx, name, typestring)

    assert(util.hastostring(argument) or type(argument) == 'number', msg, level + 1)
    return tostring(argument)
end

---Asserts that an argument is a string or nil and returns it.
---@param argument any
---@param idx integer
---@param name string
---@param level integer
---@return string?
function helpers.argIsStringOrNil(argument, idx, name, level)
    if argument == nil then
        return
    end

    return helpers.argIsString(argument, idx, name, level + 1, 'nil, string, or object convertible to string')
end

---Asserts that an argument is a table and returns it.
---@param argument any
---@param idx integer
---@param name string
---@param level integer
---@param typestring? string
---@return table
function helpers.argIsTable(argument, idx, name, level, typestring)
    local msg = helpers.badArg(argument, idx, name, typestring or 'table')

    assert(type(argument) == 'table', msg, level + 1)
    return argument
end

---Asserts that an argument is a table or nil and returns it.
---@param argument any
---@param idx integer
---@param name string
---@param level integer
---@return table?
function helpers.argIsTableOrNil(argument, idx, name, level)
    if argument == nil then
        return
    end

    return helpers.argIsTable(argument, idx, name, level + 1, 'table or nil')
end

---Asserts that an argument supports operations and returns it.
---@param argument any
---@param idx integer
---@param name string
---@param level integer
---@param ... zombusted.lua.operation
---@return any
function helpers.argSupportsOps(argument, idx, name, level, ...)
    local msg = helpers.badArg(argument, idx, name, opTypeString(...))
    assert(helpers.supportsOperations(argument, ...), msg, level + 1)

    -- return as-is if checking a string for concat
    if type(argument) == 'string' then
        for i = 1, select('#', ...) do
            if select(i, ...) == '..' then
                return argument
            end
        end
    end

    -- convert to a number if possible
    local value = tonumber(argument)
    if value then
        return value
    end

    return argument
end

---Returns an error message for a bad argument type.
---@param argument any
---@param idx integer
---@param name string
---@param typestring string
function helpers.badArg(argument, idx, name, typestring)
    return s('assertion.internal.badargtype', { idx, name, typestring, type(argument) })
end

---Registers an assertion with positive and negative strings matching its name.
---@param name string
---@param func fun(state: table, args: table): boolean
---@param idName? string
function helpers.register(name, func, idName)
    idName = idName or name
    local posId = 'assertion.' .. idName .. '.positive'
    local negId = 'assertion.' .. idName .. '.negative'
    assert:register('assertion', name, func, posId, negId)
end

---Sets the failure message to the given string, if it is not `nil`.
---@param state table
---@param message? string
function helpers.setFailureMessage(state, message)
    if message ~= nil then
        state.failure_message = message
    end
end

---Checks whether a value supports all of the given operations.
---@param value any
---@param ... zombusted.lua.operation
---@return boolean
function helpers.supportsOperations(value, ...)
    for i = 1, select('#', ...) do
        local op = select(i, ...)
        local supports = false
        if op == '..' then
            supports = type(value) == 'string'
        else
            supports = tonumber(value) ~= nil
        end

        if not supports then
            local mt = debug.getmetatable(value)
            if not mt then
                return false
            end

            if type(rawget(mt, opMeta[op])) ~= 'function' then
                return false
            end
        end
    end

    return true
end

return helpers
