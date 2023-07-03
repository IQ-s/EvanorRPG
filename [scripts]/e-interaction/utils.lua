--[[
    Resource: e-interaction
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--


main = {}
sx,sy = guiGetScreenSize()
zoom = exports['e-gui']:getZoom()

function main:init()
    self.textures = {}
    self.fonts = {}
    self.compatibleobjects = {
        ['vehicle'] = true,
		['object'] = true
    }
    self.draw = function () main:render() end
    self.clck = function (button, state, ax, ay, wx, wy, wz, element) main:click(button, state, ax, ay, wx, wy, wz, element) end
    self.toggle = false
    self.texturesToLoad = {
        ['background'] = true,
        ['circle'] = true,
        ['option_circle'] = true,
		['option_bg'] = true,
		['option_bg_hovered'] = true,
		['option_circle_hovered'] = true,
		['lock'] = true,
		['open'] = true
    }
    self.fontsToLoad = {
        [1] = { name = 'bold', size = 17/zoom },
        [2] = { name = 'medium', size = 16/zoom },
		[3] = { name = 'medium', size = 14/zoom }
    }
    self.options = {
        ['vehicle'] = {
            {
                name = 'Otworz drzwi',
				icon = 'open'
            },
            {
                name = 'Zamknij drzwi',
				icon = 'lock'
            }
        },
		[2942] = {
			{
				name = 'Otworz bankomat',
				icon = 'open'
			}
		}
    }
    self.animation = false
    self.alpha = {
        [1] = 0,
        [2] = 0
    }
    self.item = false
    self.animate = function (...) return animate(...) end


    bindKey('e','down',function ()
        if not getElementData(localPlayer, 'player:spawn') then return end
        if self.animation then return end
		if getPedOccupiedVehicle(localPlayer) then return end

        if (self.toggle) then
            self.toggle = false
            showCursor(false)
            self.animation = true
            setCursorAlpha(255)
            startWall(false)
            effectOn = false
            self.animate(255,0,'Linear',500,function (c)
                self.alpha[1] = c
                self.alpha[2] = c
            end,function ()
                setElementData(localPlayer,'player:hudof',false)
                self.animation = false
                removeEventHandler('onClientRender',root, self.draw)
                removeEventHandler('onClientClick',root, self.clck)
                showCursor(false)
                showChat(true)
				for i,v in pairs(self.textures) do
					if (isElement(v)) then
						destroyElement(v)
					end
				end
				for i,v in pairs(self.fonts) do
					if (isElement(v)) then
						destroyElement(v)
					end
				end
            end)
        else
			
			for i,v in pairs(self.texturesToLoad) do
				self.textures[i] = dxCreateTexture('data/images/'..i..'.png','argb',false,'clamp')
			end
			for i,v in pairs(self.fontsToLoad) do
				self.fonts[i] = exports['e-gui']:getFont(v.name,v.size)
			end
            startWall(true)
            self.item = false
            effectOn = true
            setElementData(localPlayer,'player:hudof',true)
            self.animation = true
            setCursorAlpha(0)
            self.animate(0,255,'Linear',500,function (c)
                self.alpha[1] = c
            end,function ()
                self.animation = false
            end)
            self.toggle = true
            addEventHandler('onClientRender',root, self.draw)
            addEventHandler('onClientClick',root, self.clck)
            showCursor(true)
            showChat(false)
        end
    end)
end

main:init()

local anims, builtins = {}, {"Linear", "InQuad", "OutQuad", "InOutQuad", "OutInQuad", "InElastic", "OutElastic", "InOutElastic", "OutInElastic", "InBack", "OutBack", "InOutBack", "OutInBack", "InBounce", "OutBounce", "InOutBounce", "OutInBounce", "SineCurve", "CosineCurve"}

function table.find(t, v)
	for k, a in ipairs(t) do
		if a == v then
			return k
		end
	end
	return false
end

function animate(f, t, easing, duration, onChange, onEnd)
	assert(type(f) == "number", "Bad argument @ 'animate' [expected number at argument 1, got "..type(f).."]")
	assert(type(t) == "number", "Bad argument @ 'animate' [expected number at argument 2, got "..type(t).."]")
	assert(type(easing) == "string" or (type(easing) == "number" and (easing >= 1 or easing <= #builtins)), "Bad argument @ 'animate' [Invalid easing at argument 3]")
	assert(type(duration) == "number", "Bad argument @ 'animate' [expected number at argument 4, got "..type(duration).."]")
	assert(type(onChange) == "function", "Bad argument @ 'animate' [expected function at argument 5, got "..type(onChange).."]")
	table.insert(anims, {from = f, to = t, easing = table.find(builtins, easing) and easing or builtins[easing], duration = duration, start = getTickCount( ), onChange = onChange, onEnd = onEnd})
	return #anims
end

function destroyAnimation(a)
	if anims[a] then
		table.remove(anims, a)
	end
end

addEventHandler("onClientRender", root, function( )
	local now = getTickCount( )
	for k,v in ipairs(anims) do
		v.onChange(interpolateBetween(v.from, 0, 0, v.to, 0, 0, (now - v.start) / v.duration, v.easing))
		if now >= v.start+v.duration then
			if type(v.onEnd) == "function" then
				v.onEnd( )
			end
			table.remove(anims, k)
		end
	end
end)


wallShader = {}
colorizePed = {58/255, 155/255, 85/255, 255}
specularPower = 1.3
effectMaxDistance = 250
isPostAura = true
scx, scy = guiGetScreenSize ()
effectOn = nil
myRT = nil
myShader = nil
isMRTEnabled = false
timer = 1101
objects = {}

function enablePedWall(isMRT)
	if isMRT and isPostAura then 
		myRT = dxCreateRenderTarget(scx, scy, true)
		myShader = dxCreateShader("data/fx/post_edge.fx")
		if not myRT or not myShader then 
			isMRTEnabled = false
			return
		else
			dxSetShaderValue(myShader, "sTex0", myRT)
			dxSetShaderValue(myShader, "sRes", scx, scy)
			isMRTEnabled = true
		end
	else
		isMRTEnabled = false
	end

	pwEffectEnabled = true
end

function disablePedWall()
	pwEffectEnabled = false
	disablePedWallTimer()
	if isElement(myRT) then
		destroyElement(myRT)
	end
end

function createWallEffectForPlayer(thisPlayer, isMRT)
    if not wallShader[thisPlayer] then
		if isMRT then 
			wallShader[thisPlayer] = dxCreateShader("data/fx/ped_wall_mrt.fx", 1, 0, true, "all")
		else
			wallShader[thisPlayer] = dxCreateShader("data/fx/ped_wall.fx", 1, 0, true, "all")
		end

		if not wallShader[thisPlayer] then 
			return false
		else
			if myRT then
				dxSetShaderValue (wallShader[thisPlayer], "secondRT", myRT)
			end

			dxSetShaderValue(wallShader[thisPlayer], "sColorizePed",colorizePed)
			dxSetShaderValue(wallShader[thisPlayer], "sSpecularPower",specularPower)
			engineApplyShaderToWorldTexture ( wallShader[thisPlayer], "*" , thisPlayer )


			return true
			end
    end
end

function destroyShaderForPlayer(thisPlayer)
    if wallShader[thisPlayer] then
		engineRemoveShaderFromWorldTexture(wallShader[thisPlayer], "*" , thisPlayer)
		destroyElement(wallShader[thisPlayer])
		wallShader[thisPlayer] = nil
	end
end

function getObjects()
		-- get all elements
		local objs = {}
		local x, y, z = getElementPosition(localPlayer)
		local rx,ry,rz = getCameraMatrix()

		for i,v in pairs(getElementsWithinRange(x, y, z, 10, "ped")) do
			local xx,yy,zz = getElementPosition(v)
			if(getElementData(v, 'interaction') and isLineOfSightClear(rx, ry, rz, xx, yy, zz, true, true, false, false))then
				objs[#objs+1] = v
			end
		end

		for i,v in pairs(getElementsWithinRange(x, y, z, 10, "vehicle")) do
			-- local data = getElementData(v, "vehicle:data")
			-- local group=getElementData(v, "vehicle:group_name")
			local xx,yy,zz = getElementPosition(v)
			--if (data and data.owner == getElementData(localPlayer, 'player:sid')) then
				if(getVehicleName(v) ~= "Bike" and getVehicleName(v) ~= "BMX" and getVehicleName(v) ~= "Mountain Bike")then
					objs[#objs+1] = v
				end
			--end
		end

		for i,v in pairs(getElementsWithinRange(x, y, z, 10, "object")) do
			local xx,yy,zz = getElementPosition(v)
			if(getElementData(v, "interaction") and isLineOfSightClear(rx, ry, rz, xx, yy, zz, true, true, false, false))then
				objs[#objs+1] = v
			end
		end

		for i,v in pairs(getElementsWithinRange(x, y, z, 10, "player")) do
			local xx,yy,zz = getElementPosition(v)
			if(not isPedInVehicle(v) and isLineOfSightClear(rx, ry, rz, xx, yy, zz, true, true, false, false))then
				objs[#objs+1] = v
			end
		end

		objects = objs
		--
		return objs
end

function enablePedWallTimer(isMRT)
	if PWenTimer then 
		return 
	end
	PWenTimer = setTimer(function()
		local x, y, z = getElementPosition(localPlayer)

		local objs = getObjects()
		for index,obj in pairs(objs)  do
			if isElement(obj) then
				createWallEffectForPlayer(obj, isMRT)
			end 
				local hx,hy,hz = getElementPosition(localPlayer)            
				local cx,cy,cz = getCameraMatrix()
				local dist = getDistanceBetweenPoints3D(cx,cy,cz,hx,hy,hz)
				local isItClear = isLineOfSightClear (cx,cy,cz, hx,hy, hz, true, false, false, true, false, true, false, localPlayer)
				if (dist<effectMaxDistance ) and not isItClear and effectOn then 
					createWallEffectForPlayer(localPlayer, isMRT)
				end 
				if (dist>effectMaxDistance ) or  isItClear or not effectOn then 
					destroyShaderForPlayer(localPlayer) 
				end
			end
		end
	,timer,0 )
end

function disablePedWallTimer()
	if PWenTimer then
		killTimer( PWenTimer )
		PWenTimer = nil		
	end
end


addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function()
		local isMRT = false
		if dxGetStatus().VideoCardNumRenderTargets > 1 then 
			isMRT = true 
		end

		switchPedWall(true, isMRT)
	end
)

function switchPedWall(pwOn, isMRT)
	if(pwOn)then
		enablePedWall(isMRT)
	else
		disablePedWall()
	end
end

function preRender()
	if(not pwEffectEnabled or not isMRTEnabled or not effectOn)then return end

	dxSetRenderTarget(myRT, true)
	dxSetRenderTarget()
end

function hudRender()
	if(not pwEffectEnabled or not isMRTEnabled or not effectOn)then return end
	dxDrawImage(0, 0, scx, scy, myShader, 0, 0, 0, tocolor(255, 255, 255, 255), true)
end

function startWall(pwOn)
	if(pwOn)then
		enablePedWallTimer(true)

		dxSetRenderTarget(myRT, true)
		dxSetRenderTarget()
		removeEventHandler("onClientPreRender", root, preRender)
		removeEventHandler("onClientHUDRender", root, hudRender)
		addEventHandler("onClientPreRender", root, preRender)
		addEventHandler("onClientHUDRender", root, hudRender)
	else
		disablePedWallTimer()

		removeEventHandler("onClientPreRender", root, preRender)
		removeEventHandler("onClientHUDRender", root, hudRender)

		local objs = getObjects()
		for index,obj in pairs(objects)  do
			destroyShaderForPlayer(obj)
		end
	end
end

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end