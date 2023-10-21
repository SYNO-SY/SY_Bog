ESX = exports["es_extended"]:getSharedObject()
lib.locale()
local BogStarted = false
local zoneData = {}

RegisterCommand('startzone', function()
    if not BogStarted then
        BogStarted = true
        OpenMenu()
    else
        lib.notify({
            id = 'error_ontification',
            title = 'SY_Bog',
            description = locale('cant_startzone'),
            position = 'top',
            duration = '3500',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'xmark',
            iconColor = '#C53030'
        })
    end
end)

RegisterCommand('stopzone', function()
    if BogStarted then
        RemoveZones()
        BogStarted = false
    end
end)

function OpenMenu()
    local zoneNames = {}
    for k, v in pairs(Config.Zones) do
        table.insert(zoneData, v)
        table.insert(zoneNames, { value = v.name })
    end

    local input = lib.inputDialog('Start Zone', {
        {
            type = 'select',
            label = 'Select zone',
            options = zoneNames,
            description = 'Some input description',
            required = true,
        },
    })

    if input then
        local selectedZone = input[1]
        for _, zone in pairs(zoneData) do
            if selectedZone == zone.name then
                CreateZone(zone)
                startCaptureZone(zone)
            end
        end
    end
end

function CreateZone(data)
    local OuterZone = lib.zones.poly({
        points = data.points,
        thickness = data.thickness,
        debug = true,
    })
    Timer()
end

function Timer()
    TriggerServerEvent("SY_Bog:startCountdown", Config.Timer)
end

function startCaptureZone(data)
    local CaptureZone = lib.zones.sphere({
        name = data.name,
        coords = data.capturezone,
        radius = 4.0,
        debug = true,
        inside = inside,
        onEnter = onEnter,
        onExit = onExit
    })
end

function inside(self)
    if IsControlJustPressed(0, 38) then
        if lib.progressBar({
                duration = 180000,
                label = 'capturing ' .. self.name,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
                anim = {
                    dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    clip = 'machinic_loop_mechandplayer'
                },
            })
        then
            GiveReward()
        else
            lib.notify({
                id = 'error_ontification',
                title = 'SY_Bog',
                description = 'Failed to Capture the ' .. self.name,
                position = 'top',
                duration = '3500',
                style = {
                    backgroundColor = '#141517',
                    color = '#C1C2C5',
                    ['.description'] = {
                        color = '#909296'
                    }
                },
                icon = 'xmark',
                iconColor = '#C53030'
            })
        end
    end
end

function onEnter(self)
    lib.showTextUI('Press [E] to capture ' .. self.name, {
        position = "right-center",
        icon = 'fa-brands fa-keycdn',
        style = {
            borderRadius = 8,
            backgroundColor = 'rgb(240 24 121 / 50%)',
            color = 'white'
        }
    })
end

function onExit(self)
    lib.hideTextUI()
    if lib.progressActive() then
        lib.cancelProgress()
    end
end

function GiveReward()
    RemoveZones()
    print("rewarded")
end

function RemoveZones()
    CaptureZone:remove()
    OuterZone:remove()
end

-- ████████╗██╗███╗   ███╗███████╗██████╗
-- ╚══██╔══╝██║████╗ ████║██╔════╝██╔══██╗
--    ██║   ██║██╔████╔██║█████╗  ██████╔╝
--    ██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗
--    ██║   ██║██║ ╚═╝ ██║███████╗██║  ██║
--    ╚═╝   ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝


RegisterNetEvent("SY_Bog:showCountdown")
AddEventHandler("SY_Bog:showCountdown", function(time)
    SendNUIMessage({
        action = "show",
        time = time
    })
end)

RegisterNetEvent("SY_Bog:updateCountdown")
AddEventHandler("SY_Bog:updateCountdown", function(time)
    SendNUIMessage({
        action = "update",
        time = time
    })
end)

RegisterNetEvent("SY_Bog:hideCountdown")
AddEventHandler("SY_Bog:hideCountdown", function()
    SendNUIMessage({
        action = "hide"
    })
end)
