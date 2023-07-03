--[[
    Resource: e-vehicleinteraction
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--


main = {}
sx,sy = guiGetScreenSize()
zoom = exports['e-gui']:getZoom()
zoom = zoom * 0.9

function main:init()
    self.textures = {}
    self.fonts = {}
    self.draw = function () main:render() end
    self.toggle = false
    self.animation = false
    self.updateRT = function () main:updateRenderTarget() end
    self.selectedOption = 1
    self.texturesToLoad = {
        ['bg'] = true,
        ['options_circle'] = true,
        ['options_circle_hovered'] = true,
        ['options_selected'] = true,
        ['option_bg'] = true,
        ['brake'] = true,
        ['engine'] = true,
        ['lights'] = true,
        ['zawieszenia'] = true,
        ['option_circle_bg'] = true,
        ['options_kurwaaaa'] = true,
        ['options_kurwaaaa2'] = true
    }
    self.y = 0
    self.options = {}
    self.alpha = 0
    self.fontsToLoad = {
        [1] = { name = 'medium', size = 16/zoom },
        [2] = { name = 'medium', size = 14/zoom },
        [3] = { name = 'medium', size = 12 }
    }
    self.rt = false

    self.moveCircleTo = function (pos, newI)
        if self.animation then return end
        self.animation = true
        animate(self.y,pos,'InOutQuad', 300,function (c)
            self.y = c
            self.updateRT()
        end,function ()
            self.animation = false
            self.selectedOption = newI
        end)
    end

    bindKey('arrow_d','down',function ()
        if self.animation or not self.toggle then return end
        if (self.selectedOption == #self.options) then
            self.selectedOption = 1
            return self.moveCircleTo(self.options[self.selectedOption].pos, self.selectedOption)
        else
            self.selectedOption = self.selectedOption + 1
            self.moveCircleTo(self.options[self.selectedOption].pos, self.selectedOption)
        end
    end)

    bindKey('arrow_u','down',function ()
        if self.animation or not self.toggle then return end
        if (self.selectedOption == 1) then
            self.selectedOption = #self.options
            return self.moveCircleTo(self.options[self.selectedOption].pos, self.selectedOption)
        else
            self.selectedOption = self.selectedOption - 1
            self.moveCircleTo(self.options[self.selectedOption].pos, self.selectedOption)
        end
    end)

    bindKey('arrow_l','down',function ()
        if self.animation or not self.toggle then return end
        if (self.options[self.selectedOption].type and self.options[self.selectedOption].type == 'regulate') then
            if (self.options[self.selectedOption].optionLevel == 1) then
                self.options[self.selectedOption].optionLevel = #self.options[self.selectedOption].options
                self.updateRT()
            else
                self.options[self.selectedOption].optionLevel = self.options[self.selectedOption].optionLevel - 1
                self.updateRT()
            end
        end
    end)

    bindKey('arrow_r','down',function ()
        if self.animation or not self.toggle then return end
        if (self.options[self.selectedOption].type and self.options[self.selectedOption].type == 'regulate') then
            if (self.options[self.selectedOption].optionLevel == #self.options[self.selectedOption].options) then
                self.options[self.selectedOption].optionLevel = 1
                self.updateRT()
            else
                self.options[self.selectedOption].optionLevel = self.options[self.selectedOption].optionLevel + 1
                self.updateRT()
            end
        end
    end)

    bindKey('space','down',function ()
        if self.animation or not self.toggle then return end
        if (self.options[self.selectedOption].type == 'brake') then
            if (getElementSpeed(getPedOccupiedVehicle(localPlayer),'km/h') > 10) then
                return exports['e-notifications']:sendNotification('error','Aby uzyc tej opcji zwolnij!')
            end
        end
        triggerServerEvent('tryUseVehicleInteraction',localPlayer,localPlayer,self.options[self.selectedOption].type)
        setTimer(function ()
            self.updateRT()
        end,30, 30*1000)
    end)

    bindKey('lshift','down',function ()
        if self.animation or not getPedOccupiedVehicle(localPlayer) then return end

        if (self.toggle) then
            self.animation = true
            animate(255,0,'Linear',500,function (c)
                self.alpha = c
                self.updateRT()
            end,function ()
                self.options = {}
                self.animation = false
                removeEventHandler('onClientRender',root,self.draw)
                self.toggle = false
                if (isElement(self.rt)) then
                    destroyElement(self.rt)
                end
                for i,v in pairs(self.fonts) do
                    if (isElement(v)) then
                        destroyElement(v)
                    end
                end
                for i,v in pairs(self.textures) do
                    if (isElement(v)) then
                        destroyElement(v)
                    end
                end
            end)
        else
            self.options = {
                {
                    name = function(veh) return (getVehicleEngineState(veh) and "Zgas silnik" or "Uruchom silnik") end,
                    pos = 0,
                    icon = 'engine',
                    type = 'engine'
                },
                {
                    name = function(veh) return (isElementFrozen(veh) == false and "Zaciagnij reczny" or "Spusc reczny") end,
                    pos = 0 + 47,
                    icon = 'brake',
                    type = 'brake'
                },
                {
                    name = function(veh) return (getVehicleOverrideLights(veh) == 2 and "Zgas swiatla" or "Wlacz swiatla") end,
                    pos = 0 + 47 + 47,
                    icon = 'lights',
                    type = 'lights'
                },
                {
                    name = function () return ("OPCJA ZAWIESZENIA") end,
                    pos = 0 + 47 + 47 + 47,
                    icon = 'zawieszenia',
                    type = 'regulate',
                    optionLevel = 1,
                    options = {
                        {
                            text = 'Zwykle zawieszenie'
                        },
                        {
                            text = 'Zawieszenie sportowe'
                        },
                        {
                            text = 'Zawieszenie sport +'
                        },
                        {
                            text = 'Zawieszenie super ultra pro'
                        },
                        {
                            text = 'zawieszenie za psc'
                        }
                    }
                }
            }
            
            self.selectedOption = 1
            self.toggle = true
            self.y = 0
            for i,v in pairs(self.texturesToLoad) do
				self.textures[i] = dxCreateTexture('data/images/'..i..'.png','argb',false,'clamp')
			end
			for i,v in pairs(self.fontsToLoad) do
				self.fonts[i] = exports['e-gui']:getFont(v.name,v.size)
			end
            local offset = 0
            for i,v in pairs(self.options) do
                offset = offset + 47
            end
            self.rt = dxCreateRenderTarget(280, offset + 30, true)
            addEventHandler('onClientRender',root,self.draw)
            self.animation = true
            animate(0,255,'Linear',500,function (c)
                self.alpha = c
                self.updateRT()
            end,function ()
                self.animation = false
            end)
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

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end
