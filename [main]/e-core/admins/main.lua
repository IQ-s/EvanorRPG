local commands = {}
local logs = {}

addCommandHandler('duty',function (plr)
    local rows = query('SELECT * FROM `e-admins` WHERE serial=?',getPlayerSerial(plr))
    if (#rows > 0) then
        if getElementData(plr,'player:admin') then
            triggerClientEvent(plr, 'toggleLogs', plr, false)
            saveCoreLog('logi-duty-adm','Administrator: '..getPlayerName(plr)..' wylogowal sie z duty administracji ranga: '..getRankName(rows[1].rank)..'')
            setElementData(plr,'player:admin',false)
            exports['e-notifications']:sendNotification('sukces','Wylogowano sie z duty administracji')
            else
                saveCoreLog('logi-duty-adm','Administrator: '..getPlayerName(plr)..' zalogowal sie na duty: '..getRankName(rows[1].rank)..'')
                setElementData(plr,'player:admin',{
                    rank = rows[1].rank,
                    reports = rows[1].reports
                })
                exports['e-notifications']:sendNotification('sukces','Zalogowano sie na duty administracji ('..getRankName(rows[1].rank)..')')
                outputChatBox('[!] Aby wlaczyc noclipa kliknij X', plr)
                triggerClientEvent(plr, 'toggleLogs', plr, true)
            end
        else
            exports['e-notifications']:sendNotification('Error','Nie posiadasz dostepu do tej komendy')
    end
end)

function addLog(text)
    if (#logs > 10) then
        table.remove(logs, 1)
    end
    table.insert(logs, {
        text = text
    })
    triggerClientEvent(root, 'refreshAdminsLogs', root, logs)
end

function havePlayerPermission(player, rank)
    local admin = getElementData(player, 'player:admin')
    if not admin then return end
    if (admin.rank == rank or admin.rank > rank) then
        return true
    end
    return false
end

function isPlayerOwner(player)
    local admin = getElementData(player, 'player:admin')
    if not admin then return end
    if (admin.rank == 4) then
        return true
    end
    return false
end