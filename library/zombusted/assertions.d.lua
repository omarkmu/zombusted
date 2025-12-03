---@meta _

---@class luassert.internal.assert
local internal = {}

--#region Additional Assertions

---Asserts that `value` is between `min` and `max`, inclusive.
---
---Non-numeric values require `__lt` and `__le` metamethods.
---@param min number | table | userdata
---@param max number | table | userdata
---@param value number | table | userdata
---@param msg? string
function internal.between(min, max, value, msg) end

---Asserts that `value` is not between `min` and `max`, inclusive.
---
---Non-numeric values require `__lt` and `__le` metamethods.
---@param min number | table | userdata
---@param max number | table | userdata
---@param value number | table | userdata
---@param msg? string
function internal.not_between(min, max, value, msg) end

---Asserts that `value` is greater than `expected`.
---
---Non-numeric values require an `__le` metamethod.
---@param expected number | table | userdata
---@param value number | table | userdata
---@param msg? string
function internal.greater(expected, value, msg) end

---Asserts that `value` is not greater than `expected`.
---
---Non-numeric values require an `__le` metamethod.
---@param expected number | table | userdata
---@param value number | table | userdata
---@param msg? string
function internal.not_greater(expected, value, msg) end

---Asserts that `value` is greater than or equal to `expected`.
---
---Non-numeric values require an `__lt` metamethod.
---@param expected number | table | userdata
---@param value number | table | userdata
---@param msg? string
function internal.greater_or_eq(expected, value, msg) end

---Asserts that `value` is not greater than or equal to `expected`.
---
---Non-numeric values require an `__lt` metamethod.
---@param expected number | table | userdata
---@param value number | table | userdata
---@param msg? string
function internal.not_greater_or_eq(expected, value, msg) end

---Asserts that `value` is less than `expected`.
---
---Non-numeric values require an `__lt` metamethod.
---@param expected number | table | userdata
---@param value number | table | userdata
---@param msg? string
function internal.less(expected, value, msg) end

---Asserts that `value` is not less than `expected`.
---
---Non-numeric values require an `__lt` metamethod.
---@param expected number | table | userdata
---@param value number | table | userdata
---@param msg? string
function internal.not_less(expected, value, msg) end

---Asserts that `value` is less than or equal to `expected`.
---
---Non-numeric values require an `__le` metamethod.
---@param expected number | table | userdata
---@param value number | table | userdata
---@param msg? string
function internal.less_or_eq(expected, value, msg) end

---Asserts that `value` is not less than or equal to `expected`.
---
---Non-numeric values require an `__le` metamethod.
---@param expected number | table | userdata
---@param value number | table | userdata
---@param msg? string
function internal.not_less_or_eq(expected, value, msg) end

--#endregion

internal.Between = internal.between
internal.is_between = internal.between
internal.is_not_between = internal.not_between

internal.Greater = internal.greater
internal.is_greater = internal.greater
internal.is_not_greater = internal.not_greater

internal.Greater_Or_Eq = internal.greater_or_eq
internal.is_greater_or_eq = internal.greater_or_eq
internal.is_not_greater_or_eq = internal.not_greater_or_eq

internal.Less = internal.less
internal.is_less = internal.less
internal.is_not_less = internal.not_less

internal.Less_Or_Eq = internal.less_or_eq
internal.is_less_or_eq = internal.less_or_eq
internal.is_not_less_or_eq = internal.not_less_or_eq
