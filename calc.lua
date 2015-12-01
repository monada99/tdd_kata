
local calc = {}

function checkNegative(str)
	
	local negativeNumbers = ""
	local wereNegatives = false
	
	for number in string.gmatch(str,"-%d+") do
		
		print ("NUMBER " .. number)
		wereNegatives = true
		negativeNumbers = negativeNumbers .. number .. " "
	end
	
	if wereNegatives then
		error("negative is not allowed : " .. negativeNumbers)
	end
end

function addStringSeparatedComma(str)

	checkNegative(str)
	
	local result = 0
	
	for number in string.gmatch(str,"%d+") do
		if tonumber(number) <= 1000 then
			result = result + number
		end
	end
	
	return result
end

function checkCorrectnessDelimeter(str, delimeter)

	if string.match(str, "[^" .. delimeter .. "^0-9]") ~= nil then
		return false
	end
	return true
end

function calc.add(str)

	if str == nil then 
		return 0
	end
	
	if str:len() == 0 then
		return 0
	end
	
	iter = string.gmatch(str, "//(.+)\n(.+)")
	
	delimeter, str2 = iter();
	
	if delimeter ~= nil and str2 ~= nil then
		
		defaultDelimeter = ","
		
		str2 = string.gsub(str2, delimeter, defaultDelimeter)
		
		if checkCorrectnessDelimeter(str2, defaultDelimeter) == false then
			return nil
		end
		
		return addStringSeparatedComma(str2)
	else
		return addStringSeparatedComma(str)
	end 
	
end

return calc;


