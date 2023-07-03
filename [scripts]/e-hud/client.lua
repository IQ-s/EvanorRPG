--[[
    Resource: e-hud
    Type: Clientside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

local sx,sy = guiGetScreenSize()
local zoom = exports['e-gui']:getZoom()
zoom = zoom * 0.9

local main = {
    ['textures'] = {
        ['custom_avatar'] = dxCreateTexture('data/images/custom_avatar.png','argb',false,'clamp'),
        ['level_bg'] = dxCreateTexture('data/images/level_bg.png','argb',false,'clamp'),
        ['bg'] = dxCreateTexture('data/images/bg.png','argb',false,'clamp'),
        ['hp'] = dxCreateTexture('data/images/hp.png','argb',false,'clamp'),
        ['kevlar'] = dxCreateTexture('data/images/kevlar.png','argb',false,'clamp'),
        ['o2'] = dxCreateTexture('data/images/o2.png','argb',false,'clamp'),
        ['i_hp'] = dxCreateTexture('data/images/i_hp.png','argb',false,'clamp'),
        ['i_kevlar'] = dxCreateTexture('data/images/i_kevlar.png','argb',false,'clamp'),
        ['i_o2'] = dxCreateTexture('data/images/i_o2.png','argb',false,'clamp'),
        ['star_1'] = dxCreateTexture('data/images/star_1.png','argb',false,'clamp'),
        ['star_2'] = dxCreateTexture('data/images/star_2.png','argb',false,'clamp')
    },
    ['fonts'] = {
        [1] = exports['e-gui']:getFont('medium',13/zoom),
        [2] = exports['e-gui']:getFont('regular',12/zoom),
        [3] = exports['e-gui']:getFont('medium',15/zoom)
    },
    type = false,
    money = 0,
    value = 0
}

function render()
    if not getElementData(localPlayer,'player:spawn') then return end
    local exp = getElementData(localPlayer, 'player:exp')
    local lvl = getElementData(localPlayer, 'player:level')
    if not exp or not lvl then return end
    local health = getElementHealth(localPlayer)
    local armor = getPedArmor(localPlayer)
    local oxygon = getPedOxygenLevel(localPlayer)
    get_money()
    oxygon = oxygon/10
    dxDrawImage(sx-160/zoom,23/zoom,137/zoom,137/zoom,main['textures']['custom_avatar'])
    dxCircle(sx-91/zoom,92/zoom, 140/zoom, 140/zoom, tocolor(255, 255, 255, 55), 180, 360, 4/zoom, 1)
    dxCircle(sx-91/zoom,92/zoom, 140/zoom, 140/zoom, tocolor(56, 175, 89), 90, 360*exp/120, 4/zoom, 1)
    dxDrawImage(sx-160/zoom + 137/zoom/2 - 49/zoom/2,130/zoom,49/zoom,49/zoom,main['textures']['level_bg'])
    dxDrawText(tostring(lvl),sx-160/zoom + 137/zoom/2 - 49/zoom/2 + 49/zoom/2,130/zoom + 49/zoom/2,nil,nil,white,1,main['fonts'][1],'center','center')
    dxDrawShadowText(exp..'/100 #38AF59exp',sx-160/zoom + 137/zoom/2 - 49/zoom/2 + 49/zoom/2,160/zoom + 49/zoom/2,nil,nil,white,1,main['fonts'][2],'center','center',false,false,false,true)
    dxDrawShadowText('$ '..addCommas(main.money),sx-175/zoom,125/zoom,nil,nil,tocolor(56,175,89),1,main['fonts'][3],'right','center',false,false,false,true)
    dxDrawImage(sx-195/zoom,77/zoom,23/zoom,23/zoom,main['textures']['bg'])
    --dxDrawImage(sx-195/zoom,77/zoom,23/zoom,23/zoom,main['textures']['hp'])
    dxDrawImageSection(sx-195/zoom, 77/zoom, 23/zoom/100*health, 23/zoom, 0, 0, 23/100*health, 23, main['textures']['hp'])
    dxDrawImage(sx-195/zoom + 23/zoom/2 - 13/zoom/2,77/zoom + 23/zoom/2 - 13/zoom/2,13/zoom,13/zoom,main['textures']['i_hp'])
    dxDrawImage(sx-195/zoom - 33/zoom,77/zoom,23/zoom,23/zoom,main['textures']['bg'])
    dxDrawImageSection(sx-195/zoom - 33/zoom, 77/zoom, 23/zoom/100*armor, 23/zoom, 0, 0, 23/100*armor, 23, main['textures']['kevlar'])
    --dxDrawImage(sx-195/zoom - 33/zoom,77/zoom,23/zoom,23/zoom,main['textures']['kevlar'])
    dxDrawImage(sx-195/zoom - 33/zoom + 23/zoom/2 - 13/zoom/2,77/zoom + 23/zoom/2 - 13/zoom/2,13/zoom,13/zoom,main['textures']['i_kevlar'])
    dxDrawImage(sx-195/zoom - 33/zoom - 33/zoom,77/zoom,23/zoom,23/zoom,main['textures']['bg'])
    dxDrawImageSection(sx-195/zoom - 33/zoom - 33/zoom, 77/zoom, 23/zoom/100*oxygon, 23/zoom, 0, 0, 23/100*oxygon, 23, main['textures']['o2'])
    --dxDrawImage(sx-195/zoom - 33/zoom - 33/zoom,77/zoom,23/zoom,23/zoom,main['textures']['o2'])
    dxDrawImage(sx-195/zoom - 33/zoom - 33/zoom + 23/zoom/2 - 13/zoom/2,77/zoom + 23/zoom/2 - 13/zoom/2,13/zoom,13/zoom,main['textures']['i_o2'])
    if (main.value > 0) then
        dxDrawShadowText(''..main.type..' '..addCommas(main.value),sx-175/zoom,145/zoom,nil,nil,tocolor(56,175,89,150),1,main['fonts'][1],'right','center',false,false,false,true)
    end
    local wanted = getElementData(localPlayer,'player:wanted') or 0
    local offset = 0
    for i=1,5 do
        offset = offset + 25/zoom
        dxDrawImage(sx-165/zoom - offset, 50/zoom, 21/zoom,21/zoom,main['textures']['star_1'])
        if (i == wanted or wanted > i) then
            dxDrawImage(sx-165/zoom - offset, 50/zoom, 21/zoom,21/zoom,main['textures']['star_2'])
        end
    end
end

function toggleHud(bool)
    if (bool) then
        addEventHandler('onClientRender',root,render)
    else
        removeEventHandler('onClientRender',root,render)
    end
end

toggleHud(true)

local function get_value(last, now, money)
    local xd
    if last > now and last - money then
         main.type = "#BD5151-"
         xd = last > now and last - money
     else
         main.type = "#3BA149+"
         xd = last < now and last + money
     end
    return xd
 end
 
 function get_money()
     local money = getPlayerMoney()
     local value = math.abs(money - main.money)
     main.value = value
     if main.money ~= money then
         main.money = value < 100 and get_value(main.money, money, 1) or value < 1000 and get_value(main.money, money, 10) or value < 10000 and get_value(main.money, money, 100) or value < 100000 and get_value(main.money, money, 1000) or get_value(main.money, money, 10000) or value < 1000000 and get_value(main.money, money, 10000)
     end
 end