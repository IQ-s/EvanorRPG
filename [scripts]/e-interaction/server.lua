local options = {
    ['vehicle'] = {
        [1] = function (plr)
            exports['e-notifications']:sendNotification(plr,'success','opcja 1')
        end,
        [2] = function (plr)
            exports['e-notifications']:sendNotification(plr,'success','opcja 2')
        end
    }
}

addEvent('useInteractionOption',true)
addEventHandler('useInteractionOption',root,function (plr,type,id)
    if not options[type] then return end
    if not options[type][id] then return end
    options[type][id](plr)
end)