---@meta

---@class busted.fixtures
local fixtures = {}


---Loads an executes a Lua file relative from the current test file.
---@param rel_path string The relative path to the file.
---@return any... results The results of the executed file.
function fixtures.load(rel_path) end

---Returns an absolute path to where the current test file is located.
---@param sub_path? string An optional relative path to be appended.
---@return string path The normalized absolute path.
function fixtures.path(sub_path) end

---Reads a file relative from the current test file.
---Throws an error on failure.
---@param rel_path string The relative path to the file.
---@param is_bin? boolean Whether the load the file as a binary file.
---@return string contents The file contents.
function fixtures.read(rel_path, is_bin) end


return fixtures
