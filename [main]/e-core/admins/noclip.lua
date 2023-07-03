local sx, sy = guiGetScreenSize()

local main = {}

main.airbreak = {}
main.airbreak.state = nil
main.airbreak.element = nil
main.airbreak.multiplier = 1.5


local keys = {}
main.airbreak.x, main.airbreak.y, main.airbreak.z = getElementPosition(localPlayer)
keys["space"] = function(x, y, z, lx, ly, lz)
	main.airbreak.z = main.airbreak.z + main.airbreak.multiplier
end
keys["lshift"] = function(x, y, z, lx, ly, lz)
	main.airbreak.z = main.airbreak.z - main.airbreak.multiplier
end
keys["w"] = function(x, y, z, lx, ly, lz, multiplier)
	main.airbreak.x = main.airbreak.x + (lx-x) * multiplier
	main.airbreak.y = main.airbreak.y + (ly-y) * multiplier
end
keys["s"] = function(x, y, z, lx, ly, lz, multiplier)
	main.airbreak.x = main.airbreak.x - (lx-x) * multiplier
	main.airbreak.y = main.airbreak.y - (ly-y) * multiplier
end
keys["a"] = function(x, y, z, lx, ly, lz, multiplier)
	main.airbreak.x = main.airbreak.x - (ly-y) * multiplier
	main.airbreak.y = main.airbreak.y + (lx-x) * multiplier
end
keys["d"] = function(x, y, z, lx, ly, lz, multiplier)
	main.airbreak.x = main.airbreak.x + (ly-y) * multiplier
	main.airbreak.y = main.airbreak.y - (lx-x) * multiplier
end





function startAirBreak()
	main.airbreak.state = true

	if isPedInVehicle(localPlayer) then 
		main.airbreak.element = getPedOccupiedVehicle(localPlayer)
	else
		main.airbreak.element = localPlayer
	end

	addEventHandler("onClientPreRender", root, renderAirBreak)
 	setElementCollisionsEnabled (main.airbreak.element, false)
 	setElementFrozen(main.airbreak.element, true)

	main.airbreak.x, main.airbreak.y, main.airbreak.z = getElementPosition(main.airbreak.element)

	if getElementType(main.airbreak.element) == "vehicle" then
		setElementAlpha(localPlayer, 0)
	end
end 



function stopAirBreak()
	main.airbreak.state = nil

	removeEventHandler("onClientPreRender", root, renderAirBreak)
	setElementFrozen(main.airbreak.element, false)
	setElementFrozen(localPlayer, false)
	setElementCollisionsEnabled ( main.airbreak.element, true)

	if getElementType(main.airbreak.element) == "vehicle" then
		setElementAlpha(localPlayer, 255)
	end

	main.airbreak.element = nil
end






function renderAirBreak()
	if isChatBoxInputActive() then return end
	local x, y, z, lx, ly, lz = getCameraMatrix()
	local multiplier = main.airbreak.multiplier / math.sqrt((lx-x)^2+(ly-y)^2)
	
	if getKeyState("lalt") then 
		main.airbreak.multiplier = 0.5
	elseif getKeyState("lctrl") then
		main.airbreak.multiplier = 5
	else
		main.airbreak.multiplier = 1.25
	end

	for i, v in pairs(keys) do
		if getKeyState(i) then 
			v(x, y, z, lx, ly, lz, multiplier)
		end
	end
	

	local angle = getPedCameraRotation(localPlayer)
	setElementRotation(main.airbreak.element, 0, 0, getElementType(main.airbreak.element) == "vehicle" and -angle or angle)
	setElementPosition(main.airbreak.element, main.airbreak.x, main.airbreak.y, main.airbreak.z)
end


bindKey('x','down',function ()
    if getElementData(localPlayer,'player:admin') then
        if main.airbreak.state then
            stopAirBreak()
        else
            startAirBreak()
        end
    end
end)