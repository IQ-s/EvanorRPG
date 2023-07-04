--[[
    Resource: e-interaction
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--


function main:render()
    dxDrawImage(0,0,sx,sy,self.textures['background'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawText('INTERAKCJA Z OTOCZENIEM',sx/2,25/zoom,nil,nil,tocolor(58,155,85,self.alpha[1]),1,self.fonts[1],'center','center')
    dxDrawText('Kliknij na wybrany obiekt',sx/2,25/zoom + 20/zoom,nil,nil,tocolor(255,255,255,self.alpha[1]),1,self.fonts[2],'center','center')
    local cursorX,cursorY = getCursorPosition()
    if not cursorX or not cursorY then return end
    local absX, absY = cursorX*sx, cursorY*sy
    if (not self.item) then
        dxDrawImage(absX - 30/zoom/2, absY - 30/zoom/2, 30/zoom, 30/zoom, self.textures['circle'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    else
        dxDrawImage(self.item.absX - 30/zoom/2, self.item.absY - 30/zoom/2, 30/zoom, 30/zoom, self.textures['circle'],0,0,0,tocolor(255,255,255,self.alpha[1]))
        local offset = 0
        local huj = (not self.options[getElementType(self.item.item)] and self.options[getElementModel(self.item.item)] or self.options[getElementType(self.item.item)])
        if huj then
            for i,v in pairs(huj) do
                offset = offset + 35/zoom
                dxDrawImage(self.item.absX + 30/zoom/2 + 20/zoom, self.item.absY - 28/zoom/2 - 35/zoom + offset, 30/zoom,30/zoom,self.textures[(isMouseInPosition(self.item.absX + 30/zoom/2 + 20/zoom, self.item.absY - 28/zoom/2 - 35/zoom + offset, 30/zoom + 230/zoom,30/zoom) and 'option_circle_hovered' or 'option_circle')],0,0,0,tocolor(255,255,255,self.alpha[2]))
                dxDrawImage(self.item.absX + 30/zoom/2 + 20/zoom + 30/zoom/2 - 14/zoom/2, self.item.absY - 28/zoom/2 - 35/zoom + offset + 30/zoom/2 - 14/zoom/2, 14/zoom,14/zoom,self.textures[v.icon],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(self.item.absX + 30/zoom/2 + 20/zoom, self.item.absY - 28/zoom/2 - 35/zoom + offset, 30/zoom + 230/zoom,30/zoom) and self.alpha[2] or self.alpha[2]*0.6) or self.alpha[2]*0.6)))
                dxDrawImage(self.item.absX + 30/zoom/2 + 20/zoom + 35/zoom, self.item.absY - 28/zoom/2 - 35/zoom + offset + 4/zoom/2, 230/zoom,26/zoom,self.textures[(isMouseInPosition(self.item.absX + 30/zoom/2 + 20/zoom, self.item.absY - 28/zoom/2 - 35/zoom + offset, 30/zoom + 230/zoom,30/zoom) and 'option_bg_hovered' or 'option_bg')],0,0,0,tocolor(255,255,255,self.alpha[2]))
                dxDrawText(v.name,self.item.absX + 30/zoom/2 + 20/zoom + 35/zoom + 230/zoom/2, self.item.absY - 28/zoom/2 - 35/zoom + offset + 4/zoom/2 + 26/zoom/2,nil,nil,tocolor(255,255,255,(not self.animation and (isMouseInPosition(self.item.absX + 30/zoom/2 + 20/zoom, self.item.absY - 28/zoom/2 - 35/zoom + offset, 30/zoom + 230/zoom,30/zoom) and self.alpha[2] or self.alpha[2]*0.6) or self.alpha[2]*0.6)),1,self.fonts[3],'center','center')
            end
        end
        dxDrawRectangle(self.item.absX + 30/zoom/2 + 10/zoom, self.item.absY - 13/zoom, 3/zoom, offset - 4/zoom, tocolor(120,120,120,self.alpha[2]))
    end
end
    
function main:click(btn, state, ax, ay, wx, wy, wz, element)
    if (btn == 'left' and state == 'down' and not self.animation) then
        if (self.item) then
            local offset = 0
            local huj = (not self.options[getElementType(self.item.item)] and self.options[getElementModel(self.item.item)] or self.options[getElementType(self.item.item)])
            if huj then
                for i,v in pairs(huj) do
                    offset = offset + 35/zoom
                    if (isMouseInPosition(self.item.absX + 30/zoom/2 + 20/zoom, self.item.absY - 28/zoom/2 - 35/zoom + offset, 30/zoom + 230/zoom,30/zoom)) then
                        triggerServerEvent('useInteractionOption',localPlayer,localPlayer,(not self.options[getElementType(self.item.item)] and getElementModel(self.item.item) or getElementType(self.item.item)),i)
                    end
                end
            end
        end
        if (element) then
            if self.compatibleobjects[getElementType(element)] and not self.item then
                local cursorX,cursorY = getCursorPosition()
                if not cursorX or not cursorY then return end
                local absX, absY = cursorX*sx, cursorY*sy
                self.animation = true
                self.animate(0,255,'Linear',300,function (c)
                    self.alpha[2] = c
                end,function ()
                    self.animation = false
                end)
                self.item = {
                    item = element,
                    absX = absX,
                    absY = absY
                }
                setCursorAlpha(255)
            end
        else
            if self.item then
                self.animation = true
                self.animate(255,0,'Linear',300,function (c)
                    self.alpha[2] = c
                    setCursorAlpha(c)
                end,function ()
                    self.animation = false
                    self.item = false
                end)
            end
        end
    end
end

local object = createObject(2942,-1262.6997070312,-220.68011474609,14)
setElementData(object,'interaction','atm')