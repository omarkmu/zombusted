---@meta

---@class luassert.stub.factory
---Function similarly to spies, except that stubs do not call the function that they replace.
---### Example
---```
---describe("Stubs", function()
---    local t = {
---        lottery = function(...)
---            print("Your numbers: " .. table.concat({ ... }, ","))
---        end,
---    }
---
---    it("Tests stubs", function()
---        local myStub = stub.new(t, "lottery")
---
---        t.lottery(1, 2, 3) -- does not print
---        t.lottery(4, 5, 6) -- does not print
---
---        assert.stub(myStub).called_with(1, 2, 3)
---        assert.stub(myStub).called_with(4, 5, 6)
---        assert.stub(myStub).called(2)
---        assert.stub(myStub).called_less_than(3)
---
---        myStub:revert()
---
---        t.lottery(10, 11, 12) -- prints
---    end)
---end)
---```
---@overload fun(object: table, key: string, ...: any): luassert.stub
---@overload fun(object: table, key: string, default: function): luassert.stub
---@overload fun(object: nil, key: nil, ...: any): luassert.stub
local stub_factory = {}

---Creates a new stub that replaces a method in a table in place.
---@param object table The object that the method is in.
---@param key string The key of the method in the `object` to replace.
---@param ... any A function to invoke as the default implementation, or return values for the stub.
---@return luassert.stub stub A stub object that can be used to perform assertions.
---@overload fun(object: table, key: string, default: function): luassert.stub
---@overload fun(object: nil, key: nil, ...: any): luassert.stub
function stub_factory.new(object, key, ...) end

return stub_factory
