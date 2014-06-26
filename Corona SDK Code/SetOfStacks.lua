SetOfStacks = {}

--local setOfStacks = {}

--local capacity = 10

function SetOfStacks:new( capacity )
	local object = {}
	if capacity <= 0 then
		print("Error: capacity cant be lower than 1")
		return nil
	end
	object.capacity = capacity
	local setOfStacks = {}
	--setOfStacks[0] = {}
	object.setOfStacks = setOfStacks
	object.setOfStacks[0] = {}
	object.count = 0
	setmetatable(object, { __index = SetOfStacks })
	return object
end

function SetOfStacks:push( object )
	--print("push " .. object )
	local capacity = self.capacity
	local count = self.count + 1
	if  count % capacity == 0  then
		self.setOfStacks[ math.floor( count  / capacity ) ] = {}
	end
	--initialize array
	self.setOfStacks[ math.floor( count / capacity )  ][ count % capacity ] = object
	self.count = count 
end

function SetOfStacks:pop(  )
	--print( "pop" )
	local capacity = self.capacity
	local count = self.count 
	if count > 0 then		
		--print( "count: " .. count  )
		local object = self.setOfStacks[ math.floor( count / capacity )  ][ count % capacity  ] 
		self.setOfStacks[ math.floor( count / capacity )  ][ "".. count % capacity  ] = nil
		count = count - 1
		--if  count % capacity == ( capacity - 1 )  then
		--	self.setOfStacks[ math.floor( count / capacity )   ] = nil
		--end
		self.count = count
		return object
	else
		return nil
	end
end

return SetOfStacks