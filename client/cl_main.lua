
local foodConfig = {
    burger = {
        {itemid = "bleederburger", displayName = "Bleeder", description = "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty", craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
        {itemid = "heartstopper", displayName = "Heart Stopper", description = "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty", craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
        {itemid = "torpedo", displayName = "Torpedo", description = "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty", craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
        {itemid = "moneyshot", displayName = "Moneyshot", description = "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty", craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
        {itemid = "meatfree", displayName = "Meat Free", description = "1 Bun, 1 Lettuce", craftTime = 10, recipe = {"hamburgerbuns", "lettuce"}},
        {itemid = "questionablemeatburger", displayName = "Questionable Meat Burger", description = "1 Bun, 1 Questionable Meat, 1 Cheese, 1 Lettuce", craftTime = 10, recipe = {"hamburgerbuns", "cheese", "questionablemeat", "lettuce"}},
        
    },
    fries = {
        {itemid = "fries", displayName = "Fries", description = "1 Potato", craftTime = 10, recipe = {"potatoingred"}}
    },
    drinks = {
        {itemid = "water", displayName =  "Tap Water", description = "None", craftTime = 5, recipe = {}},
        {itemid = "softdrink", displayName =  "Soft Drink", description = "1 High-Fructose Syrup", craftTime = 5, recipe = {"hfcs"}},
        {itemid = "mshake", displayName =  "Milkshake", description = "1 Milk, 1 Ice Cream", craftTime = 10, recipe = {"milk", "icecreamingred"}},
        {itemid = "fruitslushy", displayName =  "Fruit Slushy", description = "1 Apple, 1 Banana, 1 Cherry, 1 Orange, 1 Peach, 1 Strawberry", craftTime = 15, recipe = {"apple", "banana", "cherry", "orange", "peach", "strawberry",}},
    },
    misc = {
        {itemid = "donut", displayName = "Donut", description = "None", craftTime = 15, recipe = {}},
        {itemid = "applepie", displayName = "Cream Pie", description = "Made with love ;)", craftTime = 15, recipe = {}},
        {itemid = "franksmonster", displayName = "Frankster", description = "Zoom zoom zoom", craftTime = 15, recipe = {}, cid = 1810},
        {itemid = "frankstruth", displayName = "Truth Serum", description = "Speak", craftTime = 15, recipe = {}, cid = 1810},
        {itemid = "franksflute", displayName = "Frank's Flute", description = "Time to dance", craftTime = 15, recipe = {}, cid = 1810},
    }
}

local isSignedOn = false

local burgerContext, friesContext, drinksContext, miscContext = {}, {}, {}, {}

local activePurchases = {}

local serverCode = "wl"

Citizen.CreateThread(function()
    serverCode = exports["np-config"]:GetServerCode()
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_signon', {{
        event = "np-foodchain:signOnPrompt",
        id = "food_chain_sign_on",
        icon = "clock",
        label = "Clock In",
        parameters = { location = "main" }
    }}, { distance = { radius = 3.5 }  , isEnabled = function(pEntity, pContext) return not isSignedOn end })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_signon', {{
        event = "np-foodchain:getActiveEmployees",
        id = "food_chain_active_employees",
        icon = "list",
        label = "View Active Employees",
    }}, { distance = { radius = 3.5 }  , isEnabled = function(pEntity, pContext) return isSignedOn end })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_signon_pier', {{
        event = "np-foodchain:signOnPrompt",
        id = "food_chain_sign_on_pier",
        icon = "clock",
        label = "Clock In",
        parameters = { location = "pier" }
    }}, { distance = { radius = 3.5 }  , isEnabled = function(pEntity, pContext) return not isSignedOn end })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_signon_pier', {{
        event = "np-foodchain:getActiveEmployees",
        id = "food_chain_active_employees",
        icon = "list",
        label = "View Active Employees",
    }}, { distance = { radius = 3.5 }  , isEnabled = function(pEntity, pContext) return isSignedOn end })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_signon', {{
        event = "np-foodchain:signOffPrompt",
        id = "food_chain_sign_off",
        icon = "clock",
        label = "Clock Out"
    }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_signon_pier', {{
        event = "np-foodchain:signOffPrompt",
        id = "food_chain_sign_off_pier",
        icon = "clock",
        label = "Clock Out"
    }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_shelfstorage', {{
        event = "np-foodchain:shelfPrompt",
        id = "food_chain_shelf_storage",
        icon = "box-open",
        label = "Open"
    }}, { distance = { radius = 3.5 }  })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_shelfstorage2', {{
        event = "np-foodchain:shelfPrompt2",
        id = "food_chain_shelf_storage_pier",
        icon = "box-open",
        label = "Open"
    }}, { distance = { radius = 3.5 }  })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_fridge', {{
        event = "np-foodchain:fridgePrompt",
        id = "food_chain_fridge",
        icon = "box-open",
        label = "Open"
    }}, { distance = { radius = 3.5 }  })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_fridge2', {{
        event = "np-foodchain:fridgePrompt2",
        id = "food_chain_fridge_pier",
        icon = "box-open",
        label = "Open"
    }}, { distance = { radius = 3.5 }  })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_drivethruwindow', {{
        event = "np-foodchain:pickupPromptWindow",
        id = "food_chain_order_pickup_tray3",
        icon = "hand-holding",
        label = "Open"
    }}, { distance = { radius = 7.0 }  })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_bagging', {{
        event = "np-foodchain:getBag",
        id = "food_chain_get_bag",
        icon = "shopping-bag",
        label = "Get Bag"
    }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_bagging', {{
        event = "np-foodchain:getMeal",
        id = "food_chain_get_meal",
        icon = "box",
        label = "Get Murder Meal"
    }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_bagging', {{
        event = "np-foodchain:getToysPrompt",
        id = "food_chain_get_toys",
        icon = "meh-rolling-eyes",
        label = "Get Toys"
    }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })

    --Stations
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_station0', {{
        event = "np-foodchain:stationPrompt",
        id = 'food_chain_station_0', --Fridge
        icon = "ice-cream",
        label = "Open Station",
        parameters = { stationId = 0 }
    }}, { distance = { radius = 3.5 } , isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_station1', {{
        event = "np-foodchain:stationPrompt",
        id = 'food_chain_station_1', --Fries
        icon = "temperature-high",
        label = "Open Station",
        parameters = { stationId = 1 }
    }}, { distance = { radius = 3.5 } , isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_station2', {{
        event = "np-foodchain:stationPrompt",
        id = 'food_chain_station_2', --Burgers
        icon = "hamburger",
        label = "Open Station",
        parameters = { stationId = 2 }
    }}, { distance = { radius = 3.5 } , isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_station3', {{
        event = "np-foodchain:stationPrompt",
        id = 'food_chain_station_3', --Drinks
        icon = "mug-hot",
        label = "Open Station",
        parameters = { stationId = 3 }
    }}, { distance = { radius = 3.5 } , isEnabled = isChargeActive })

    --Cash Registers
    local purchasePeekData = {{
        event = "np-foodchain:registerPurchasePrompt",
        icon = "cash-register",
        label = "Make Payment",
        parameters = {}
    }}

    local purchasePeekOptions = { distance = { radius = 3.5 } }

    -- This should 100% not work, but it does because exports serialize/copy the object
    -- If exports were to send references in the future then it would break for sure!

    purchasePeekData[1].id = 'food_chain_register_customer_1'
    purchasePeekData[1].parameters = {registerId = 1}
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register1', purchasePeekData, purchasePeekOptions)

    purchasePeekData[1].id = 'food_chain_register_customer_2'
    purchasePeekData[1].parameters = {registerId = 2}
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register2', purchasePeekData, purchasePeekOptions)

    purchasePeekData[1].id = 'food_chain_register_customer_3'
    purchasePeekData[1].parameters = {registerId = 3}
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register3', purchasePeekData, purchasePeekOptions)

    purchasePeekData[1].id = 'food_chain_register_customer_4'
    purchasePeekData[1].parameters = {registerId = 4}
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_drivethruwindow', purchasePeekData, { distance = { radius = 7.0 } })

    purchasePeekData[1].id = 'food_chain_register_customer_5'
    purchasePeekData[1].parameters = {registerId = 5}
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register_pier', purchasePeekData, { distance = { radius = 4.0 } })
    


    local registerPeekData = {{
        event = "np-foodchain:registerChargePrompt",
        icon = "credit-card",
        label = "Charge Customer",
        parameters = {}
    }}

    local registerPeekOptions = { distance = { radius = 3.5 }, isEnabled = isChargeActive }

    registerPeekData[1].id = 'food_chain_register_worker_1'
    registerPeekData[1].parameters = { registerId = 1 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register1', registerPeekData, registerPeekOptions)
    
    registerPeekData[1].id = 'food_chain_register_worker_2'
    registerPeekData[1].parameters = { registerId = 2 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register2', registerPeekData, registerPeekOptions)

    registerPeekData[1].id = 'food_chain_register_worker_3'
    registerPeekData[1].parameters = { registerId = 3 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register3', registerPeekData, registerPeekOptions)

    registerPeekData[1].id = 'food_chain_register_worker_4'
    registerPeekData[1].parameters = { registerId = 4 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register4', registerPeekData, registerPeekOptions)

    registerPeekData[1].id = 'food_chain_register_worker_5'
    registerPeekData[1].parameters = { registerId = 5 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register_pier', registerPeekData, registerPeekOptions)
end)

function isChargeActive(pEntity, pContext)
    return isSignedOn
end

RegisterUICallback('np-foodchain:orderFood', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local startPos = GetEntityCoords(PlayerPedId())

    local tempContext, tempAction, tempAnimDict, tempAnim, animLoop = {}, "", "", "", false
    if data.key.context == "burger" then
        tempContext = burgerContext
        tempAction = "Preparing "
        tempAnimDict = "anim@amb@business@coc@coc_unpack_cut@"
        tempAnim = "fullcut_cycle_v6_cokecutter"
        animLoop = true
    elseif data.key.context == "fries" then
        tempContext = friesContext
        tempAction = "Frying "
        tempAnimDict = "missfinale_c2ig_11"
        tempAnim = "pushcar_offcliff_f"
        animLoop = true
    elseif data.key.context == "drinks" then
        tempContext = drinksContext
        tempAction = "Dispensing "
        tempAnimDict = "mp_ped_interaction"
        tempAnim = "handshake_guy_a"
        animLoop = false
    else
        tempContext = miscContext
        tempAction = "Grabbing "
        tempAnimDict = "missfinale_c2ig_11"
        tempAnim = "pushcar_offcliff_f"
        animLoop = true
    end

    --Ingredient check
    for _,itemid in pairs(data.key.recipe) do
        local hasItem = exports['np-inventory']:hasEnoughOfItem(itemid, 1, false, true)
        if not hasItem then
            TriggerEvent("DoLongHudText", "You're missing " .. tostring(itemid))
            return
        end
    end

    if IsPedArmed(PlayerPedId(), 7) then
        SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
    end

    RequestAnimDict(tempAnimDict)

    while not HasAnimDictLoaded(tempAnimDict) do
        Citizen.Wait(0)
    end

    if IsEntityPlayingAnim(PlayerPedId(), tempAnimDict, tempAnim, 3) then
        ClearPedSecondaryTask(PlayerPedId())
    else
        local animLength = animLoop and -1 or GetAnimDuration(tempAnimDict, tempAnim)
        TaskPlayAnim(PlayerPedId(), tempAnimDict, tempAnim, 1.0, 4.0, animLength, 18, 0, 0, 0, 0)
    end

    local finished = exports["np-taskbar"]:taskBar(data.key.craftTime * 1000, tempAction .. data.key.displayName)
    if finished == 100 then
        pos = GetEntityCoords(PlayerPedId(), false)
        if(#(startPos - pos) < 2.0) then
            for _,itemid in pairs(data.key.recipe) do
                TriggerEvent("inventory:removeItem", itemid, 1)
            end
            TriggerEvent("player:receiveItem", data.key.itemid, 1, false, {})
            exports['np-ui']:showContextMenu(tempContext)
        end
    end

    StopAnimTask(PlayerPedId(), tempAnimDict, tempAnim, 3.0)
end)

AddEventHandler('np-foodchain:signOnPrompt', function(pParameters, pEntity, pContext)
    isSignedOn, message = RPC.execute("np-foodchain:tryJoinJob", pParameters.location)
    if isSignedOn then
        --Build Context Menus
        local cid = exports["isPed"]:isPed("cid")
        for foodContext, data in pairs(foodConfig) do
            local temp = {}
            for k, item in pairs(data) do
                if not item.cid or item.cid == cid then
                  temp[#temp+1] = {
                      title = item.displayName,
                      description = item.description .. " | " .. item.craftTime .. "s",
                      action = "np-foodchain:orderFood",
                      key = {itemid = item.itemid, displayName = item.displayName, craftTime = item.craftTime, recipe = item.recipe, context = foodContext},
                      disabled = false
                  }
                end
            end

            if foodContext == "burger" then
                burgerContext = temp
            elseif foodContext == "fries" then
                friesContext = temp
            elseif foodContext == "drinks" then
                drinksContext = temp
            else
                miscContext = temp
            end
        end
        TriggerEvent("DoLongHudText", message)
    else
        TriggerEvent("DoLongHudText", message)
    end
end)

AddEventHandler('np-foodchain:signOffPrompt', function(pParameters, pEntity, pContext)
    TriggerEvent("DoLongHudText", "Clocked out.")
    RPC.execute("np-foodchain:leaveJob")
    isSignedOn = false
end)

AddEventHandler('np-foodchain:pickupPromptWindow', function(pParameters, pEntity, pContext)
    TriggerEvent("server-inventory-open", "1", "burgerjob_window-" .. serverCode)
end)

AddEventHandler('np-foodchain:shelfPrompt', function(pParameters, pEntity, pContext)
    TriggerEvent("server-inventory-open", "1", "burgerjob_shelf-" .. serverCode)
end)

AddEventHandler('np-foodchain:shelfPrompt2', function(pParameters, pEntity, pContext)
    TriggerEvent("server-inventory-open", "1", "burgerjob_shelf2-" .. serverCode)
end)

AddEventHandler('np-foodchain:fridgePrompt', function(pParameters, pEntity, pContext)
    TriggerEvent("server-inventory-open", "1", "burgerjob_fridge-" .. serverCode)
end)

AddEventHandler('np-foodchain:fridgePrompt2', function(pParameters, pEntity, pContext)
    TriggerEvent("server-inventory-open", "1", "burgerjob_fridge2-" .. serverCode)
end)

AddEventHandler('np-foodchain:getBag', function(pParameters, pEntity, pContext)
    local genId = tostring(math.random(10000, 99999999))
    local invId = "container-" .. genId .. "-burgershot bag"
    local metaData = json.encode({
        inventoryId = invId,
        slots = 4,
        weight = 4,
        _hideKeys = {'inventoryId', 'slots', 'weight'},
    })
    TriggerEvent('player:receiveItem', 'burgershotbag', 1, false, {}, metaData)
end)

AddEventHandler('np-foodchain:getMeal', function(pParameters, pEntity, pContext)
    RPC.execute("np-foodchain:getMurderMeal")
end)

AddEventHandler('np-foodchain:getToysPrompt', function()
  exports["np-ui"]:openApplication("textbox", {
    callbackUrl = "np-foodchain:ui:getToysPrompt",
    key = "np-foodchain:ui:getToysPrompt",
    items = {
      {
        icon = "meh-rolling-eyes",
        label = "Number of toys",
        name = "toys",
      }
    },
    show = true,
  });
end)

RegisterUICallback("np-foodchain:ui:getToysPrompt", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = "" } })
  exports["np-ui"]:closeApplication("textbox")
  local numToys = tonumber(data.values.toys)
  if numToys then
    TriggerEvent('player:receiveItem', 'randomtoy3', numToys, false, {})
  end
end)

AddEventHandler('np-foodchain:stationPrompt', function(pParameters, pEntity, pContext)
    local tempContext, tempBrokeText, tempBrokeAction = {}, "", ""
    if pParameters.stationId == 0 then
        tempContext = miscContext
        tempBrokeText = "The trays need cleaning"
    elseif pParameters.stationId == 1 then
        tempContext = friesContext
        tempBrokeText = "The fryer needs cleaning"
    elseif pParameters.stationId == 2 then
        tempContext = burgerContext
        tempBrokeText = "The table needs cleaning"
    elseif pParameters.stationId == 3 then
        tempContext = drinksContext
        tempBrokeText = "The dispenser needs cleaning"
    end

    --Check if station is broken (server handles the random break chance)
    local isActive = RPC.execute("np-foodchain:isStationActive", pParameters.stationId)

    if not isActive then
        --Open failed dialog
        local failedContext = {{
            title = "Clean",
            description = tempBrokeText,
            action = "np-foodchain:cleanStation",
            key = {stationId = pParameters.stationId},
            disabled = false
        }}
        tempContext = failedContext
    end
    
    exports['np-ui']:showContextMenu(tempContext)
end)

AddEventHandler('np-foodchain:registerPurchasePrompt', function(pParameters, pEntity, pContext)
    local activeRegisterId = pParameters.registerId
    local activeRegister = activePurchases[activeRegisterId]
    if not activeRegister or activeRegister == nil then
        TriggerEvent("DoLongHudText", "No purchase active.")
        return
    end
    local priceWithTax = RPC.execute("PriceWithTaxString", activeRegister.cost, "Goods")
    local acceptContext = {{
        title = "Accept Purchase",
        description = "$" .. priceWithTax.text .. " | " .. activeRegister.comment,
        action = "np-foodchain:finishPurchasePrompt",
        key = {cost = activeRegister.cost, comment = activeRegister.comment, registerId = pParameters.registerId, charger = activeRegister.charger},
        disabled = false
    }}
    exports['np-ui']:showContextMenu(acceptContext)
end)

AddEventHandler('np-foodchain:registerChargePrompt', function(pParameters, pEntity, pContext)
    exports['np-ui']:openApplication('textbox', {
        callbackUrl = 'np-ui:foodchain:charge',
        key = pParameters.registerId,
        items = {
          {
            icon = "dollar-sign",
            label = "Cost",
            name = "cost",
          },
          {
            icon = "pencil-alt",
            label = "Comment",
            name = "comment",
          },
        },
        show = true,
    })
end)


RegisterUICallback('np-foodchain:cleanStation', function(data, cb)
    local tempAnimDict = "amb@world_human_maid_clean@base"
    local tempAnim = "base"

    if IsPedArmed(PlayerPedId(), 7) then
        SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
    end

    RequestAnimDict(tempAnimDict)

    while not HasAnimDictLoaded(tempAnimDict) do
        Citizen.Wait(0)
    end

    if IsEntityPlayingAnim(PlayerPedId(), tempAnimDict, tempAnim, 3) then
        ClearPedSecondaryTask(PlayerPedId())
    else
        TaskPlayAnim(PlayerPedId(), tempAnimDict, tempAnim, 1.0, 4.0, -1, 19, 0, 0, 0, 0)
    end

    --Open taskbar skill
    local failed = false
    for i=1,4 do
        if not failed then
            local finished = exports["np-ui"]:taskBarSkill(3000,  math.random(15, 20))
            if finished ~= 100 then
                failed = true
            end
        end
    end

    StopAnimTask(PlayerPedId(), tempAnimDict, tempAnim, 3.0)

    if not failed then
        RPC.execute("np-foodchain:setStationActive", data.key.stationId)
        TriggerEvent("DoLongHudText", "Station cleaned.")
    end
end)

RegisterUICallback('np-foodchain:finishPurchasePrompt', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local success = RPC.execute("np-foodchain:completePurchase", data.key)
    if not success then
        TriggerEvent("DoLongHudText", "The purchase could not be completed.")
    end
end)

RegisterUICallback("np-ui:foodchain:charge", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    exports['np-ui']:closeApplication('textbox')
    local cost = tonumber(data.values.cost)
    local comment = data.values.comment
    --check if cost is actually a number
    if cost == nil or not cost then return end
    if comment == nil then comment = "" end

    if cost < 10 then cost = 10 end --Minimum $10

    --Send event to everyone indicating a purchase is ready at specified register
    RPC.execute("np-foodchain:startPurchase", {cost = cost, comment = comment, registerId = data.key})
end)

--Add to purchases at registerId pos
RegisterNetEvent('np-foodchain:activePurchase')
AddEventHandler("np-foodchain:activePurchase", function(data)
    activePurchases[data.registerId] = data
end)

--Remove at registerId pos
RegisterNetEvent('np-foodchain:closePurchase')
AddEventHandler("np-foodchain:closePurchase", function(data)
    activePurchases[data.registerId] = nil
end)

--Getting fired
RegisterNetEvent('np-foodchain:firedEmployee')
AddEventHandler("np-foodchain:firedEmployee", function(data)
    isSignedOn = false
    TriggerEvent("DoLongHudText", data, 2)
end)

--Firing someone
RegisterNetEvent('np-foodchain:burgerjob_fire')
AddEventHandler("np-foodchain:burgerjob_fire", function(employee)
    if employee == nil then return end
    local success = RPC.execute("np-foodchain:fireEmployee", employee)
    if success then 
        TriggerEvent("DoLongHudText", "Fired Employee")
    end
end)

AddEventHandler("np-inventory:itemUsed", function(item, info)
    if item == "burgershotbag" or item == "murdermeal" or item == "wrappedgift" then
        data = json.decode(info)
        TriggerEvent("InteractSound_CL:PlayOnOne","unwrap",0.1)
        TriggerEvent("inventory-open-container", data.inventoryId, data.slots, data.weight)
    end
    if item == "randomtoy" or item == "randomtoy2" or item == "randomtoy3" then
        local finished = exports["np-taskbar"]:taskBar(1000, "Opening")
        if finished == 100 then
            TriggerServerEvent('loot:useItem', item)
            TriggerEvent("inventory:removeItem", item, 1)
        end
    end
end)

-- active employee list
AddEventHandler('np-foodchain:getActiveEmployees', function ()
    local employees = RPC.execute('np-foodchain:server:getActiveEmployees')

    local mappedEmployees = {}

    for location, list in pairs(employees) do
        local fancyLocationName = "Main Restaurant"
        if location == "pier" then
            fancyLocationName = "the Pier"
        end
        for _, employee in pairs(employees[location]) do
            table.insert(mappedEmployees, {
                title = string.format("%s (%s)", employee.name, employee.cid),
                description = string.format("Clocked in at %s", fancyLocationName),
            })
        end
    end
    if #mappedEmployees == 0 then
        table.insert(mappedEmployees, {
            title = "Nobody is clocked in currently",
        })
    end

    exports['np-ui']:showContextMenu(mappedEmployees)
end)

-- Citizen.CreateThread(function()
--   while true do
--     TriggerServerEvent('loot:useItem', 'randomtoy3')
--     Citizen.Wait(100)
--   end
-- end)

local inLine = false

AddEventHandler("np-polyzone:enter", function(zone, data)
    if zone == "np-foodchain:burgerjob_outsidenear" then
        TriggerEvent('np-voice:setQuietMode', 'burgershot', true, 2)
    end

    if zone == "np-foodchain:burgerjob_interior" then
        --TriggerEvent('np-voice:setVoiceProximity', 1)
    end

    if zone == "np-foodchain:burgerjob_intercom_outside" then
        TriggerEvent('np:fiber:voice-event', 'intercom', 85, 2, true)
        exports["np-ui"]:sendAppEvent("hud", { burgerShotIntercom = true })
    end

    if zone == "np-foodchain:burgerjob_line" then
        local canUse = RPC.execute("np-foodchain:canUseStore")
        if canUse then
            inLine = true
            Citizen.CreateThread(function()
                local promptShowing = false
                while inLine do
                    if not promptShowing then
                        exports["np-ui"]:showInteraction("[E] Wait in Line")
                        promptShowing = true
                    end
                    if IsControlJustPressed(1, 38) then
                        exports["np-ui"]:hideInteraction()
                        local finished = exports["np-taskbar"]:taskBar(10000, "Ordering Food", false, true, false, false, nil, 5.0, PlayerPedId())
                        if finished == 100 then
                            TriggerEvent("server-inventory-open", "123", "Shop")
                        end
                    end
                    Wait(0)
                end
            end)
        end
    end
end)

AddEventHandler("np-polyzone:exit", function(zone)
    if zone == "np-foodchain:burgerjob_outsidenear" then
        TriggerEvent('np-voice:setQuietMode', 'burgershot', false)
    end

    if zone == "np-foodchain:burgerjob_intercom_outside" then
        -- TriggerEvent("np:fiber:voice-event", "radioFrequency", 0)
        TriggerEvent('np:fiber:voice-event', 'intercom', 85, 2, false)
        exports["np-ui"]:sendAppEvent("hud", { burgerShotIntercom = false })
    end

    if zone == "np-foodchain:burgerjob_line" then
        inLine = false
        exports["np-ui"]:hideInteraction()
    end
end)

local headsetConnected = false
AddEventHandler("np-inventory:itemUsed", function(item)
  if item ~= "burgershotheadset" then return end
  if not headsetConnected then
    headsetConnected = true
    TriggerEvent('np:fiber:voice-event', 'intercom', 85, 1, true, true)
    exports["np-ui"]:sendAppEvent("hud", { burgerShotIntercom = true })
else
    headsetConnected = false
    TriggerEvent('np:fiber:voice-event', 'intercom', 85, 1, false, false)
    exports["np-ui"]:sendAppEvent("hud", { burgerShotIntercom = false })
  end
end)

RegisterNetEvent('np-inventory:itemCheck')
AddEventHandler('np-inventory:itemCheck', function (item)
  if item ~= "burgershotheadset" or not headsetConnected then return end
  headsetConnected = false
  TriggerEvent('np:fiber:voice-event', 'intercom', 85, 1, false, false)
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end
 