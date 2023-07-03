local saveData = {
    { elementData = 'player:skin', key = 'skin', callback = function(player, value)
        setElementModel(player, value)
    end },
   -- { elementData = 'player:test', key = 'test', json = true},
    { key = 'money', callback = function (player, value)
        setPlayerMoney(player, value)
    end },
    { elementData = 'player:discord:data', key = 'discordData', json = true },
    { elementData = 'player:level', key = 'level' },
    { elementData = 'player:exp', key = 'exp' },
    { elementData = 'player:wanted', key = 'wanted' }
}

function loadPlayerData(player)
    local uid = getElementData(player, 'player:uid')
    if not uid then return end

    local data = query('SELECT * FROM `e-users` WHERE uid=?', uid)

    if (#data == 0) then return false end

    local rows = query('SELECT * FROM `e-users` WHERE premium>NOW() AND uid=?', uid)
    if (#rows > 0) then
        setElementData(player, 'player:premium', data[1].premium)
        outputChatBox("✓ #ffffffPosiadasz zakupioną usługę #ffa600Premium#ffffff #bfbfbf(Ważne do "..data[1].premium..")#ffffff", plr, 0, 255, 0, true)
    end
    
    for i,v in pairs(saveData) do
        if (v.elementData) then
            setElementData(player, v.elementData, (v.json and fromJSON(data[1][v.key]) or data[1][v.key]))
        end
        
        if v.callback then
            v.callback(player, (v.json and fromJSON(data[1][v.key]) or data[1][v.key]))
        end
    end

    return true
end

function savePlayerData(player)
    local uid = getElementData(player, 'player:uid')
    if not uid then return end

    local data = {}
    data.money = getPlayerMoney(player)
    data.skin = getElementModel(player)
    data.exp = getElementData(player, 'player:exp') or 0
    data.level = getElementData(player, 'player:level') or 0
    data.wanted = getElementData(player, 'player:wanted') or 0
    query('UPDATE `e-users` SET `money` = ?, `skin` = ?, `level` = ?, `exp` = ?, `wanted` = ?  WHERE uid=? ', data.money, data.skin, data.level, data.exp, data.wanted, uid)
end

addEventHandler('onPlayerQuit',root,function ()
    savePlayerData(source)
end)