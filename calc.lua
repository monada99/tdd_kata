local calc = {}

local string_find = string.find
local string_gmatch = string.gmatch
local string_match = string.match

function checkNegative( str )
    for number in string_gmatch( str, "-%d+" ) do
        return true
    end
    return false
end

function addStringSeparated( str )
    if checkNegative( str ) then
        return nil
    end

    local result = 0
    local threshold = 1000

    for number in string_gmatch( str, "%d+" ) do
        if tonumber(number) <= threshold then
            result = result + number
        end
    end

    return result
end

local function checkCorrectnessString( string, expectedDelimeter )
    for currentDelimeter in string_gmatch( string, "[^0-9]+" ) do
        if currentDelimeter ~= expectedDelimeter then
            return false
        end
    end

    return true
end

local function returnCustomDelimeters()
    local customDelimeters = { ',', '\n' }
    return customDelimeters
end

local function pullDelimetersAndString( str )
    local delimeters, numbers = string_match( str, "//(.+)\n(.+)" )
    local pair = {}

    if delimeters == nil then
        pair.string = str
        pair.delimeters = returnCustomDelimeters()
    else
        pair.string = numbers

        local del = string_match( delimeters, "%b[]" )

        local outputDelimeters = {}

        if del == nil then
            outputDelimeters[1] = delimeters
        else
            while del ~= nil do
                local delimeter = string_match( del, "%[(.+)%]" )
                table.insert( outputDelimeters, delimeter )
                delimeters = string.sub( delimeters, del:len() )
                del = string_match( delimeters, "%b[]")
            end
        end

        pair.delimeters = outputDelimeters
    end
    return pair
end

local function replaceDelimetersOnSymbolInString( pair, symbol )
    local string = pair.string

    for index = 1, #pair.delimeters do
        local delimeter = pair.delimeters[ index ]
        string = string.gsub( string, delimeter, symbol )
    end
    return string
end

function calc.add( str )
    if not str then
        return 0
    end

    if str:len() == 0 then
        return 0
    end

    local pair = pullDelimetersAndString(str)
    local separator = ','

    local newString = replaceDelimetersOnSymbolInString( pair, separator )

    if checkCorrectnessString( newString, separator ) == false then
        return nil
    end

    return addStringSeparated( newString, separator )
end

return calc
