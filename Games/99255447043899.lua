local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- become a brainrot

local plr = game:GetService("Players").LocalPlayer

local runTrigger = workspace.RunTrigger

_G._BR_FARMING = false
_G._BR_AUTOSELL = false

local maxedCon

TOGGLES[99255447043899] = {
    {label="Autoequip + Sell when maxed", callback=function(on)
        _G._BR_AUTOSELL = on
        if not on then if maxedCon then maxedCon:Disconnect() end return end

        local Event = game:GetService("ReplicatedStorage").Events.Notify
        maxedCon = Event.OnClientEvent:Connect(function(arg1)
            if arg1:find("Max 75") then
                local Event = game:GetService("ReplicatedStorage").Events.EquipBest
                Event:FireServer()

                task.wait(1)

                local brlist = plr.Backpack:GetChildren()

                local Event = game:GetService("ReplicatedStorage").Events.SellAllBrainrots
                Event:FireServer(brlist)
            end
        end)
    end, cleanup=function() _G._BR_AUTOSELL = false end},

    {label="Autofarm", callback=function(on)
        _G._BR_FARMING = on
        if not on then return end

        while _G._BR_FARMING do
            pcall(function()
                firetouchinterest(plr.Character.Head, runTrigger, true)
                task.wait()
                firetouchinterest(plr.Character.Head, runTrigger, false)
                task.wait(0.5)
                plr.Character:MoveTo(Vector3.new(46, 4, -1816))
                local firstbr
                repeat
                    firstbr = workspace.Locations.End.Brainrots:FindFirstChildOfClass("Model")
                    task.wait()
                until firstbr

                local bestbr = nil
                local mostval = 0
                for i, v in pairs(workspace.Locations.End.Brainrots:GetChildren()) do
                    if v.MoneyPerSecond.Value > mostval then
                        if v.PrimaryPart.ProximityPrompt.ActionText == "STEAL OP" then continue end
                        mostval = v.MoneyPerSecond.Value
                        bestbr = v
                    end
                end

                plr.Character:MoveTo(bestbr.PrimaryPart.Position)
                task.wait()
                repeat
                    fireproximityprompt(bestbr.PrimaryPart.ProximityPrompt)
                    task.wait()
                until not bestbr or bestbr.Parent ~= workspace.Locations.End.Brainrots
                task.wait()
                plr.Character:MoveTo(workspace.EscapeHitbox.Position)
            end)
            task.wait(1)
        end
    end, cleanup=function() _G._BR_FARMING = false end}
}

print("[FlixHub] Game 99255447043899 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end