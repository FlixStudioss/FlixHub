local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- Survive flood for brainrots

local repStorage = game:GetService("ReplicatedStorage")
local plr = game:GetService("Players").LocalPlayer
local brainrotFold = workspace.GameFolder.Brainrots

_G._BR_FARMING = false

local function grabem(where)
    local char = plr.Character
    for _, br in pairs(where:GetChildren()) do
        if not br.PrimaryPart then continue end
        char:MoveTo(br.PrimaryPart.Position)
        task.wait(0.5)
        fireproximityprompt(br.PrimaryPart.ProximityPrompt)
        task.wait(0.25)
        char:MoveTo(Vector3.new(-2, 4, 13))
        task.wait(0.5)
    end
end

TOGGLES[100070667273689] = {
    {label="Farming", callback=function(on)
        if on then
            _G._BR_FARMING = true
            while _G._BR_FARMING do
                grabem(brainrotFold.Infinity)
                grabem(brainrotFold.Godly)
                grabem(brainrotFold.Secret)
                grabem(brainrotFold.Celestial)
                task.wait(1)
            end
        else
            _G._BR_FARMING = false
        end
    end, cleanup=function() _G._BR_FARMING = false end}
}

print("[FlixHub] Game 100070667273689 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end