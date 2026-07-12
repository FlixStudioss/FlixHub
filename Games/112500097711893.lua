local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- Lick a brainrot

local plr = game:GetService("Players").LocalPlayer
local httpservice = game:GetService("HttpService")

_G._BR_FARMING = false
_G._BR_STRENGTH = false

TOGGLES[112500097711893] = {
    {label="Farm Brainrots", callback=function(on)
        _G._BR_FARMING = on
        if not on then return end

        while _G._BR_FARMING do
            spawn(function()
                local Event = game:GetService("ReplicatedStorage").Remotes.OnCast
                Event:InvokeServer(1)
                local Event = game:GetService("ReplicatedStorage").Remotes.StartRun
                Event:InvokeServer()
                local Event = game:GetService("ReplicatedStorage").Remotes.FinishRun
                Event:InvokeServer(true)
            end)
            task.wait()
        end
    end, cleanup=function() _G._BR_FARMING = false end},

    {label="Farm Strength", callback=function(on)
        _G._BR_STRENGTH = on
        if not on then return end

        while _G._BR_STRENGTH do
            local gym = plr.Backpack:FindFirstChild("Gym")
            if gym then
                pcall(function()
                    plr.Character.Humanoid:EquipTool(gym)
                end)
            end

            local Event = game:GetService("ReplicatedStorage").Remotes.doubleStrength
            Event:FireServer()

            task.wait(1)
        end
    end, cleanup=function() _G._BR_STRENGTH = false end}
}

print("[FlixHub] Game 112500097711893 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end