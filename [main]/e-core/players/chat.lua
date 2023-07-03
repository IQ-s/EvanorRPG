addEventHandler('onPlayerChat',root,function (message)
    local player = source
    if not getElementData(player, 'player:data') then return end
    cancelEvent()

    local x,y,z = getElementPosition(player)
    local players = getElementsWithinRange(x, y, z, 30, 'player')
    local id = getElementData(player, 'player:id') or 0
    
    for i,v in pairs(players) do
        outputChatBox('('..(getElementData(player,'player:admin') and getRankColor(getElementData(player, 'player:admin').rank).hex or getRankColor(0))..''..id..'#ffffff) ['..(getElementData(player,'player:admin') and getRankColor(getElementData(player, 'player:admin').rank).hex or getRankColor(0))..''..(getElementData(player,'player:admin') and getRankName(getElementData(player, 'player:admin').rank) or getRankName(0))..'#ffffff] '..getPlayerName(player)..': #e6e6e6'..message, v, 255, 255, 255, true)
    end

    saveCoreLog('chat','('..id..') ['..(getElementData(player,'player:admin') and getRankName(getElementData(player, 'player:admin').rank) or getRankName(0))..'] '..getPlayerName(player)..': '..message)
    addLog('('..id..') ['..(getElementData(player,'player:admin') and getRankName(getElementData(player, 'player:admin').rank) or getRankName(0))..'] '..getPlayerName(player)..': '..message)
    sendDiscordMessage('https://discord.com/api/webhooks/1113879954774573126/sCQraPc-es0AR7vkH_QnFUgXOBhEvImdIfhvFQ4jITwcK4kIJZRMin_ZVt24Yis0k12g','CHAT-MTA', '('..id..') ['..(getElementData(player,'player:admin') and getRankName(getElementData(player, 'player:admin').rank) or getRankName(0))..'] '..getPlayerName(player)..': '..message)
end)

local plrsPremium = {}

addCommandHandler('v', function (player, cmd, ...)
    local text = table.concat({...}, ' ')
    if not getElementData(player, 'player:premium') then
        return exports['e-notifications']:sendNotification('Blad', 'Nie posiadasz konta premium')
    end

    if (plrsPremium[player] and getTickCount() - plrsPremium[player] < 3000) then
        return exports['e-notifications']:sendNotification('Blad','Odczekaj chwile przede uzyciem tej komendy')
    end

    plrsPremium[player] = getTickCount()
    local id = getElementData(player, 'player:id') or 0
    if (getElementData(player, 'player:admin')) then
        outputChatBox('(#ffa600P#ffffff) ('..(getElementData(player,'player:admin') and getRankColor(getElementData(player, 'player:admin').rank).hex or getRankColor(0))..''..id..'#ffffff) ['..(getElementData(player,'player:admin') and getRankColor(getElementData(player, 'player:admin').rank).hex or getRankColor(0))..''..(getElementData(player,'player:admin') and getRankName(getElementData(player, 'player:admin').rank) or '')..'#ffffff] '..getPlayerName(player)..': #e6e6e6'..text, root, 255,255,255, true)
    else
        outputChatBox('(#ffa600P#ffffff) ('..getRankColor(0)..''..id..'#ffffff) '..getPlayerName(player)..': #e6e6e6'..text, root, 255,255,255, true)
    end
end)

local blockedCommands = {
    {
        name = "register",
        cancel = function ()
            cancelEvent()
        end,
    },
}


addEventHandler('onPlayerCommand',root, function (cmd)
    if (cmd == 'restart' or cmd == 'say') then return end
    local id = getElementData(source, 'player:id') or 0
    sendDiscordMessage('https://discord.com/api/webhooks/1113879958448783522/U6nyUq3Lf5Yo6gyS2SGyJBtytEhzOspqDiXT5dalEbqsrxUJe-wUB73gTlGrLN5mUd8k','KOMENDY-MTA','('..id..') ['..(getElementData(source,'player:admin') and getRankName(getElementData(source, 'player:admin').rank) or getRankName(0))..'] '..getPlayerName(source)..': /'..cmd)
    saveCoreLog('komendy','('..id..') ['..(getElementData(source,'player:admin') and getRankName(getElementData(source, 'player:admin').rank) or getRankName(0))..'] '..getPlayerName(source)..' wpisal komende: '..cmd)
    addLog('('..id..') ['..(getElementData(source,'player:admin') and getRankName(getElementData(source, 'player:admin').rank) or getRankName(0))..'] '..getPlayerName(source)..' wpisal komende: '..cmd)

    for i,v in pairs(blockedCommands) do
        if (cmd == v.name) then
            v.cancel()
        end
    end
end)