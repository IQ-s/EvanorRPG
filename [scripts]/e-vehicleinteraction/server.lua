

addEvent('tryUseVehicleInteraction',true)
addEventHandler('tryUseVehicleInteraction',root,function (plr, type)
    local veh = getPedOccupiedVehicle(plr)
    if not veh then return end

    if (type == 'engine') then
        setVehicleEngineState(veh, not getVehicleEngineState(veh))
    elseif (type == 'brake') then
        setElementFrozen(veh, not isElementFrozen(veh))
    elseif (type == 'lights') then
        setVehicleOverrideLights(veh, (getVehicleOverrideLights(veh) == 2) and 1 or 2)
    end
end)