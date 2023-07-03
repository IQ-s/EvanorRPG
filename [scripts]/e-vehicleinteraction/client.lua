--[[
    Resource: e-vehicleinteraction
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

function main:updateRenderTarget()
    if not (isElement(self.rt)) then return end
    dxSetRenderTarget(self.rt, true)
    local offset = 0
    for i,v in pairs(self.options) do
        offset = offset + 47
        dxDrawImage(0 + 270 - 40, 0 - 47 + offset, 40, 40, self.textures['options_circle'],0,0,0,tocolor(255,255,255,self.alpha))
        dxDrawImage(0 + 270 - 40 + 40/2 - 26/2, 0 - 47 + offset + 40/2 - 26/2, 26, 26, self.textures[v.icon],0,0,0,tocolor(255,255,255,self.alpha))
    end
    dxDrawImage(0 + 270 - 40, self.y, 40, 40, self.textures['options_circle_hovered'],0,0,0,tocolor(255,255,255,self.alpha))
    dxDrawImage(0 + 270 - 40 - 213 - 10, self.y + 6/2, 213, 34, self.textures['option_bg'],0,0,0,tocolor(255,255,255,self.alpha))
    dxDrawText(self.options[self.selectedOption].name(getPedOccupiedVehicle(localPlayer)):upper(), 0 + 270 - 40 - 213 - 10 + 213/2,self.y + 6/2 + 34/2, nil,nil,tocolor(255,255,255,self.alpha),1,self.fonts[3],'center','center')
    dxDrawImage(0 + 270 - 40 + 40/2 - 26/2, self.y + 40/2 - 26/2, 26, 26, self.textures[self.options[self.selectedOption].icon],0,0,0,tocolor(255,255,255,self.alpha))
    dxDrawRectangle(0 + 280 - 4, 0, 3,offset - 10,tocolor(110,110,110,self.alpha *0.8))
    dxDrawRectangle(0 + 280 - 4, 0 + self.y, 3,40,tocolor(58,243,109,self.alpha *0.8))
    if (self.options[self.selectedOption].type and self.options[self.selectedOption].type == 'regulate') then
        local offset = 0
        for i,v in pairs(self.options[self.selectedOption].options) do
            offset = offset + 25
            dxDrawImage(0 + 270 - 40 - 213 - 10 - 25 + offset + 213/2 - 110/2, self.y + 34 + 20/2.5,20,20,self.textures['options_circle'],0,0,0,tocolor(255,255,255,self.alpha))
            if (self.options[self.selectedOption].optionLevel == i) then
                dxDrawImage(0 + 270 - 40 - 213 - 10 - 25 + offset + 213/2 - 110/2, self.y + 34 + 20/2.5,20,20,self.textures['options_circle_hovered'],0,0,0,tocolor(255,255,255,self.alpha))
            end
            dxDrawText(self.options[self.selectedOption].options[self.options[self.selectedOption].optionLevel].text,0 + 270 - 40 - 213 - 10 + 225/2, self.y + 70,nil,nil,tocolor(255,255,255,self.alpha),1,self.fonts[3],'center','center')
            --dxDrawText(i,0 + 270 - 40 - 213 - 10 - 25 + offset + 213/2 - 110/2, self.y + 34 + 20/2.5,nil,nil,white)
        end
    end
    dxSetRenderTarget()
end

function main:render()
    dxDrawImage(sx-350/zoom,sy/2-440/zoom/2,378/zoom,440/zoom,self.textures['bg'],0,0,0,tocolor(255,255,255,self.alpha))
    dxDrawText('KLAWISZOLOGIA INTERAKCJI',sx - 10/zoom + 1/zoom, sy/2-130/zoom, nil, nil, tocolor(0,0,0,self.alpha),1, self.fonts[1],'right','center')
    dxDrawText('KLAWISZOLOGIA INTERAKCJI',sx - 10/zoom, sy/2-130/zoom, nil, nil, tocolor(56,175,89,self.alpha),1, self.fonts[1],'right','center')
    dxDrawText('Strzałki góra dół oraz spacja',sx - 10/zoom + 1/zoom, sy/2-110/zoom, nil, nil, tocolor(0,0,0,self.alpha),1, self.fonts[2],'right','center')
    dxDrawText('Strzałki góra dół oraz spacja',sx - 10/zoom, sy/2-110/zoom, nil, nil, tocolor(238,238,238,self.alpha),1, self.fonts[2],'right','center')
    dxDrawRectangle(sx - 10/zoom - 270/zoom, sy/2-95/zoom, 270/zoom,3/zoom,tocolor(110,110,110,self.alpha *0.8))
    dxDrawImage(sx - 20/zoom - 270/zoom, sy/2-75/zoom, 280/zoom,200/zoom,self.rt,0,0,0,tocolor(255,255,255,self.alpha))
    --main:updateRenderTarget()
end