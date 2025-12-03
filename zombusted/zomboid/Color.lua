---Mock object for a `Color`.
---@namespace zombusted

---@class zomboid.Color
---@field private _r integer
---@field private _g integer
---@field private _b integer
local Color = {}
Color.__index = Color
require 'zombusted.env.install' ('Color', Color)


function Color:getRed() return self._r end

function Color:getGreen() return self._g end

function Color:getBlue() return self._b end

---@param r integer
---@param g integer
---@param b integer
---@return Color
function Color.new(r, g, b)
    local this = setmetatable({}, Color)

    this._r = r
    this._g = g
    this._b = b

    return this
end

return Color
