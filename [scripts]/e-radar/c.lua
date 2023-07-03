radarPos = {

    x = 25/zoom,
    y = (sy - 25/zoom) - 200/zoom,
    w = 330/zoom,
    h = 200/zoom,

}

dots = 0

main.renderRadar = function()
    if getElementData(localPlayer, 'player:hudof') or not getElementData(localPlayer, "player:spawn") then
        return
    end

    dxDrawImage(radarPos.x, radarPos.y, radarPos.w, radarPos.h, main.radarData.background)
    setPlayerHudComponentVisible('radar', false)

    local px,py,pz = getElementPosition(localPlayer)
    local int, dim = getElementInterior(localPlayer), getElementDimension(localPlayer)
	local x = (px) / 6000
	local y = (py) / -6000
	dxSetShaderValue(main.radarData.maskShader, "gUVPosition", x, y)
	dxSetShaderValue(main.radarData.maskShader, "gUVScale", ( radarPos.w / 3000 ), ( radarPos.h / 3000 ))

    if GPS and GPS.road and #GPS.road ~= lastGPS then
		updateRadarTexture()
		lastGPS = #GPS.road
	end

	local _, _, camrot = getElementRotation(getCamera())
	dxSetShaderValue(main.radarData.maskShader, "gUVRotAngle", math.rad(-camrot))

    if int ~= 0 or dim ~= 0 then
        dots = dots + 0.5

        if dots >= 100 then
            dots = 0
        end

        local theDots = dots > 50 and '...' or dots > 25 and '..' or '.'

        dxDrawText('Brak sygnału', radarPos.x + radarPos.w/2, radarPos.y + radarPos.h/2, nil, nil, tocolor(255, 100, 100, 155), 1, main.radarData.font2, 'center', 'bottom', false, false, false, false, false)
        dxDrawText('Łączenie z GPS'..theDots, radarPos.x + radarPos.w/2, radarPos.y + radarPos.h/2, nil, nil, tocolor(255, 255, 255, 155), 1, main.radarData.font3, 'center', 'top', false, false, false, false, false)
    else
        dxDrawImage(radarPos.x, radarPos.y, radarPos.w, radarPos.h, main.radarData.maskShader)
    end

    if int ~= 0 or dim ~= 0 then
    else
        local x, y, z = getElementPosition(localPlayer)
        local zoneName = (getZoneName(x, y, z, true) or 'Brak danych')
        local zoneName2 = (getZoneName(x, y, z, false) or 'Brak danych')
        dxDrawText(zoneName, radarPos.x + radarPos.w + 12/zoom, radarPos.y + radarPos.h - 18/zoom + 2, nil, nil, tocolor(0, 0, 0, 200), 1, main.radarData.font4, 'left', 'bottom', false, false, false, false, false)
        dxDrawText(zoneName2, radarPos.x + radarPos.w + 12/zoom, radarPos.y + radarPos.h - 20/zoom + 2, nil, nil, tocolor(0, 0, 0, 200), 1, main.radarData.font5, 'left', 'top', false, false, false, false, false)
        dxDrawText(zoneName, radarPos.x + radarPos.w + 12/zoom, radarPos.y + radarPos.h - 18/zoom, nil, nil, tocolor(255, 255, 255, 195), 1, main.radarData.font4, 'left', 'bottom', false, false, false, false, false)
        dxDrawText(zoneName2, radarPos.x + radarPos.w + 12/zoom, radarPos.y + radarPos.h - 20/zoom, nil, nil, tocolor(56, 175, 89), 1, main.radarData.font5, 'left', 'top', false, false, false, false, false)

        for k,v in pairs(getElementsByType("blip")) do
            local attach = getElementAttachedTo(v)
            local bx, by, bz = getElementPosition(v)
            local dist = getDistanceBetweenPoints2D(px, py, bx, by) / (2)
            local rot = math.atan2(bx - px, by - py) + math.rad(camrot)
            local icon = getBlipIcon(v)
            
            if attach ~= localPlayer then
                if fileExists("blips/"..icon..".png") then
                    if icon ~= 0 then
                        local x, y = radarPos.x + radarPos.w / 2 - (main.settings.blipsScale/2)/zoom + math.sin(rot) * dist, radarPos.y + radarPos.h / 2 + (main.settings.blipsScale/2)/zoom - math.cos(rot) * dist
                        local x = math.min(math.max(x, radarPos.x + 2/zoom - (main.settings.blipsScale/zoom)/2), radarPos.x + radarPos.w - main.settings.blipsScale/zoom + (main.settings.blipsScale/zoom)/2)
                        local y = math.min(math.max(y, radarPos.y + main.settings.blipsScale/zoom + 3/zoom - (main.settings.blipsScale/zoom)/2), radarPos.y + radarPos.h - 4/zoom + (main.settings.blipsScale/zoom)/2)
                        
                        if icon == 1 then
                            local r, g, b = getBlipColor(v)
                            local theSize = main.settings.blipsScale - 20
                            dxDrawImage(x + 10/zoom, y - 10/zoom - theSize/zoom, theSize/zoom, theSize/zoom, "blips/"..icon..".png", 0, 0, 0, tocolor(r, g, b))
                        else
                            if 200 >= dist then
                                local r, g, b = 75, 165, 255
                                dxDrawImage(x, y - main.settings.blipsScale/zoom, main.settings.blipsScale/zoom, main.settings.blipsScale/zoom, "blips/circle.png", 0, 0, 0, tocolor(r/3, g/3, b/3, 245))
                                dxDrawImage(x, y - main.settings.blipsScale/zoom, main.settings.blipsScale/zoom, main.settings.blipsScale/zoom, "blips/obrys.png", 0, 0, 0, tocolor(r, g, b, 250))
                                dxDrawImage(x, y + 4/zoom - main.settings.blipsScale/zoom, main.settings.blipsScale/zoom, main.settings.blipsScale/zoom, "blips/"..icon..".png", 0, 0, 0, tocolor(255, 255, 255, 200))
                            end
                        end
                    else
                        local playerBlip = getElementData(v, "player:blip")

                        if playerBlip ~= localPlayer then
                            local x, y = radarPos.x + radarPos.w / 2 - (25/2)/zoom + math.sin(rot) * dist, radarPos.y + radarPos.h / 2 + (25/2)/zoom - math.cos(rot) * dist
                            local x = math.min(math.max(x, radarPos.x), radarPos.x + radarPos.w - 25/zoom)
                            local y = math.min(math.max(y, radarPos.y + 25/zoom), radarPos.y + radarPos.h)

                            dxDrawImage(x + 5/zoom, y - 22/zoom, 14/zoom, 14/zoom, "blips/0.png")
                        end
                    end
                end
            end
        end

        local _, _, rz = getElementRotation(localPlayer)
        dxDrawImage(radarPos.x + radarPos.w / 2 - 10/zoom, radarPos.y + radarPos.h / 2 - 10/zoom, 20/zoom, 20/zoom, "blips/arrow.png", camrot - rz)
    end
