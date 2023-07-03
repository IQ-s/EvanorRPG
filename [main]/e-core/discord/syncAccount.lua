function generateKey(key)
    return tonumber(key)..""..math.random(1,20)..""..math.random(20,40)
end

local players = {}

addCommandHandler('discord', function (plr)
    if not getElementData(plr, 'player:uid') then return end

    if (players[plr] and getTickCount() - players[plr] < 5000) then
        return exports['e-notifications']:sendNotification('Blad','Odczekaj chwile')
    end

    players[plr] = getTickCount()
    local data = getElementData(plr, 'player:discord:data')

    if (data.connected) then
        return exports['e-notifications']:sendNotification('Blad','Posiadasz juz polaczone konto z discordem')
    end

    outputChatBox("#00ff00* #ffffffTwój kod: "..data.code.." #a9a9a9(kod został skopiowany do schowka)", plr, 255, 255, 255, true)
    triggerClientEvent(plr,'copyText', plr, data.code)

    saveCoreLog('discord','Gracz: '..getPlayerName(plr)..' UID: '..getElementData(plr,'player:uid')..' '..getPlayerSerial(plr)..' Wlasnie skopiowal kod')
end)