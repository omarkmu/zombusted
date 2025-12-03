---Helpers for creating mocks.
---@namespace zombusted

require 'zombusted.env.Globals'

---@class zomboid
local zomboid = {}

require 'zombusted.zomboid.Color'
require 'zombusted.zomboid.SurvivorDesc'

local Language = require 'zombusted.zomboid.Language'
local IsoPlayer = require 'zombusted.zomboid.IsoPlayer'
local internal = require 'zombusted.internal.state'
local state = require 'zombusted.zomboid.state'


---Adds a mod ID as an active mod.
function zomboid.add_mod(modId)
    local files = state.FILES.Mod
    files[modId] = {}
end

---Helper for creating a mock `IsoPlayer` object and
---adding the player to the list of online players.
---@param args? Args.IsoPlayer
---@return zombusted.zomboid.IsoPlayer
function zomboid.player(args)
    local player = IsoPlayer:newMock(args)
    state.ONLINE_PLAYERS[#state.ONLINE_PLAYERS + 1] = player

    return player
end

-- TODO: snapshot function or include in luassert snapshot
---Reverts all PZ mock data to its original state.
function zomboid.revert()
    zomboid.revert_events()
    zomboid.revert_files()
    zomboid.revert_mod_data()
    zomboid.revert_strings()
    zomboid.revert_timestamp()
    zomboid.revert_translator()
    zomboid.revert_ui()
    zomboid.revert_is_server()
    zomboid.revert_players()
end

---Reverts events to their original state, clearing listeners and newly created events.
function zomboid.revert_events()
    state.resetEvents()
end

---Reverts the mock filesystem to its original state.
function zomboid.revert_files()
    state.FILES.Mod = {}
    state.FILES.LuaCache = {}
end

---Reverts the state of `isServer` to return `false`.
---This also updates `isClient`.
function zomboid.revert_is_server()
    zomboid.set_is_server(false)
end

---Reverts the mock mod data to its original state.
function zomboid.revert_mod_data()
    state.MOD_DATA = {}
end

---Removes all player mocks from the list of online players.
function zomboid.revert_players()
    state.ONLINE_PLAYERS = {}
    IsoPlayer.NEXT_ONLINE_ID = 0
end

---Reverts `getTimestampMs` so that it gets a real timestamp.
---Also affects `getTimestamp`.
function zomboid.revert_timestamp()
    state.TIMESTAMP = nil
end

---Reverts strings to their original state.
function zomboid.revert_strings()
    state.STRINGS = {}
end

---Reverts the translator to its original state.
function zomboid.revert_translator()
    Translator.debug = false
    state.LANGUAGE = Language:newMock({ name = 'EN' })
    state.DEFAULT_LANGUAGE = Language:newMock({ name = 'EN' })
end

---Reverts the UI to its original state, removing all elements.
function zomboid.revert_ui()
    ---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
    UIManager.UI = {}
    UIManager.uiUpdateTimeMS = 0
    UIManager.uiUpdateIntervalMS = 0
    UIManager.doTick = false
    UIManager._toRemove = {}
    UIManager._toAdd = {}
end

---Adds a mock file to the Lua cache directory.
function zomboid.set_cache_file(filename, content)
    local files = state.FILES.LuaCache
    files[filename] = content and { content = content } or nil
end

---Adds a mock file to a Lua mod directory.
function zomboid.set_mod_file(modId, filename, content)
    local files = state.FILES.Mod
    if not files[modId] then
        files[modId] = {}
    end

    files[modId][filename] = content and { content = content } or nil
end

---Sets whether `getDebug` should return `true`.
---@param debug boolean
function zomboid.set_debug(debug)
    state.IS_DEBUG = debug
end

-- TODO: replace with context blocks
---Sets whether `isServer` should return `true`.
---This also updates `isClient`.
---@param isServer boolean
function zomboid.set_is_server(isServer)
    isServer = isServer ~= false
    state.IS_SERVER = isServer
    state.IS_CLIENT = not isServer
end

---Sets the value of a string.
---@param id string
---@param value? string
function zomboid.set_string(id, value)
    state.STRINGS[id] = value
end

-- TODO: use stub
---Sets the return value of `getTimestampMs`.
---Also affects `getTimestamp`.
---@param n integer
function zomboid.set_timestamp(n)
    state.TIMESTAMP = n
end

---Helper for creating a stub for `getActivatedMods`.
---@param list string[]
---@return luassert.stub
function zomboid.stub_activated_mods(list)
    local mods = {}
    local size = #list
    for i = 1, size do
        mods[i - 1] = list[i]
    end

    -- TODO: return a proper ArrayList mock
    return internal.api.stub(_G, 'getActivatedMods', {
        size = function() return size end,
        get = function(_, index) return mods[index] end,
    })
end

---Triggers an update for UI elements.
---@param newTimestamp? integer A new value for the mock timestamp. If given `-1`, the timestamp won't be set.
function zomboid.trigger_update_ui(newTimestamp)
    if newTimestamp and newTimestamp > 0 then
        state.TIMESTAMP = newTimestamp
    end

    UIManager.update()
end

zomboid.revert_events()
return zomboid
