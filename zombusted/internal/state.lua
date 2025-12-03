---Shared state information.

---@class zombusted.state
local state = {}

local internal = {}
local expect = { busted = true }

setmetatable(state, {
    __index = function(_, k)
        if k == 'api' then
            return state.busted.api
        end

        local value = internal[k]
        if value == nil and expect[k] then
            error('zombusted was not initialized with a reference to busted')
        end

        return value
    end,
    ___newindex = function(_, k, v)
        internal[k] = v
    end,
})

return state
