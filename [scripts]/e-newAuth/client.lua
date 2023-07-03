--[[
    Resource: e-newAuth
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--
--pierwszy skrypt napisany na selfach ;/

sx,sy = guiGetScreenSize()
zoom = exports['e-gui']:getZoom()

renderID, renderData = nil, nil

function main:render()
    dxDrawImage(0,0,sx,sy,self.textures['background'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawImage(0,0,sx,sy,self.textures['left_light'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawImage(0,0,sx,sy,self.textures['right_light'],0,0,0,tocolor(255,255,255,self.alpha[1]))
    dxDrawImage(sx-92/zoom,sy-92/zoom,62/zoom,62/zoom,self.textures['bg_music'],0,0,0,tocolor(255,255,255,self.alpha[1]),true)
    dxDrawImage(sx-92/zoom + 62/zoom/2 - 34/zoom/2,sy-92/zoom + 62/zoom/2 - 34/zoom/2,34/zoom,34/zoom,self.textures['i_music'],0,0,0,tocolor(255,255,255,self.alpha[1]),true)
    dxDrawText(self.sound.title,sx-108/zoom,sy-71/zoom,nil,nil,tocolor(255,255,255,self.alpha[1]),1,self.fonts[3],'right','center',false,false,true,true)
    dxDrawText(self.sound.desc,sx-108/zoom,sy-50/zoom,nil,nil,tocolor(255,255,255,self.alpha[1]),1,self.fonts[3],'right','center',false,false,true,true)
    dxDrawImage(30/zoom,sy-80/zoom,50/zoom,50/zoom,self.textures['bg_players'],0,0,0,tocolor(255,255,255,self.alpha[1]),true)
    dxDrawText('#3AB35B'..#getElementsByType('player')..' #FBFAFAGRACZY ONLINE',30/zoom + 65/zoom,sy-80/zoom + 50/zoom/2,nil,nil,tocolor(255,255,255,self.alpha[1]),1,self.fonts[1],'left','center',false,false,true,true)
    dxDrawImage(30/zoom + 50/zoom/2 - 34/zoom/2,sy-80/zoom + 50/zoom/2 - 34/zoom/2,34/zoom,34/zoom,self.textures['i_players'],0,0,0,tocolor(255,255,255,self.alpha[1]),true)

    for i,v in pairs(self.pages) do
        if (self.page == i) then
            v.render(self)
        end
    end
end

function main:updateRenderTarget()
    if not renderData.rt then return end
    dxSetRenderTarget(renderData.rt, true)
    dxSetBlendMode('modulate_add')
    for i,v in pairs(self.pages) do
        if (self.page == i and pages[self.page].rt) then
            v.rt(self)
        end
    end
    dxSetBlendMode('blend')
    dxSetRenderTarget()
end

function main:click(btn,state)
    if (btn == 'left' and state == 'down') then
        for i,v in pairs(self.pages) do
            if (self.page == i) then
                v.interact(self)
            end
        end
    end
end

function main:load()
    if getElementData(localPlayer, 'player:uid') then return end
    self.textures = {}
    self.fonts = {}
    self.alpha = {
        [1] = 0,
        [2] = 0
    }
    self.page = 0
    self.sound = {
        sound = false,
        title = "#D3D4D3Twisted & Oliver Tree",
        desc = "#37A957WORTH#A2C8FD NOTHING"
    }
    self.checkboxes = {
        [1] = false,
        [2] = false
    }
    self.animation = true
    self.rt = dxCreateRenderTarget(1600, 1600, true)
    self.shader = dxCreateShader("data/fx/mask.fx")
    self.map = {
        txt = dxCreateTexture("data/images/map.png"),
        x = -1942.90,
        y = 511.02,
        hold = false,
    }
    self.spawns = {
        {
            name = "Spawn San Fierro",
            pos = {-1917.51,487.18,35.17}
        },
        {
            name = "Prawo Jazdy",
            pos = {-2019.98,-97.13,35.16}
        },
        {
            name = "Pierwsza Praca",
            pos = {-1729.56,18.89,3.55}
        },
        {
            name = "Blueberry",
            pos = {280, -100, 0}
        },
        {
            name = "Fort Carson",
            pos = {-62, 1045, 0}
        },
        {
            name = "Dillimore",
            pos = {713.52167, -522.02460, 16.32814}
        },
    }
    self.map_mask = dxCreateTexture("data/images/map_mask.png")
    self.renderFnc = function () main:render() end
    self.clickFnc = function (btn,state) main:click(btn,state) end
    self.updateRT = function () main:updateRenderTarget() end
    self.resourceStop = function ()
        if (self.page) then
            self.pages[self.page].leave()
        end
    end
    self.changePage = function (page)
        if self.animation then return end
        self.animation = true
        if (renderData) then
            exports['e-scroll']:animateScroll(renderID, 600, 'Linear', 255, 0)
        end
        if (edit1) then
            exports['e-gui']:fadeElement(edit1, 0, 600, 'Linear')
        end
        if (edit2) then
            exports['e-gui']:fadeElement(edit2, 0, 600, 'Linear')
        end
        if (edit3) then
            exports['e-gui']:fadeElement(edit3, 0, 600, 'Linear')
        end
        if (edit4) then
            exports['e-gui']:fadeElement(edit4, 0, 600, 'Linear')
        end
        animate(255,0, "Linear", 600, function(value)
            self.alpha[2] = value
            if (renderData) then
                self.updateRT()
            end
        end,function ()
            self.pages[self.page].leave()
            self.page = page
            self.pages[self.page].enter(self)
            if (edit1) then
                exports['e-gui']:fadeElement(edit1, 1, 600, 'Linear')
            end
            if (edit2) then
                exports['e-gui']:fadeElement(edit2, 1, 600, 'Linear')
            end
            if (edit3) then
                exports['e-gui']:fadeElement(edit3, 1, 600, 'Linear')
            end
            if (edit4) then
                exports['e-gui']:fadeElement(edit4, 1, 600, 'Linear')
            end
            animate(0,255, "Linear", 600, function(value)
                self.alpha[2] = value
                if (renderData) then
                    self.updateRT()
                end
            end,function ()
                self.animation = false
            end)
        end)
    end
    self.pages = pages

    dxSetShaderValue(self.shader, "sPicTexture", self.rt)
    dxSetShaderValue(self.shader, "sMaskTexture", self.map_mask)
    dxSetShaderValue(self.shader, "gUVScale", 0.7, 0.7*(350/600))

    main:loadTextures({
        ['background'] = true,
        ['left_light'] = true,
        ['right_light'] = true,
        ['logo'] = true,
        ['login'] = true,
        ['register'] = true,
        ['register_hover'] = true,
        ['login_hover'] = true,
        ['logo_2'] = true,
        ['changelog'] = true,
        ['rule'] = true,
        ['changelog_hover'] = true,
        ['rule_hover'] = true,
        ['bg_players'] = true,
        ['i_players'] = true,
        ['bg_music'] = true,
        ['i_music'] = true,
        ['i_login'] = true,
        ['i_login_hover'] = true,
        ['i_register_hover'] = true,
        ['i_register'] = true,
        ['i_changelog_hover'] = true,
        ['i_rule'] = true,
        ['i_rule_hover'] = true,
        ['bg_rules'] = true,
        ['return'] = true,
        ['bg_changelog'] = true,
        ['i_header_changelog'] = true,
        ['bg_login'] = true,
        ['i_login2'] = true,
        ['i_forgotpassword'] = true,
        ['remember_1'] = true,
        ['button'] = true,
        ['bg_newpassword'] = true,
        ['bg_register'] = true,
        ['remember_2'] = true,
        ['map'] = true,
        ['bg_loc'] = true,
        ['bg_loc_hover'] = true,
        ['i_loc'] = true,
        ['bg_loc_panel'] = true,
        ['bg_loc_panel_hover'] = true,
        ['i_password'] = true,
        ['i_mail'] = true
    })

    main:loadFonts({
        [1] = {size = 20/zoom, name = 'medium'},
        [2] = {size = 15/zoom, name = 'medium'},
        [3] = {size = 17/zoom, name = 'medium'},
        [4] = {size = 17, name = 'medium'},
        [5] = {size = 12/zoom, name = 'medium'},
        [6] = {size = 13/zoom, name = 'regular'}
    })

    showChat(false)
    showCursor(true)
    addEventHandler('onClientRender', root, self.renderFnc)
    addEventHandler('onClientClick',root,self.clickFnc)
    addEventHandler('onClientResourceStop',resourceRoot,self.resourceStop)

    addEvent('changePage',true)
    addEventHandler('changePage',root,function (c)
        self.changePage(c)
    end)

    addEvent('createAccount',true)
    addEventHandler('createAccount',root,function (login,password)
        main:saveData(login,password)
        self.changePage(3)
    end)

    animate(0,255, "Linear", 600, function(value)
        self.alpha[1] = value
        self.alpha[2] = value
    end,function ()
        self.animation = false
    end)
end


main:load()