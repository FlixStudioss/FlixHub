local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- paper plane for brainrot

local plr = game:GetService("Players").LocalPlayer
local httpservice = game:GetService("HttpService")

_G._BR_FARMING = false
_G._BR_STRENGTH = false

TOGGLES[110373292461174] = {
    {label="Farm Brainrots", callback=function(on)
        _G._BR_FARMING = on
        if not on then return end

        while _G._BR_FARMING do
            game:GetService("ReplicatedStorage").SharedModules.Network.RequestPendingFlight:FireServer()

            task.wait(1)

            local vsp = Vector3.new(-347.2116394043, 89.037544250488, 25.892095565796)
            local GameCore = require(game:GetService("ReplicatedStorage").GameCore)
            local GROUND_Y = GameCore.GameConfig.GROUND_Y
            local FORWARD_VECTOR = GameCore.GameConfig.FORWARD_VECTOR

            local results = game:GetService("ReplicatedStorage").SharedModules.Network.RequestActiveFlight:InvokeServer({
                plotIndex = 3,
                intensity = 1,
                player = plr,
                flightUID = require(game:GetService("ReplicatedStorage").UtilityCore).StringUtility.GenerateUID(),
                serverFloors = 10000000,
                visualStartPos = vsp,
                startTime = GameCore.GetSycnedTime(),
                startPos = Vector3.new(-347.2116394043, 85.050003051758, 25.892095565796),
                serverStrength = 10000000
            })

            if not results then continue end

            local chosenBrainrot = results.spawnedBrainrots[1]

            task.wait(results.timeInAir + 0.5)

            game:GetService("ReplicatedStorage").SharedModules.Network.ClaimFlight:InvokeServer(chosenBrainrot.uid)
        end
    end, cleanup=function() _G._BR_FARMING = false end},

    {label="Farm Strength", callback=function(on)
        _G._BR_STRENGTH = on
        if not on then return end

        while _G._BR_STRENGTH do
            local Event = game:GetService("ReplicatedStorage").SharedModules.Network.RequestStrength
            Event:InvokeServer()
            local Event = game:GetService("ReplicatedStorage").SharedModules.Network.RequestDoubleStrength
            Event:InvokeServer()
            task.wait(0.1)
        end
    end, cleanup=function() _G._BR_STRENGTH = false end}
}

print("[FlixHub] Game 110373292461174 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end