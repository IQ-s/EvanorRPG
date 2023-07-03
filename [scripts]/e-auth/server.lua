addEvent('registerAccount',true)
addEventHandler('registerAccount',root,function (player, login, password, password2, email)
    if (#login > 3 and #password > 3 and #password2 > 3 and #email > 3) then
        triggerClientEvent(player, 'createAccount', player, login, password)
        exports['e-core']:createAccount(player, login, password, password2, email, function ()
            exports['e-notifications']:sendNotification('Sukces','Stworzono konto!')
            triggerClientEvent(player, 'createAccount', player, login, password)
        end)
    else
        exports['e-notifications']:sendNotification('Blad','Za malo znakow!')
    end
end)

addEvent('loginAccount',true)
addEventHandler('loginAccount',root,function (player, login, password)
    exports['e-core']:loginAccount(player, login, password, function ()
        triggerClientEvent(player, 'loginAccount', player)
    end)
end)