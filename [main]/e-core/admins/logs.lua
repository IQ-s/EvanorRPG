local sx,sy = guiGetScreenSize()
local zoom = exports['e-gui']:getZoom()

local savedLogs = {}

local toggledLogs = false
local toggledReports = false

local savedReports = {}

local fonts = {
    [1] = exports['e-gui']:getFont('semibold',16/zoom),
    [2] = exports['e-gui']:getFont('medium',13/zoom)
}

function render()
    if (toggledLogs) then
        dxDrawText('Serwerowe logi',10/zoom,sy/2-150/zoom,nil,nil,tocolor(255,255,255),1,fonts[1],'left','center')
        local offset = 0
        for i,v in pairs(savedLogs) do
            offset = offset + 18/zoom
            dxDrawText(v.text,10/zoom,sy/2-163/zoom+offset,nil,nil,tocolor(230,230,230),1,fonts[2],'left','top')
        end
    end
    if (toggledReports) then
        dxDrawText('Reporty',sx-10/zoom,sy/2-150/zoom,nil,nil,tocolor(255,255,255),1,fonts[1],'right','center')
    end
end

addEventHandler('onClientResourceStart', resourceRoot,function ()
    if (getElementData(localPlayer,'player:admin')) then
        toggledLogs = true
        addEventHandler('onClientRender',root,render)
        toggledReports = true
    end
end)

addEvent('refreshAdminsLogs',true)
addEventHandler('refreshAdminsLogs',root,function (c)
    savedLogs = c
end)


addEvent('toggleLogs', true)
addEventHandler('toggleLogs',root,function (c)
    if (c) then
        toggledLogs = true
        addEventHandler('onClientRender', root, render)
    else
        toggledLog = false
        removeEventHandler('onClientRender', root, render)
    end
end)