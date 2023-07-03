--[[
    Resource: e-newAuth
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

pages = {
    [0] = {
        enter = function ()
        end,
        leave = function ()
        end,
        render = function (self)
            dxDrawImage(sx/2-460/2/zoom,sy/2-460/2/zoom,460/zoom,460/zoom,self.textures['logo'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawImage(sx/2-403/2/zoom - 320/zoom,sy/2-112/2/zoom,403/zoom,112/zoom,self.textures[(isMouseInPosition(sx/2-403/2/zoom - 320/zoom,sy/2-112/2/zoom,403/zoom,112/zoom) and 'login_hover' or 'login')],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawImage(sx/2-270/2/zoom - 320/zoom,sy/2-112/2/zoom + 112/zoom/2 - 36/zoom/2 - 4/zoom,36/zoom,36/zoom,self.textures[(isMouseInPosition(sx/2-403/2/zoom - 320/zoom,sy/2-112/2/zoom,403/zoom,112/zoom) and 'i_login_hover' or 'i_login')],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawText('PANEL LOGOWANIA',sx/2-403/2/zoom - 210/zoom,sy/2-4/zoom,nil,nil,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-403/2/zoom - 320/zoom,sy/2-112/2/zoom,403/zoom,112/zoom) and 255 or 200) or self.alpha[2]*0.7)),1,main['fonts'][1],'left','center')
            dxDrawImage(sx/2-403/2/zoom + 320/zoom,sy/2-112/2/zoom,403/zoom,112/zoom,self.textures[(isMouseInPosition(sx/2-403/2/zoom + 320/zoom,sy/2-112/2/zoom,403/zoom,112/zoom) and 'register_hover' or 'register')],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawText('PANEL REJESTRACJI',sx/2-403/2/zoom + 365/zoom,sy/2-4/zoom,nil,nil,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-403/2/zoom + 320/zoom,sy/2-112/2/zoom,403/zoom,112/zoom) and 255 or 200) or self.alpha[2]*0.7)),1,main['fonts'][1],'left','center')
            if (isMouseInPosition(sx/2-403/2/zoom + 320/zoom,sy/2-112/2/zoom,403/zoom,112/zoom)) then
                dxDrawImage(sx/2-403/2/zoom + 617/zoom,sy/2-112/2/zoom + 105/zoom/2 - 36/zoom/2,36/zoom,36/zoom,self.textures[(isMouseInPosition(sx/2-403/2/zoom + 320/zoom,sy/2-112/2/zoom,403/zoom,112/zoom) and 'i_register_hover' or 'i_register')],0,0,0,tocolor(255,255,255,self.alpha[2]))
            else
                dxDrawImage(sx/2-403/2/zoom + 620/zoom,sy/2-112/2/zoom + 112/zoom/2 - 36/zoom/2,30/zoom,30/zoom,self.textures[(isMouseInPosition(sx/2-403/2/zoom + 320/zoom,sy/2-112/2/zoom,403/zoom,112/zoom) and 'i_register_hover' or 'i_register')],0,0,0,tocolor(255,255,255,self.alpha[2]))
            end
            dxDrawImage(sx/2-100/2/zoom,sy/2+130/zoom,100/zoom,100/zoom,self.textures['logo'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawImage(sx/2-183/2/zoom - 140/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5,183/zoom,44/zoom,self.textures[(isMouseInPosition(sx/2-183/2/zoom - 140/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5,183/zoom,44/zoom) and 'changelog_hover' or 'changelog')],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawText('Lista zmian',sx/2-183/2/zoom - 75/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5 + 44/zoom/2,nil,nil,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-183/2/zoom - 140/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5,183/zoom,44/zoom) and 255 or 200) or self.alpha[2]*0.7)),1,self.fonts[2],'left','center')
            dxDrawImage(sx/2-183/2/zoom - 115/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5 + 44/zoom/2 - 36/zoom/2,36/zoom,36/zoom,self.textures['i_changelog_hover'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-183/2/zoom - 140/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5,183/zoom,44/zoom) and 255 or 200) or self.alpha[2]*0.7)))
            dxDrawImage(sx/2-183/2/zoom + 140/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5,183/zoom,44/zoom,self.textures[(isMouseInPosition(sx/2-183/2/zoom + 140/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5,183/zoom,44/zoom) and 'rule_hover' or 'rule')],0,0,0,tocolor(255,255,255,self.alpha[2]))
            if (isMouseInPosition(sx/2-183/2/zoom + 140/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5,183/zoom,44/zoom)) then
                dxDrawImage(sx/2-183/2/zoom + 263/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5 + 44/zoom/2 - 36/zoom/2,36/zoom,36/zoom,self.textures['i_rule_hover'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            else
                dxDrawImage(sx/2-183/2/zoom + 270/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5 + 44/zoom/2 - 22/zoom/2,22/zoom,22/zoom,self.textures['i_rule'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            end
            dxDrawText('Regulamin',sx/2-183/2/zoom + 170/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5 + 44/zoom/2 + 2/zoom,nil,nil,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-183/2/zoom + 140/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5,183/zoom,44/zoom) and 255 or 200) or self.alpha[2]*0.7)),1,self.fonts[2],'left','center')
        end,
        interact = function (self)
            if (isMouseInPosition(sx/2-183/2/zoom + 140/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5,183/zoom,44/zoom) and not self.animation) then
                self.changePage(1)
            elseif (isMouseInPosition(sx/2-183/2/zoom - 140/zoom,sy/2+130/zoom+97/zoom/2-100/zoom/5,183/zoom,44/zoom) and not self.animation) then
                self.changePage(2)
            elseif (isMouseInPosition(sx/2-403/2/zoom - 320/zoom,sy/2-112/2/zoom,403/zoom,112/zoom) and not self.animation) then
                self.changePage(3)
            elseif (isMouseInPosition(sx/2-403/2/zoom + 320/zoom,sy/2-112/2/zoom,403/zoom,112/zoom) and not self.animation) then
                self.changePage(5)
            end
        end
    },
    [1] = {
        enter = function (self)
            renderID, renderData = exports['e-scroll']:createTarget({
                x = sx/2-1295/2/zoom,
                y = sy/2-573/2/zoom,
                w = 1280/zoom,
                h = 565/zoom,
                rtw = 1280,
                rth = 565,
                alpha = true,
                max_scroll = 300/zoom,
                scrollSpeed = 15,
                noDrag = true,
                animation = true,
                anim = 0,
                
                scrollData = {
                    visible = true,
                    x = sx/2-1295/2/zoom + 1290/zoom,
                    w = 2/zoom,
                    color = {242, 242, 242},
                    thumb = {56,175,89},
                    thumbSize = 4/zoom
                }
            })
            self.updateRT()
            exports['e-scroll']:animateScroll(renderID, 600, 'Linear', 0, 255)
        end,
        leave = function ()
            if renderID then
                exports['e-scroll']:destroyTarget(renderID)
                renderID = false
                renderData = false
            end
        end,
        render = function (self)
            dxDrawImage(sx/2-1320/2/zoom,sy/2-593/2/zoom,1320/zoom,593/zoom,self.textures['bg_rules'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawImage(sx/2-250/2/zoom,sy/2-600/zoom,250/zoom,250/zoom,self.textures['logo'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawText('REGULAMIN #3AB35BSERWERA',sx/2 + 25/zoom/2,sy/2-360/zoom,nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[1],'center','center',false,false,false,true)
            dxDrawText('#3AB35BEvanor, #ffffffna dzien 03.06.2023',sx/2,sy/2-340/zoom,nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[2],'center','center',false,false,false,true)
            dxDrawImage(sx/2-158/zoom,sy/2-373/zoom,25/zoom,25/zoom,self.textures['i_rule'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            --dxDrawRectangle(sx/2-1295/2/zoom,sy/2-573/2/zoom,1290/zoom,565/zoom)
            dxDrawImage(sx/2-80/zoom, sy/2+340/zoom,40/zoom,40/zoom,self.textures['return'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-80/zoom, sy/2+340/zoom,115/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.5)))
            dxDrawText('Cofnij',sx/2-20/zoom,sy/2+340/zoom + 40/zoom/2, nil, nil, tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-80/zoom, sy/2+340/zoom,115/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.5)),1,self.fonts[3],'left','center')
        end,
        interact = function (self)
            if (isMouseInPosition(sx/2-80/zoom, sy/2+340/zoom,115/zoom,40/zoom) and not self.animation) then
                self.changePage(0)
            end
        end,
        rt = function (self)
            dxDrawText(rules, 1290/2, 0, nil,nil, tocolor(255,255,255,self.alpha[2]),1,self.fonts[4],'center','top',false,false,false,true)
        end
    },
    [2] = {
        enter = function (self)
            renderID, renderData = exports['e-scroll']:createTarget({
                x = sx/2-450/2/zoom,
                y = sy/2-573/2/zoom,
                w = 450/zoom,
                h = 565/zoom,
                rtw = 450,
                rth = 565,
                alpha = true,
                max_scroll = 20/zoom,
                scrollSpeed = 15,
                noDrag = true,
                animation = true,
                anim = 0,
                
                scrollData = {
                    visible = true,
                    x = sx/2-480/2/zoom + 480/zoom,
                    w = 2/zoom,
                    color = {242, 242, 242},
                    thumb = {56,175,89},
                    thumbSize = 4/zoom
                }
            })
            self.updateRT()
            exports['e-scroll']:animateScroll(renderID, 600, 'Linear', 0, 255)
        end,
        leave = function ()
            if renderID then
                exports['e-scroll']:destroyTarget(renderID)
                renderID = false
                renderData = false
            end
        end,
        render = function (self)
            dxDrawImage(sx/2-500/2/zoom,sy/2-593/2/zoom,500/zoom,593/zoom,self.textures['bg_changelog'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawImage(sx/2-250/2/zoom,sy/2-600/zoom,250/zoom,250/zoom,self.textures['logo'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawText('LISTA #3AB35BZMIAN',sx/2 + 25/zoom/2,sy/2-360/zoom,nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[1],'center','center',false,false,false,true)
            dxDrawText('#3AB35BEvanor, #ffffffna dzien 03.06.2023',sx/2,sy/2-340/zoom,nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[2],'center','center',false,false,false,true)
            dxDrawImage(sx/2-95/zoom,sy/2-373/zoom,25/zoom,25/zoom,self.textures['i_header_changelog'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            --dxDrawRectangle(sx/2-480/2/zoom,sy/2-573/2/zoom,480/zoom,565/zoom)
            dxDrawImage(sx/2-80/zoom, sy/2+340/zoom,40/zoom,40/zoom,self.textures['return'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-80/zoom, sy/2+340/zoom,115/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.5)))
            dxDrawText('Cofnij',sx/2-20/zoom,sy/2+340/zoom + 40/zoom/2, nil, nil, tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-80/zoom, sy/2+340/zoom,115/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.5)),1,self.fonts[3],'left','center')
        end,
        interact = function (self)
            if (isMouseInPosition(sx/2-80/zoom, sy/2+340/zoom,115/zoom,40/zoom) and not self.animation) then
                self.changePage(0)
            end
        end,
        rt = function (self)
            dxDrawText(updates, 450/2, 0, nil,nil, tocolor(255,255,255,self.alpha[2]),1,self.fonts[4],'center','top',false,false,false,true)
        end
    },
    [3] = {
        enter = function (self)
            edit1 = exports['e-gui']:createEditbox('Wpisz nazwe uzytkownika', sx/2-340/2/zoom,sy/2-50/zoom, 340/zoom, 37/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 35/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                iconPadding = 10/zoom,
                font = exports['e-gui']:getFont('regular',13/zoom),
                line = true,
                icon = self.textures['i_login2'],
                specialCharacters = '.*[_].*'
            })
            edit2 = exports['e-gui']:createEditbox('Wpisz nazwe uzytkownika', sx/2-340/2/zoom,sy/2, 340/zoom, 37/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 35/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                iconPadding = 10/zoom,
                font = exports['e-gui']:getFont('regular',13/zoom),
                line = true,
                icon = self.textures['i_password'],
                specialCharacters = '.*[_].*',
                passworded = true
            })
            exports['e-gui']:setElementAlpha(edit1,0)
            exports['e-gui']:setElementAlpha(edit2,0)
            local data = main:loadAccountData()
            if (data) then
                exports['e-gui']:setEditboxText(edit1, data.login)
                exports['e-gui']:setEditboxText(edit2, data.password)
                self.checkboxes[1] = true
            end
        end,
        leave = function ()
            exports['e-gui']:destroyUIElement(edit1)
            exports['e-gui']:destroyUIElement(edit2)
        end,
        render = function (self)
            dxDrawImage(sx/2-400/2/zoom,sy/2-470/2/zoom,400/zoom,470/zoom,self.textures['bg_login'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawImage(sx/2-190/2/zoom,sy/2-265/zoom,190/zoom,190/zoom,self.textures['logo'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawImage(sx/2-80/zoom, sy/2+340/zoom,40/zoom,40/zoom,self.textures['return'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-80/zoom, sy/2+340/zoom,115/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.5)))
            dxDrawText('Cofnij',sx/2-20/zoom,sy/2+340/zoom + 40/zoom/2, nil, nil, tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-80/zoom, sy/2+340/zoom,115/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.5)),1,self.fonts[3],'left','center')
            dxDrawText('Aby sie #3AB35Bzalogowac#ffffff, uzupelnij swoje dane, a nastepnie\nwcisnij przycisk #3AB35BZALOGUJ',sx/2,sy/2-85/zoom,nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[5],'center','center',false,false,false,true)
            dxDrawText('Zapomnialem hasla',sx/2-340/2/zoom + 340/zoom, sy/2+53/zoom,nil,nil,tocolor(230,230,230,(not self.animation and (isMouseInPosition(sx/2-340/2/zoom + 340/zoom - dxGetTextWidth('Zapomnialem hasla',1,self.fonts[5]) - 17/zoom, sy/2+47/zoom,dxGetTextWidth('Zapomnialem hasla',1,self.fonts[5]) + 17/zoom,12/zoom) and 255 or 200) or self.alpha[2]*0.8)),1,self.fonts[5],'right','center')
            dxDrawImage(sx/2-340/2/zoom + 340/zoom - dxGetTextWidth('Zapomnialem hasla',1,self.fonts[5]) - 17/zoom, sy/2+47/zoom,12/zoom,12/zoom,self.textures['i_forgotpassword'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-340/2/zoom + 340/zoom - dxGetTextWidth('Zapomnialem hasla',1,self.fonts[5]) - 17/zoom, sy/2+47/zoom,dxGetTextWidth('Zapomnialem hasla',1,self.fonts[5]) + 17/zoom,12/zoom) and 255 or 200) or self.alpha[2]*0.8)))
            dxDrawImage(sx/2-330/2/zoom, sy/2+70/zoom, 20/zoom,20/zoom,self.textures['remember_1'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            if (self.checkboxes[1]) then
                dxDrawImage(sx/2-330/2/zoom + 20/zoom/2 - 10/zoom/2, sy/2+70/zoom+20/zoom/2- 10/zoom/2, 10/zoom,10/zoom,self.textures['remember_2'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            end
            dxDrawText('Zapamietaj moje dane',sx/2-330/2/zoom + 30/zoom, sy/2+70/zoom + 21/zoom/2,nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[5],'left','center')
            dxDrawImage(sx/2-200/2/zoom,sy/2+150/zoom,200/zoom,40/zoom,self.textures['button'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-200/2/zoom,sy/2+150/zoom,200/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.6)))
            dxDrawText('ZALOGUJ',sx/2-200/2/zoom + 200/zoom/2,sy/2+150/zoom + 40/zoom/2,nil,nil,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-200/2/zoom,sy/2+150/zoom,200/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.6)),1,self.fonts[2],'center','center')
        end,
        interact = function (self)
            if (isMouseInPosition(sx/2-80/zoom, sy/2+340/zoom,115/zoom,40/zoom) and not self.animation) then
                self.changePage(0)
            elseif (isMouseInPosition(sx/2-340/2/zoom + 340/zoom - dxGetTextWidth('Zapomnialem hasla',1,self.fonts[5]) - 17/zoom, sy/2+47/zoom,dxGetTextWidth('Zapomnialem hasla',1,self.fonts[5]) + 17/zoom,12/zoom) and not self.animation) then
                self.changePage(4)
            elseif (isMouseInPosition(sx/2-330/2/zoom, sy/2+70/zoom, 20/zoom,20/zoom) and not self.animation) then
                self.checkboxes[1] = not self.checkboxes[1]
                main:saveData(exports['e-gui']:getEditboxText(edit1), exports['e-gui']:getEditboxText(edit2))
            elseif (isMouseInPosition(sx/2-200/2/zoom,sy/2+150/zoom,200/zoom,40/zoom) and not self.animation) then
                local login = exports['e-gui']:getEditboxText(edit1)
                local password = exports['e-gui']:getEditboxText(edit2)
                triggerServerEvent('loginAccount',localPlayer,localPlayer,login,password)
            end
        end
    },
    [4] = {
        enter = function (self)
            edit1 = exports['e-gui']:createEditbox('Wpisz nazwe uzytkownika', sx/2-340/2/zoom,sy/2-30/zoom, 340/zoom, 37/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 35/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                iconPadding = 10/zoom,
                font = exports['e-gui']:getFont('regular',13/zoom),
                line = true,
                icon = self.textures['i_login2'],
                specialCharacters = '.*[_].*'
            })
            exports['e-gui']:setElementAlpha(edit1,0)
        end,
        leave = function ()
            exports['e-gui']:destroyUIElement(edit1)
        end,
        render = function (self)
            dxDrawImage(sx/2-400/2/zoom,sy/2-194/2/zoom,400/zoom,194/zoom,self.textures['bg_newpassword'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawText('Aby #3AB35Bprzypomniec#ffffff haslo do przypisanego konta, wpisz\nponizej swoja nazwe uzytkownika',sx/2-175/zoom,sy/2-65/zoom,nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[5],'left','center',false,false,false,true)
            dxDrawImage(sx/2-100/zoom,sy/2+27/zoom,200/zoom,40/zoom,self.textures['button'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-100/zoom,sy/2+27/zoom,200/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.6)))
            dxDrawText('PRZYPOMNIJ',sx/2-100/zoom + 200/zoom/2,sy/2+27/zoom + 40/zoom/2,nil,nil,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-100/zoom,sy/2+27/zoom,200/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.6)),1,self.fonts[2],'center','center')
            dxDrawImage(sx/2-80/zoom, sy/2+140/zoom,40/zoom,40/zoom,self.textures['return'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-80/zoom, sy/2+140/zoom,115/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.5)))
            dxDrawText('Cofnij',sx/2-20/zoom,sy/2+140/zoom + 40/zoom/2, nil, nil, tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-80/zoom, sy/2+140/zoom,115/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.5)),1,self.fonts[3],'left','center')
        end,
        interact = function (self)
            if (isMouseInPosition(sx/2-80/zoom, sy/2+140/zoom,115/zoom,40/zoom) and not self.animation) then
                self.changePage(3)
            end
        end
    },
    [5] = {
        enter = function (self)
            edit1 = exports['e-gui']:createEditbox('Wpisz nazwe uzytkownika', sx/2-340/2/zoom,sy/2-50/zoom - 25/zoom, 340/zoom, 37/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 35/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                iconPadding = 10/zoom,
                font = exports['e-gui']:getFont('regular',13/zoom),
                line = true,
                icon = self.textures['i_login2'],
                specialCharacters = '.*[_].*'
            })
            edit2 = exports['e-gui']:createEditbox('Wpisz nazwe uzytkownika', sx/2-340/2/zoom,sy/2-50/zoom + 55/zoom - 25/zoom, 340/zoom, 37/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 35/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                iconPadding = 10/zoom,
                font = exports['e-gui']:getFont('regular',13/zoom),
                line = true,
                icon = self.textures['i_password'],
                specialCharacters = '.*[_].*',
                passworded = true
            })
            edit3 = exports['e-gui']:createEditbox('Powtorz haslo', sx/2-340/2/zoom,sy/2-50/zoom + 55/zoom + 55/zoom - 25/zoom, 340/zoom, 37/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 35/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                iconPadding = 10/zoom,
                font = exports['e-gui']:getFont('regular',13/zoom),
                line = true,
                icon = self.textures['i_password'],
                specialCharacters = '.*[_].*',
                passworded = true
            })
            edit4 = exports['e-gui']:createEditbox('Wprowadz swoj adres E-mail', sx/2-340/2/zoom,sy/2-50/zoom + 55/zoom + 55/zoom + 55/zoom - 25/zoom, 340/zoom, 37/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 35/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                iconPadding = 10/zoom,
                font = exports['e-gui']:getFont('regular',13/zoom),
                line = true,
                icon = self.textures['i_mail'],
                specialCharacters = '.*[_].*',
            })

            exports['e-gui']:setElementAlpha(edit1,0)
            exports['e-gui']:setElementAlpha(edit2,0)
            exports['e-gui']:setElementAlpha(edit3,0)
            exports['e-gui']:setElementAlpha(edit4,0)
        end,
        leave = function ()
            exports['e-gui']:destroyUIElement(edit1)
            exports['e-gui']:destroyUIElement(edit2)
            exports['e-gui']:destroyUIElement(edit3)
            exports['e-gui']:destroyUIElement(edit4)
        end,
        render = function (self)
            dxDrawImage(sx/2-400/2/zoom,sy/2-593/2/zoom,400/zoom,593/zoom,self.textures['bg_register'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawImage(sx/2-190/2/zoom,sy/2-325/zoom,190/zoom,190/zoom,self.textures['logo'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            dxDrawImage(sx/2-80/zoom, sy/2+340/zoom,40/zoom,40/zoom,self.textures['return'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-80/zoom, sy/2+340/zoom,115/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.5)))
            dxDrawText('Cofnij',sx/2-20/zoom,sy/2+340/zoom + 40/zoom/2, nil, nil, tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-80/zoom, sy/2+340/zoom,115/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.5)),1,self.fonts[3],'left','center')
            dxDrawText('Aby sie #3AB35Bzarejestrowac#ffffff, uzupelnij swoje dane, a nastepnie\nwcisnij przycisk #3AB35BZAREJESTRUJ',sx/2,sy/2-145/zoom,nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[5],'center','center',false,false,false,true)
            dxDrawImage(sx/2-330/2/zoom, sy/2+140/zoom, 20/zoom,20/zoom,self.textures['remember_1'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            if (self.checkboxes[2]) then
                dxDrawImage(sx/2-330/2/zoom + 20/zoom/2 - 10/zoom/2, sy/2+140/zoom+20/zoom/2- 10/zoom/2, 10/zoom,10/zoom,self.textures['remember_2'],0,0,0,tocolor(255,255,255,self.alpha[2]))
            end
            dxDrawText('Akceptuje regulamin',sx/2-330/2/zoom + 30/zoom, sy/2+140/zoom + 20/zoom/2,nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[5],'left','center')
            dxDrawImage(sx/2-200/2/zoom,sy/2+205/zoom,200/zoom,40/zoom,self.textures['button'],0,0,0,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-200/2/zoom,sy/2+205/zoom,200/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.6)))
            dxDrawText('ZAREJESTRUJ',sx/2-200/2/zoom + 200/zoom/2,sy/2+205/zoom + 40/zoom/2,nil,nil,tocolor(255,255,255,(not self.animation and (isMouseInPosition(sx/2-200/2/zoom,sy/2+205/zoom,200/zoom,40/zoom) and 255 or 150) or self.alpha[2]*0.6)),1,self.fonts[2],'center','center')
        end,
        interact = function (self)
            if (isMouseInPosition(sx/2-80/zoom, sy/2+340/zoom,115/zoom,40/zoom) and not self.animation) then
                self.changePage(0)
            elseif (isMouseInPosition(sx/2-330/2/zoom, sy/2+140/zoom, 20/zoom,20/zoom) and not self.animation) then
                self.checkboxes[2] = not self.checkboxes[2]
            elseif (isMouseInPosition(sx/2-200/2/zoom,sy/2+205/zoom,200/zoom,40/zoom) and not self.animation) then
                local login = exports['e-gui']:getEditboxText(edit1)
                local password = exports['e-gui']:getEditboxText(edit2)
                local password2 = exports['e-gui']:getEditboxText(edit3)
                local email = exports['e-gui']:getEditboxText(edit4)
                triggerServerEvent('registerAccount',localPlayer,localPlayer, login,password,password2, email)
            end
        end
    },
    [6] = {
        enter = function (self)
        end,
        leave = function ()
        end,
        render = function (self)
            if (isElement(self.rt)) then
                local x = ( self.map.x ) / 6000
                local y = ( self.map.y ) / -6000
                dxSetShaderValue(self.shader, "gUVPosition", x, y)
                dxSetRenderTarget(self.rt, true)
                dxDrawImage(0, 0, 1600, 1600, self.textures['map'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                for i,v in pairs(self.spawns) do
                    local x, y = (v.pos[1]+3000)/6000*1600, (-v.pos[2]+3000)/6000*1600
                    local clr = (v.selected and {56,175,89} or {255,255,255})
                    dxDrawImage(x - 25/zoom/2, y - 25/zoom/2, 25/zoom, 25/zoom, self.textures['i_loc'],0,0,0,tocolor(clr[1],clr[2],clr[3],self.alpha[2]))
                end
                dxSetRenderTarget()
                dxDrawImage(0,0,sx,sy, self.shader,0,0,0,tocolor(255,255,255,self.alpha[2]))
                dxDrawText('LISTA #3AB35BSPAWNOW', 50/zoom, 70/zoom, nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[3],'left','center',false,false,true,true)
                dxDrawText('Aby #3AB35Bzagrac#ffffff wybierz jedna pozycje z listy spawnow\na nastepnie wcinij przycisk #3AB35BSPAWN', 50/zoom, 85/zoom, nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[2],'left','top',false,false,true,true)
                local offset = 0
                for i,v in pairs(self.spawns) do
                    offset = offset + 70/zoom
                    if (v.selected) then
                        dxDrawImage(50/zoom,90/zoom+offset,50/zoom,50/zoom,self.textures['bg_loc_hover'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                        dxDrawImage(50/zoom + 50/zoom/2 - 24/zoom/2, 90/zoom+offset + 50/zoom/2 - 24/zoom/2,24/zoom,24/zoom,self.textures['i_loc'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                        dxDrawImage(100/zoom,92/zoom+offset,184/zoom,44/zoom,self.textures['bg_loc_panel_hover'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                        dxDrawText(v.name,100/zoom + 184/zoom/2 - 6/zoom,92/zoom+offset + 44/zoom/2,nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[2],'center','center')
                        dxDrawImage(sx/2-100/zoom,sy-60/zoom,200/zoom,40/zoom,self.textures['button'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                        dxDrawText('SPAWN',sx/2-100/zoom + 200/zoom/2,sy-60/zoom + 40/zoom/2,nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[2],'center','center')
                        dxDrawText('Wybrano lokalizacje\n#3AB35B'..v.name..'',sx/2,sy-90/zoom,nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[2],'center','center',false,false,false,true)
                    else
                        dxDrawImage(50/zoom,90/zoom+offset,50/zoom,50/zoom,self.textures[not self.animation and (isMouseInPosition(50/zoom,90/zoom+offset,210/zoom,50/zoom) and 'bg_loc_hover' or 'bg_loc') or 'bg_loc'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                        dxDrawImage(50/zoom + 50/zoom/2 - 24/zoom/2, 90/zoom+offset + 50/zoom/2 - 24/zoom/2,24/zoom,24/zoom,self.textures['i_loc'],0,0,0,tocolor(255,255,255,self.alpha[2]))
                        dxDrawImage(100/zoom,92/zoom+offset,184/zoom,44/zoom,self.textures[(isMouseInPosition(50/zoom,90/zoom+offset,210/zoom,50/zoom) and 'bg_loc_panel_hover' or 'bg_loc_panel')],0,0,0,tocolor(255,255,255,self.alpha[2]))
                        dxDrawText(v.name,100/zoom + 184/zoom/2 - 6/zoom,92/zoom+offset + 44/zoom/2,nil,nil,tocolor(255,255,255,self.alpha[2]),1,self.fonts[2],'center','center')
                    end
                    if (isMouseInPosition(50/zoom,90/zoom+offset,210/zoom,50/zoom) and not self.animation and self.selected ~= i) then
                        self.animation = true
                        self.selected = i
                        animate(self.map.x, v.pos[1], "OutQuad", 600, function(value)
                            self.map.x = value
                        end)
                        animate(self.map.y, v.pos[2], "OutQuad", 600, function(value)
                            self.map.y = value
                        end,function ()
                            self.animation = false
                        end)
                    end
                end

                if getKeyState("mouse1") then
                    local cx, cy = getCursorPosition()
                    cx, cy = cx * sx, cy * sy
                    if isMouseInPosition(0,0,sx,sy) then
                        if not self.map.hold then
                            self.map.hold = {cx, cy}
                            for k,v in pairs(self.spawns) do
                                v.active = false
                            end
                        end
                    end
            
                    if self.map.hold then
                        self.map.x = math.min(math.max(self.map.x - (cx - self.map.hold[1])/0.32/zoom, -1500), 1500)
                        self.map.y = math.min(math.max(self.map.y + (cy - self.map.hold[2])/0.32/zoom, -2150), 2150)
            
                        self.map.hold = {cx, cy}
                    end
                else
                    self.map.hold = false
                end
            end
        end,
        interact = function (self)
            local function unselectAll()
                for i,v in pairs(self.spawns) do
                    v.selected = false
                end
            end
            local offset = 0
            for i,v in pairs(self.spawns) do
                offset = offset + 70/zoom
                if (isMouseInPosition(50/zoom,90/zoom+offset,210/zoom,50/zoom)) then
                    unselectAll()
                    v.selected = true
                elseif (isMouseInPosition(sx/2-100/zoom,sy-60/zoom,200/zoom,40/zoom) and not self.animation and v.selected) then
                    self.animation = false
                    animate(255,0, "Linear", 600, function(value)
                        self.alpha[1] = value
                        self.alpha[2] = value
                    end,function ()
                        self.animation = false
                        showChat(true)
                        showCursor(false)
                        main:unloadTextures()
                        main:unloadFonts()
                        removeEventHandler('onClientRender', root, self.renderFnc)
                        removeEventHandler('onClientClick',root,self.clickFnc)
                        destroyElement(self.shader)
                        destroyElement(self.rt)
                        triggerServerEvent('spawnPlayer', localPlayer, localPlayer,v.pos)
                        setElementData(localPlayer,'player:spawn',true)
                        --exports['e-radar']:toggleRadar()
                    end)
                else
                    v.selected = false
                end
            end
        end
    }
}