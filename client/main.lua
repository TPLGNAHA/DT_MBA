ESX = exports["es_extended"]:getSharedObject()
local hasSpawned = false
local authorizedJobs = {
    ['reporter'] = true,
    ['weazel'] = true
}

local function setMBA(entitySet)
    local interior = GetInteriorAtCoords(-324.22, -1968.49, 20.60)
    if interior ~= 0 then
        local removeSets, newEntitySet = Config.Removals.interiors, Config.Sets[entitySet]
        local removeSigns, newSign = Config.Removals.signs, Config.Signs[entitySet]

        for i = 1, #removeSets do
            DeactivateInteriorEntitySet(interior, removeSets[i])
        end

        for i = 1, #removeSigns do
            RemoveIpl(removeSigns[i])
        end

        Wait(100)

        for i = 1, #newEntitySet do
            ActivateInteriorEntitySet(interior, newEntitySet[i])
        end

        if newSign then
            RequestIpl(newSign)
        end

        RefreshInterior(interior)
    end
end

AddEventHandler('playerSpawned', function()
    if not hasSpawned then
        setMBA(GlobalState.mba)
        hasSpawned = true
    end
end)

AddStateBagChangeHandler('mba', nil, function(_, _, value)
    setMBA(value)
end)

RegisterCommand("dtmba", function() -- Modifier le nom de la commandes ici !
    ESX.TriggerServerCallback('dt_mba:canOpenMenu', function(canOpen)
        if not canOpen then
            ESX.ShowNotification("~r~Vous n’avez pas la permission d’ouvrir ce menu.")
            return
        end

        local options = {}

        for key, _ in pairs(Config.Sets) do
            table.insert(options, {
                title = key,
                description = "Activer l'intérieur : " .. key,
                icon = "building",
                onSelect = function()
                    TriggerServerEvent("dt_mba:setInterior", key)
                end
            })
        end

        lib.registerContext({
            id = "mba_menu",
            title = "Maze Bank Arena - Intérieurs",
            options = options
        })

        lib.showContext("mba_menu")
    end)
end)

CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/dtmba', 'Ouvre le menu pour choisir l\'intérieur MBA')
end)
