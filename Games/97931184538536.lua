local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- Skate for brainrots

local plr = game:GetService("Players").LocalPlayer
local httpservice = game:GetService("HttpService")

_G._BR_FARMING = false
_G._BR_FARMINGA = false

local Brainrots = workspace.Bin.FieldBrainrots

TOGGLES[97931184538536] = {
    {label="Farm OG + Celestial Brainrots", callback=function(on)
        _G._BR_FARMING = on
        if not on then return end

        while _G._BR_FARMING do
            pcall(function()
                for i, br in pairs(Brainrots:GetChildren()) do
                    if br:GetAttribute("FieldName") == "CelestialField" or br:GetAttribute("FieldName") == "OGField" then
                        if br:GetAttribute("Traits") == "VIP" then continue end
                        plr.Character:MoveTo(br.Position)
                        repeat
                            fireproximityprompt(br:FindFirstChildOfClass("ProximityPrompt"))
                            task.wait()
                        until not br or br.Parent ~= Brainrots
                        task.wait()
                        repeat
                            plr.Character:MoveTo(Vector3.new(69, 30, 162))
                            task.wait()
                        until not plr.Character:FindFirstChild("HeldFieldBrainrot")
                        task.wait()
                    end
                end
            end)
            task.wait(0.1)
        end
    end, cleanup=function() _G._BR_FARMING = false end},

    {label="Farm All Brainrots", callback=function(on)
        _G._BR_FARMINGA = on
        if not on then return end

        while _G._BR_FARMINGA do
            pcall(function()
                for i, br in pairs(Brainrots:GetChildren()) do
                    if br:GetAttribute("FieldName") == nil then continue end
                    if br:GetAttribute("Traits") == "VIP" then continue end
                    plr.Character:MoveTo(br.Position)
                    repeat
                        fireproximityprompt(br:FindFirstChildOfClass("ProximityPrompt"))
                        task.wait()
                    until not br or br.Parent ~= Brainrots
                    task.wait()
                    repeat
                        plr.Character:MoveTo(Vector3.new(69, 30, 162))
                        task.wait()
                    until not plr.Character:FindFirstChild("HeldFieldBrainrot")
                    task.wait()
                end
            end)
            task.wait(0.1)
        end
    end, cleanup=function() _G._BR_FARMINGA = false end}
}

print("[FlixHub] Game 97931184538536 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end