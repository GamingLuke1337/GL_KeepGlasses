local config = require("config")

Citizen.CreateThread(function()
    local function SetPropsCannotBeLost(ped)
        SetPedCanLosePropsOnDamage(ped, false, 0)
    end

    if config.enablePlayerProps then
        SetPropsCannotBeLost(PlayerPedId())
    end

    while true do
        Citizen.Wait(1000)

        if config.enablePedProps then
            for ped in EnumeratePeds() do
                SetPropsCannotBeLost(ped)
            end
        end
    end
end)

function EnumeratePeds()
    return coroutine.wrap(function()
        local handle, ped = FindFirstPed()
        local success

        repeat
            coroutine.yield(ped)
            success, ped = FindNextPed(handle)
        until not success

        EndFindPed(handle)
    end)
end
