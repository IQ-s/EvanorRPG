

function main:render()
    local exp = getElementData(localPlayer,'player:exp')
    local maxExp = 100
    exports['e-blur']:dxDrawBlur(sx/2-1000/2/zoom,sy/2-660/2/zoom,1000/zoom,660/zoom,self.textures['mask'],self.alpha[1])
    dxDrawImage(sx/2-1000/2/zoom,sy/2-660/2/zoom,1000/zoom,660/zoom,self.textures['bg'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawText('Dashboard /.', sx/2 + -479/zoom, sy/2 + -309/zoom, (sx/2 + -479/zoom) + (121/zoom), (sy/2 + -309/zoom) + (25/zoom), tocolor(238, 242, 239, self.alpha[1]), 1, self.fonts[1], 'left', 'top')
    dxDrawText(self.pages[self.page].name:upper(), sx/2 + -479/zoom + dxGetTextWidth('Dashboard /.',1,self.fonts[1]) + 10/zoom, sy/2 + -305/zoom, (sx/2 + -479/zoom) + (121/zoom), (sy/2 + -309/zoom) + (25/zoom), tocolor(56, 175, 89, self.alpha[1]), 1, self.fonts[4], 'left', 'top')
    dxDrawRectangle(sx/2 + -500/zoom, sy/2 + -263/zoom, 999/zoom, 2/zoom,tocolor(91,91,91,self.alpha[1]*0.5))
    dxDrawImage(sx/2 + -148/zoom, sy/2 + -277/zoom, 595/zoom, 3/zoom, self.textures['lvl_bar'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawImage(sx/2 + -148/zoom, sy/2 + -277/zoom, 595/zoom * exp / maxExp, 3/zoom, self.textures['lvl_bar_full'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawText('Następny poziom za', sx/2 + -148/zoom + 595/zoom, sy/2 + -319/zoom, nil, (sy/2 + -319/zoom) + (13/zoom), tocolor(207, 207, 207, self.alpha[1]), 1, self.fonts[2], 'right', 'top')
    dxDrawText(''..(maxExp - exp)..' xp', sx/2 + -148/zoom + 595/zoom, sy/2 + -303/zoom, nil, (sy/2 + -319/zoom) + (13/zoom), tocolor(207, 207, 207, self.alpha[1]), 1, self.fonts[3], 'right', 'top')
    dxDrawImage(sx/2 + -148/zoom, sy/2 + -313/zoom, 30/zoom, 30/zoom, self.textures['circle_level'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawText(tostring(getElementData(localPlayer,'player:level')),sx/2 + -148/zoom + 30/zoom/2, sy/2 + -313/zoom + 30/zoom/2, nil, nil, tocolor(238, 242, 239, self.alpha[1]),1,self.fonts[3],'center','center')
    dxDrawText('Poziom konta',sx/2 + -148/zoom + 40/zoom, sy/2 + -313/zoom + 30/zoom/2, nil, nil, tocolor(238, 242, 239, self.alpha[1]),1,self.fonts[3],'left','center')
    for i,v in pairs(self.pages) do
        if (self.page == i) then
            if (self.loaded) then
                v.render()
            end
        end
    end
    dxDrawImage(sx/2 + -500/zoom, sy/2 + -263/zoom, 300/zoom, 593/zoom,self.textures['menu_bg'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawRectangle(sx/2 + -200/zoom, sy/2 + -262/zoom, 2/zoom, 591/zoom, tocolor(64,64,64,self.alpha[1]))
    dxDrawImage(sx/2 + -479.70310730899206/zoom + 2.000030517578381/zoom, sy/2 + -313.2968927025795/zoom + 69.99998638214751/zoom, 68.49998314398839/zoom, 69.00001361785249/zoom, self.textures['custom_avatar'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawText(getPlayerName(localPlayer), sx/2 + -395/zoom, sy/2 + -235/zoom + 3/zoom, (sx/2 + -397/zoom) + (61/zoom), (sy/2 + -235/zoom) + (25/zoom), tocolor(238, 242, 239, self.alpha[1]), 1, self.fonts[5], 'left', 'top')
    dxDrawText(exports['e-core']:getRankName((getElementData(localPlayer,'player:admin') and getElementData(localPlayer,'player:admin').rank or 0)), sx/2 + -395/zoom, sy/2 + -215/zoom + 3/zoom, (sx/2 + -397/zoom) + (61/zoom), (sy/2 + -235/zoom) + (25/zoom), tocolor(238, 242, 239, self.alpha[1]*0.7), 1, self.fonts[5], 'left', 'top')
    local offset = 0
    for i,v in pairs(self.pages) do
        offset = offset + 52/zoom
        dxDrawImage(sx/2-1000/2/zoom,sy/2-200/zoom + offset, 300/zoom, 52/zoom,self.textures['page_bg'],0,0,0,tocolor(255,255,255,self.alpha[1]))
        dxDrawImage(sx/2-1000/2/zoom,self.y, 300/zoom, 52/zoom,self.textures['selected_page'],0,0,0,tocolor(255,255,255,self.alpha[1]*0.5))
        dxDrawImage(sx/2-960/2/zoom,sy/2-188/zoom + offset, 28/zoom, 28/zoom,self.textures[v.icon],0,0,0,tocolor(255,255,255,self.alpha[1]))
        dxDrawText(v.name, sx/2-895/2/zoom,sy/2-173/zoom + offset, nil, nil, tocolor(255,255,255,(self.page == i and self.alpha[1] or self.alpha[1]*0.5)),1,self.fonts[5],'left','center')
    end
end

function main:click(btn,state)
    if (btn == 'left' and state == 'down') then
        local offset = 0
        for i,v in pairs(self.pages) do
            offset = offset + 52/zoom
            if (isMouseInPosition(sx/2-1000/2/zoom,sy/2-200/zoom + offset, 300/zoom, 52/zoom) and self.page ~= i and not self.animation) then
                self.changePage(i)
            end
        end
    end
end