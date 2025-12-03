---@meta

---@class busted.compatibility
local compatibility = {}


---Executes a shell command.
---@param command string
---@return boolean success
---@return integer exitcode
function compatibility.execute(command) end

---Handles garabe collection before exit where required.
---@param code integer The exit code.
---@param force? boolean Flag for whether exit should be forced.
function compatibility.exit(code, force) end

---Retrieves the environment table of the function.
---@param f function | integer
---@return table
function compatibility.getfenv(f) end

---Loads a chunk from the given string.
---@param text string
---@param chunkname string
function compatibility.loadstring(text, chunkname) end

---Sets the environment table of the function.
---@param f function | integer
---@param t table
function compatibility.setfenv(f, t) end

---Unpacks the contents of a list.
---@param t table The table to unpack.
---@param i? integer The start index. Defaults to `1`.
---@param j? integer The end index. Defaults to the table length.
function compatibility.unpack(t, i, j) end


return compatibility
