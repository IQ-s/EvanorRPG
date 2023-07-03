--[[
    Resource: e-newAuth
    Type: Serverside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

addEvent('loginAccount',true)
addEventHandler('loginAccount',root,function (player, login, password)
    exports['e-core']:loginAccount(player, login, password, function ()
        triggerClientEvent(player, 'changePage', player, 6)
    end)
end)

addEvent('registerAccount',true)
addEventHandler('registerAccount',root,function (player, login, password, password2, email)
    if (#login > 3 and #password > 3 and #password2 > 3 and #email > 3) then
        exports['e-core']:createAccount(player, login, password, password2, email)
    else
        exports['e-notifications']:sendNotification('Blad','Za malo znakow!')
    end
end)