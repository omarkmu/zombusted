---@meta

---@class luassert.internal.assert
local internal = {}

---@class luassert : luassert.internal.assert
---@overload fun(...: any): ...
local luassert = {}

--#region Assertions

---Assert that `value == true`.
---@param value any The value to confirm is `true`.
---@param msg? string The failure message.
function internal.is_true(value, msg) end

---Assert that `value ~= true`.
---@param value any The value to confirm is not `true`.
---@param msg? string The failure message.
function internal.not_true(value, msg) end

---Assert that `value == false`.
---@param value any The value to confirm is `false`.
---@param msg? string The failure message.
function internal.is_false(value, msg) end

---Assert that `value ~= false`.
---@param value any The value to confirm is not `false`.
---@param msg? string The failure message.
function internal.not_false(value, msg) end

---Assert that `type(value) == "boolean"`.
---@param value any The value to confirm is of type `boolean`.
---@param msg? string The failure message.
function internal.boolean(value, msg) end

---Assert that `type(value) ~= "boolean"`.
---@param value any The value to confirm is not of type `boolean`.
---@param msg? string The failure message.
function internal.not_boolean(value, msg) end

---Assert that `type(value) == "number"`.
---@param value any The value to confirm is of type `number`.
---@param msg? string The failure message.
function internal.number(value, msg) end

---Assert that `type(value) ~= "number"`.
---@param value any The value to confirm is not of type `number`.
---@param msg? string The failure message.
function internal.not_number(value, msg) end

---Assert that `type(value) == "string"`.
---@param value any The value to confirm is of type `string`.
---@param msg? string The failure message.
function internal.string(value, msg) end

---Assert that `type(value) ~= "string"`.
---@param value any The value to confirm is not of type `string`.
---@param msg? string The failure message.
function internal.not_string(value, msg) end

---Assert that `type(value) == "table"`.
---@param value any The value to confirm is of type `table`.
---@param msg? string The failure message.
function internal.table(value, msg) end

---Assert that `type(value) ~= "table"`.
---@param value any The value to confirm is not of type `table`.
---@param msg? string The failure message.
function internal.not_table(value, msg) end

---Assert that `type(value) == "nil"`.
---@param value any The value to confirm is of type `nil`.
---@param msg? string The failure message.
function internal.is_nil(value, msg) end

---Assert that `type(value) ~= "nil"`.
---@generic T
---@param value any The value to confirm is not of type `nil`.
---@param msg? string The failure message.
function internal.not_nil(value, msg) end

---Assert that `type(value) == "userdata"`.
---@param value any The value to confirm is of type `userdata`.
---@param msg? string The failure message.
function internal.userdata(value, msg) end

---Assert that `type(value) ~= "userdata"`.
---@param value any The value to confirm is not of type `userdata`.
---@param msg? string The failure message.
function internal.not_userdata(value, msg) end

---Assert that `type(value) == "function"`.
---@param value any The value to confirm is of type `function`.
---@param msg? string The failure message.
function internal.is_function(value, msg) end

---Assert that `type(value) ~= "function"`.
---@param value any The value to confirm isnot  of type `function`.
---@param msg? string The failure message.
function internal.not_function(value, msg) end

---Assert that `type(value) == "thread"`.
---@param value any The value to confirm is of type `thread`.
---@param msg? string The failure message.
function internal.thread(value, msg) end

---Assert that `type(value) ~= "thread"`.
---@param value any The value to confirm is not of type `thread`.
---@param msg? string The failure message.
function internal.not_thread(value, msg) end

---Assert that a value is truthy.
---@param value any The value to confirm is truthy.
---@param msg? string The failure message.
function internal.truthy(value, msg) end

---Assert that a value is not truthy.
---@param value any The value to confirm is not truthy.
---@param msg? string The failure message.
function internal.not_truthy(value, msg) end

---Assert that a value is falsy.
---@param value any The value to confirm is falsy.
---@param msg? string The failure message.
function internal.falsy(value, msg) end

---Assert that a value is falsy.
---@param value any The value to confirm is not falsy.
---@param msg? string The failure message.
function internal.not_falsy(value, msg) end

---Assert that a callback throws an error.
---@param callback function A callback function that should error.
---@param error? string The specific error message that will be asserted.
---@param msg? string The failure message.
---@return any...
function internal.error(callback, error, msg) end

