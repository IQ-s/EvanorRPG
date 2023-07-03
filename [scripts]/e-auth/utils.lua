function loadTextures(data)
    for i,v in pairs((data and data or {})) do
        main['textures'][i] = dxCreateTexture('data/images/'..i..'.png','argb',false,'clamp')
    end
end

function unloadTextures()
	for i,v in pairs(main['textures']) do
		if (isElement(v)) then
			destroyElement(v)
		end
	end
end

function loadFonts(data)
    for i,v in pairs((data and data or {})) do
        main['fonts'][i] = exports['e-gui']:getFont(v.name,v.size)
    end
end

function unloadFonts()
	for i,v in pairs(main['fonts']) do
		if (isElement(v)) then
			destroyElement(v)
		end
	end
end

function loadAccountData()
    if (fileExists('data.json')) then
		local file = fileOpen('data.json')
        return fromJSON(fileRead(file, fileGetSize(file)))
    end
    return false
end

rules = [[
	Ogolne:
	 1. Jakis tam punkt
	 2. Jakis tam punkt
	 3. Jakis tam punkt
	 4. Jakis tam punkt
	 5. Jakis tam punkt
	 6. Jakis tam punkt
	 7. Jakis tam punkt
	 8. Jakis tam punkt
	 9. Jakis tam punkt
	Administracja:
	 1. Jakis tam punkt
	 2. Jakis tam punkt
	 3. Jakis tam punkt
	 4. Jakis tam punkt
	 5. Jakis tam punkt
	 6. Jakis tam punkt
	 7. Jakis tam punkt
	 8. Jakis tam punkt
	 9. Jakis tam punkt
	 10. Jakis tam punkt
	 11. Jakis tam punkt
]]

updates = [[
	Nowosc #1
	Nowosc #1
	Nowosc #1
	Nowosc #1
	Nowosc #123411234
	Nowosc #1 2342341
	Nowosc #234
	Nowosc #2136
]]

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

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