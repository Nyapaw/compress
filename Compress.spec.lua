--Compress.spec.lua
--iiau, Wed Apr 05 2023

local ServerStorage = game:GetService("ServerStorage")
local Compress = require(path.to.Compress)

return function()
    describe("generateGUID", function()
        it("should create a GUID of length 16", function()
            local guid = Compress.generateGUID()
            expect(#guid).to.equal(16)
            print(guid)
        end)
    end)

    describe("shrink and expand", function()
        it("should turn an even length hex number len=8 into string len=4, and back", function()
            local num = "abcdef12"
            local str = Compress.shrink(num)
            print(str)
            expect(#str).to.equal(4)
            local num2 = Compress.expand(str)
            expect(num2).to.equal(num)
        end)

        it("should turn an odd length hex number len=7 into string len=4, and back", function()
            local num = "abcde12"
            local str = Compress.shrink(num)
            print(str)
            expect(#str).to.equal(4)
            local num2 = Compress.expand(str)
            expect(num2).to.equal(num)
        end)

        it("should pass the \"Hello world!\" test", function()
            local num = "48656c6c6f20776f726c6421"
            local str = Compress.shrink(num)
            print(str)
            expect(#str).to.equal(12)
            local num2 = Compress.expand(str)
            expect(num2).to.equal(num)
        end)
    end)
end
