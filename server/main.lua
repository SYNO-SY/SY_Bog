-- ████████╗██╗███╗   ███╗███████╗██████╗
-- ╚══██╔══╝██║████╗ ████║██╔════╝██╔══██╗
--    ██║   ██║██╔████╔██║█████╗  ██████╔╝
--    ██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗
--    ██║   ██║██║ ╚═╝ ██║███████╗██║  ██║
--    ╚═╝   ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝

local countdownActive = false
local countdownTime = 0

RegisterNetEvent("SY_Bog:startCountdown")
AddEventHandler("SY_Bog:startCountdown", function(time)
    countdownActive = true
    countdownTime = time
    TriggerClientEvent("SY_Bog:showCountdown", -1, countdownTime)
    CreateThread(function()
        while countdownActive and countdownTime > 0 do
            Wait(1000)
            countdownTime = countdownTime - 1
            TriggerClientEvent("SY_Bog:updateCountdown", -1, countdownTime)
        end
        countdownActive = false
        countdownTime = 0
        TriggerClientEvent("SY_Bog:hideCountdown", -1)
    end)
end)
