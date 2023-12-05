RegisterServerEvent("spawnWeapon")
AddEventHandler("spawnWeapon", function(weaponHash)
    local player = source
    TriggerClientEvent("giveWeapon", player, weaponHash)
end)
