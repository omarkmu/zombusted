---@meta _

---Creates multiple tests using the data passed to the function.
---@generic T
---@param name string The test name.
---Provided data can be interpolated into the name using `{key}`,
---where `key` is a table key.
---
---`{0}` can be used to get the argument value.
---
---Data that is not interpolated will be indicated after the name.
---@param block fun(arg: T) The function to execute for each test.
---@param data T[] A list of test case data to pass to the test.
function theory(name, block, data) end

---Creates multiple tests using the data passed to the function.
---@generic T
---@param name string The test name.
---Provided data can be interpolated into the name using `{key}`,
---where `key` is a table key.
---
---`{0}` can be used to get the argument value.
---
---Data that is not interpolated will be indicated after the name.
---@param block fun(arg: T) The function to execute for each test.
---@param ... T Values to pass to the function.
function theory(name, block, ...) end
