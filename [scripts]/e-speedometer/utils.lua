--[[
    Resource: e-speedometer
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

sx,sy = guiGetScreenSize()
zoom = exports['e-gui']:getZoom()

main = {}

function main:init()
    self.textures = {}
    self.fonts = {}
    self.render = function () main:rnd() end
    self.actaullType = false
    self.check = {}

    self.initSpeed = function (type)
        self.actaullType = type
        if (type == 'normal') then
            local textures = {
                ['bg'] = true,
                ['mask'] = true,
                ['wskazowka'] = true,
                ['bg_paliwo'] = true,
                ['brake'] = true,
                ['engine'] = true,
                ['lights'] = true,
                ['lock'] = true
            }
            self.check = {
                {
                    check = function (veh) return isElementFrozen(veh) end,
                    icon = 'brake'
                },
                {
                    check = function (veh) return getVehicleEngineState(veh) end,
                    icon = 'engine'
                },
                {
                    check = function (veh) return true end,
                    icon = 'lights'
                },
                {
                    check = function (veh) return isVehicleLocked(veh) end,
                    icon = 'lock'
                }
            }

            for i,v in pairs(textures) do
                self.textures[i] = dxCreateTexture('data/images/'..i..'.png','argb',false,'clamp')
            end
            self.fonts[1] = dxCreateFont('data/images/DigitalNumbers-Regular.ttf',14/zoom)
            self.fonts[2] = dxCreateFont('data/images/DigitalNumbers-Regular.ttf',12/zoom)
            self.fonts[3] = exports['e-gui']:getFont('medium',13/zoom)
            self.fonts[4] = dxCreateFont('data/images/DigitalNumbers-Regular.ttf',22/zoom)
            self.fonts[5] = exports['e-gui']:getFont('medium',16/zoom)
            addEventHandler('onClientRender',root,self.render)
        elseif (type == 'elektryk') then
            local textures = {
                ['bg2'] = true,
                ['mask2'] = true,
                ['bg_filled'] = true,
                ['bg_fuel'] = true,
                ['fuel_filled'] = true
            }
            for i,v in pairs(textures) do
                self.textures[i] = dxCreateTexture('data/images/'..i..'.png','argb',false,'clamp')
            end
            addEventHandler('onClientRender',root,self.render)
        end
    end

    self.initSpeed('elektryk')

    self.destroySpeedo = function ()
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
        removeEventHandler('onClientRender',root,self.render)
        self.check = {}
    end

    -- self.initSpeed('normal')
    addEventHandler('onClientPlayerVehicleEnter', root, function()
        if (source == localPlayer) then
            self.initSpeed('normal')
        end
    end)

    addEventHandler('onClientPlayerVehicleExit', root, function()
        if (source == localPlayer) then
            self.destroySpeedo()
        end
    end)

    addEventHandler('onClientResourceStart',resourceRoot,function ()
        if getPedOccupiedVehicle(localPlayer) then
            --self.initSpeed('normal')
        end
    end)
end


main:init()

function getElementSpeed(theElement, unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function getVehicleRPM(vehicle)
    local vehicleRPM = 0
    if (vehicle) then
        if (getVehicleEngineState(vehicle) == true) then
            if getVehicleCurrentGear(vehicle) > 0 then
                vehicleRPM = math.floor(((getElementSpeed(vehicle, "km/h") / getVehicleCurrentGear(vehicle)) * 160) + 0.5)
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9000) then
                    vehicleRPM = math.random(9000, 9900)
                end
            else
                vehicleRPM = math.floor((getElementSpeed(vehicle, "km/h") * 160) + 0.5)
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9000) then
                    vehicleRPM = math.random(9000, 9900)
                end
            end
        else
            vehicleRPM = 0
        end

        return tonumber(vehicleRPM)
    else
        return 0
    end
end

function dxCircle( x, y, width, height, color, angleStart, angleSweep, borderWidth, aaSize, test )
	height = height or width
	color = color or tocolor(255,255,255)
	borderWidth = borderWidth or 1e9
	angleStart = angleStart or 0
	angleSweep = angleSweep or 360 - angleStart
	if ( angleSweep < 360 ) then
		angleEnd = math.fmod( angleStart + angleSweep, 360 ) + (test and 90 or 0)
	else
		angleStart = 0
		angleEnd = 360 + (test and 90 or 0)
	end
	x = x - width / 2
	y = y - height / 2
	if not circleShader then
		circleShader = dxCreateShader ( "data/fx/circle.fx" )
	end
    
	dxSetShaderValue ( circleShader, "sCircleWidthInPixel", width );
	dxSetShaderValue ( circleShader, "sCircleHeightInPixel", height );
	dxSetShaderValue ( circleShader, "sBorderWidthInPixel", borderWidth );
	dxSetShaderValue ( circleShader, "aaSize", aaSize );
	dxSetShaderValue ( circleShader, "sAngleStart", math.rad( angleStart ) - math.pi );
	dxSetShaderValue ( circleShader, "sAngleEnd", math.rad( angleEnd ) - math.pi );
	dxDrawImage( x, y, width, height, circleShader, 90, 0, 0, color )
end