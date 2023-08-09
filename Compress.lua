--Compress.lua
--iiau, Sat Oct 29 2022
--This library allows you to de/Compress numerical data and create compact GUIDs

local Compress = {}
local HttpService = game:GetService('HttpService')

Compress.LUAU_INT_BOUND = 18446744073709552000
Compress.LUAU_HEX_BOUND = 16

--~ return: int
Compress.generateGUID = function(GUID)
    GUID = GUID or HttpService:GenerateGUID(false) --? always an even number of characters
    GUID = GUID:gsub('-', '')
    local strB = ''
    for i = 1, #GUID, 2 do
        strB = strB .. string.char(tonumber(GUID:sub(i, i+1), 16))
    end
    return strB
end

--? args: int or hex string (when isHex=true)
--~ return: string
Compress.shrink = function(input, isHex)
    isHex = isHex or true
    assert(not (not isHex and input > Compress.LUAU_INT_BOUND), "Number too large to compress")

    local hex = isHex and input or string.format("%x", input)
    local strB = ''
    if #hex%2 == 1 then -- pad
        hex = '0' .. hex
    end
    for i = 1, #hex, 2 do
        strB = strB .. string.char(tonumber(hex:sub(i, i+1), 16))
    end
    return strB
end

--? args: string
--~ return: int
Compress.expand = function(input, toHex)
    toHex = toHex or true
    assert(not (not toHex and #input > Compress.LUAU_HEX_BOUND), "Hex string too large to expand")

    local strB = ''
    for i = 1, #input do
        strB = strB .. string.format("%x", string.byte(input:sub(i, i)))
    end
    return toHex and strB or tonumber(strB, 16)
end

--? https://gist.github.com/yi/01e3ab762838d567e65d
Compress.fromHex = function(str)
    return (str:gsub('..', function (cc)
        return string.char(tonumber(cc, 16))
    end))
end

Compress.toHex = function(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end)):lower()
end

return Compress
