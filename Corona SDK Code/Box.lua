Box = {}

--local setOfStacks = {}

--local capacity = 10

function Box:new( height, weight )
	local object = {}
	object.height = height
	object.weight = weight
	setmetatable(object, { __index = Box })
	return object
end

return Box