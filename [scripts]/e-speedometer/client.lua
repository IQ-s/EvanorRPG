--[[
    Resource: e-speedometer
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

function main:rnd()
    if not getPedOccupiedVehicle(localPlayer) then return end
    if (self.actaullType == 'normal') then
        local sxx, syx, szx = getElementVelocity(getPedOccupiedVehicle(localPlayer))
        local rpm = getVehicleRPM(getPedOccupiedVehicle(localPlayer))
        exports['e-blur']:dxDrawBlur(sx-360/zoom,sy-360/zoom,340/zoom,340/zoom,self.textures['mask'])
        dxDrawImage(sx-360/zoom,sy-360/zoom,340/zoom,340/zoom,self.textures['bg'])
        dxDrawImage(sx-360/zoom + 340/2/zoom - 94/zoom/2,sy-45/zoom,94/zoom,17/zoom,self.textures['bg_paliwo'])
        dxDrawText('0',sx-355/zoom + 340/2/zoom - 94/zoom/2,sy-60/zoom,nil,nil,tocolor(255,255,255),1,self.fonts[2],'center','center')
        dxDrawText('1',sx-273/zoom + 340/2/zoom - 94/zoom/2,sy-60/zoom,nil,nil,tocolor(255,255,255),1,self.fonts[2],'center','center')
        dxDrawImage(sx-360/zoom,sy-360/zoom,340/zoom,340/zoom,self.textures['wskazowka'],285*rpm/10000)
        dxDrawText('PB',sx-360/zoom + 340/2/zoom - 94/zoom/2 + 94/zoom/2,sy-55/zoom,nil,nil,tocolor(255,255,255),1,self.fonts[3],'center','center')
        dxDrawText('0',sx-265/zoom,sy-80/zoom,nil,nil,tocolor(255,255,255),1,self.fonts[1],'center','center')
        dxDrawText('1',sx-320/zoom,sy-135/zoom,nil,nil,tocolor(255,255,255),1,self.fonts[1],'center','center')
        dxDrawText('2',sx-322/zoom,sy-210/zoom,nil,nil,tocolor(255,255,255),1,self.fonts[1],'center','center')
        dxDrawText('3',sx-290/zoom,sy-278/zoom,nil,nil,tocolor(255,255,255),1,self.fonts[1],'center','center')
        dxDrawText('4',sx-225/zoom,sy-315/zoom,nil,nil,tocolor(255,255,255),1,self.fonts[1],'center','center')
        dxDrawText('5',sx-153/zoom,sy-315/zoom,nil,nil,tocolor(255,255,255),1,self.fonts[1],'center','center')
        dxDrawText('6',sx-85/zoom,sy-275/zoom,nil,nil,tocolor(255,255,255),1,self.fonts[1],'center','center')
        dxDrawText('7',sx-55/zoom,sy-210/zoom,nil,nil,tocolor(255,255,255),1,self.fonts[1],'center','center')
        dxDrawText('8',sx-65/zoom,sy-137/zoom,nil,nil,tocolor(255,255,255),1,self.fonts[1],'center','center')
        dxDrawText('9',sx-105/zoom,sy-85/zoom,nil,nil,tocolor(255,255,255),1,self.fonts[1],'center','center')
        dxDrawText(math.ceil(((sxx^2+syx^2+szx^2)^(0.5)) * 150),sx-360/zoom + 340/zoom/2,sy-360/zoom + 340/zoom/2,nil,nil,tocolor(255,255,255),1,self.fonts[4],'center','center')
        dxDrawRectangle(sx-360/zoom + 340/zoom/2 + dxGetTextWidth(tostring(math.ceil(((sxx^2+syx^2+szx^2)^(0.5)) * 150)),1,self.fonts[4])/2 + 10/zoom,sy-360/zoom + 340/zoom/2,40/zoom,2/zoom)
        dxDrawRectangle(sx-360/zoom + 340/zoom/2 - dxGetTextWidth(tostring(math.ceil(((sxx^2+syx^2+szx^2)^(0.5)) * 150)),1,self.fonts[4])/2 - 100/zoom/2,sy-360/zoom + 340/zoom/2,40/zoom,2/zoom)
        dxDrawText('kmh',sx-360/zoom + 340/zoom/2,sy-360/zoom + 400/zoom/2,nil,nil,tocolor(200,200,200),1,self.fonts[5],'center','center')
        dxDrawText('0000020 km',sx-360/zoom + 340/zoom/2,sy-360/zoom + 460/zoom/2,nil,nil,tocolor(255,255,255),1,self.fonts[3],'center','center')
        local offset = 0
        for i,v in pairs(self.check) do
            offset = offset + 30/zoom
            dxDrawImage(sx-360/zoom + 340/zoom/2  + offset - 20/zoom * #self.check - 1,sy-250/zoom,20/zoom,20/zoom,self.textures[v.icon],0,0,0,tocolor(255,255,255,(v.check(getPedOccupiedVehicle(localPlayer)) and 255 or 150)))
        end
        local fuel = 30
    elseif (self.actaullType == 'elektryk') then
        local fuel = 35
        local rpm = getVehicleRPM(getPedOccupiedVehicle(localPlayer))/100
        exports['e-blur']:dxDrawBlur(sx-360/zoom,sy-340/zoom,350/zoom,324.51/zoom,self.textures['mask2'])
        dxDrawImage(sx-360/zoom,sy-340/zoom,350/zoom,324.51/zoom,self.textures['bg2'])
        --dxDrawImage(sx-360/zoom + 350/zoom/2 - (322.65/zoom + 10/zoom)/2,sy-330/zoom,322.6502990722656/zoom + 10/zoom, 292.2717590332031/zoom + 10/zoom,self.textures['bg_filled'])
        dxCircle(sx-185/zoom, sy-165/zoom, 330/zoom, 320/zoom, tocolor(136, 136, 136), 128, 220, 20/zoom, 1, true)
        dxCircle(sx-185/zoom, sy-165/zoom, 330/zoom, 320/zoom, tocolor(56, 175, 89), 128, 220*rpm/100, 20/zoom, 1)
        dxDrawImage(sx-360/zoom + 350/zoom/2 - 178/zoom/2,sy-41/zoom,178/zoom,15/zoom,self.textures['bg_fuel'])
        dxDrawImage(sx-356/zoom + 350/zoom/2 - 178/zoom/2,sy-37/zoom,170/zoom * fuel/100,8/zoom,self.textures['fuel_filled'])
    end
end