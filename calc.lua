
local calc = {}

function checkNegative(str)
	
    for number in string.gmatch(str,"-%d+") do
		return true
	end
	return false
end

function addStringSeparatedDefaultDelimeter(str)

	if checkNegative(str) == true then
        return nil
    end
	
	local result = 0
	
	for number in string.gmatch(str,"%d+") do
		if tonumber(number) <= 1000 then
			result = result + number
		end
	end
	
	return result
end

function checkCorrectnessString(string, expectedDelimeter)
    
    for currentDelimeter in string.gmatch(string, "[^0-9]+") do
       
        if currentDelimeter ~= expectedDelimeter then
            return false
        end
    end
	return true
end

function returnCustomDelimeters()
    
    customDelimeters = {}
    customDelimeters[1] = ','
    customDelimeters[2] = '\n'

    return customDelimeters

end

function pullDelimetersAndString(str)

    result = string.match(str, "//(.+)\n.+")

	pair = {} 

    if result == nil then
        pair.string = str
        pair.delimeters = returnCustomDelimeters()
    else
       
        pair.string = string.match(str, "//.+\n(.+)")

        del = string.match(result, "%b[]")
        
        delimeters = {}

        if del == nil then 
            delimeters[1] = result
        else
            
            while del ~= nil do
                delimeter = string.match(del, "%[(.+)%]")
                table.insert(delimeters, delimeter)
                result = string.sub(result, del:len())
                del = string.match( result, "%b[]")
            end
        end

        pair.delimeters = delimeters
    end
    return pair
end

function calc.add(str)

	if str == nil then 
		return 0
	end
	
	if str:len() == 0 then
		return 0
	end

	pair = pullDelimetersAndString(str)
    
    defaultDelimeters = returnCustomDelimeters()
    
    string = pair.string
    if pair.delimeters ~= defaultDelimeters then
        
        for k, delimeter in pairs(pair.delimeters) do
            string = string.gsub(string, delimeter, defaultDelimeters[1])
        end
        
        if checkCorrectnessString(string, defaultDelimeters[1]) == false then
            return nil
        end
    end
    
    return addStringSeparatedDefaultDelimeter(string)
end

return calc;
