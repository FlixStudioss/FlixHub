local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- parkour run for brainrots

_G._BR_FARMING = false

local plr = game:GetService("Players").LocalPlayer

TOGGLES[97508801613157] = {
    {label="Farming", callback=function(on)
        if on then
            _G._BR_FARMING = true

            while _G._BR_FARMING do
                plr.Character:MoveTo(Vector3.new(12738, 1490, 231))

                for _, v in pairs(workspace.BG_BrainrotSpawner:GetChildren()) do
                    local br = v:FindFirstChildOfClass("Model")
                    if v.Name == "Mythical" and br then
                        if not br.PrimaryPart:FindFirstChildOfClass("ProximityPrompt") then continue end
                        repeat fireproximityprompt(br.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")) task.wait() until br.Parent ~= v
                        local Event = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net["RE/BG_ReturnToBase"]
                        Event:FireServer()
                        task.wait(1)
                    end
                end

                task.wait(0.1)
            end
        else
            _G._BR_FARMING = false
        end
    end, cleanup=function() _G._BR_FARMING = false end}
}

print("[FlixHub] Game 97508801613157 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end