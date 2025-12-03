---@meta

---@class luassert.util
local util = {}

---@class luassert.packed
---@field [integer] any Argument values.
---@field n integer The number of arguments.

---A list of arguments. These are marked with a metatable to identify them.
---@see luassert.util.make_arglist
---@class luassert.arglist : luassert.packed

---Information about copied arguments. This contains deep copies and references.
---@see luassert.util.copyargs
---@class luassert.argcopy
---@field vals luassert.arglist A deep copy of the argument list.
---@field refs luassert.arglist A shallow copy of the argument list.

---Checks whether an element is callable.
---The object must either be a function or have a metatable which contains a `__call` function.
---@param object any
---@return boolean
function util.callable(object) end

---Clears arguments from an argument list. This also unsets the `n` field.
---@param args luassert.arglist The argument list to clear.
function util.cleararglist(args) end

---Copies arguments as a list containing both deep copies and references.
---@param args luassert.arglist The argument list to copy.
---@return luassert.argcopy
function util.copyargs(args) end

---Compares two values for deep equality.
---@param t1? any The first value for comparison.
---@param t2? any The second value for comparison.
---@param ignore_mt? boolean Flag for preventing checking metatables for an `__eq` method.
---@return boolean
function util.deepcompare(t1, t2, ignore_mt) end

---Returns a deep copy of the table.
---@param t table The table to copy.
---@param deepmt? boolean Flag for whether the metatable should be deepcopied as well, if present. Defaults to `false`.
---@return table
function util.deepcopy(t, deepmt) end

---Finds the first level not defined in the same file as the caller.
---@param level? integer The level to use for the source file.
---@return integer level The level to use for reporting an error.
function util.errorlevel(level) end

---Extracts namespace keys from a list of tokens.
---@param nspace string The name of the namespace to extract from.
---@param tokens string[] Tokens to search for keys.
---@return string[] extracted
function util.extract_keys(nspace, tokens) end

---Checks whether an element is convertible to a string.
---The object must either be a string or have a metatable which contains a `__tostring` function.
---@param object any
---@return boolean
function util.hastostring(object) end

---Checks whether a table is an `arglist`.
---@param object any
---@return TypeGuard<luassert.arglist>
function util.is_arglist(object) end

---Stores a list of arguments for a call or return values as a table.
---@param ... any
---@return luassert.arglist
function util.make_arglist(...) end

---Finds matching arguments or return values in a saved list.
---@param invocations_list luassert.argcopy[] The list of arguments to search.
---@param specs any[] The list of arguments or matchers to match.
---@return luassert.argcopy? last_match The last match if a match is found, otherwise `nil`.
function util.matchargs(invocations_list, specs) end

---Finds a matching argument list within a list of arguments and matchers.
---@param oncalls luassert.argcopy[] The list of arguments and matchers to search.
---@param args any[] The list of arguments to match.
---@return luassert.argcopy? last_match The last match if a match is found, otherwise `nil`.
function util.matchoncall(oncalls, args) end

---Returns a table with the passed elements, including an `n` field
---for the number of passed in arguments.
---@param ... any Arguments to pack.
---@return luassert.packed
---@see luassert.util.unpack
function util.pack(...) end

---Returns a shallow copy of the table.
---This also copies the table metatable, if present.
---@param t table The table to copy.
---@return table
function util.shallowcopy(t) end

---Inserts a value into a table. Respects `nil` values by checking for an `n` field.
---If the `n` field is not present, it will be set.
---@param t table The table to insert a value into.
---@param pos? integer The position in the table where the value should be inserted.
---If inserting a `nil` value, this is not optional. Defaults to the end of the list.
---@param val any The value to insert.
---@overload fun(t: table, val: any)
---@overload fun(t: table, pos?: integer, val: any)
function util.tinsert(t, pos, val) end

---Removes a value from a table. Respects `nil` values by checking for an `n` field.
---If the `n` field is not present, it will be set.
---@param t table The table to insert a value into.
---@param pos? integer The position in the table where the value should be removed. Defaults to the end of the list.
---@return any removed
function util.tremove(t, pos) end

---Unpacks the contents of a list.
---This works equivalently to `unpack`, but respects an `n` field for the list size.
---@param t table | luassert.packed The table to unpack.
---@param i? integer The start index. Defaults to `1`.
---@param j? integer The end index. Defaults to the table length, determined by `n` if present and the `#` operator otherwise.
---@return any...
---@see luassert.util.pack
function util.unpack(t, i, j) end


return util
