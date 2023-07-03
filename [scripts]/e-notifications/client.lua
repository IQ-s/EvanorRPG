--[[
    Resource: e-notifications
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

local sx,sy = guiGetScreenSize()
local zoom = exports['e-gui']:getZoom()
zoom = zoom * 0.9

local main = {
    ['notifications'] = {},
    ['types'] = {
        ['error'] = {
            bg = dxCreateTexture('data/images/error.png','argb',false,'clamp'),
            circleIcon =  dxCreateTexture('data/images/erroricon.png','argb',false,'clamp'),
            text = 'Uwaga!'
        },
        ['success'] = {
            bg = dxCreateTexture('data/images/success.png','argb',false,'clamp'),
            circleIcon =  dxCreateTexture('data/images/successicon.png','argb',false,'clamp'),
            text = 'Gratulacje!'
        },
        ['info'] = {
            bg = dxCreateTexture('data/images/info.png','argb',false,'clamp'),
            circleIcon =  dxCreateTexture('data/images/infoicon.png','argb',false,'clamp'),
            text = 'Informacja!'
        }
    },
    ['fonts'] = {
        [1] = exports['e-gui']:getFont('medium',14/zoom),
        [2] = exports['e-gui']:getFont('regular',12/zoom)
    }
}

addEventHandler('onClientRender',root,function ()
    local offset = 0
    for i,v in pairs(main['notifications']) do
        local h = 50/zoom + v.h
        offset = offset + h + 5/zoom
        if not (v.visible) then
            v.visible = true
            animate(v.x, 25/zoom, 'OutQuad', 600, function (s)
                v.x = s
            end)
        end
        dxDrawImage(v.x, sy-235/zoom - offset ,330/zoom, h, main['types'][v.type].bg,0,0,0,tocolor(255,255,255),true)
        dxDrawImage(v.x + 272/zoom, sy-235/zoom - offset + h/2 - 46/zoom/2,46/zoom, 46/zoom, main['types'][v.type].circleIcon,0,0,0,tocolor(255,255,255),true)
        dxDrawText(main['types'][v.type].text,v.x + 10/zoom, sy-235/zoom - offset + 15/zoom, nil,nil,white,1,main['fonts'][1],'left','center',false,false,true)
        local offset2 = 0
		for z = 1, #v.message do
			offset2 = offset2 + dxGetFontHeight(1,main['fonts'][2]) - 3/zoom
			dxDrawText(v.message[z],v.x+10/zoom,sy-217/zoom - offset+offset2,nill,nill,tocolor(255,255,255,200),1,main['fonts'][2],'left','center',false,false,true)
		end
    end

    for i, v in ipairs(main['notifications']) do
        if getTickCount()-v.tick >= 8000 and not v.animation then
            v.animation = true
            animate(v.x, -340/zoom, 'InQuad', 600, function (s)
                v.x = s
            end,function ()
                table.remove(main['notifications'], i)
            end)
        end
	end
end)

function sendNotification(type, message, time)
    local h = 0
    local wrap = wordWrap(message, 330/zoom, 1, main['fonts'][2], false)
    for i = 1,#wrap - 1 do
        h = h + 15/zoom
    end
    table.insert(main['notifications'],{
        type = type,
        message = wrap,
        visible = false,
        x = - 340/zoom,
        tick = getTickCount(),
        h = h
    })
end

addEvent('sendNotification',true)
addEventHandler('sendNotification',root,function (type, message)
    sendNotification(type, message)
end)

--[[sendNotification('error', 'testowa notyfikacja error testowa notyfikacja error')
sendNotification('info', 'testowa notyfikacja info testowa notyfikacja info testowa notyfikacja info testowa notyfikacja info testowa notyfikacja info testowa notyfikacja info')
sendNotification('success', 'testowa notyfikacja success')]]