local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- pole obby for brainrots

local plr = game:GetService("Players").LocalPlayer

_G._BR_FARMING = false

TOGGLES[105215477731035] = {
    {label="Farm Brainrots", callback=function(on)
        if on then
            _G._BR_FARMING = true

            while _G._BR_FARMING do
                pcall(function()
                    for i, v in pairs(workspace.Mobs:GetChildren()) do
                        if v.PrimaryPart then
                            local Rarity = v.PrimaryPart.OverheadAttach.AnimalOverhead.Rarity.Text
                            if Rarity == "OG" or Rarity == "Admin" then
                                plr.Character:MoveTo(v.PrimaryPart.Position)
                                repeat fireproximityprompt(v.PrimaryPart.ProximityPrompt) task.wait() until not v or not v.PrimaryPart or v.PrimaryPart:FindFirstChild("MobCarryWeld")
                                local Event = game:GetService("ReplicatedStorage").Packages.Net["RE/SafeZoneEvent"]
                                Event:FireServer()
                                task.wait(0.1)
                            end
                        end
                    end
                end)
                task.wait(0.1)
            end
        else
            _G._BR_FARMING = false
        end
    end, cleanup=function() _G._BR_FARMING = false end}
}

print("[FlixHub] Game 105215477731035 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end