---Assert that a callback does not throw an error.
---@param callback function A callback function that should error.
---@param error? string The specific error message that will be asserted.
---@param msg? string The failure message.
---@return any...
function internal.no_error(callback, error, msg) end

---Asserts that a value matches a pattern.
---### Example
---```lua
---it("Checks matches() assertion does string matching", function()
---    assert.is.error(function() assert.matches('.*') end)  -- minimum 2 arguments
---    assert.is.error(function() assert.matches(nil, 's') end)  -- arg1 must be a string
---    assert.is.error(function() assert.matches('s', {}) end)  -- arg2 must be convertable to string
---    assert.is.error(function() assert.matches('s', 's', 's', 's') end)  -- arg3 or arg4 must be a number or nil
---    assert.matches("%w+", "test")
---    assert.has.match("%w+", "test")
---    assert.has_no.match("%d+", "derp")
---    assert.has.match("test", "test", nil, true)
---    assert.has_no.match("%w+", "test", nil, true)
---    assert.has.match("^test", "123 test", 5)
---    assert.has_no.match("%d+", "123 test", '4')
---end)
---```
---@param pattern string
---@param actual string | number
---@param init? integer
---@param plain? boolean
---@param msg? string The failure message.
---@return any... matches
---@overload fun(pattern: string, actual: string | number, msg?: string): any...
---@overload fun(pattern: string, actual: string | number, init?: integer, msg?: string): any...
---@overload fun(pattern: string, actual: string | number, init?: integer, plain?: boolean, msg?: string): any...
function internal.matches(pattern, actual, init, plain, msg) end

---Asserts that a value does not match a pattern.
---@param pattern string
---@param actual string | number
---@param init? integer
---@param plain? boolean
---@param msg? string The failure message.
---@return any... matches
---@overload fun(pattern: string, actual: string | number, msg?: string): any...
---@overload fun(pattern: string, actual: string | number, init?: integer, msg?: string): any...
---@overload fun(pattern: string, actual: string | number, init?: integer, plain?: boolean, msg?: string): any...
function internal.not_matches(pattern, actual, init, plain, msg) end

---Assert that two values are near (equal to within a tolerance).
---### Example
---```lua
---it("Checks near() assertion handles tolerances", function()
---    assert.is.error(function() assert.near(0) end)  -- minimum 3 arguments
---    assert.is.error(function() assert.near(0, 0) end)  -- minimum 3 arguments
---    assert.is.error(function() assert.near('a', 0, 0) end)  -- arg1 must be convertable to number
---    assert.is.error(function() assert.near(0, 'a', 0) end)  -- arg2 must be convertable to number
---    assert.is.error(function() assert.near(0, 0, 'a') end)  -- arg3 must be convertable to number
---    assert.is.near(1.5, 2.0, 0.5)
---    assert.is.near('1.5', '2.0', '0.5')
---    assert.is_not.near(1.5, 2.0, 0.499)
---    assert.is_not.near('1.5', '2.0', '0.499')
---end)
---```
---@param expected number The expected value
---@param actual number The actual value
---@param tolerance number The tolerable difference between the two values
---@param msg? string The failure message.
function internal.near(expected, actual, tolerance, msg) end

---Assert that two values are not near (equal to within a tolerance).
---@param expected number The value to check against
---@param actual number The actual value
---@param tolerance number The tolerable difference between the two values
---@param msg? string The failure message.
function internal.not_near(expected, actual, tolerance, msg) end

---Asserts that two items are equal.
---
---When comparing tables, a reference check will be used.
---@param expected any The expected value
---@param actual any The actual value to check
---@param msg? string The failure message.
function internal.equal(expected, actual, msg) end

---Asserts that two items are not equal.
---
---When comparing tables, a reference check will be used.
---@param expected any The value to check against
---@param actual any The actual value to check
---@param msg? string The failure message.
function internal.not_equal(expected, actual, msg) end

---Asserts that two values are considered the "same".
---
---When comparing tables, a deep compare will be performed.
---@param expected any The expected value
---@param actual any The actual value to check
---@param msg? string The failure message.
function internal.same(expected, actual, msg) end

