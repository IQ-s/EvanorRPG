--[[
    Resource: e-f1
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--


renderID, renderData = nil, nil

function main:updateRenderTarget()
    if not renderData then return end
    dxSetRenderTarget(renderData.rt, true)
    dxSetBlendMode('modulate_add')
    for i,v in pairs(self.pages) do
        if (self.page == i and self.pages[self.page].rt) then
            v.rt(self)
        end
    end
    dxSetBlendMode('blend')
    dxSetRenderTarget()
end
function main:render()
    dxDrawImage(sx/2-770/2/zoom,sy/2-660/2/zoom,770/zoom,660/zoom,self.textures['bg'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawImage(sx/2-720/2/zoom,sy/2-260/zoom,720/zoom,2/zoom,self.textures['menu_line'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawText('Panel pomocy #38AF59F1 /. '..self.pages[self.page].name,sx/2-770/2/zoom + 30/zoom,sy/2-660/2/zoom + 40/zoom,nil,nil,tocolor(255,255,255,self.alpha[1]),1,self.fonts[1],'left','center',false,false,false,true)
    local offset = 0
    for i,v in pairs(self.pages) do
        offset = offset + 55/zoom
        if (self.page == i) then
            v.render()
        end
        dxDrawImage(sx/2+105/zoom+offset,sy/2-306/zoom,32/zoom,32/zoom,self.textures['bg_menu'],0,0,0,tocolor(255,255,255,self.alpha[1]))
        dxDrawImage(sx/2+105/zoom+offset + 32/zoom/2 - 24/zoom/2,sy/2-306/zoom + 32/zoom/2 - 24/zoom/2,24/zoom,24/zoom,v.icon,0,0,0,tocolor(255,255,255,self.alpha[1]),true)
    end
    dxDrawImage(self.x,sy/2-306/zoom,32/zoom,32/zoom,self.textures['bg_menu_hover'],0,0,0,tocolor(255,255,255,self.alpha[1]))
end

function main:click(btn,state)
    if (btn == 'left' and state == 'down') then
        local offset = 0
        for i,v in pairs(self.pages) do
            offset = offset + 55/zoom
            if (isMouseInPosition(sx/2+105/zoom+offset,sy/2-306/zoom,32/zoom,32/zoom) and not self.animation and self.page ~= i) then
                self.changePage(i)
                animate(self.x,v.x,'InOutQuad', 600,function (c)
                    self.x = c
                end)
            end
        end
    end
end

function main:load()
    self.textures = {}
    self.fonts = {}
    self.renderFunc = function () main:render() end
    self.clickFunc = function (btn,state) main:click(btn,state) end
    self.updateRT = function () main:updateRenderTarget() end
    self.toggle = false
    self.page = 1
    self.alpha = {
        [1] = 0,
        [2] = 0
    }
    self.animation = false
    self.pages = pages
    self.x = sx/2+105/zoom + 55/zoom
    self.changePage = function (page)
        if self.animation then return end
        self.animation = true
        exports['e-scroll']:animateScroll(renderID, 300, 'InOutQuad', 255, 0)
        animate(255,0,'InOutQuad', 300,function (c)
            self.alpha[2] = c
            self.updateRT()
        end,function ()
            self.pages[self.page].leave(self)
            self.page = page
            self.pages[self.page].enter(self)
            animate(0,255,'InOutQuad', 300,function (c)
                self.alpha[2] = c
                self.updateRT()
            end,function ()
                self.animation = false
            end)
        end)
    end

    addEventHandler('onClientResourceStop',resourceRoot,function ()
        if (self.page) then
            self.pages[self.page].leave()
        end
    end)

    bindKey('f1','down',function ()
        if not getElementData(localPlayer, 'player:spawn') then return end
        if self.animation then return end
        if (self.toggle) then
            showCursor(false)
            self.toggle = false
            self.animation = true
            exports['e-scroll']:animateScroll(renderID, 300, 'InOutQuad', 255, 0)
            animate(255,0,'InOutQuad', 300,function (c)
                self.alpha[1] = c
                self.alpha[2] = c
                self.updateRT()
            end,function ()
                self.pages[self.page].leave(self)
                self.animation = false
                removeEventHandler('onClientRender',root,self.renderFunc)
                removeEventHandler('onClientClick',root,self.clickFunc)
                main:unloadTextures()
                main:unloadFonts()
            end)
        else
            self.page = 1
            self.pages[self.page].enter(self)
            main:loadTextures({
                ['bg'] = true,
                ['menu_line'] = true,
                ['bg_menu'] = true,
                ['bg_menu_hover'] = true
            })
            main:loadFonts({
                [1] = {name = 'medium', size = 18/zoom},
                [2] = {name = 'medium', size = 15}
            })
            showCursor(true)
            self.toggle = true
            addEventHandler('onClientRender',root,self.renderFunc)
            addEventHandler('onClientClick',root,self.clickFunc)
            self.animation = true
            animate(0,255,'InOutQuad', 300,function (c)
                self.alpha[1] = c
                self.alpha[2] = c
                self.updateRT()
            end,function ()
                self.animation = false
            end)
        end
    end)
end

main:load()