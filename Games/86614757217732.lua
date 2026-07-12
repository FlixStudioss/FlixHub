local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- +1 health for brainrot

local plr = game:GetService("Players").LocalPlayer

_G._BR_FARMING = false

TOGGLES[86614757217732] = {
    {label="Farm Brainrots", callback=function(on)
        _G._BR_FARMING = on
        if not on then return end

        while _G._BR_FARMING do
            pcall(function()
                local topRot = nil
                local bestAmt = 0
                for i, br in pairs(workspace.SpawnedBrainrots:GetChildren()) do
                    if br:GetAttribute("CashPerSec") >= bestAmt then
                        bestAmt = br:GetAttribute("CashPerSec")
                        topRot = br
                    end
                end

                plr.Character:MoveTo(topRot.PrimaryPart.Position)

                repeat
                    fireproximityprompt(topRot.PickupHitbox.ProximityPrompt)
                    task.wait()
                until not topRot or topRot.Parent ~= workspace.SpawnedBrainrots

                firetouchinterest(plr.Character.Head, workspace.Map.BrainrotCollectionPart, true)
                task.wait()
                firetouchinterest(plr.Character.Head, workspace.Map.BrainrotCollectionPart, false)
            end)

            task.wait(0.5)
        end
    end, cleanup=function() _G._BR_FARMING = false end}
}

print("[FlixHub] Game 86614757217732 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end