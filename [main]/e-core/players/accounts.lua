--[[
    Resource: e-core
    Type: Serverside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

function createAccount(player, login, password, password2, email, callback)
    
    if (password ~= password2) then
        return exports['e-notifications']:sendNotification(player, 'error','Hasla sie roznia')
    end

    local rows = query('SELECT * FROM `e-users` WHERE login=?', login)
    if (#rows > 0) then
        return exports['e-notifications']:sendNotification(player, 'error','Konto o podanym loginie juz istnieje!')
    end

    local rows2 = query('SELECT * FROM `e-users` WHERE email=?', email)
    if (#rows2 > 0) then
        return exports['e-notifications']:sendNotification(player, 'error','Konto o podanym emailu juz istnieje!')
    end

    local rows3 = query('SELECT * FROM `e-users` WHERE serial=?', getPlayerSerial(player))
    if (#rows3 > 0) then
        return exports['e-notifications']:sendNotification(player, 'error','Limit kont (1)!')
    end

    local rows4 = query('SELECT * FROM `e-users`')

    local discordData = {
        code = generateKey(#rows4 + 1),
        connected = false,
        discordID = false
    }

    query('INSERT INTO `e-users` (`login`, `nick`, `password`, `email`, `serial`, `ip`, `discordData`) VALUES (?, ?, ?, ?, ?, ?, ?)', login, login, md5(password), email, getPlayerSerial(player), getPlayerIP(player), toJSON(discordData))
    saveCoreLog('register-logs', 'Gracz '..getPlayerName(player)..' '..getPlayerSerial(player)..' wlasnie stworzyl konto o loginie: '..login..'')
    exports['e-notifications']:sendNotification(player, 'success','Stworzono konto!')
    triggerClientEvent(player, 'createAccount', player, login, password)
end

function loginAccount(player, login, password, callback)
    if not callback then
        callback = function ()
            triggerClientEvent(player, 'changePage', player, 6)
        end
    end
    local rows = query('SELECT * FROM `e-users` WHERE login=?', login)
    if (#rows == 0) then
        return exports['e-notifications']:sendNotification(player, 'error','Nie ma takiego konta!')
    end
    if (rows[1].password == md5(password)) then
        if (findPlayerByUID(rows[1].uid)) then
            return exports['e-notifications']:sendNotification(player, 'error','Ktos jest juz zalogowany na to konto!')
        end
        setPlayerName(player, rows[1].nick)
        setElementData(player, 'player:uid', rows[1].uid)
        setElementData(player, 'player:data', {})
        exports['e-notifications']:sendNotification(player, 'success','Pomyslnie zalogowano na konto!')
        callback()
        saveCoreLog('login-logs', 'Gracz '..getPlayerName(player)..' zalogowal sie na konto o loginie: '..login..'')
    else
        saveCoreLog('login-logs', 'Gracz '..getPlayerName(player)..' probowal sie zalogowac na konto o loginie: '..login..'')
        exports['e-notifications']:sendNotification(player, 'error','Podano zle haslo!')
    end
end

--[[
    createAccount(getRandomPlayer(), 'IQ_', '1234','1234', 'iq@admin.com', function ()
        exports['e-notifications']:sendNotification('Sukces','Stworzono konto!')
    end)
]]

function findPlayerByUID(uid)
    for i,v in pairs(getElementsByType('player')) do
        if (getElementData(v,'player:uid') == uid) then
            return v
        end
    end

    return false
end