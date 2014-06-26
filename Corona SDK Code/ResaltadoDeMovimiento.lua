ResaltadoDeMovimiento = {}

local squareLength = math.min( display.contentWidth, display.contentHeight )
print("squareLength: "..squareLength)
local insideSquareLength = squareLength / 8
print("insideSquareLength: "..insideSquareLength)
local ResaltadoDeMovimientoRadio = insideSquareLength / 2 * .8
print("ResaltadoDeMovimientoRadio: "..ResaltadoDeMovimientoRadio)

local ResaltadoDeMovimientoSeleccionada = false


local ResaltadoDeMovimientos = {}

local onCollision = function ( resaltadoDeMovimiento,  event )
	print( "event.phase: " .. event.phase )
    if ( event.phase == "began" ) then
		movimientoSeleccionado = resaltadoDeMovimiento
    elseif ( event.phase == "ended" ) then  
    	movimientoSeleccionado = nil
    end
end
    
 
function ResaltadoDeMovimiento:new( column, row  )
	local object = {}
	object.name = "ResaltadoDeMovimiento"
	object.column = column
	object.row = row
  image = display.newRect( 0 , 0 , insideSquareLength , insideSquareLength )
  
  local xIni = display.contentCenterX -  ( insideSquareLength * 8 ) / 2 + insideSquareLength / 2
  local yIni = display.contentCenterY -  ( insideSquareLength * 8 ) / 2 + insideSquareLength / 2
  image.x = xIni + insideSquareLength * ( column - 1 )
  image.y = yIni + insideSquareLength * ( row - 1 )

  image.strokeWidth = 5
  image:setStrokeColor(180,0,200)
  image:setFillColor( 0, 0, 0, 0 )
  
  tipo = ficha.tipo
  
  table.insert(ResaltadoDeMovimientos,image)
	object.image = image
  
  physics.addBody( image, { radius = insideSquareLength / 4 , density = 0, isSensor=true } )
  
  image:addEventListener( "collision", function ( event) onCollision(object, event) end ) 
  
  setmetatable(object, { __index = ResaltadoDeMovimiento })
  
	return object
end


function ResaltadoDeMovimiento:getAll()
	return ResaltadoDeMovimientos
end

function ResaltadoDeMovimiento:deleteAll()
	print("deleteAll")
	for key,resaltado in pairs(ResaltadoDeMovimientos) do 
		ResaltadoDeMovimientos[key]=nil
		resaltado:removeSelf()
		resaltado = nil
	end
end


-- function ResaltadoDeMovimiento:copy()
-- 	return ResaltadoDeMovimiento:new(self.x, self.y)
-- end

-- function ResaltadoDeMovimiento:equals(vec)
-- 	if self.x == vec.x and self.y == vec.y then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end

return ResaltadoDeMovimiento