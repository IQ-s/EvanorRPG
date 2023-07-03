addCommandHandler('k',function (plr,cmd,plr2,...)
    if not havePlayerPermission(plr,1) then
        return exports['e-notifications']:sendNotification(plr, 'error','Nie posiadasz uprawnien!')
    end

    if not plr2 or not ... then
        return exports['e-notifications']:sendNotification(plr, 'error','Poprawne uzycie komendy: /k (nick gracza lub id) (powod)')
    end

    local player = findPlayer(plr, plr2)
    if not player then
        return exports['e-notifications']:sendNotification(plr, 'error','Nie znaleziono podanego gracza!')
    end

    reason = table.concat({...}, ' ')

    if (isPlayerOwner(player)) then
        return exports['e-notifications']:sendNotification(plr, 'error','Nie mozesz wyrzucic wlasciciela serwera!')
    end

    saveCoreLog('kary','Gracz '..getPlayerName(player)..' zostal wyrzucony z serwera przez: '..getPlayerName(plr)..' Powod: '..reason..'')
    kickPlayer(player,'Zostales wyrzucony z serwera przez: '..getPlayerName(plr)..'\nPowod: '..reason..'')


    exports['e-notifications']:sendNotification(plr, 'success','Pomyslnie wyrzucono gracza z serwera!')
end)