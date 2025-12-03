---Implementations of additional global elements for the Kahlua environment.
---@diagnostic disable: duplicate-set-field, missing-global-doc

local install = require 'zombusted.env.install'

install('__classmetatables', setmetatable({}, {
    __index = function()
        return { __index = {} }
    end
}))


local _char = string.char
install('string.char', function(...)
    local s = {}
    for i = 1, select('#', ...) do
        s[#s + 1] = _char((select(i, ...) % 256) --[[@as integer]])
    end

    return table.concat(s)
end)

install('string.contains', function(s, other)
    return s:find(other, 1, true) ~= nil
end)

install('string.sort', function(s, other)
    return s > other
end)

install('string.trim', function(s)
    return (s:gsub('^%s*(.-)%s*$', '%1'))
end)

install('table.pairs', pairs)

install('table.isempty', function(table)
    for _ in pairs(table) do
        return false
    end

    return true
end)

install('table.newarray', function(...)
    local arg = ...
    local argCount = select('#', ...)

    local arr = {}
    if argCount == 1 and type(arg) == 'table' then
        for i = 1, #arg do
            arr[#arr + 1] = arg[i]
        end

        return arr
    end

    for i = 1, argCount do
        arr[#arr + 1] = select(i, ...)
    end

    return arr
end)

install('table.wipe', function(table)
    for k in pairs(table) do
        table[k] = nil
    end
end)

install('newrandom', function()
    return {
        _history = {},

        random = function(self, m, n)
            if self._lastSeed and #self._history > 0 then
                -- replay previous calls on the same seed to act like it's not shared state
                math.randomseed(self._lastSeed)

                for i = 1, #self._history do
                    local values = self._history[i]
                    self:_random(values[1], values[2])
                end
            end

            self._history[#self._history + 1] = { m, n }
            return self:_random(m, n)
        end,

        seed = function(self, value)
            self._lastSeed = value
            self._history = {}
            math.randomseed(value)
        end,

        _random = function(_, m, n)
            if n then
                return math.random(m, n)
            elseif m then
                return math.random(m)
            end

            return math.random()
        end,
    }
end)
