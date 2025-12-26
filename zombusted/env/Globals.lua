---Declares global functions with fields for mocking.
---@diagnostic disable: deprecated, undefined-field, access-invisible

require 'zombusted.env.Kahlua'
require 'zombusted.env.ui'
require 'zombusted.env.LuaEventManager'
require 'zombusted.env.BufferedReader'
require 'zombusted.env.LuaFileWriter'
require 'zombusted.env.ModData'
require 'zombusted.env.Translator'
local state = require 'zombusted.zomboid.state'
local install = require 'zombusted.env.install'

local os = os
local math = math


-- TODO: replace with proper mock implementation
local function arrayList(t)
    t = t or {}
    local elements = {}
    local size = #t
    for i = 1, size do elements[i - 1] = t[i] end

    return {
        size = function() return size end,
        get = function(_, index) return elements[index] end,
    }
end

local function getVirtualFile(filename, createIfNull, files)
    files = files or state.FILES.LuaCache

    local sep = package.config:sub(1, 1)
    filename = filename:gsub('/', sep):gsub('\\', sep)

    if not files[filename] then
        if not createIfNull then
            return
        end

        files[filename] = { content = '' }
    end

    return files[filename]
end

local function listFilesInDirectory(directory, files)
    if not directory then
        return
    end

    files = files or state.FILES.LuaCache

    local sep = package.config:sub(1, 1)
    directory = directory:gsub('/', sep):gsub('\\', sep)
    if directory:sub(-1) ~= sep then
        directory = directory .. sep
    end

    local list = {}
    for name in pairs(files) do
        if name:sub(1, #directory) == directory then
            name = name:sub(#directory + 1)
            if not name:find(sep) then
                list[#list + 1] = name
            end
        end
    end

    return arrayList(list)
end


install('isAdmin', function() return false end)

install('isClient', function() return state.IS_CLIENT end)

install('isServer', function() return state.IS_SERVER end)

install('getActivatedMods', function() return arrayList() end)

install('Core', { class = {} })
install('getCore', function()
    return {
        getBadHighlitedColor = function()
            return {
                getR = function() return 1 end,
                getG = function() return 0 end,
                getB = function() return 0 end,
                getA = function() return 1 end,
            }
        end,
        getGoodHighlitedColor = function()
            return {
                getR = function() return 0 end,
                getG = function() return 1 end,
                getB = function() return 0 end,
                getA = function() return 1 end,
            }
        end,
    }
end)

install('getDebug', function() return state.IS_DEBUG end)

install('getFileReader', function(filename, createIfNull)
    local file = getVirtualFile(filename, createIfNull)
    if not file then
        return
    end

    return BufferedReader.newMock(file)
end)

install('getFileWriter', function(filename, createIfNull, append)
    local file = getVirtualFile(filename, createIfNull)

    local buffer
    if append and file then
        buffer = { file.content }
    end

    -- recreate bug from game; still pass if null
    return LuaFileWriter.newMock(file, buffer)
end)

install('getModFileReader', function(modId, filename, createIfNull)
    local files = state.FILES.Mod[modId]
    if not files then
        return
    end

    local file = getVirtualFile(filename, createIfNull, files)
    if not file then
        return
    end

    return BufferedReader.newMock(file)
end)

install('getModFileWriter', function(modId, filename, createIfNull, append)
    local files = state.FILES.Mod[modId]
    if not files then
        return
    end

    local file = getVirtualFile(filename, createIfNull, files)

    local buffer
    if append and file then
        buffer = { file.content }
    end

    -- recreate bug from game; still pass if null
    return LuaFileWriter.newMock(file, buffer)
end)

install('getOnlinePlayers', function() return arrayList(state.ONLINE_PLAYERS) end)

install('getNumClassFields', function() return 0 end)

install('getPlayerByOnlineID', function(id)
    for i = 1, #state.ONLINE_PLAYERS do
        local player = state.ONLINE_PLAYERS[i] ---@type any
        if player:getOnlineID() == id then
            return player
        end
    end
end)

install('getPlayerFromUsername', function(username)
    for i = 1, #state.ONLINE_PLAYERS do
        local player = state.ONLINE_PLAYERS[i] ---@type any
        if player:getUsername() == username then
            return player
        end
    end
end)

install('getSpecificPlayer', function(player)
    for i = 1, #state.ONLINE_PLAYERS do
        local playerObj = state.ONLINE_PLAYERS[i] ---@type any
        if playerObj:getPlayerNum() == player then
            return playerObj
        end
    end
end)

install('getText', function(id) return state.STRINGS[id] or id end)

install('getTextOrNull', function(id) return state.STRINGS[id] end)

install('getTimestamp', function()
    if state.TIMESTAMP then
        return math.floor(state.TIMESTAMP / 1000)
    end

    return os.time()
end)

install('getTimestampMs', function()
    if state.TIMESTAMP then
        return state.TIMESTAMP
    end

    local secs = os.time()
    local _, ms = math.modf(os.clock())
    return ((secs + ms) * 1000) --[[@as integer]]
end)

install('listFilesInModDirectory', function(modId, directory)
    if not modId or modId:match('^%s*$') then
        return
    end

    return listFilesInDirectory(directory, state.FILES.Mod[modId] or {})
end)

install('listFilesInZomboidLuaDirectory', function(modId, directory)
    return listFilesInDirectory(modId, directory)
end)

install('sendClientCommand', function(...) end) -- no-op for tests

install('sendServerCommand', function(...) end) -- no-op for tests

install('triggerEvent', function(name, ...)
    LuaEventManager.triggerEvent(name, ...)
end)

install('Locale', {})

install('Faction', {
    getPlayerFaction = function(player)
        if not player._faction then
            return
        end

        return {
            getName = function() return player._faction end,
        }
    end,
})