---Asserts that two values are not considered the "same".
---
---When comparing tables, a deep compare will be performed.
---@param expected any The value to check against
---@param actual any The actual value to check
---@param msg? string The failure message.
function internal.not_same(expected, actual, msg) end

---Asserts that the number of arguments passed to the function matches.
---### Example
---```lua
---it("Checks returned_arguments() validates the argument count", function()
---    local f = function() return 1, 2 end
---    assert.returned_arguments(2, f())
---end)
---```
---@param argument_number integer The expected number of following arguments.
---@param ... any Arguments to count.
function internal.returned_arguments(argument_number, ...) end

---Asserts that the number of arguments passed to the function does not match.
---@param argument_number integer The number of following arguments not expected.
---@param ... any Arguments to count.
function internal.not_returned_arguments(argument_number, ...) end

---Asserts that an error message matching the given pattern is thrown by the function.
---### Example
---```lua
---it("Checks error_matches to accept only callable arguments", function()
---    local t_ok = setmetatable( {}, { __call = function() end } )
---    local t_nok = setmetatable( {}, { __call = function() error("some error") end } )
---    local f_ok = function() end
---    local f_nok = function() error("some error") end
---
---    assert.error_matches(f_nok, ".*")
---    assert.no_error_matches(f_ok, ".*")
---    assert.error_matches(t_nok, ".*")
---    assert.no_error_matches(t_ok, ".*")
---end)
-- ```
---@param func function
---@param pattern string
---@param init? integer
---@param plain? boolean
---@param msg? string The failure message.
---@return any...
---@overload fun(func: function, pattern: string, msg?: string): any...
---@overload fun(func: function, pattern: string, init?: integer, msg?: string): any...
---@overload fun(func: function, pattern: string, init?: integer, plain?: boolean, msg?: string): any...
function internal.error_matches(func, pattern, init, plain, msg) end

---Asserts that an error message matching the given pattern is not thrown by the function.
---@param func function
---@param pattern string
---@param init? integer
---@param plain? boolean
---@param msg? string The failure message.
---@return any... matches
---@overload fun(func: function, pattern: string, msg?: string): any...
---@overload fun(func: function, pattern: string, init?: integer, msg?: string): any...
---@overload fun(func: function, pattern: string, init?: integer, plain?: boolean, msg?: string): any...
function internal.no_error_matches(func, pattern, init, plain, msg) end

---Asserts that a table contains only unique elements.
---### Example
---```lua
---it("Checks to see if table1 only contains unique elements", function()
---    local table2 = { derp = false}
---    local table3 = { derp = true }
---    local table1 = { table2, table3 }
---    local tablenotunique = { table2, table2 }
---    assert.is.unique(table1)
---    assert.is_not.unique(tablenotunique)
---end)
---```
---@param arr any[]
---@param deep? boolean
---@param msg? string
---@overload fun(arr: any[], msg: string)
function internal.unique(arr, deep, msg) end

---Asserts that a table does not contain only unique elements.
---@param arr any[]
---@param deep? boolean
---@param msg? string
---@overload fun(arr: any[], msg: string)
function internal.not_unique(arr, deep, msg) end

--#endregion

--#region Assertion Aliases

internal.True = internal.is_true
internal.is_not_true = internal.not_true

internal.False = internal.is_false
internal.is_not_false = internal.not_false

internal.Boolean = internal.boolean
internal.is_boolean = internal.boolean
internal.is_not_boolean = internal.not_boolean

internal.Number = internal.number
internal.is_number = internal.number
internal.is_not_number = internal.not_number

internal.String = internal.string
internal.is_string = internal.string
internal.is_not_string = internal.not_string

internal.Table = internal.table
internal.is_table = internal.table
internal.is_not_table = internal.not_table

internal.Nil = internal.is_nil
internal.is_not_nil = internal.not_nil

internal.Userdata = internal.userdata
internal.is_userdata = internal.userdata
internal.is_not_userdata = internal.not_userdata

internal.Function = internal.is_function
internal.is_not_function = internal.not_function

internal.Thread = internal.thread
internal.is_thread = internal.thread
internal.is_not_thread = internal.not_thread

internal.Truthy = internal.truthy
internal.is_truthy = internal.truthy
internal.is_not_truthy = internal.not_truthy

