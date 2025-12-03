---@meta

---@class luassert.internal.match
local internal = {}

---Matchers are used to provide flexible argument matching for `called_with` and
---`returned_with` asserts for spies.
---
---Just like with asserts, you can chain a modifier value using `is` or `is_not`,
---followed by the matcher you wish to use.
local match = {} ---@class luassert.match : luassert.internal.match

--#region Matchers

---An instance of a matcher.
---@class luassert.matcher
---@overload fun(self: luassert.matcher, value: any): boolean
---@field name string The name of the matcher.
---@field mod boolean Set to `false` if the matcher is negated by a modifier.
---@field arguments luassert.arglist Arguments passed to the matcher.
---@field callback fun(self: luassert.matcher, value: any): boolean

--- Wildcard match, matches anything.
---
---### Example
---```
---it("tests wildcard matcher", function()
---    local s = spy.new(function() end)
---    local _ = match._
---
---    s("foo")
---
---    assert.spy(s).was_called_with(_)        -- matches any argument
---    assert.spy(s).was_not_called_with(_, _) -- does not match two arguments
---end)
---```
---@type luassert.matcher
match._ = {}

---If you're creating a spy for functions that mutate any properties on a table
---(like `self`) and you want to use `was_called_with`, you should use
---`match.is_ref(obj)`.
---
---### Example
---```lua
---describe("combine matchers", function()
---    local match = require("luassert.match")
---
---    it("tests ref matchers for passed in table", function()
---        local t = { count = 0, }
---        function t.incrby(t, i) t.count = t.count + i end
---
---        local s = spy.on(t, "incrby")
---
---        s(t, 2)
---
---        assert.spy(s).was_called_with(match.is_ref(t), 2)
---    end)
---
---    it("tests ref matchers for self", function()
---        local t = { count = 0, }
---        function t:incrby(i) self.count = self.count + i end
---
---        local s = spy.on(t, "incrby")
---
---        t:incrby(2)
---
---        assert.spy(s).was_called_with(match.is_ref(t), 2)
---    end)
---end)
---```
---@param obj any
---@return luassert.matcher
function internal.Ref(obj) end

internal.ref = internal.Ref
internal.is_ref = internal.Ref

---Check that the value is `true`.
---@return luassert.matcher
function internal.True() end

internal.is_true = internal.True

---Check that the value is `false`.
---@return luassert.matcher
function internal.False() end

internal.is_false = internal.False

---Check that the value is `nil`.
---@return luassert.matcher
function internal.Nil() end

internal.is_nil = internal.Nil

---Check that the value is of type `boolean`.
---@return luassert.matcher
function internal.Boolean() end

internal.boolean = internal.Boolean
internal.is_boolean = internal.Boolean

---Check that the value is of type `number`.
---@return luassert.matcher
function internal.Number() end

internal.number = internal.Number
internal.is_number = internal.Number

---Check that the value is of type `string`.
---@return luassert.matcher
function internal.String() end

internal.string = internal.String
internal.is_string = internal.String

---Check that the value is of type `table`.
---@return luassert.matcher
function internal.Table() end

internal.table = internal.Table
internal.is_table = internal.Table

---Check that the value is of type `function`.
---@return luassert.matcher
function internal.Function() end

internal.is_function = internal.Function

---Check that the value is of type `userdata`.
---@return luassert.matcher
function internal.Userdata() end

internal.userdata = internal.Userdata
internal.is_userdata = internal.Userdata

---Check that the value is of type `thread`.
---@return luassert.matcher
function internal.Thread() end

internal.thread = internal.Thread
internal.is_thread = internal.Thread

---Check that the value is truthy.
---@return luassert.matcher
function internal.truthy() end

internal.Truthy = internal.truthy
internal.is_truthy = internal.truthy

---Check that the value is falsy.
---@return luassert.matcher
function internal.falsy() end

internal.Falsy = internal.falsy
internal.is_falsy = internal.falsy

---Check that the two values are equal.
---
---When comparing tables, a reference check will be used.
---@param value any The target value
---@return luassert.matcher
function internal.Equals(value) end

internal.equals = internal.Equals
internal.is_equals = internal.Equals

---Check that the two values are considered the "same".
---
---When comparing tables, a deep compare will be performed.
---@param value any The target value
---@return luassert.matcher
function internal.Same(value) end

internal.same = internal.Same
internal.is_same = internal.Same

---Match a table with unique values. Will pass if no values are duplicates.
---@param deep? boolean If a deep check should be performed or just the first level
---@return luassert.matcher
function internal.Unique(deep) end

internal.unique = internal.Unique
internal.is_unique = internal.Unique

---Match a certain numerical value with a specified +/- tolerance.
---@param value number The target value
---@param tolerance number The amount that the true value can be off by (inclusive)
---@return luassert.matcher
function internal.Near(value, tolerance) end

internal.near = internal.Near
internal.is_near = internal.Near

---Perform a `string.find()` match.
---@param pattern string String match pattern
---@param init? integer Index of character to start searching for a match at
---@param plain? boolean If the `pattern` should be treated as plain text instead of a pattern
---@return luassert.matcher
function internal.Matches(pattern, init, plain) end

internal.matches = internal.Matches
internal.is_matches = internal.Matches
internal.match = internal.Matches
internal.Match = internal.Matches
internal.is_match = internal.Matches

--#endregion

--#region Inverse Matchers

---Check that the value is **not** `true`.
---@return luassert.matcher
function internal.not_true() end

internal.is_not_true = internal.not_true

---Check that the value is **not** `false`.
---@return luassert.matcher
function internal.not_false() end

internal.is_not_false = internal.not_false

---Check that the value is **not** `nil`.
---@return luassert.matcher
function internal.not_nil() end

internal.is_not_nil = internal.not_nil

