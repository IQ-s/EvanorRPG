function sendNotification(plr,type,message)
    if plr and type and message then
        triggerClientEvent(plr,'sendNotification',plr,type,message)
    end
end