internal.Falsy = internal.falsy
internal.is_falsy = internal.falsy
internal.is_not_falsy = internal.not_falsy

internal.Error = internal.error
internal.Errors = internal.error
internal.errors = internal.error
internal.has_error = internal.error
internal.no_errors = internal.no_error
internal.has_no_error = internal.no_error
internal.has_no_errors = internal.no_error

internal.Match = internal.matches
internal.match = internal.matches
internal.is_match = internal.matches
internal.is_matches = internal.matches
internal.not_match = internal.not_matches
internal.is_not_match = internal.not_matches
internal.is_not_match = internal.not_matches
internal.is_not_matches = internal.not_matches

internal.Near = internal.near
internal.is_near = internal.near
internal.is_not_near = internal.not_near

internal.Equal = internal.equal
internal.is_equal = internal.equal
internal.are_equal = internal.equal

internal.is_not_equal = internal.not_equal
internal.are_not_equal = internal.not_equal

internal.Same = internal.same
internal.are_same = internal.same
internal.are_not_same = internal.not_same

internal.Error_Match = internal.error_matches
internal.error_match = internal.error_matches
internal.match_error = internal.error_matches
internal.matches_error = internal.error_matches
internal.no_error_match = internal.no_error_matches
internal.no_matches_error = internal.no_error_matches
internal.no_match_error = internal.no_error_matches

internal.Unique = internal.unique
internal.is_unique = internal.unique
internal.is_not_unique = internal.not_unique

--#endregion

--#region Modifiers

---Perform an assertion on a spy object. This will allow you to call further
---functions to perform an assertion.
---@param spy luassert.spy The spy object to begin asserting
---@param msg? string The failure message.
---@return luassert.spy.assert spyAssert A new object that has further assert function options
function internal.spy(spy, msg) end

---Perform an assertion on a stub object. This will allow you to call further
---functions to perform an assertion.
---@param stub luassert.spy The stub object to begin asserting
---@param msg? string The failure message.
---@return luassert.spy.assert stubAssert A new object that has further assert function options
function internal.stub(stub, msg) end

---Perform an assertion on an array object. This will allow you to call further
---function to perform an assertion.
---### Example
---```lua
---local arr = { "one", "two", "three" }
---
---assert.array(arr).has.no.holes()   -- checks the array to not contain holes -> passes
---assert.array(arr).has.no.holes(4)  -- sets explicit length to 4 -> fails
--```
---@param object table<integer, any> The array object to begin asserting
---@return luassert.array arrayAssert A new object that has further assert function options
function internal.array(object) end

---Set the failure message to use for the assertion.
---@param msg? string
---@return luassert.internal.assert
function internal.message(msg) end

internal.is = internal
internal.are = internal
internal.was = internal
internal.has = internal
internal.does = internal

internal.is_not = internal
internal.are_not = internal
internal.was_not = internal
internal.has_no = internal
internal.no_has = internal
internal.does_not = internal
internal.no = internal
internal.Not = internal

--#endregion

--#region API

---@class luassert.level_value
---@field level integer The level of the assert.

---@class luassert.arguments : luassert.packed
---@field nofmt? table<integer, boolean> Associates argument indices to a flag indicating whether formatting should be skipped.
---@field fmtargs? table<integer, any> Associates argument indices to additional values to be passed to the formatter.

---@class luassert.assert.state
---@overload fun(self: luassert.assert.state, ...: any): ...any
---@field mod boolean Set to `false` if the state is negated by a modifier.
---@field tokens string[] The tokens collected in the state.
---@field [string] luassert.assert.state

