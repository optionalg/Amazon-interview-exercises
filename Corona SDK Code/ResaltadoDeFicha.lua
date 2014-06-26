ResaltadoDeFicha = {}

local squareLength = math.min( display.contentWidth, display.contentHeight )
print("squareLength: "..squareLength)
local insideSquareLength = squareLength / 8
print("insideSquareLength: "..insideSquareLength)
local ResaltadoDeFichaRadio = insideSquareLength / 2 * .8
print("ResaltadoDeFichaRadio: "..ResaltadoDeFichaRadio)
--local ResaltadoDeFichaRadio = 
local ResaltadoDeFichaSeleccionada = false

ResaltadoDeMovimiento = require("ResaltadoDeMovimiento")


local ResaltadoDeFichas = {}


local colorear_los_cuadros_donde_se_puede_mover = function ( ficha )
	print("colorear_los_cuadros_donde_se_puede_mover")
	for key,square in pairs(blackSquares) do 
		if  ficha:canMoveTo( square.column, square.row ) then
      resaltadoDeMovimiento = ResaltadoDeMovimiento:new( square.column, square.row )
      --[[
			resaltado = display.newRect( square.x , square.y , insideSquareLength , insideSquareLength )
			resaltado.name = "resaltado"
			resaltado.x = square.x
			resaltado.y = square.y
			resaltado.column = square.column
			resaltado.row = square.row
			resaltado:setFillColor( 0, 0, 0, 0 )
			resaltado.strokeWidth = 5
			resaltado:setStrokeColor(180,0,200)
			--resaltado.square = square
			physics.addBody(
					resaltado,
					"static",
					{
						radius = insideSquareLength / 4 ,
						density = 0,
						isSensor=true
					}
				)
			resaltado:addEventListener( "collision", onCollision ) 
			table.insert(movimientosResaltados, resaltado)
      ]]--
		end
	end
end


--local dragBody = function ( event, params )
local dragBody = function ( ResaltadoDeFicha,ficha, event, params )
	--print("dragBody")
	--if ResaltadoDeFichaSeleccionada == false then
		--ResaltadoDeFicha = event.target
    imagenResaltado = ResaltadoDeFicha.image
    imagenFicha = ficha.image
		ResaltadoDeFichaSeleccionada = true
		phase = event.phase
		if ( phase == "began" ) then
			-- startX = ResaltadoDeFicha.x
			-- startY = ResaltadoDeFicha.y
      colorear_los_cuadros_donde_se_puede_mover(ficha)
	    elseif ( event.phase == "moved" ) then  
	    	imagenResaltado.x = event.x
			  imagenResaltado.y = event.y
	    	imagenFicha.x = event.x
			  imagenFicha.y = event.y
	    elseif ( phase == "ended" ) then
	    	if not ( movimientoSeleccionado == nil ) then
	    		--ResaltadoDeFicha.square = nil
          

	    		column = movimientoSeleccionado.column
	    		row = movimientoSeleccionado.row
          
          local xIni = display.contentCenterX -  ( insideSquareLength * 8 ) / 2 + insideSquareLength / 2
          local yIni = display.contentCenterY -  ( insideSquareLength * 8 ) / 2 + insideSquareLength / 2
          imagenResaltado.x = xIni + insideSquareLength * ( column - 1 )
          imagenResaltado.y = yIni + insideSquareLength * ( row - 1 )
          imagenFicha.x = xIni + insideSquareLength * ( column - 1 )
          imagenFicha.y = yIni + insideSquareLength * ( row - 1 )
          
	    		ficha.getAll()[column][row] = nil
	    		ficha.column  = movimientoSeleccionado.column
	    		ficha.row  = movimientoSeleccionado.row
          ResaltadoDeFicha:deleteAll()
          if fichasAMover == fichasNegras then
            fichasAMover = fichasBlancas
          else
            fichasAMover = fichasNegras
          end
          --resaltar_fichas_que_se_pueden_mover()
          movimientoSeleccionado:deleteAll()
	    		movimientoSeleccionado = nil
          ResaltadoDeFicha:resaltarPosibles()
	    	else
          local xIni = display.contentCenterX -  ( insideSquareLength * 8 ) / 2 + insideSquareLength / 2
          local yIni = display.contentCenterY -  ( insideSquareLength * 8 ) / 2 + insideSquareLength / 2
          imagenResaltado.x = xIni + insideSquareLength * ( ficha.column - 1 )
          imagenResaltado.y = yIni + insideSquareLength * ( ficha.row - 1 )
          imagenFicha.x = xIni + insideSquareLength * ( ficha.column - 1 )
          imagenFicha.y = yIni + insideSquareLength * ( ficha.row - 1 )
          --ResaltadoDeFicha.x = startX
          --ResaltadoDeFicha.y = startY
          ResaltadoDeFichaSeleccionada = false
	    	end
	    end
	--end
	-- Stop further propagation of touch event
	return true
