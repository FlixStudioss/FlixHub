local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- Bike obby for brainrots

local plr = game:GetService("Players").LocalPlayer

_G._BR_FARMING = false
_G._BR_EQUIP = false

TOGGLES[136919941417380] = {
    {label="Farm Brainrots", callback=function(on)
        _G._BR_FARMING = on

        if _G._BR_FARMING then
            while _G._BR_FARMING do
                pcall(function()
                    plr.Character:MoveTo(Vector3.new(-3394, 1450, 7887))
                    local divines = workspace.ItemSpawns:WaitForChild("10", 5)
                    for _,v in pairs(divines:GetChildren()) do
                        if v:IsA("Model") then
                            local prp = v.PrimaryPart
                            if not prp then continue end
                            plr.Character:MoveTo(prp.Position)
                            repeat fireproximityprompt(prp.ProximityPrompt) task.wait() until not v or v.Parent ~= divines
                            local br = plr.Character:WaitForChild("StackItem")
                            plr.Character:MoveTo(workspace.Zones.BikeSpawn.Position)
                            repeat task.wait() until not br or br.Parent ~= plr.Character
                            task.wait(0.1)
                        end
                    end
                    plr.Character:MoveTo(Vector3.new(-3394, 1450, 6269))
                    local celestial = workspace.ItemSpawns:WaitForChild("9", 5)
                    for _,v in pairs(celestial:GetChildren()) do
                        if v:IsA("Model") then
                            local prp = v.PrimaryPart
                            if not prp then continue end
                            plr.Character:MoveTo(prp.Position)
                            repeat fireproximityprompt(prp.ProximityPrompt) task.wait() until not v or v.Parent ~= celestial
                            local br = plr.Character:WaitForChild("StackItem")
                            plr.Character:MoveTo(workspace.Zones.BikeSpawn.Position)
                            repeat task.wait() until not br or br.Parent ~= plr.Character
                            task.wait(0.1)
                        end
                    end
                    plr.Character:MoveTo(Vector3.new(-3394, 1450, 4732))
                    local secret = workspace.ItemSpawns:WaitForChild("8", 5)
                    for _,v in pairs(secret:GetChildren()) do
                        if v:IsA("Model") then
                            local prp = v.PrimaryPart
                            if not prp then continue end
                            plr.Character:MoveTo(prp.Position)
                            repeat fireproximityprompt(prp.ProximityPrompt) task.wait() until not v or v.Parent ~= secret
                            local br = plr.Character:WaitForChild("StackItem")
                            plr.Character:MoveTo(workspace.Zones.BikeSpawn.Position)
                            repeat task.wait() until not br or br.Parent ~= plr.Character
                            task.wait(0.1)
                        end
                    end
                end)
                task.wait(0.1)
            end
        end
    end, cleanup=function() _G._BR_FARMING = false end},

    {label="Auto Equip Best", callback=function(on)
        _G._BR_EQUIP = on
        if _G._BR_EQUIP then
            while _G._BR_EQUIP do
                local Event = game:GetService("ReplicatedStorage").Events.PlaceBestBrainrots
                Event:FireServer()
                task.wait(5)
            end
        end
    end, cleanup=function() _G._BR_EQUIP = false end}
}

print("[FlixHub] Game 136919941417380 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end