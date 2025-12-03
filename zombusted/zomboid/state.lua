---Helpers for mocking global function behavior.
---@namespace zombusted

local EventList = require 'zombusted.env.EventList'
local Language = require 'zombusted.zomboid.Language'
local AddEvent = LuaEventManager.AddEvent

---@class zomboid.state
local state = {
    IS_DEBUG = false,
    IS_CLIENT = true,
    IS_SERVER = false,
    TIMESTAMP = nil, ---@type integer?
    STRINGS = {},
    ONLINE_PLAYERS = {},
    MOD_DATA = {},
    LANGUAGE = Language:newMock({ name = 'EN' }),
    DEFAULT_LANGUAGE = Language:newMock({ name = 'EN' }),
    FILES = {
        Mod = {},
        LuaCache = {},
    },
}

---Resets the event list with built-in events.
function state.resetEvents()
    ---@diagnostic disable-next-line: global-in-non-module
    table.wipe(Events)
    for i = 1, #EventList do
        AddEvent(EventList[i])
    end
end

return state
