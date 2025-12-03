---@meta

---@class luassert.array
local array = {}

---Assert that an array has holes in it.
---@param length? integer The expected length of the array.
---@return integer? holeIndex The index of the first found hole or `nil` if there was no hole.
function array.holes(length) end

array.has_holes = array.holes

---Assert that an array does not have holes in it.
---@param length? integer The expected length of the array.
---@return integer? holeIndex The index of the first found hole or `nil` if there was no hole.
function array.no_holes(length) end

array.has_no_holes = array.no_holes

array.no = array
array.has = array

return array
