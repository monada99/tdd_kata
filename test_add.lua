
calc = require('calc')
luaunit = require('luaunit')


function testAddEmptyString()
	luaunit.assertEquals(calc.add(""), 0)
end

function testAddOneNumber()
	luaunit.assertEquals(calc.add("5"), 5)
end

function testAddTwoNumbers()
	luaunit.assertEquals(calc.add("10,5"), 15)
end

function testAddThreeNumbers()
	luaunit.assertEquals(calc.add("1,10,100"), 111)
end

function testAddThreeNumbersSeparetedNewLines()
	luaunit.assertEquals(calc.add("1\n10\n100"), 111)
end

function testAddSpecifiedDelimeter()
	luaunit.assertEquals(calc.add("//;\n1;10"), 11)
end

function testAddThreeNumbersSeparetedNewLinesAndCommaDelimeter()
	luaunit.assertEquals(calc.add("1,10,100"), 111)
end

function testAddBadDelimeter()
	luaunit.assertNil(calc.add("//+\n20;10"))
end

function testAddNegativeNumbers()
	luaunit.assertNil(calc.add("-25,10"))
end

function testAddGreatNumbers()
	luaunit.assertEquals(calc.add("10,1001"), 10)
end

function testAddLongDelimeter()
	luaunit.assertEquals(calc.add("//+++\n5+++25+++5000"), 30)
end

function testAddManyDelimeters()
	luaunit.assertEquals(calc.add("//[;][++]\n5;15+5"), 25)
end

os.exit( luaunit.LuaUnit.run() )
