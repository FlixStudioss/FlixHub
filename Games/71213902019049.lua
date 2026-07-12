local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- Cross rivers for brainrots

local plr = game:GetService("Players").LocalPlayer

_G._BR_FARMING = false
_G._BR_UPGRADE = false
_G._BR_COLLECT = false

local brainrotsFolder = workspace.SpawnedBrainrots
local crossWall = workspace.MainGame.Map.Model.CrossWall
local plots = workspace.MainGame.Plots

local plrPlot

for i, v in pairs(plots:GetChildren()) do
    if v.PlotOwner.UIPart.SGUI_Name.Frame.NameTxt.Text:find(plr.Name) then
        plrPlot = v
        break
    end
end

TOGGLES[71213902019049] = {
    {label="Farm Brainrots", callback=function(on)
        _G._BR_FARMING = on
        if not _G._BR_FARMING then return end
        while _G._BR_FARMING do
            pcall(function()
                for i, v in pairs(brainrotsFolder:GetChildren()) do
                    if v:GetAttribute("_ZoneIndex") == 10 then
                        local proximityPromt = v.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")
                        if proximityPromt then
                            plr.Character:MoveTo(v.PrimaryPart.Position)
                            repeat
                                fireproximityprompt(proximityPromt)
                                task.wait()
                            until not proximityPromt or proximityPromt.Parent ~= v.PrimaryPart or not proximityPromt.Enabled

                            task.wait(0.5)

                            firetouchinterest(plr.Character.Head, crossWall, true)
                            task.wait()
                            firetouchinterest(plr.Character.Head, crossWall, false)

                            task.wait(0.5)
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end, cleanup=function() _G._BR_FARMING = false end},

    {label="Auto Upgrade", callback=function(on)
        _G._BR_UPGRADE = on
        if not _G._BR_UPGRADE then return end
        while _G._BR_UPGRADE do
            for i = 1, 30 do
                local Event = game:GetService("ReplicatedStorage").Packages.Knit.Services.PadService.RF.UpgradePad
                Event:InvokeServer(tostring(i))
            end
            task.wait(0.1)
        end
    end, cleanup=function() _G._BR_UPGRADE = false end},

    {label="Auto Collect", callback=function(on)
        _G._BR_COLLECT = on
        if not _G._BR_COLLECT then return end
        while _G._BR_COLLECT do
            for i, v in pairs(plrPlot.Pads:GetChildren()) do
                firetouchinterest(plr.Character.Head, v.CollectPart, true)
                task.wait()
                firetouchinterest(plr.Character.Head, v.CollectPart, false)
            end
            task.wait(0.1)
        end
    end, cleanup=function() _G._BR_COLLECT = false end}
}

print("[FlixHub] Game 71213902019049 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end