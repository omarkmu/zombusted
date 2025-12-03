---Custom luassert assertions added by zombusted.

local helpers = require 'zombusted.helpers'
local util = require 'luassert.util'

---Implementation of custom assertion for checking an operation between two values.
---@param name string
---@param state table
---@param args table
---@param level integer
---@param op zombusted.lua.operation
---@param compare fun(value: number, expected: number): boolean
---@return boolean
local function assertOp(name, state, args, level, op, compare)
    level = level + 2
    helpers.argCount(2, args.n, name, level)

    local expected = helpers.argSupportsOps(args[1], 1, name, level, op)
    local value = helpers.argSupportsOps(args[2], 2, name, level, op)

    util.tinsert(args, 1, util.tremove(args, 2))

    args.nofmt = args.nofmt or {}
    args.nofmt[1] = true
    helpers.setFailureMessage(state, args[3])

    util.tinsert(args, 2, util.tremove(args, 1))
    return compare(value, expected)
end

---Custom assertion for checking whether a number is within a range.
---@param state table
---@param args table
---@param level integer
---@return boolean
local function between(state, args, level)
    level = level + 1
    helpers.argCount(3, args.n, 'between', level)

    local min = helpers.argSupportsOps(args[1], 1, 'between', level, '>=')
    local max = helpers.argSupportsOps(args[2], 3, 'between', level, '<=')
    local value = helpers.argSupportsOps(args[3], 3, 'between', level, '>=', '<=')

    args.nofmt = args.nofmt or {}
    args.nofmt[1] = true
    args.nofmt[2] = true
    helpers.setFailureMessage(state, args[4])

    return value >= min and value <= max
end

---Custom assertion for checking if a number is greater than another number.
---@param state table
---@param args table
---@param level integer
---@return boolean
local function greater(state, args, level)
    return assertOp('greater', state, args, level, '>', function(a, b) return a > b end)
end

---Custom assertion for checking if a number is greater than or equal to another number.
---@param state table
---@param args table
---@param level integer
---@return boolean
local function greaterOrEqual(state, args, level)
    return assertOp('greater_or_equal', state, args, level, '>=', function(a, b) return a >= b end)
end

---Custom assertion for checking if a number is less than another number.
---@param state table
---@param args table
---@param level integer
---@return boolean
local function less(state, args, level)
    return assertOp('less', state, args, level, '<', function(a, b) return a < b end)
end

---Custom assertion for checking if a number is less than or equal to another number.
---@param state table
---@param args table
---@param level integer
---@return boolean
local function lessOrEqual(state, args, level)
    return assertOp('less_or_equal', state, args, level, '<=', function(a, b) return a <= b end)
end

helpers.register('between', between)
helpers.register('greater', greater)
helpers.register('greater_or_eq', greaterOrEqual)
helpers.register('less', less)
helpers.register('less_or_eq', lessOrEqual)
