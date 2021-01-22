ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('exchange:cambio')
AddEventHandler('exchange:cambio', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    balance = xPlayer.getAccount('bank').money
    if xPlayer.getAccount(Config.vipcoin).money > 1 then
    xPlayer.removeAccountMoney(Config.vipcoin, tonumber(Config.moneyVipAmount))
    xPlayer.addAccountMoney(Config.GameMoney, tonumber(Config.GameMoneyAmount))
    xPlayer.showNotification('Has cambiado una moneda vip por  '..Config.GameMoneyAmount..'  de dinero')
    else
        xPlayer.showNotification('~r~No tienes Monedas Vip')
    end
    	
end)