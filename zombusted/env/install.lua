---Helper function to add elements to `_G` without ruining references.

---@generic T
---@param name string
---@param value T
---@return T
return function(name, value)
    local member
    local split = name:find('%.')
    if split then
        member = name:sub(split + 1)
        name = name:sub(1, split - 1)
    end

    if member ~= nil then
        _G[name][member] = value
    else
        _G[name] = value
    end

    return value
end
