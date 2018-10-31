local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_weaponselect")

RegisterServerEvent('copWeap:check')
AddEventHandler('copWeap:check', function()
	local user_id =  vRP.getUserId({source})
	if vRP.hasGroup({user_id, "cop"}) then
		TriggerClientEvent('copWeap:checkx', -1, true)
	else
		TriggerClientEvent('copWeap:checkx', -1, false)
	end
end)