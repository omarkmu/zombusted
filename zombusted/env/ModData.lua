---Declares a mock ModData table.
---@diagnostic disable: unused-local

local state = require 'zombusted.zomboid.state'

local ModData = {}
require 'zombusted.env.install' ('ModData', ModData)

function ModData.add(tag, table)
    state.MOD_DATA[tag] = table
end

function ModData.get(tag)
    return state.MOD_DATA[tag]
end

function ModData.getOrCreate(tag)
    if not state.MOD_DATA[tag] then
        state.MOD_DATA[tag] = {}
    end

    return state.MOD_DATA[tag]
end
