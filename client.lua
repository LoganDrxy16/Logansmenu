local weaponsMenu = nil
local menuKey = 288 -- Change this to the desired key code (F1 in this example)

function CreateWeaponMenu()
    weaponsMenu = NativeUI.CreateMenu("Weapon Menu", "Choose a weapon:")

    local pistolsMenu = weaponsMenu:AddSubMenu("Pistols", "Select a pistol:")
    AddWeaponToMenu(pistolsMenu, "WEAPON_PISTOL", "Pistol")
    AddWeaponToMenu(pistolsMenu, "WEAPON_COMBATPISTOL", "Combat Pistol")

    local riflesMenu = weaponsMenu:AddSubMenu("Rifles", "Select a rifle:")
    AddWeaponToMenu(riflesMenu, "WEAPON_ASSAULTRIFLE", "Assault Rifle")
    AddWeaponToMenu(riflesMenu, "WEAPON_CARBINERIFLE", "Carbine Rifle")

    weaponsMenu.OnItemSelect = function(_, _, index)
        local selectedItem = weaponsMenu:GetItemByIndex(index)
        if selectedItem then
            local weaponHash = GetHashKey(selectedItem.Text)
            GiveWeaponToPlayer(weaponHash)
        end
    end

    weaponsMenu:Visible(true)
end

function AddWeaponToMenu(menu, weaponHash, weaponName)
    local menuItem = NativeUI.CreateItem(weaponName, "Select this weapon")
    menu:AddItem(menuItem)

    menuItem.Activated = function()
        -- Handle activation if needed
    end
end

function GiveWeaponToPlayer(weaponHash)
    local ped = GetPlayerPed(-1)
    if DoesEntityExist(ped) and not IsEntityDead(ped) then
        GiveWeaponToPed(ped, weaponHash, 100, false, true)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlJustReleased(0, menuKey) then
            if not weaponsMenu or not weaponsMenu:Visible() then
                CreateWeaponMenu()
            else
                weaponsMenu:Visible(false)
            end
        end
    end
end)