---Formatters are functions taking a single argument that needs to be converted to a string representation.
---The formatter should examine the value provided, if it can format the value, it should return the formatted string, otherwise it should return `nil`.
---Formatters can be added through `assert:add_formatter(formatter_func)`, and removed by calling `assert:remove_formatter(formatter_func)`.
---
---Example using the included binary string formatter:
---```lua
---local binstring = require("luassert.formatters.binarystring")
---
---describe("Tests using a binary string formatter", function()
---    setup(function()
---        assert:add_formatter(binstring)
---    end)
---
---    teardown(function()
---        assert:remove_formatter(binstring)
---    end)
---
---    it("tests a string comparison with binary formatting", function()
---        local s1, s2 = "", ""
---        for n = 65,88 do
---            s1 = s1 .. string.char(n)
---            s2 = string.char(n) .. s2
---        end
---        assert.are.same(s1, s2)
---    end)
---end)
---```
---
---Because this formatter formats string values, and is added last, it will take precedence over the regular string formatter.
---The results will be:
---```
---Failure: ...ua projects\busted\formatter\spec\formatter_spec.lua @ 13
---tests a string comparison with binary formatting
---...ua projects\busted\formatter\spec\formatter_spec.lua:19: Expected objects to be the same. Passed in:
---Binary string length; 24 bytes
---58 57 56 55 54 53 52 51   50 4f 4e 4d 4c 4b 4a 49  XWVUTSRQ PONMLKJI
---48 47 46 45 44 43 42 41                            HGFEDCBA
---
---Expected:
---Binary string length; 24 bytes
---41 42 43 44 45 46 47 48   49 4a 4b 4c 4d 4e 4f 50  ABCDEFGH IJKLMNOP
---51 52 53 54 55 56 57 58                            QRSTUVWX
---```
---@param callback fun(obj:any):string|nil
function luassert:add_formatter(callback) end

---Formats a table of arguments, replacing argument values with formatted strings.
---@param args Partial<luassert.arguments> | table
---@return string?
function luassert:format(args) end

---Returns a level for a level object, or nil if not a level object.
---@param level any
---@return integer?
---@overload fun(level: luassert.level_value): integer
function luassert:get_level(level) end

---Gets the current value of a snapshot parameter.
---@param name any
---@return any value
function luassert:get_parameter(name) end

---Returns a level object for a level.
---@param level integer
---@return luassert.level_value
function luassert:level(level) end

---Removes a formatter added with `add_formatter`.
---@param callback function
---@see luassert.add_formatter
function luassert:remove_formatter(callback) end

---Used to register custom assertions.
---### Example
---```lua
---it("Checks register creates custom assertions", function()
---    local say = require("say")
---
---    local function has_property(state, arguments)
---        local property = arguments[1]
---        local table = arguments[2]
---        for key in pairs(table) do
---            if key == property then
---                return true
---            end
---        end
---        return false
---    end
---
---    say:set_namespace("en")
---    say:set("assertion.has_property.positive", "Expected property %s in:\n%s")
---    say:set("assertion.has_property.negative", "Expected property %s to not be in:\n%s")
---    assert:register("assertion", "has_property", has_property, "assertion.has_property.positive", "assertion.has_property.negative")
---
---    assert.has_property("name", { name = "jack" })
---    assert.has.property("name", { name = "jack" })
---    assert.not_has_property("surname", { name = "jack" })
---    assert.Not.has.property("surname", { name = "jack" })
---    assert.has_error(function() assert.has_property("surname", { name = "jack" }) end)
---    assert.has_error(function() assert.has.property("surname", { name = "jack" }) end)
---    assert.has_error(function() assert.no_has_property("name", { name = "jack" }) end)
---    assert.has_error(function() assert.no.has.property("name", { name = "jack" }) end)
---end)
---```
---@param namespace 'assertion' | 'matcher' | 'modifier' | string
---@param name string
---@param callback function
---@param positive_message string
---@param negative_message string
function luassert:register(namespace, name, callback, positive_message, negative_message) end

---To register state information, 'parameters' can be used.
---The parameter is included in a snapshot and can hence be restored in between tests.
---### Example
---```lua
---assert:set_parameter("my_param_name", 1)
---local s = assert:snapshot()
---assert:set_parameter("my_param_name", 2)
---s:revert()
---assert.are.equal(1, assert:get_parameter("my_param_name"))
---```
---@param name any
---@param value any
function luassert:set_parameter(name, value) end

---To be able to revert changes created by tests, inserting spies and stubs for example, luassert supports 'snapshots'.
---A snapshot includes the following:
---1. Spies and stubs
---2. Parameters
---3. Formatters
---@return luassert.state.snapshot
function luassert:snapshot() end

---Returns a new assertion state.
---This is used internally to build assertions.
---@return luassert.assert.state
function luassert.state() end

---Unregisters a custom assertion.
---@param namespace 'assertion' | 'matcher' | 'modifier' | string
---@param name string
function luassert:unregister(namespace, name) end

--#endregion

return luassert
