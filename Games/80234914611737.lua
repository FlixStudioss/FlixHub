local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- +1 Jetpack for Brainrots

local plr = game:GetService("Players").LocalPlayer

_G._BR_FARMING = false

local endPos = Vector3.new(-93, 59, -9943)
local scndEndPos = Vector3.new(-104, 59, -7863)

TOGGLES[80234914611737] = {
    {label="Farm Brainrots", callback=function(on)
        _G._BR_FARMING = on
        if not _G._BR_FARMING then return end
        while _G._BR_FARMING do
            plr.Character:MoveTo(endPos)
            task.wait(1)
            for _, fold in pairs(workspace.Brainrots:GetChildren()) do
                for i, br in pairs(fold:GetChildren()) do
                    plr.Character:MoveTo(br.PrimaryPart.Position)
                    local prox = br.AttachmentProximityPrompt:FindFirstChildOfClass("ProximityPrompt")
                    repeat
                        fireproximityprompt(prox)
                        task.wait()
                    until not br or br.Parent ~= fold
                    task.wait()
                    local Event = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.7.0"].knit.Services.Game.RF.ClaimRewards
                    Event:InvokeServer()
                    task.wait()
                end
            end

            plr.Character:MoveTo(scndEndPos)
            task.wait(1)
            for _, fold in pairs(workspace.Brainrots:GetChildren()) do
                for i, br in pairs(fold:GetChildren()) do
                    plr.Character:MoveTo(br.PrimaryPart.Position)
                    local prox = br.AttachmentProximityPrompt:FindFirstChildOfClass("ProximityPrompt")
                    repeat
                        fireproximityprompt(prox)
                        task.wait()
                    until not br or br.Parent ~= fold
                    task.wait()
                    local Event = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.7.0"].knit.Services.Game.RF.ClaimRewards
                    Event:InvokeServer()
                    task.wait()
                end
            end
        end
    end, cleanup=function() _G._BR_FARMING = false end}
}

print("[FlixHub] Game 80234914611737 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end