end
    
 
function ResaltadoDeFicha:new( ficha )
	local object = {}
  --object.image = image
	--object.class = ResaltadoDeFicha
	object.radius = ficha.radius 
	object.name = "ResaltadoDeFicha"
	object.tipo = tipo
	object.column = column
	object.row = row
	--ResaltadoDeFichas[column][row]= object
  --object.ResaltadoDeFichas = ResaltadoDeFichas
  image = display.newCircle( 0, 0, ficha.radius )
  
  local xIni = display.contentCenterX -  ( insideSquareLength * 8 ) / 2 + insideSquareLength / 2
  local yIni = display.contentCenterY -  ( insideSquareLength * 8 ) / 2 + insideSquareLength / 2
  image.x = xIni + insideSquareLength * ( ficha.column - 1 )
  image.y = yIni + insideSquareLength * ( ficha.row - 1 )
  
	

  image.strokeWidth = 5
  image:setStrokeColor(180,0,200)
  
  tipo = ficha.tipo
	if tipo == "White" then
		image:setFillColor( 255, 255, 255 )
	elseif tipo == "Black" then
		image:setFillColor( 255, 0, 0 )
	else
		print("Error: Tipo incorrecto, las opciones son \"White\" y \"Black\"")
	end
  
  table.insert(ResaltadoDeFichas,image)
	object.image = image
  
  image:addEventListener( 
    "touch",
    function( event,params ) 
      print("touch")
      dragBody(object,ficha,event,params) 
    end
  )
  physics.addBody( image, { radius = insideSquareLength / 4 } )
  
	--setmetatable(object, { __index = ResaltadoDeFicha })  -- Da problemas con Corona
  setmetatable(object, { __index = ResaltadoDeFicha })
	return object
end

function ResaltadoDeFicha:canMove(ficha)
	return ficha:canMove()
end

function ResaltadoDeFicha:resaltarPosibles()
	print("resaltarPosibles")
  --print(prettyPrint(fichasAMover))
  --print(json.encode( fichasAMover ))
	for key,ficha in pairs(fichasAMover) do 
		if self:canMove( ficha ) then
			--ficha:addEventListener( "touch", dragBody )
      resaltado = ResaltadoDeFicha:new( ficha )
		end
	end
end

function ResaltadoDeFicha:getAll()
	return ResaltadoDeFichas
end

function ResaltadoDeFicha:deleteAll()
	print("deleteAll")
	for key,resaltado in pairs(ResaltadoDeFichas) do 
		ResaltadoDeFichas[key]=nil
		resaltado:removeSelf()
		resaltado = nil
	end
end


-- function ResaltadoDeFicha:copy()
-- 	return ResaltadoDeFicha:new(self.x, self.y)
-- end

-- function ResaltadoDeFicha:equals(vec)
-- 	if self.x == vec.x and self.y == vec.y then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end

return ResaltadoDeFicha