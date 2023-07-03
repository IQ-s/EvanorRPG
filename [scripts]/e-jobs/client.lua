--[[
    Resource: e-jobs
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--


function main:renderGUI()
    dxDrawImage(sx/2-640/2/zoom,sy/2-408/2/zoom,640/zoom,408/zoom,self.textures['bg'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawImage(sx/2-640/2/zoom + 640/zoom - 35/zoom,sy/2-408/2/zoom + 15/zoom/2,26/zoom,26/zoom,self.textures['exit'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-640/2/zoom + 640/zoom - 35/zoom,sy/2-408/2/zoom + 15/zoom/2,26/zoom,26/zoom) and 255 or 200) or self.alpha[1]*0.8)))
    dxDrawText('Praca dorwycza',sx/2-640/2/zoom + 25/zoom,sy/2-408/2/zoom + 25/zoom,nil,nil,tocolor(255,255,255,self.alpha[1]),1,self.fonts[1],'left','center')
    dxDrawText(self.jobs[self.job].desc,sx/2-640/2/zoom + 25/zoom,sy/2-408/2/zoom + 25/zoom + dxGetFontHeight(1,self.fonts[1]),nil,nil,tocolor(56,175,89,self.alpha[1]),1,self.fonts[2],'left','center')
    dxDrawRectangle(sx/2-245/zoom,sy/2-214/2/zoom, 2.0000000000001137/zoom, 214/zoom,tocolor(91,91,91,self.alpha[1]))
    local offset = 0
    for i,v in pairs(self.pages) do
        offset = offset + 55/zoom
        dxDrawImage(sx/2-245/zoom - 30/zoom - 35/zoom/2,sy/2-214/2/zoom - 55/zoom + offset, 30/zoom, 30/zoom, self.textures['option_bg'],0,0,0,tocolor(255,255,255,self.alpha[1]))
        dxDrawImage(sx/2-245/zoom - 30/zoom - 35/zoom/2 + 30/zoom/2 - 24/2/zoom,sy/2-214/2/zoom - 55/zoom + offset + 30/zoom/2 - 24/2/zoom, 24/zoom, 24/zoom, self.textures[v.icon],0,0,0,tocolor(255,255,255,self.alpha[1]),true)
        if (self.page == i and v.render) then
            v.render(self)
        end
    end
    dxDrawImage(sx/2-245/zoom - 30/zoom - 35/zoom/2,self.y, 30/zoom, 30/zoom, self.textures['option_bg_hovered'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawText(self.pages[self.page].name, sx/2-245/zoom + 20/zoom,sy/2-214/2/zoom + 5/zoom, nil, nil, tocolor(255,255,255,self.alpha[2]),1,self.fonts[2],'left','center')
    dxDrawImage(sx/2-212/2/zoom,sy/2+150/zoom,212/zoom,30/zoom,self.textures['button_start'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-212/2/zoom,sy/2+150/zoom,212/zoom,30/zoom) and 255 or 150) or self.alpha[1]*0.6)))
    dxDrawText((getElementData(localPlayer,'player:job') and 'Zakoncz prace' or 'Rozpocznij prace'),sx/2-212/2/zoom + 212/2/zoom,sy/2+150/zoom + 30/zoom/2,nil,nil,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-212/2/zoom,sy/2+150/zoom,212/zoom,30/zoom) and 255 or 150) or self.alpha[1]*0.6)),1,self.fonts[3],'center','center')
end

function main:click(btn,state)
    if (btn == 'left' and state == 'down' and not self.animation) then
        if (isMouseInPosition(sx/2-640/2/zoom + 640/zoom - 35/zoom,sy/2-408/2/zoom + 15/zoom/2,26/zoom,26/zoom)) then
            self.animation = true
            animate(255,0,'InOutQuad',700,function (c)
                self.alpha[1] = c
                self.alpha[2] = c
            end,function ()
                self.pages[self.page].exit()
                removeEventHandler('onClientRender',root,self.renderMain)
                removeEventHandler('onClientClick',root,self.clickMain)
                showCursor(false)
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
        end
        local offset = 0
        for i,v in pairs(self.pages) do
            offset = offset + 55/zoom
            if (isMouseInPosition(sx/2-245/zoom - 30/zoom - 35/zoom/2,sy/2-214/2/zoom - 55/zoom + offset, 30/zoom, 30/zoom) and self.page ~= i) then
                self.animation = true
                animate(255,0,'InOutQuad', 600/2,function (c)
                    self.alpha[2] = c
                end,function ()
                    self.pages[self.page].exit()
                    self.page = i
                    self.pages[self.page].enter()
                    animate(0,255,'InOutQuad', 600/2,function (c)
                        self.alpha[2] = c
                    end,function ()
                        self.animation = false
                    end)
                end)
                animate(self.y,v.y,'InOutQuad', 600,function (c)
                    self.y = c
                end,function ()
                end)
            end
        end
    end
end

function showJobGUI(data)
    return main.createGUI(data)
end

-- showJobGUI({
--     job = 1
-- })

-- showCursor(true)

local marker = createMarker(2452.6728515625,834.64971923828,6.734375-1,'cylinder',1.5,255,255,255,50)
addEventHandler('onClientMarkerHit',marker,function (plr)
    if (plr ~= localPlayer) then return end
    showJobGUI({
        job = 1
    })
    showCursor(true)
end)