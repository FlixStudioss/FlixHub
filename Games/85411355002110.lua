local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- +1 Dash for brainrots

local plr = game:GetService("Players").LocalPlayer

_G._BR_FARMING = false

local endPos = Vector3.new(-74, 63, 15784)
local colPos = Vector3.new(-74, 20, -447)

TOGGLES[85411355002110] = {
    {label="Farm Brainrots", callback=function(on)
        _G._BR_FARMING = on
        if not _G._BR_FARMING then return end
        while _G._BR_FARMING do
            plr.Character:MoveTo(endPos)
            local lastPlace = workspace.Map.Spawners:WaitForChild("???xLuck"):WaitForChild("???")

            pcall(function()
                for i, v in pairs(lastPlace:GetChildren()) do
                    if not v:IsA("Model") then continue end

                    repeat
                        task.wait()
                    until not plr.GameplayPaused

                    if not v.PrimaryPart then continue end

                    plr.Character:MoveTo(v.PrimaryPart.Position)

                    local prox = v.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")
                    repeat
                        fireproximityprompt(prox)
                        task.wait()
                    until not v or v.Parent ~= lastPlace

                    task.wait(0.5)

                    repeat
                        plr.Character:MoveTo(colPos)
                        task.wait()
                    until not plr.Character:FindFirstChildOfClass("Model")

                    break
                end
            end)
            task.wait()
        end
    end, cleanup=function() _G._BR_FARMING = false end}
}

print("[FlixHub] Game 85411355002110 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end