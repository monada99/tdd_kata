local calc = require 'calc'
local luaunit = require 'luaunit'

local assertEquals = luaunit.assertEquals
local assertNil = luaunit.assertNil

function testAddEmptyString()
    assertEquals( calc.add( "" ), 0 )
end

function testAddOneNumber()
    assertEquals( calc.add( "5" ), 5 )
end

function testAddTwoNumbers()
    assertEquals( calc.add( "10,5" ), 15 )
end

function testAddThreeNumbers()
    assertEquals( calc.add( "1,10,100" ), 111 )
end

function testAddThreeNumbersSeparetedNewLines()
    assertEquals( calc.add( "1\n10\n100" ), 111 )
end

function testAddSpecifiedDelimeter()
    assertEquals( calc.add( "//;\n1;10" ), 11 )
end

function testAddThreeNumbersSeparetedNewLinesAndCommaDelimeter()
    assertEquals( calc.add( "1,10,100" ), 111 )
end

function testAddBadDelimeter()
    assertNil( calc.add( "//+\n20;10" ) )
end

function testAddNegativeNumbers()
    assertNil( calc.add( "-25,10" ) )
end

function testAddGreatNumbers()
    assertEquals( calc.add( "10,1001" ), 10 )
end

function testAddLongDelimeter()
    assertEquals( calc.add( "//+++\n5+++25+++5000" ), 30 )
end

function testAddManyDelimeters()
    assertEquals( calc.add( "//[;][++]\n5;15+5" ), 25 )
end

os.exit( luaunit.LuaUnit.run() )
