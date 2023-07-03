local sx,sy = guiGetScreenSize()
local zoom = exports['e-gui']:getZoom()

local renderTarget = dxCreateRenderTarget(3072, 3072, true)
local shader = dxCreateShader('mask.fx')
local mask = dxCreateTexture('mask.png')
local map = dxCreateTexture('map.png')
dxSetShaderValue(shader, "sPicTexture", renderTarget)


function getMapPositionFromWorld(x, y, w, h)
	return (x+3000)/6000*w, (3000-y)/6000*h
end

function updateRadarTexture()
	dxSetRenderTarget(renderTarget, true)
    dxDrawImage(0, 0, 3072, 3072, map)
    local GPS = exports['e-radar']:getGPS()

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

addEventHandler('onClientRender',root,function ()
    local px,py,pz = getElementPosition(localPlayer)
    local int, dim = getElementInterior(localPlayer), getElementDimension(localPlayer)
	local x = (px) / 6000
	local y = (py) / -6000
	dxSetShaderValue(shader, "gUVPosition", x, y)
	dxSetShaderValue(shader, "gUVScale", ( sx / 3000 ), ( sy / 3000 ))

    dxDrawRectangle(0,0,sx,sy,tocolor(31,31,31,200))
    dxDrawImage(0,0,sx,sy,shader)
    
end)