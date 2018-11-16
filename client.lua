-- cfg

local weapons = {
	'WEAPON_UNARMED',
	'WEAPON_STUNGUN',
	
	-- pistol
	'WEAPON_SNSPISTOL',
	'WEAPON_COMBATPISTOL',
	'WEAPON_REVOLVER',
	
	-- shotgun
	'WEAPON_SAWNOFFSHOTGUN',
	'WEAPON_PUMPSHOTGUN',
	
	-- smg
	'WEAPON_SMG',
	'WEAPON_MINISMG',
	'WEAPON_ASSAULTSMG',
	
	-- rifle
	'WEAPON_CARBINERIFLE'
}
-- -- Set this to true and non-police players will be set to unarmed when exiting a vehicle. If you use a custom unholstering animation enable this to prevent players bypassing it
local disablePedWeaponDraw 	= true 
---
local policeMan = true
local setWeapon 		 	= ""
local weaponCount			= 1

RegisterNetEvent('copWeap:checkx')
AddEventHandler('copWeap:checkx', function(bools)
	policeMan = bools
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		--TriggerServerEvent('copWeap:check')
		if policeMan then
			if IsPedInAnyVehicle(ped, false) or IsPedInAnyVehicle(ped, false) == 0 then
				DisableControlAction(0,157,true) -- disable '1' Key
				if IsDisabledControlJustReleased(0, 157) then
					TriggerEvent('weaponCounter')
					Citizen.Wait(800)
				end
				
			end
		end
	end	
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) or IsPedInAnyVehicle(ped, false) == 0 then
			--TriggerServerEvent('copWeap:check')
			if policeMan then
				if IsControlJustReleased(0, 75) then
					SetCurrentPedWeapon(ped, setWeapon, true)
					ClearPedSecondaryTask()
					Citizen.Wait(1000)
				end
			else
				if disablePedWeaponDraw then
					if IsControlJustReleased(0, 75) then
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"))
						Citizen.Wait(1000)
					end
				end

			end
		end
	end	
end)

local get_wname = function(weapon_id)
  local name = string.gsub(weapon_id,"WEAPON_","")
  name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
  return name
end

local number = 0;
for i in pairs(weapons) do number = number + 1 end

RegisterNetEvent('weaponCounter')
AddEventHandler('weaponCounter', function()
	local ok = true
	local ped = PlayerPedId()
	while ok do
		if HasPedGotWeapon(ped, GetHashKey(weapons[weaponCount]), false) then
			setWeapon = GetHashKey(weapons[weaponCount])
			TriggerEvent('alertWeapon', get_wname(weapons[weaponCount]))
			ok = false
		end
		weaponCount = weaponCount + 1
		if weaponCount >= number then
			weaponCount = 1
		end
	end
end)

RegisterNetEvent('alertWeapon')
AddEventHandler('alertWeapon', function(weapon_name)
	exports.pNotify:SetQueueMax("left", 1)
    exports.pNotify:SendNotification({
    text = weapon_name,
    type = "info",
    timeout = 600,
    layout = "centerLeft",
    queue = "left",
    killer = true
      })
end)
