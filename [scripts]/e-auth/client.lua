--[[
    Resource: e-auth
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

sx,sy = guiGetScreenSize()
zoom = exports['e-gui']:getZoom()

renderID, renderData = nil, nil

main = {
    ['textures'] = {},
    ['fonts'] = {},
    ['alpha'] = {
        [1] = 0,
        [2] = 0
    },
    ['animation'] = false,
    ['accountData'] = false,
    ['page'] = false,
    ['checkbox'] = false
}

function updateRenderTarget()
    if not renderData then return end
    dxSetRenderTarget(renderData.rt, true)
    dxSetBlendMode('modulate_add')
    for i,v in pairs(pages) do
        if (main['page'] == i and pages[main['page']].rt) then
            v.rt()
        end
    end
    dxSetBlendMode('blend')
    dxSetRenderTarget()
end

function render()
    dxDrawImage(0,0,sx,sy,main['textures']['background'],0,0,0,tocolor(255,255,255,main['alpha'][1]))
    dxDrawText('© 2023 EVANOR | WSZELKIE PRAWA ZASTRZEŻONE.',50/zoom,sy-50/zoom,nil,nil,tocolor(255,255,255,main['alpha'][1]),1,main['fonts'][1],'left','center')
    --dxDrawImage(0,0,sx,sy,"data/images/preview.png")
    for i,v in pairs(pages) do
        if (main['page'] == i) then
            v.render()
        end
    end
end

function click(btn,state)
    if (btn == 'left' and state == 'down') then
        for i,v in pairs(pages) do
            if (main['page'] == i) then
                v.interact()
            end
        end
    end
end


addEvent('createAccount',true)
addEventHandler('createAccount',root,function (login, password)
    if (fileExists('data.json')) then
        fileDelete('data.json')
    end
    local file = fileCreate('data.json')
    local data = {
        login = login,
        password = password
    }
    fileWrite(file, toJSON(data))
    fileClose(file)
    exports['e-gui']:fadeElement(main['loginEditbox'], 0, 600, 'Linear')
    exports['e-gui']:fadeElement(main['passwordEditbox'], 0, 600, 'Linear')
    exports['e-gui']:fadeElement(main['passwordEditbox2'], 0, 600, 'Linear')
    exports['e-gui']:fadeElement(main['emailEditbox'], 0, 600, 'Linear')
    main['animation'] = true
    animate(255,0, "Linear", 600, function(value)
        main['alpha'][2] = value
    end,function ()
        pages[main['page']].leave()
        main['page'] = 2
        pages[main['page']].enter()
        exports['e-gui']:setEditboxText(main['loginEditbox'], login)
        exports['e-gui']:setEditboxText(main['passwordEditbox'], password)
        animate(0,255, "Linear", 600, function(value)
            main['alpha'][2] = value
        end,function ()
            main['animation'] = false
        end)
    end)
end)

addEvent('loginAccount',true)
addEventHandler('loginAccount',root,function ()
    main['animation'] = true
    exports['e-gui']:fadeElement(main['loginEditbox'], 0, 600, 'Linear')
    exports['e-gui']:fadeElement(main['passwordEditbox'], 0, 600, 'Linear')
    animate(255,0, "Linear", 600, function(value)
        main['alpha'][2] = value
        main['alpha'][1] = value
    end,function ()
        pages[main['page']].leave()
        removeEventHandler('onClientRender',root,render)
        removeEventHandler('onClientClick',root,click)
        unloadTextures()
        unloadFonts()
        showChat(true)
        showCursor(false)
        triggerServerEvent('spawnPlayer', localPlayer, localPlayer, {280, -100, 0})
    end)
end)

addEventHandler('onClientResourceStart',resourceRoot,function ()
    if (getElementData(localPlayer,'player:data')) then return end
    loadTextures({
        ['background'] = true,
        ['logo'] = true,
        ['button'] = true,
        ['button1'] = true,
        ['button2'] = true,
        ['editbox'] = true,
        ['checkbox'] = true,
        ['checkbox_selected'] = true,
        ['bg_main'] = true
    })
    loadFonts({
        [1] = { name = "light", size = 18/zoom },
        [2] = { name = "bold", size = 26/zoom },
        [3] = { name = "light", size = 20/zoom },
        [4] = { name = "bold", size = 15/zoom },
        [5] = { name = "bold", size = 19/zoom },
        [6] = { name = "regular", size = 15/zoom },
        [7] = { name = "bold", size = 15 }
    })
    showCursor(true)
    showChat(false)
    addEventHandler('onClientRender',root,render)
    addEventHandler('onClientClick',root,click)
    main['accountData'] = loadAccountData()
    main['animation'] = true
    main['page'] = (main['accountData'] and 2 or 0)
    pages[main['page']].enter()
    animate(0,255, "Linear", 600, function(value)
        main['alpha'][1] = value
        main['alpha'][2] = value
    end,function ()
        main['animation'] = false
    end)
end)

addEventHandler('onClientResourceStop',resourceRoot,function ()
    if (main['page']) then
        pages[main['page']].leave()
    end
end)