end

function findRotation(x1, y1, x2, y2) 
    local t = -math.deg(math.atan2(x2 - x1, y2 - y1))
    return t < 0 and t + 360 or t
end

function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle)
    local dx = math.cos(a) * dist
    local dy = math.sin(a) * dist
    return x+dx, y+dy
end

function getMapPositionFromWorld(x, y, w, h)
	return (x+3000)/6000*w, (3000-y)/6000*h
end


function updateRadarTexture()
	dxSetRenderTarget(main.renderTarget, true)
    dxDrawImage(0, 0, 3072, 3072, main.radarData.mapTexture)

	for k,v in pairs(getElementsByType("radararea")) do
		local x, y = getElementPosition(v)
		local w, h = getRadarAreaSize(v)
		local dim = getElementDimension(v)
		local int = getElementInterior(v)

		if getElementDimension(localPlayer) == dim and getElementInterior(localPlayer) == int then
			local x, y = getMapPositionFromWorld(x, y, 3072, 3072)
			w, h = w * (3072/6000), h * (3072/6000)
			local r, g, b = getRadarAreaColor(v)
			dxDrawRectangle(x, y, w, -h, tocolor(r, g, b, 155))
		end
	end

	if GPS and GPS.road then
        if #GPS.road > 0 then
            for i = #GPS.road, 1, -1 do
                if (GPS.road[i + 1] ~= nil) then
                    local x, y = getMapPositionFromWorld(GPS.road[i].posX, GPS.road[i].posY, 3072, 3072)
                    local ex, ey = getMapPositionFromWorld(GPS.road[i + 1].posX, GPS.road[i + 1].posY, 3072, 3072)
                    dxDrawLine(x, y, ex, ey, tocolor(225, 100, 255, 225), 4)
                end
            end
        end
    end

	dxSetRenderTarget()
end
setTimer(updateRadarTexture, 50, 1)
setTimer(updateRadarTexture, 500, 0)

function dxDrawLinedRectangle( x, y, width, height, color, _width, postGUI )
	_width = _width or 1
	dxDrawLine ( x, y, x+width, y, color, _width, postGUI ) -- Top
	dxDrawLine ( x, y, x, y+height, color, _width, postGUI ) -- Left
	dxDrawLine ( x, y+height, x+width, y+height, color, _width, postGUI ) -- Bottom
	return dxDrawLine ( x+width, y, x+width, y+height, color, _width, postGUI ) -- Right
end

findBestWay(-2427.625,-2474.75)