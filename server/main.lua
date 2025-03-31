ESX = exports["es_extended"]:getSharedObject()
local authorizedJobs = {
    ['reporter'] = true, 
    ['weazel'] = true
}

local authorizedGroups = {
    ['admin'] = true,
    ['fonda'] = true
}

CreateThread(function()
    GlobalState.mba = Config.Default
end)

ESX.RegisterServerCallback('dt_mba:canOpenMenu', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    
    local group = xPlayer.getGroup()

    if authorizedGroups[group] then
        cb(true)
        return
    end

    
    if authorizedJobs[xPlayer.job.name] then
        cb(true)
        return
    end

    
    if IsPlayerAceAllowed(source, "mba") then
        cb(true)
        return
    end

    cb(false)
end)

RegisterNetEvent('dt_mba:setInterior', function(mba)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local group = xPlayer.getGroup()

    if not authorizedGroups[group] and not authorizedJobs[xPlayer.job.name] and not IsPlayerAceAllowed(src, "mba") then
        print(('[dt_mba] %s (%s) a tenté un accès non autorisé'):format(GetPlayerName(src), xPlayer.identifier))
        return
    end

    if Config.Sets[mba] then
        GlobalState.mba = mba
        print(('^2[dt_mba]^7 Intérieur défini sur : %s par %s'):format(mba, GetPlayerName(src)))
    end
end)
