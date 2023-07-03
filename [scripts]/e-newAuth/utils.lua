main = {}

function main:loadTextures(data)
    for i,v in pairs(data) do
        self.textures[i] = dxCreateTexture('data/images/'..i..'.png','argb',false,'clamp')
    end
end

function main:loadFonts(data)
    for i,v in pairs((data and data or {})) do
        self.fonts[i] = exports['e-gui']:getFont(v.name,v.size)
    end
end

function main:unloadFonts()
	for i,v in pairs(self.fonts) do
		if (isElement(v)) then
			destroyElement(v)
		end
	end
end

function main:unloadTextures()
	for i,v in pairs(self.textures) do
		if (isElement(v)) then
			destroyElement(v)
		end
	end
end

function main:loadAccountData()
    if (fileExists('data.json')) then
		local file = fileOpen('data.json')
		local data = fromJSON(fileRead(file, fileGetSize(file)))
        fileClose(file)
		return data
    end
    return false
end

function main:saveData(login, password)
	if (fileExists('data.json')) then
        fileDelete('data.json')
    end
    local file = fileCreate('data.json')
    local data = {
        login = login,
        password = password
    }
    fileWrite(file, toJSON(data))
    fileClose(file)
end


rules = [[
	Postanowienia ogolne #38AF59#1#C8C8C8
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	#ffffffPostanowienia ogolne #38AF59#2#C8C8C8
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	#ffffffPostanowienia ogolne #38AF59#3#C8C8C8
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	#ffffffPostanowienia ogolne #38AF59#4#C8C8C8
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis eros elementum ligula interdum aliquam vel non risus.
]]

updates = [[
	#0.01 Aktualizacja na serwerze #38AF590.3.0.6.23#C8C8C8
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
	#ffffff#0.02 Aktualizacja na serwerze #38AF590.3.0.6.23#C8C8C8
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
	#ffffff#0.03 Aktualizacja na serwerze #38AF590.3.0.6.23#C8C8C8
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
	Lorem ipsum dolor sit amet, consectetur
]]

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

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end
