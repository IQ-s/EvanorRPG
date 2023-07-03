--[[
    Resource: e-core
    Type: Serverside
    Developers: Daniel "IQ" Wójcik <iq21376@gmail.com>
    (©) 2023 <iq21376@gmail.com>. All rights reserved.
]]--

function spawnPlr(player, pos)
    if not pos then pos = {0,0,0} end
    if not player then return end
    local x,y,z = unpack(pos)
    fadeCamera(player, true)
    spawnPlayer(player, x, y, z)
    setCameraTarget(player, player)
    setPlayerHudComponentVisible(player, 'all', false)

    loadPlayerData(player)
end

addEvent('spawnPlayer', true)
addEventHandler('spawnPlayer',root, spawnPlr)