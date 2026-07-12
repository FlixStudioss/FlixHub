local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- swing obby for brainrots

local plr = game:GetService("Players").LocalPlayer

_G._BR_FARMING = false

TOGGLES[114640202062357] = {
    {label="Autofarm", callback=function(on)
        _G._BR_FARMING = on
        if not on then return end

        local Event = game:GetService("ReplicatedStorage").Packages.Knit.Services.GameplayService.RF.ReturnToPlot
        Event:InvokeServer()
        task.wait()
        while _G._BR_FARMING do
            for i, v in pairs(workspace.ActiveBrainrots:GetChildren()) do
                if v:GetAttribute("Zone") == 14 or v:GetAttribute("Zone") == 13 then
                    pcall(function()
                        plr.Character:PivotTo(v.CFrame)
                        repeat fireproximityprompt(v.Attachment.ProximityPrompt) task.wait() until not v or v.Parent ~= workspace.ActiveBrainrots
                        task.wait()
                    end)
                end
            end
            task.wait(1)
        end
    end, cleanup=function() _G._BR_FARMING = false end}
}

print("[FlixHub] Game 114640202062357 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end