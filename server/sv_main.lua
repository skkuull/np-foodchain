RegisterServerEvent('np-foodchain:orderFood')
AddEventHandler('np-foodchain:orderFood', function (data, cb)
    local startPos = GetEntityCoords(PlayerPedId())
    local cb = cb({ data = {}, meta = { ok = true, message = '' } })
    local tempContext, tempAction, tempAnimDict, tempAnim, animLoop = {}, "", "", "", false
end)

RegisterServerEvent('np-foodchain:cleanStation')
AddEventHandler('np-foodchain:cleanStation', function(data, cb)
    local tempAnimDict = "amb@world_human_maid_clean@base"
    local tempAnim = "base"
end)
