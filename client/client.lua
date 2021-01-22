local dentro = false
local on = false

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function ()
	while true do
        Citizen.Wait(10)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local coords = Config.moneyPoint
        local distance = GetDistanceBetweenCoords(playerCoords, vector3(coords.x,coords.y,coords.z), true)

        if distance < 20 then
            DrawMarker(1,coords.x,coords.y,coords.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
            dentro = true
        end

        if dentro == true and distance < 2 then 
            floatingmsg("~g~Exchange", vector3(coords.x,coords.y,coords.z))
        end
    end
    Citizen.Wait(500)
end)


Citizen.CreateThread(function ()
	while true do
        Citizen.Wait(10)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local coords = Config.moneyPoint
        local distance = GetDistanceBetweenCoords(playerCoords, vector3(coords.x,coords.y,coords.z), true)

        if distance < 0.4 then
            on = true
        end

        if on == true then 
            if IsControlJustReleased(0, 38) then
                menu()
            end
        end
    end
    Citizen.Wait(500)
end)

function floatingmsg(msg, coords)
    AddTextEntry('esxFloatingHelpNotification', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('esxFloatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

function menu()
    id = GetPlayerServerId(PlayerId())
    name = GetPlayerName(PlayerId())
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'exchange',
		{
            title    = 'Exchange Vip Coins',
            align    = 'bottom-right',
			elements = {
                {label = 'Exchange', value = 'exchange'}
			}
		},
		function(data, menu)
            if data.current.value == 'exchange' then
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menuexchange',
                    {
                        title    = 'Exchange Coin',
                        align    = 'bottom-right',
                        elements = {
                            {label = 'Yes', value = 'si'}
                        }
                    },
                    function(data, menu)
                        if data.current.value == 'si' then
                            TriggerServerEvent('exchange:cambio')
                        end
                    end,
                    function(data, menu)
                        menu.close()
                    end)
                end
			menu.close()
		end,
		function(data, menu)
			menu.close()
        end)
        Citizen.Wait(100)
    end