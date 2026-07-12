local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- dream for brainrots

_G._BR_FARMING = false

TOGGLES[135882949571046] = {
    {label="Farming", callback=function(on)
        if on then
            _G._BR_FARMING = true

            while _G._BR_FARMING do
                local Event = game:GetService("ReplicatedStorage").Remotes.DreamStateChanged
                Event:FireServer(true)

                local Event = game:GetService("ReplicatedStorage").Remotes.RequestDreamBrainrots
                Event:FireServer()

                local Event = game:GetService("ReplicatedStorage").Remotes.PickupDreamBrainrot
                Event:FireServer("60")

                task.wait()
                local Event = game:GetService("ReplicatedStorage").Remotes.RequestDreamWallExit
                Event:FireServer()
                task.wait()
            end
        else
            _G._BR_FARMING = false
        end
    end, cleanup=function() _G._BR_FARMING = false end}
}

print("[FlixHub] Game 135882949571046 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end