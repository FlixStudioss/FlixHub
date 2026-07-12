local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- Reel for brainrots

local repStorage = game:GetService("ReplicatedStorage")
local plr = game:GetService("Players").LocalPlayer

local placeEv = game:GetService("ReplicatedStorage").RemoteHandler.Plot

_G._BR_FARMING = false

TOGGLES[106772177198260] = {
    {label="Farming", callback=function(on)
        if on then
            _G._BR_FARMING = true
            while _G._BR_FARMING do
                repStorage.RemoteHandler.Fishing:FireServer("Caught", 3)
                task.wait(0.1)
            end
        else
            _G._BR_FARMING = false
        end
    end, cleanup=function() _G._BR_FARMING = false end},

    {label="Dupe Brainrot InHand", isButton=true, callback=function()
        local char = plr.Character
        local br = char:FindFirstChildOfClass("Tool")
        if br and br:GetAttribute("brainrot") then
            for plotNum = 1, 30 do
                placeEv:FireServer("Add", "Plot" .. plotNum, br.Name)
                task.wait(0.5)
            end
        end
    end}
}

print("[FlixHub] Game 106772177198260 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end