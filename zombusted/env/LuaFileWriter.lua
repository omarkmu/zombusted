---Implementation of LuaFileWriter that writes to a buffer table.
---@diagnostic disable: undefined-field, inject-field

local LuaFileWriter = {}
LuaFileWriter.__index = LuaFileWriter
require 'zombusted.env.install' ('LuaFileWriter', LuaFileWriter)


function LuaFileWriter:write(text)
    self.buffer[#self.buffer + 1] = text
end

function LuaFileWriter:writeln(text)
    self.buffer[#self.buffer + 1] = text
    self.buffer[#self.buffer + 1] = '\r\n'
end

function LuaFileWriter:close()
    self.closed = true
    self.fileHandle.content = table.concat(self.buffer)
    self.fileHandle.isWriting = false
end

function LuaFileWriter.newMock(fileHandle, buffer)
    local this = setmetatable({}, LuaFileWriter)
    this.closed = false
    this.buffer = buffer or {}
    this.fileHandle = fileHandle

    fileHandle.isWriting = true

    return this
end
