function getPlayerData(plr)
    local rows = exports['e-core']:query('SELECT * FROM `e-users` WHERE uid=?', getElementData(plr,'player:uid'))
    local rows2 = exports['e-core']:query('SELECT * FROM `e-users` WHERE premium>NOW() AND uid=?', getElementData(plr,'player:uid'))
    local data = {}
    data.bankMoney = rows[1].bankMoney
    data.hours = 233
    data.registerDate = rows[1].registerDate
    data.lastLogin = rows[1].registerDate
    data.premium = (#rows2 > 0 and 'Posiadane do: '..rows[1].premium or 'Brak')
    data.faction = false
    return data
end

addEvent('fetchPlayerData',true)
addEventHandler('fetchPlayerData',root,function (plr)
    triggerClientEvent(plr,'fetchPlayerData',plr,getPlayerData(plr))
end)