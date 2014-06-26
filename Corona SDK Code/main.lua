-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--Test damas inglesas
--Draughts ?
--http://en.wikipedia.org/wiki/Draughts
os.execute('clear')
print("Amazon")

--local t = os.date( '*t' )  -- get table of current date and time
--print( os.time( t ) )      -- print date & time as number of seconds

--http://docs.coronalabs.com/api/library/os/date.html
--//TODO: buscar como hacerlo ISO_8601
print( os.date( "%c" ) )        -- print out time/date string: e.g., "Thu Oct 23 14:55:02 2010"

prettyPrint = require 'PrettyPrint'
--prettyOutput = PrettyPrint( someTable )

print ("Question 1")

SetOfStacks = require("SetOfStacks")

local setOfStacks = SetOfStacks:new( 3 )

setOfStacks:push( "hola" )
setOfStacks:push( "mundo" )
setOfStacks:push( "!" )
setOfStacks:push( "!" )
setOfStacks:push( "!" )
--print( prettyPrint ( setOfStacks.setOfStacks ) )

print(  setOfStacks:pop( ) )
print(  setOfStacks:pop( ) )
print(  setOfStacks:pop( ) )
print(  setOfStacks:pop( ) )
print(  setOfStacks:pop( ) or "There is no elements" )
setOfStacks = nil

print ("Question 2")
Box = require("Box")


local boxes = {
	Box:new(3,4),
	--Box:new(7,5),
	--Box:new(3,9),
	--Box:new(3,13),
	Box:new(11,6),
	--Box:new(7,5),
	--Box:new(7,5),
	--Box:new(7,5),
	--Box:new(7,5),
	Box:new(7,5),
	Box:new(12,7),
	Box:new(13,8)
}

function getArrayWithout( array , element )
	local result = {}
	for key,value in ipairs(array) do 
		if not ( value == element ) then
			table.insert( result, value)
		end
	end
	--print( prettyPrint ( result ) )
	return result
end

function getBoxStacked ( box, boxes  )
	local max = 0
	local arrayMax = {}
	print( "#boxes:" .. #boxes )
	--print( prettyPrint ( boxes ) )

	if #boxes == 0 then
		return {}
	end

	if #boxes == 1 then
		return {box}
	end
	--local newMax
	--local foundOne =false
	for key,value in ipairs(boxes) do
		if	--is smaller
			value.height < box.height
			and
			--ligther
			value.weight < box.weight 
			then
    		local array = getBoxStacked(
    			value,
    				getArrayWithout( boxes, value )
    			)
    		if  #arrayMax <  #array  then
    			arrayMax = array--joinTables( array,{value} )
    		end
    	end
	end
	table.insert( arrayMax,box )
	return  arrayMax
end

local maximumNumber = 10000


boxStacked = getBoxStacked( Box:new(maximumNumber , maximumNumber) , boxes,{})  -- because i am assuming i already have one

--print( "maxNumberOfBoxStacked: " .. maxNumberOfBoxStacked )
print( "BoxStacked: " )
print( prettyPrint ( boxStacked ) )
print( "maxNumberOfBoxStacked: " .. (#boxStacked - 1) )

print("Question 3:")


function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function heigth(tree)

	--print( "heigth" )
	--print( prettyPrint ( tree ) )

	if tree == nil then
		return 0
	end
	--print("#tree: "..#tree)
	--print("table.getn(tree): ".. table.getn(tree))
	--print("tablelength(tree): ".. tablelength(tree))
	--if #tree == 0  then
	--if table.getn(tree) == 0  then
	if tablelength(tree) == 0  then
		return 1
	end

	local rigthHeigth = 0
	--if not( tree.rigth == nil  ) then
		rigthHeigth =  heigth( tree.rigth )
	--end
	local leftHeigth = 0
	--if not( tree.left == nil  ) then
		leftHeigth = heigth( tree.left )
	--end

	return math.max(rigthHeigth,leftHeigth) + 1
end
function isBalanced( tree )
	--print( "isBalanced" )
	--print( prettyPrint ( tree ) )
	if tree == nil then
		return true
	end

	--if #tree == 0  then
	--if table.getn(tree) == 0  then
	if tablelength(tree) == 0  then
		return true
	end

	if 
	--1)	The left and right subtrees' heights differ by at most one, AND
		math.abs( heigth(tree.left ) - heigth(tree.rigth ) ) <= 1  and
	--2)	The left subtree is balanced, AND
		isBalanced( tree.left ) and
	--3)	The right subtree is balanced
		isBalanced( tree.rigth )
		then
		return true
	end
	return false
end

local tree = {
	rigth = {
		rigth = {
			rigth = {},
			left = {}
		},
		left = {}
	},
	left = {}
}

--print("height: " .. heigth(tree))

print("isBalanced: " .. (  (isBalanced(tree)==true )  and "true"  or "false" ) )

print("The End")

