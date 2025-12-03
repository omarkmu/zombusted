---@meta _

--#region Instance

---An instance of a spy.
---@class luassert.spy
local spy = {}

---Revert the spied on function to its state before being spied on.
---
---Effectively removes spy from spied-on function.
---@return any original
function spy:revert() end

---Clear the call history for this spy.
function spy:clear() end

---Check how many times this spy has been called.
---@generic T
---@param times integer The expected number of calls.
---@param compare? fun(callCount: integer, expected: integer): T A compare function, whose result will be returned as the first return value.
---@return any result By default, `true` if the spy was called `times` times. Will be the result of `compare` if given.
---@return integer calls Number of times called.
---@overload fun(times?: integer): boolean, integer
---@overload fun(times?: integer, compare: fun(callCount: integer, expected: integer): T): T, integer
function spy:called(times, compare) end

---Check that the spy was called with the provided arguments.
---@param args table<integer, any> Arguments that are expected to have been passed to this spy.
---@return boolean was If this spy was called with the provided arguments.
---@return luassert.arglist? arguments If `was == false`, this will be a list of the arguments *last* given to this spy.
---If `was == true`, this will be a list of the arguments given to the matching call of this spy.
function spy:called_with(args) end

---Check that the spy returned the provided values.
---@param args table<integer, any> Arguments that are expected to have been returned by this spy.
---@return boolean did If this spy did return the provided values.
---@return luassert.arglist? returns If `did == false`, this will be an array of the values *last* returned by this spy.
---If `did == true`, this will be an array of the values returned by the matching call of this spy.
function spy:returned_with(args) end

--#endregion

--#region Spy Assertion

---The result of asserting a spy.
---
---Includes functions for performing assertions on a spy.
---@class luassert.spy.assert
local spy_assert = {}

---Assert that the function being spied on was called.
---@param times? integer The number of times the function is expected to have been called.
function spy_assert.called(times) end

spy_assert.was_called = spy_assert.called

---Assert that the function being spied on was not called.
---@param times? integer The number of times the function is not expected to have been called.
function spy_assert.not_called(times) end

spy_assert.was_not_called = spy_assert.not_called

---Assert that the function being spied on was called with the provided parameters.
---@param ... any The parameters that the function is expected to have been called with.
function spy_assert.called_with(...) end

spy_assert.was_called_with = spy_assert.called_with

---Assert that the function being spied on was not called with the provided parameters.
---@param ... any The parameters that the function is expected to not have been called with.
function spy_assert.not_called_with(...) end

spy_assert.was_not_called_with = spy_assert.not_called_with

---Assert that the function being spied on was called at **least** a specified number of times.
---@param times integer The minimum number of times that the spied-on function should have been called.
function spy_assert.called_at_least(times) end

spy_assert.was_called_at_least = spy_assert.called_at_least

---Assert that the function being spied on was called at **most** a specified number of times.
---@param times integer The maximum number of times that the spied-on function should have been called.
function spy_assert.called_at_most(times) end

spy_assert.was_called_at_most = spy_assert.called_at_most

---Assert that the function being spied on was called **more** than the specified number of times.
---@param times integer The number of times that the spied-on function should have been called more than.
function spy_assert.called_more_than(times) end

spy_assert.was_called_more_than = spy_assert.called_more_than

---Assert that the function being spied on was called **less** than the specified number of times.
---@param times integer The number of times that the spied-on function should have been called less than.
function spy_assert.called_less_than(times) end

spy_assert.was_called_less_than = spy_assert.called_less_than

---Check that the spy returned the provided values.
---@param ... any An array of values that are expected to have been returned by this spy.
function spy_assert.returned_with(...) end

spy_assert.was = spy_assert
spy_assert.was_not = spy_assert

--#endregion
