---Mock player object for tests. Implements the minimum members for tests.
---@namespace zombusted

local Color = require 'zombusted.zomboid.Color'
local SurvivorDesc = require 'zombusted.zomboid.SurvivorDesc'

---@class zomboid.IsoPlayer
---@field private _username string
---@field private _onlineID number
---@field private _speechColor Color
---@field private _survivorDesc zomboid.SurvivorDesc
---@field private _isDead boolean
---@field private _accessLevel string
---@field private _faction string?
local IsoPlayer = {}
IsoPlayer.__index = IsoPlayer
IsoPlayer.NEXT_ONLINE_ID = 0

function IsoPlayer:getAccessLevel()
    local level = self._accessLevel:lower()

    if level == 'admin' then
        return 'Admin'
    elseif level == 'moderator' then
        return 'Moderator'
    elseif level == 'overseer' then
        return 'Overseer'
    elseif level == 'gm' then
        return 'GM'
    elseif level == 'observer' then
        return 'Observer'
    end

    return 'None'
end

function IsoPlayer:getDescriptor() return self._survivorDesc end

function IsoPlayer:getSpeakColour() return self._speechColor end

function IsoPlayer:getUsername() return self._username end

function IsoPlayer:getOnlineID() return self._onlineID end

function IsoPlayer:getPlayerNum() return 0 end

---@param accessLevel string
---@return boolean
function IsoPlayer:isAccessLevel(accessLevel)
    return self._accessLevel == accessLevel:lower()
end

function IsoPlayer:isDead() return false end

---@param args? Args.IsoPlayer
---@return zomboid.IsoPlayer
function IsoPlayer:newMock(args)
    ---@type zomboid.IsoPlayer
    local this = setmetatable({}, self)

    args = args or {}
    this._username = args.username or 'Username'

    if args.onlineID then
        this._onlineID = args.onlineID
    else
        this._onlineID = self.NEXT_ONLINE_ID
        self.NEXT_ONLINE_ID = self.NEXT_ONLINE_ID + 1
    end

    local color = args.speechColor or { r = 48, g = 48, b = 48 }
    this._speechColor = Color.new(color.r, color.g, color.b)
    this._survivorDesc = SurvivorDesc:newMock { forename = args.forename, surname = args.surname }
    this._accessLevel = 'none'
    this._faction = args.faction

    return this
end

return IsoPlayer
