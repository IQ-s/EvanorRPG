--[[
    Resource: e-auth
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
        interact = function ()
            if (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+85/zoom,209/zoom,47/zoom) and not main['animation']) then
                main['animation'] = true
                animate(255,0, "Linear", 600, function(value)
                    main['alpha'][2] = value
                end,function ()
                    main['page'] = 1
                    pages[main['page']].enter()
                    exports['e-gui']:fadeElement(main['loginEditbox'], 1, 600, 'Linear')
                    exports['e-gui']:fadeElement(main['passwordEditbox'], 1, 600, 'Linear')
                    exports['e-gui']:fadeElement(main['passwordEditbox2'], 1, 600, 'Linear')
                    exports['e-gui']:fadeElement(main['emailEditbox'], 1, 600, 'Linear')
                    animate(0,255, "Linear", 600, function(value)
                        main['alpha'][2] = value
                    end,function ()
                        main['animation'] = false
                    end)
                end)
            elseif (isMouseInPosition(sx/2-68/zoom,sy/2+180/zoom,55/zoom,55/zoom) and not main['animation']) then
                main['animation'] = true
                animate(255,0, "Linear", 600, function(value)
                    main['alpha'][2] = value
                end,function ()
                    main['page'] = 4
                    pages[main['page']].enter()
                    animate(0,255, "Linear", 600, function(value)
                        main['alpha'][2] = value
                        updateRenderTarget()
                    end,function ()
                        main['animation'] = false
                    end)
                end)
            elseif (isMouseInPosition(sx/2+10/zoom,sy/2+180/zoom,55/zoom,55/zoom) and not main['animation']) then
                main['animation'] = true
                animate(255,0, "Linear", 600, function(value)
                    main['alpha'][2] = value
                end,function ()
                    main['page'] = 5
                    pages[main['page']].enter()
                    animate(0,255, "Linear", 600, function(value)
                        main['alpha'][2] = value
                        updateRenderTarget()
                    end,function ()
                        main['animation'] = false
                    end)
                end)
            end
        end,
        render = function ()
            dxDrawImage(sx/2-(154/2)/zoom,sy/2-285/zoom,154/zoom,193/zoom,main['textures']['logo'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            dxDrawText('Witaj na Evanor,',sx/2,sy/2-25/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]),1,main['fonts'][2],'center','center')
            dxDrawText('Nasz system wykrył, że nie posiadasz u nas konta.\nAby dołączyć do serwera, zarejestruj się.',sx/2,sy/2-5/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]*0.9),1,main['fonts'][3],'center','top')
            dxDrawImage(sx/2-(209/2)/zoom,sy/2+85/zoom,209/zoom,47/zoom,main['textures']['button'],0,0,0,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+85/zoom,209/zoom,47/zoom) and 255 or 150) or main['alpha'][2]*0.6)))
            dxDrawText('Stworz konto',sx/2-(209/2)/zoom+209/zoom/2,sy/2+85/zoom+52/zoom/2,nil,nil,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+85/zoom,209/zoom,47/zoom) and 255 or 150) or main['alpha'][2]*0.6)),1,main['fonts'][4],'center','center')
            dxDrawImage(sx/2-68/zoom,sy/2+180/zoom,55/zoom,55/zoom,main['textures']['button1'],0,0,0,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2-68/zoom,sy/2+180/zoom,55/zoom,55/zoom) and 255 or 150) or main['alpha'][2]*0.6)))
            dxDrawImage(sx/2+10/zoom,sy/2+180/zoom,55/zoom,55/zoom,main['textures']['button2'],0,0,0,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2+10/zoom,sy/2+180/zoom,55/zoom,55/zoom) and 255 or 150) or main['alpha'][2]*0.6)))
            if (isMouseInPosition(sx/2-68/zoom,sy/2+180/zoom,55/zoom,55/zoom) and not main['animation']) then
                local cursorX,cursorY = getCursorPosition()
                local absX, absY = cursorX*sx, cursorY*sy
                dxDrawText('Regulamin',absX+20/zoom, absY+20/zoom,nil,nil,white,1,main['fonts'][4],'left','center')
            elseif (isMouseInPosition(sx/2+10/zoom,sy/2+180/zoom,55/zoom,55/zoom) and not main['animation']) then
                local cursorX,cursorY = getCursorPosition()
                local absX, absY = cursorX*sx, cursorY*sy
                dxDrawText('Aktualnosci',absX+20/zoom, absY+20/zoom,nil,nil,white,1,main['fonts'][4],'left','center')
            end
        end
    },
    [1] = {
        enter = function ()
            main['loginEditbox'] = exports['e-gui']:createEditbox('Wprowadz login', sx/2-(273/2)/zoom,sy/2-68/zoom,273/zoom,47/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 10/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                font = main['fonts'][6],
                image = main['textures']['editbox'],
                specialCharacters = '.*[_].*'
            })
            main['passwordEditbox'] = exports['e-gui']:createEditbox('Wprowadz haslo', sx/2-(273/2)/zoom,sy/2-68/zoom+105/zoom,273/zoom,47/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 10/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                font = main['fonts'][6],
                image = main['textures']['editbox'],
                specialCharacters = '.*[_].*',
                passworded = true
            })
            main['passwordEditbox2'] = exports['e-gui']:createEditbox('Powtorz haslo', sx/2-(273/2)/zoom,sy/2-68/zoom+105/zoom+105/zoom,273/zoom,47/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 10/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                font = main['fonts'][6],
                image = main['textures']['editbox'],
                specialCharacters = '.*[_].*',
                passworded = true
            })
            main['emailEditbox'] = exports['e-gui']:createEditbox('Adres e-mail', sx/2-(273/2)/zoom,sy/2-68/zoom+105/zoom+105/zoom+105/zoom,273/zoom,47/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 10/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                font = main['fonts'][6],
                image = main['textures']['editbox'],
                specialCharacters = '.*[_].*',
            })
            exports['e-gui']:setElementAlpha(main['loginEditbox'],0)
            exports['e-gui']:setElementAlpha(main['passwordEditbox'],0)
            exports['e-gui']:setElementAlpha(main['passwordEditbox2'],0)
            exports['e-gui']:setElementAlpha(main['emailEditbox'],0)
        end,
        leave = function ()
            exports['e-gui']:destroyUIElement(main['loginEditbox'])
            exports['e-gui']:destroyUIElement(main['passwordEditbox'])
            exports['e-gui']:destroyUIElement(main['passwordEditbox2'])
            exports['e-gui']:destroyUIElement(main['emailEditbox'])
        end,
        interact = function ()
            if (isMouseInPosition(sx/2-95/zoom,sy/2+309/zoom,30/zoom,30/zoom) and not main['animation']) then
                main['checkbox'] = not main['checkbox']
            elseif (isMouseInPosition(sx/2-48/zoom,sy/2+420/zoom,dxGetTextWidth('Logowanie',1,main['fonts'][5]),dxGetFontHeight(1,main['fonts'][5])) and not main['animation']) then
                main['animation'] = true
                exports['e-gui']:fadeElement(main['loginEditbox'], 0, 600, 'Linear')
                exports['e-gui']:fadeElement(main['passwordEditbox'], 0, 600, 'Linear')
                exports['e-gui']:fadeElement(main['passwordEditbox2'], 0, 600, 'Linear')
                exports['e-gui']:fadeElement(main['emailEditbox'], 0, 600, 'Linear')
                animate(255,0, "Linear", 600, function(value)
                    main['alpha'][2] = value
                end,function ()
                    pages[main['page']].leave()
                    main['page'] = 2
                    pages[main['page']].enter()
                    animate(0,255, "Linear", 600, function(value)
                        main['alpha'][2] = value
                    end,function ()
                        main['animation'] = false
                    end)
                end)
            elseif (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+360/zoom,209/zoom,47/zoom) and not main['animation']) then
                local login = exports['e-gui']:getEditboxText(main['loginEditbox'])
                local password = exports['e-gui']:getEditboxText(main['passwordEditbox'])
                local password2 = exports['e-gui']:getEditboxText(main['passwordEditbox2'])
                local email = exports['e-gui']:getEditboxText(main['emailEditbox'])
                triggerServerEvent('registerAccount', localPlayer, localPlayer, login, password, password2, email)
            end
        end,
        render = function ()

            --dxDrawImage(0,0,sx,sy,"data/images/preview.png")
            dxDrawImage(sx/2-(154/2)/zoom,sy/2-475/zoom,154/zoom,193/zoom,main['textures']['logo'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            dxDrawText('Rejestracja konta',sx/2,sy/2-209/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]),1,main['fonts'][2],'center','center')
            dxDrawText('Jesteś na etapie tworzenia konta,\nuzupełnij poprawnie pola, a następnie kliknij przycisk Stwórz konto.',sx/2,sy/2-199/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]*0.9),1,main['fonts'][3],'center','top')
            dxDrawText('Login:',sx/2,sy/2-87/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]*0.9),1,main['fonts'][5],'center','center')
            --dxDrawImage(sx/2-(273/2)/zoom,sy/2-68/zoom,273/zoom,47/zoom,main['textures']['editbox'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            dxDrawText('Haslo:',sx/2,sy/2-87/zoom+105/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]*0.9),1,main['fonts'][5],'center','center')
            --dxDrawImage(sx/2-(273/2)/zoom,sy/2-68/zoom+105/zoom,273/zoom,47/zoom,main['textures']['editbox'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            dxDrawText('Powtorz haslo:',sx/2,sy/2-87/zoom+105/zoom+105/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]*0.9),1,main['fonts'][5],'center','center')
            --dxDrawImage(sx/2-(273/2)/zoom,sy/2-68/zoom+105/zoom+105/zoom,273/zoom,47/zoom,main['textures']['editbox'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            dxDrawText('Adres e-mail:',sx/2,sy/2-87/zoom+105/zoom+105/zoom+105/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]*0.9),1,main['fonts'][5],'center','center')
            --dxDrawImage(sx/2-(273/2)/zoom,sy/2-68/zoom+105/zoom+105/zoom+105/zoom,273/zoom,47/zoom,main['textures']['editbox'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            dxDrawImage(sx/2-(209/2)/zoom,sy/2+360/zoom,209/zoom,47/zoom,main['textures']['button'],0,0,0,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+360/zoom,209/zoom,47/zoom) and 255 or 150) or main['alpha'][2]*0.6)))
            dxDrawText('Stworz konto',sx/2-(209/2)/zoom+209/zoom/2,sy/2+360/zoom+52/zoom/2,nil,nil,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+360/zoom,209/zoom,47/zoom) and 255 or 150) or main['alpha'][2]*0.6)),1,main['fonts'][4],'center','center')
            dxDrawImage(sx/2-95/zoom,sy/2+309/zoom,30/zoom,30/zoom,main['textures']['checkbox'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            dxDrawText('Akceptuje regulamin',sx/2-55/zoom,sy/2+309/zoom+35/zoom/2,nil,nil,tocolor(255,255,255,main['alpha'][2]*0.8),1,main['fonts'][6],'left','center')
            dxDrawText('Logowanie',sx/2,sy/2+440/zoom,nil,nil,tocolor(255,255,255,(isMouseInPosition(sx/2-48/zoom,sy/2+420/zoom,dxGetTextWidth('Logowanie',1,main['fonts'][5]),dxGetFontHeight(1,main['fonts'][5]) ) and main['alpha'][2]*0.8 or main['alpha'][2]*0.4)),1,main['fonts'][5],'center','center')
            if (main['checkbox']) then
                dxDrawImage(sx/2-87/zoom,sy/2+319/zoom,14/zoom,11/zoom,main['textures']['checkbox_selected'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            end

        end
    },
    [2] = {
        enter = function ()
            main['loginEditbox'] = exports['e-gui']:createEditbox('Wprowadz login', sx/2-(273/2)/zoom,sy/2+28/zoom,273/zoom,47/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 10/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                font = main['fonts'][6],
                image = main['textures']['editbox'],
                specialCharacters = '.*[_].*'
            })
            main['passwordEditbox'] = exports['e-gui']:createEditbox('Wprowadz haslo', sx/2-(273/2)/zoom,sy/2+28/zoom+105/zoom,273/zoom,47/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 10/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                font = main['fonts'][6],
                image = main['textures']['editbox'],
                specialCharacters = '.*[_].*',
                passworded = true
            })
            exports['e-gui']:setElementAlpha(main['loginEditbox'],0)
            exports['e-gui']:setElementAlpha(main['passwordEditbox'],0)
            exports['e-gui']:fadeElement(main['loginEditbox'], 1, 600, 'Linear')
            exports['e-gui']:fadeElement(main['passwordEditbox'], 1, 600, 'Linear')
            if (main['accountData']) then
                exports['e-gui']:setEditboxText(main['loginEditbox'], main['accountData'].login)
                exports['e-gui']:setEditboxText(main['passwordEditbox'], main['accountData'].password)
            end
        end,
        leave = function ()
            exports['e-gui']:destroyUIElement(main['loginEditbox'])
            exports['e-gui']:destroyUIElement(main['passwordEditbox'])
        end,
        interact = function ()
            if (isMouseInPosition(sx/2-48/zoom,sy/2+195/zoom,dxGetTextWidth('Logowanie',1,main['fonts'][5]),dxGetFontHeight(1,main['fonts'][5])) and not main['animation']) then
                main['animation'] = true
                exports['e-gui']:fadeElement(main['loginEditbox'], 0, 600, 'Linear')
                exports['e-gui']:fadeElement(main['passwordEditbox'], 0, 600, 'Linear')
                animate(255,0, "Linear", 600, function(value)
                    main['alpha'][2] = value
                end,function ()
                    pages[main['page']].leave()
                    main['page'] = 3
                    pages[main['page']].enter()
                    animate(0,255, "Linear", 600, function(value)
                        main['alpha'][2] = value
                    end,function ()
                        main['animation'] = false
                    end)
                end)
            elseif (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+240/zoom,209/zoom,47/zoom) and not main['animation']) then
                local login = exports['e-gui']:getEditboxText(main['loginEditbox'])
                local password = exports['e-gui']:getEditboxText(main['passwordEditbox'])
                triggerServerEvent('loginAccount',localPlayer, localPlayer, login, password)
            end
        end,
        render = function ()
            dxDrawImage(sx/2-(154/2)/zoom,sy/2-285/zoom-100/zoom,154/zoom,193/zoom,main['textures']['logo'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            dxDrawText('Witaj ponownie!,',sx/2,sy/2-25/zoom-100/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]),1,main['fonts'][2],'center','center')
            dxDrawText('Miło Cię widzieć, '..(main['accountData'] and main['accountData'].login or getPlayerName(localPlayer))..'!\nZaloguj się, aby dołączyć do serwera.',sx/2,sy/2-5/zoom-100/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]*0.9),1,main['fonts'][3],'center','top')
            dxDrawText('Login:',sx/2,sy/2+10/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]*0.9),1,main['fonts'][5],'center','center')
            dxDrawText('Haslo:',sx/2,sy/2+105/zoom+10/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]*0.9),1,main['fonts'][5],'center','center')
            dxDrawImage(sx/2-(209/2)/zoom,sy/2+240/zoom,209/zoom,47/zoom,main['textures']['button'],0,0,0,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+240/zoom,209/zoom,47/zoom) and 255 or 150) or main['alpha'][2]*0.6)))
            dxDrawText('Zaloguj sie',sx/2-(209/2)/zoom+209/zoom/2,sy/2+240/zoom+52/zoom/2,nil,nil,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+240/zoom,209/zoom,47/zoom) and 255 or 150) or main['alpha'][2]*0.6)),1,main['fonts'][4],'center','center')
            dxDrawText('Resetowanie hasla',sx/2,sy/2+210/zoom,nil,nil,tocolor(255,255,255,(isMouseInPosition(sx/2-48/zoom,sy/2+195/zoom,dxGetTextWidth('Resetowanie hasla',1,main['fonts'][5]),dxGetFontHeight(1,main['fonts'][5]) ) and main['alpha'][2]*0.8 or main['alpha'][2]*0.4)),1,main['fonts'][5],'center','center')
        end
    },
    [3] = {
        enter = function ()
            main['resetEditbox'] = exports['e-gui']:createEditbox('Wprowadz login', sx/2-(273/2)/zoom,sy/2+115/zoom,273/zoom,47/zoom, {255, 255, 255}, {
                alignX = 'left',
                paddingX = 10/zoom,
                caretColor = {255, 255, 255, 50},
                caretWidth = 2,
                font = main['fonts'][6],
                image = main['textures']['editbox'],
                specialCharacters = '.*[_].*'
            })
            exports['e-gui']:setElementAlpha(main['resetEditbox'],0)
            exports['e-gui']:fadeElement(main['resetEditbox'], 1, 600, 'Linear')
        end,
        leave = function ()
            exports['e-gui']:destroyUIElement(main['resetEditbox'])
        end,
        interact = function ()
            if (isMouseInPosition(sx/2-48/zoom,sy/2+255/zoom,dxGetTextWidth('Logowanie',1,main['fonts'][5]),dxGetFontHeight(1,main['fonts'][5])) and not main['animation']) then
                main['animation'] = true
                exports['e-gui']:fadeElement(main['resetEditbox'], 0, 600, 'Linear')
                animate(255,0, "Linear", 600, function(value)
                    main['alpha'][2] = value
                end,function ()
                    pages[main['page']].leave()
                    main['page'] = 2
                    pages[main['page']].enter()
                    exports['e-gui']:fadeElement(main['loginEditbox'], 1, 600, 'Linear')
                    exports['e-gui']:fadeElement(main['passwordEditbox'], 1, 600, 'Linear')
                    animate(0,255, "Linear", 600, function(value)
                        main['alpha'][2] = value
                    end,function ()
                        main['animation'] = false
                    end)
                end)
            end
        end,
        render = function ()
            dxDrawImage(sx/2-(154/2)/zoom,sy/2-285/zoom,154/zoom,193/zoom,main['textures']['logo'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            dxDrawText('Przypomnij hasło!',sx/2,sy/2-25/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]),1,main['fonts'][2],'center','center')
            dxDrawText('Zapomniałeś hasła?\nUzupełnij formularz, a hasło zostanie wygeneraowane na discordzie!',sx/2,sy/2-5/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]*0.9),1,main['fonts'][3],'center','top')
            dxDrawText('Login:',sx/2,sy/2+90/zoom,nil,nil,tocolor(255,255,255,main['alpha'][2]*0.9),1,main['fonts'][5],'center','center')
            dxDrawImage(sx/2-(209/2)/zoom,sy/2+240/zoom-50/zoom,209/zoom,47/zoom,main['textures']['button'],0,0,0,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+240/zoom-50/zoom,209/zoom,47/zoom) and 255 or 150) or main['alpha'][2]*0.6)))
            dxDrawText('Przypomnij hasło',sx/2-(209/2)/zoom+209/zoom/2,sy/2+240/zoom+52/zoom/2-50/zoom,nil,nil,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+240/zoom-50/zoom,209/zoom,47/zoom) and 255 or 150) or main['alpha'][2]*0.6)),1,main['fonts'][4],'center','center')
            dxDrawText('Logowanie',sx/2,sy/2+270/zoom,nil,nil,tocolor(255,255,255,(isMouseInPosition(sx/2-48/zoom,sy/2+255/zoom,dxGetTextWidth('Logowanie',1,main['fonts'][5]),dxGetFontHeight(1,main['fonts'][5]) ) and main['alpha'][2]*0.8 or main['alpha'][2]*0.4)),1,main['fonts'][5],'center','center')
        end
    },
    [4] = {
        enter = function ()
            renderID, renderData = exports['e-scroll']:createTarget({
                x = sx/2-(736/2)/zoom+20/zoom,
                y = sy/2-(414/2)/zoom+60/zoom,
                w = 700/zoom,
                h = 290/zoom,
                rtw = 700,
                rth = 290,
                alpha = true,
                max_scroll = 300/zoom,
                scrollSpeed = 20,
                noDrag = true,
                
                scrollData = {
                    visible = false,

                }
            })
            updateRenderTarget()
        end,
        leave = function ()
            if renderID then
                exports['e-scroll']:destroyTarget(renderID)
            end
        end,
        interact = function ()
            if (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+240/zoom-95/zoom,209/zoom,47/zoom) and not main['animation']) then
                main['animation'] = true
                animate(255,0, "Linear", 600, function(value)
                    main['alpha'][2] = value
                    updateRenderTarget()
                end,function ()
                    pages[main['page']].leave()
                    main['page'] = 0
                    pages[main['page']].enter()
                    animate(0,255, "Linear", 600, function(value)
                        main['alpha'][2] = value
                    end,function ()
                        main['animation'] = false
                    end)
                end)
            end
        end,
        render = function ()
            dxDrawImage(sx/2-(154/2)/zoom,sy/2-440/zoom,154/zoom,193/zoom,main['textures']['logo'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            dxDrawImage(sx/2-(736/2)/zoom,sy/2-(414/2)/zoom,736/zoom,414/zoom,main['textures']['bg_main'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            dxDrawRectangle(sx/2-(736/2)/zoom+20/zoom,sy/2-(414/2)/zoom+20/zoom,4/zoom,27/zoom,tocolor(56,175,89,main['alpha'][2]))
            dxDrawText('Regulamin',sx/2-(736/2)/zoom+35/zoom,sy/2-(414/2)/zoom+20/zoom+33/zoom/2,nil,nil,tocolor(255,255,255,main['alpha'][2]),1,main['fonts'][5],'left','center')
            dxDrawImage(sx/2-(209/2)/zoom,sy/2+240/zoom-95/zoom,209/zoom,47/zoom,main['textures']['button'],0,0,0,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+240/zoom-95/zoom,209/zoom,47/zoom) and 255 or 150) or main['alpha'][2]*0.6)))
            dxDrawText('Wstecz',sx/2-(209/2)/zoom+209/zoom/2,sy/2+240/zoom+52/zoom/2-95/zoom,nil,nil,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+240/zoom-95/zoom,209/zoom,47/zoom) and 255 or 150) or main['alpha'][2]*0.6)),1,main['fonts'][4],'center','center')
        end,
        rt = function ()
            dxDrawText(rules,0,0,nil,nil,tocolor(255,255,255,main['alpha'][2]),1,main['fonts'][7],'left','top')
        end
    },
    [5] = {
        enter = function ()
            renderID, renderData = exports['e-scroll']:createTarget({
                x = sx/2-(736/2)/zoom+20/zoom,
                y = sy/2-(414/2)/zoom+60/zoom,
                w = 700/zoom,
                h = 290/zoom,
                rtw = 700,
                rth = 290,
                alpha = true,
                max_scroll = 1,
                scrollSpeed = 20,
                noDrag = true,
                
                scrollData = {
                    visible = false,

                }
            })
            updateRenderTarget()
        end,
        leave = function ()
            if renderID then
                exports['e-scroll']:destroyTarget(renderID)
            end
        end,
        interact = function ()
            if (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+240/zoom-95/zoom,209/zoom,47/zoom) and not main['animation']) then
                main['animation'] = true
                animate(255,0, "Linear", 600, function(value)
                    main['alpha'][2] = value
                    updateRenderTarget()
                end,function ()
                    pages[main['page']].leave()
                    main['page'] = 0
                    pages[main['page']].enter()
                    animate(0,255, "Linear", 600, function(value)
                        main['alpha'][2] = value
                    end,function ()
                        main['animation'] = false
                    end)
                end)
            end
        end,
        render = function ()
            dxDrawImage(sx/2-(154/2)/zoom,sy/2-440/zoom,154/zoom,193/zoom,main['textures']['logo'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            dxDrawImage(sx/2-(736/2)/zoom,sy/2-(414/2)/zoom,736/zoom,414/zoom,main['textures']['bg_main'],0,0,0,tocolor(255,255,255,main['alpha'][2]))
            dxDrawRectangle(sx/2-(736/2)/zoom+20/zoom,sy/2-(414/2)/zoom+20/zoom,4/zoom,27/zoom,tocolor(56,175,89,main['alpha'][2]))
            dxDrawText('Aktualnosci',sx/2-(736/2)/zoom+35/zoom,sy/2-(414/2)/zoom+20/zoom+33/zoom/2,nil,nil,tocolor(255,255,255,main['alpha'][2]),1,main['fonts'][5],'left','center')
            dxDrawImage(sx/2-(209/2)/zoom,sy/2+240/zoom-95/zoom,209/zoom,47/zoom,main['textures']['button'],0,0,0,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+240/zoom-95/zoom,209/zoom,47/zoom) and 255 or 150) or main['alpha'][2]*0.6)))
            dxDrawText('Wstecz',sx/2-(209/2)/zoom+209/zoom/2,sy/2+240/zoom+52/zoom/2-95/zoom,nil,nil,tocolor(255,255,255,(not main['animation'] and (isMouseInPosition(sx/2-(209/2)/zoom,sy/2+240/zoom-95/zoom,209/zoom,47/zoom) and 255 or 150) or main['alpha'][2]*0.6)),1,main['fonts'][4],'center','center')
        end,
        rt = function ()
            dxDrawText(updates,0,0,nil,nil,tocolor(255,255,255,main['alpha'][2]),1,main['fonts'][7],'left','top')
        end
    }
}