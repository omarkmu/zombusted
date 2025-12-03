---@meta
---@namespace zombusted

---Contains mock functionality for Project Zomboid.
local zomboid = {} ---@class zomboid

--#region Helper Functions

---Adds a mod ID as an active mod.
---@param modId string
function zomboid.add_mod(modId) end

---Creates a mock `IsoPlayer` object.
---Also adds the player to the list of online players.
---@param args? Args.IsoPlayer
---@return IsoPlayer
function zomboid.player(args) end

---Reverts all mock data to its original state.
function zomboid.revert() end

---Reverts events to their original state, clearing listeners and newly created events.
function zomboid.revert_events() end

---Reverts the state of `isServer` to return `false`.
---This also updates `isClient`.
function zomboid.revert_is_server() end

---Reverts the mock filesystem to its original state.
function zomboid.revert_files() end

---Reverts the mock mod data to its original state.
function zomboid.revert_mod_data() end

---Removes all player mocks from the list of online players.
function zomboid.revert_players() end

---Reverts `getTimestampMs` so that it gets a real timestamp.
---Also affects `getTimestamp`.
function zomboid.revert_timestamp() end

---Reverts strings to their original state.
function zomboid.revert_strings() end

---Reverts the translator to its original state.
function zomboid.revert_translator() end

---Reverts the UI to its original state, removing all elements.
function zomboid.revert_ui() end

---Sets whether `isAdmin` should return `true`.
---@param admin boolean
function zomboid.set_admin(admin) end

---Adds a mock file to the Lua cache directory.
---@param filename string The name of the file.
---@param content? string The file content. If `nil`, the file will be removed.
function zomboid.set_cache_file(filename, content) end

---Sets whether `getDebug` should return `true`.
---@param debug boolean
function zomboid.set_debug(debug) end

---Sets whether `isServer` should return `true`.
---This also updates `isClient`.
---@param isServer? boolean The value for `isServer`. Defaults to `true`.
function zomboid.set_is_server(isServer) end

---Adds a mock file to a Lua mod directory.
---@param modId string
---@param filename string
---@param content? string
function zomboid.set_mod_file(modId, filename, content) end

---Sets the value of a string.
---@param id string
---@param value? string
function zomboid.set_string(id, value) end

---Sets the return value of `getTimestampMs`.
---Also affects `getTimestamp`.
---@param n integer
function zomboid.set_timestamp(n) end

---Helper for creating a stub for `getActivatedMods`.
---@param list string[] The list of mods that should be used.
---@return luassert.stub
function zomboid.stub_activated_mods(list) end

---Triggers an update for UI elements.
---@param newTimestamp? integer A new value for the mock timestamp. If given `-1`, the timestamp won't be set.
function zomboid.trigger_update_ui(newTimestamp) end

--#endregion

--#region Helper Types

---@class Args.IsoPlayer
---@field username? string A username for the player. Defaults to `Username`.
---@field forename? string A forename for the player character. Defaults to `John`.
---@field surname? string A surname for the player character. Defaults to `Zomboid`.
---@field onlineID? integer The online ID to use for the player. Defaults to an incrementing integer for each mock.
---@field speechColor? table The speech color for the player. Defaults to #303030.
---@field faction? string The player's faction name.

--#endregion

return zomboid
