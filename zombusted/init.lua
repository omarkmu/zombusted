---Helper for testing Project Zomboid mods with busted.

local util = require 'luassert.util'
local state = require 'zombusted.internal.state'
require 'zombusted.env.Globals'
require 'zombusted.assertions'
require 'zombusted.languages.en'

local pack = util.pack
local unpack = util.unpack

local zombusted = {}

---@type table<busted.context, function[]>
local testEndCallbacks = {}

---Converts a value to a string for display.
---If the value cannot convert to a string, this converts to a representation of its type.
---@param value string
---@return string
local function str(value)
    local _type = type(value)
    if _type == 'string' then
        return string.format('%q', value)
    end

    if _type == 'number' or _type == 'boolean' or util.hastostring(value) then
        return tostring(value)
    end

    return '(' .. _type .. ')'
end

---Initialization function.
---Must be called to populate the global environment with test functions.
---@param busted busted.instance
function zombusted.init(busted)
    local api = busted.api
    state.busted = busted

    api.stub.module = zombusted.stub_module
    api.spy.new = zombusted.auto_revert_wrap(api.spy.new)
    api.assert.snapshot = zombusted.auto_revert_wrap(api.assert.snapshot)

    busted.export('zomboid', require('zombusted.zomboid'))
    busted.export('reload_module', zombusted.reload_module)
    busted.export('theory', zombusted.theory)
    busted.subscribe({ 'test', 'end' }, zombusted.on_test_end)

    return true
end


---Handles automatically reverting stubs and snapshots.
---@param self any
---@param enable? boolean
function zombusted.auto_revert(self, enable)
    if enable == false then
        self.__auto_revert = nil
        return self
    end

    if self.__auto_revert then
        return self
    end

    self.__auto_revert = true
    return zombusted.with_finally('auto_revert', function(finally)
        finally(function()
            if self.__auto_revert then
                self:revert()
            end
        end)

        return self
    end)
end

---Wraps a constructor function to include the `auto_revert` method.
function zombusted.auto_revert_wrap(f)
    return function(...)
        local success, object = pcall(f, ...)
        if not success then
            error(object, util.errorlevel())
        end

        ---@cast object -string
        rawset(object, 'auto_revert', zombusted.auto_revert)
        return object
    end
end

---Handler for test end.
function zombusted.on_test_end(ctx)
    local callbacks = testEndCallbacks[ctx]
    if not callbacks then
        return
    end

    for i = 1, #callbacks do
        local cb = callbacks[i]
        cb()
    end
end

---Removes a required module from the loaded cache and requires it again.
---@param mod string
---@return ...any
function zombusted.reload_module(mod)
    package.loaded[mod] = nil
    return require(mod)
end

---Stubs the return value of `require`.
---@param ... any
---@return luassert.stub
function zombusted.stub_module(mod, ...)
    package.loaded[mod] = nil
    local old_elem = package.preload[mod]

    -- package.preload members must be functions, so create a dummy stub
    local _stub = state.api.stub(nil, nil, ...) --[[@as any]]
    package.preload[mod] = function(...) return _stub(...) end

    -- wrap revert to reset preload
    local _revert = _stub.revert
    _stub.revert = function(self)
        if not self.reverted then
            _revert(self)
            package.preload[mod] = old_elem
            self.reverted = true
        end

        return old_elem
    end

    return _stub
end

---@generic T
---@param name string The test name.
---@param test fun(arg: T) The function to execute for each test.
---@param ... T Values to pass to the function.
function zombusted.theory(name, test, ...)
    local data = { ... }
    local count = select('#', ...)
    if count == 1 and type(data[1]) == 'table' then
        -- must be a list
        if data[1][1] then
            data = data[1]
            count = #data
        end
    end

    for i = 1, count do
        local args = data[i] --[[@as any]]

        local referenced = {}

        local isTable = type(args) == 'table'
        local testName = name:gsub('{([^}]-)}', function(match)
            local value
            if isTable then
                value = args[match]
                if match == '0' and value == nil then
                    value = args
                end
            else
                value = match == '0' and args or nil
            end

            if value ~= nil then
                referenced[match] = true
                return str(value)
            end

            return '{' .. match .. '}'
        end)

        if isTable then
            local keys = {}
            local isList = true
            for k in pairs(args) do
                if not referenced[k] then
                    keys[#keys + 1] = k
                    if type(k) ~= 'number' then
                        isList = false
                    end
                end
            end

            table.sort(keys, function(a, b)
                return tostring(a) < tostring(b)
            end)

            local nextNumeric = 1
            local argDisplay = {}
            for j = 1, #keys do
                local k = keys[j]
                local v = args[k]
                if isList and k == nextNumeric then
                    nextNumeric = nextNumeric + 1
                else
                    argDisplay[#argDisplay + 1] = tostring(k)
                    argDisplay[#argDisplay + 1] = ': '
                end

                argDisplay[#argDisplay + 1] = str(v)
                argDisplay[#argDisplay + 1] = ', '
            end

            if #argDisplay > 0 then
                argDisplay[#argDisplay] = nil
                testName = testName .. ' [' .. table.concat(argDisplay) .. ']'
            end
        elseif not referenced['0'] then
            testName = testName .. ' [value: ' .. str(args) .. ']'
        end

        state.api.it(testName, function()
            test(args)
        end)
    end
end

---Determines the function to use for reverting a stub, spy, or snapshot
---and sets the context to call it with before calling the callback.
---@param name string
---@param cb fun(finally: function): ... any
---@return ... any
---@private
function zombusted.with_finally(name, cb)
    local ctx = state.busted.context.get() --[[@as any]]
    local desc = ctx.descriptor

    if desc == 'it' then
        local function finally(finallyCb)
            testEndCallbacks[ctx] = testEndCallbacks[ctx] or {}
            local list = testEndCallbacks[ctx]
            list[#list + 1] = finallyCb
        end

        return cb(finally)
    end

    local target
    if desc == 'before_each' then
        target = state.api.after_each
    elseif desc == 'lazy_setup' then
        target = state.api.lazy_teardown
    elseif desc == 'strict_setup' then
        target = state.api.strict_teardown
    else
        error('Invalid context for ' .. name .. ': ' .. tostring(desc), 3)
    end

    state.busted.context.pop()
    local ret = pack(pcall(cb, target))
    state.busted.context.push(ctx)

    if not ret[1] then
        error(ret[2], util.errorlevel())
    end

    return unpack(ret, 2)
end


return zombusted.init