---Check that the value is **not** of type `boolean`.
---@return luassert.matcher
function internal.not_boolean() end

internal.not_boolean = internal.not_boolean
internal.is_not_boolean = internal.not_boolean

---Check that the value is **not** of type `number`.
---@return luassert.matcher
function internal.not_number() end

internal.not_number = internal.not_number
internal.is_not_number = internal.not_number

---Check that the value is **not** of type `string`.
---@return luassert.matcher
function internal.not_string() end

internal.not_string = internal.not_string
internal.is_not_string = internal.not_string

---Check that the value is **not** of type `table`.
---@return luassert.matcher
function internal.not_table() end

internal.not_table = internal.not_table
internal.is_not_table = internal.not_table

---Check that the value is **not** of type `function`.
---@return luassert.matcher
function internal.not_function() end

internal.is_not_function = internal.not_function

---Check that the value is **not** of type `userdata`.
---@return luassert.matcher
function internal.not_userdata() end

internal.not_userdata = internal.not_userdata
internal.is_not_userdata = internal.not_userdata

---Check that the value is **not** of type `thread`.
---@return luassert.matcher
function internal.not_thread() end

internal.not_thread = internal.not_thread
internal.is_not_thread = internal.not_thread

---Check that the value is **not** truthy.
---@return luassert.matcher
function internal.not_truthy() end

internal.not_Truthy = internal.not_truthy
internal.is_not_truthy = internal.not_truthy

---Check that the value is **not** falsy.
---@return luassert.matcher
function internal.not_falsy() end

internal.not_Falsy = internal.not_falsy
internal.is_not_falsy = internal.not_falsy

---Check that the two values are **not** equal.
---
---When comparing tables, a reference check will be used.
---@param value any The target value
---@return luassert.matcher
function internal.not_equals(value) end

internal.not_equals = internal.not_equals
internal.is_not_equals = internal.not_equals

---Check that the two values are **not** considered the "same".
---
---When comparing tables, a deep compare will be performed.
---@param value any The target value
---@return luassert.matcher
function internal.not_same(value) end

internal.not_same = internal.not_same
internal.is_not_same = internal.not_same

---Match a table with **not** unique values. Will pass if at least one duplicate is found.
---@param deep boolean If a deep check should be performed or just the first level
---@return luassert.matcher
function internal.not_unique(deep) end

internal.not_unique = internal.not_unique
internal.is_not_unique = internal.not_unique

---Match a certain numerical value outside a specified +/- tolerance.
---@param value number The target value
---@param tolerance number The amount that the true value must be off by (inclusive)
---@return luassert.matcher
function internal.not_near(value, tolerance) end

internal.not_near = internal.not_near
internal.is_not_near = internal.not_near

---Perform a `string.find()` match to find a value that does **not** match.
---@param pattern string String match pattern
---@param init integer Index of character to start searching for a match at
---@param plain boolean If the `pattern` should be treated as plain text instead of a pattern
---@return luassert.matcher
function internal.not_matches(pattern, init, plain) end

internal.not_matches = internal.not_matches
internal.is_not_matches = internal.not_matches
internal.not_match = internal.not_matches
internal.is_not_match = internal.not_matches

--#endregion

--#region Composite Matchers

---Combine matcher matching all provided matchers.
---```lua
---describe("combine matchers", function()
---    local match = require("luassert.match")
---
---    it("tests composite matchers", function()
---        local s = spy.new(function() end)
---
---        s("foo")
---
---        assert.spy(s).was_called_with(match.is_all_of(
---            match.is_not_nil(),
---            match.is_not_number()
---        ))
---    end)
---end)
---```
---@param ... luassert.matcher
function internal.all_of(...) end

internal.is_all_of = internal.all_of

---Combine matcher matching at least one provided matcher.
---```lua
---describe("combine matchers", function()
---    local match = require("luassert.match")
---
---    it("tests composite matchers", function()
---        local s = spy.new(function() end)
---
---        s("foo")
---
---        assert.spy(s).was_called_with(match.is_any_of(
---            match.is_number(),
---            match.is_string(),
---            match.is_boolean()
---        ))
---    end)
---end)
---```
---@param ... luassert.matcher
function internal.any_of(...) end

internal.is_any_of = internal.any_of

---Combine matcher matching none of the provided matchers.
---```lua
---describe("combine matchers", function()
---    local match = require("luassert.match")
---
---    it("tests composite matchers", function()
---        local s = spy.new(function() end)
---
---        s("foo")
---
---        assert.spy(s).was_called_with(match.is_none_of(
---            match.is_number(),
---            match.is_table(),
---            match.is_boolean()
---        ))
---    end)
---end)
---```
---@param ... luassert.matcher
function internal.none_of(...) end

internal.is_none_of = internal.none_of

--#endregion

--#region Modifiers

---Match on the following matcher.
internal.is = internal

---Match on the inverse of the following matcher.
internal.is_not = internal

--#endregion

--#region API

---@class luassert.match.state
---@overload fun(self: luassert.match.state, ...: any): ...any
---@field mod boolean Set to `false` if the state is negated by a modifier.
---@field tokens string[] The tokens collected in the state.
---@field [string] luassert.match.state

---Check that the provided object is a matcher.
---@param object any The object to confirm is a matcher.
---@return boolean isMatcher If the object is a matcher or not.
---@return_cast object luassert.matcher
function match.is_matcher(object) end

---Check that the provided object is a ref matcher.
---@param object any The object to confirm is a ref matcher.
---@return boolean isMatcher If the object is a ref matcher or not.
---@return_cast object luassert.matcher
function match.is_ref_matcher(object) end

---Returns a new matcher state.
---This is used internally to build matchers.
---@return luassert.match.state
function match.state() end

--#endregion

return match
