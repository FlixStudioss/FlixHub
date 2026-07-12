local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- DUMP

_G._BR_AUTODIG = false
_G._BR_AUTOBUY = false
_G._BR_COLLECT = false
_G._BR_STEALFROMALL = false

local plr = game:GetService("Players").LocalPlayer
local ShovelData = require(game:GetService("ReplicatedStorage").SharedSource.GameData.Shovels)

TOGGLES[98868317791094] = {
    {label="Steal from all", callback=function(on)
        _G._BR_STEALFROMALL = on
        if not _G._BR_STEALFROMALL then return end
        while _G._BR_STEALFROMALL do
            pcall(function()
                for _,v in pairs(workspace.ActivePlots:GetChildren()) do
                    if v.Name ~= "Plot" and v.Name ~= tostring(plr.UserId) then
                        local Event = game:GetService("ReplicatedStorage").Network.RemoteEvents.LockpickGateOpen
                        Event:FireServer(v, 30)

                        task.wait()
                        for i, item in pairs(v.PlacedItems:GetChildren()) do
                            plr.Character:MoveTo(item.PrimaryPart.Position)
                            task.wait(0.5)
                            fireproximityprompt(item.PrimaryPart.Attachment.ProximityPrompt)
                            task.wait(0.5)
                            plr.Character:MoveTo(workspace.ActivePlots[tostring(plr.UserId)].TeleportPoint.Position)
                            task.wait(0.5)
                        end
                    end
                    task.wait()
                end
            end)
            task.wait(1)
        end
    end, cleanup=function() _G._BR_STEALFROMALL = false end},

    {label="Auto Dig", callback=function(on)
        _G._BR_AUTODIG = on
        if not _G._BR_AUTODIG then return end
        while _G._BR_AUTODIG do
            local Event = game:GetService("ReplicatedStorage").Network.RemoteFunctions.StartDigging
            Event:InvokeServer()

            task.wait(1)

            local Event = game:GetService("ReplicatedStorage").Network.RemoteFunctions.GetSelectedItem
            Event:InvokeServer(2)

            local Event = game:GetService("ReplicatedStorage").Network.RemoteEvents["0a1baf564dbb5375"]
            Event:FireServer(-1)

            local Event = game:GetService("ReplicatedStorage").Network.RemoteEvents["0a1baf564dbb5375"]
            Event:FireServer(0)

            task.wait(2)

            local Event = game:GetService("ReplicatedStorage").Network.RemoteEvents.EndDigging
            Event:FireServer("Succeeded", 3)

            task.wait(0.2)
        end
    end, cleanup=function() _G._BR_AUTODIG = false end},

    {label="Auto Buy", callback=function(on)
        _G._BR_AUTOBUY = on
        if not _G._BR_AUTOBUY then return end

        local RarityOrder = {"Mythic", "Legendary", "Epic","Rare", "Uncommon", "Common"}

        local function getBest()
            local money = game:GetService("Players").LocalPlayer.leaderstats.Doubloons.Value
            local best = nil

            for _, rarity in ipairs(RarityOrder) do
                local shovels = ShovelData:GetShovelsByRarity(rarity)
                for _, shovel in ipairs(shovels) do
                    if shovel.BaseCost <= money then
                        if not best or shovel.BaseCost > best.BaseCost then
                            best = shovel
                        end
                    end
                end
                if best then break end
            end

            return best
        end

        while _G._BR_AUTOBUY do
            local best = getBest()
            if best then
                local Event = game:GetService("ReplicatedStorage").Network.RemoteEvents["5844c2fc64759f91"]
                Event:FireServer({
                    ItemType = "Shovel",
                    Name = best.Name
                })
            end
            task.wait(5)
        end
    end, cleanup=function() _G._BR_AUTOBUY = false end},

    {label="Auto Collect", callback=function(on)
        _G._BR_COLLECT = on
        if not _G._BR_COLLECT then return end
        while _G._BR_COLLECT do
            local Event = game:GetService("ReplicatedStorage").Network.RemoteEvents.CollectSavedPlotMoney
            Event:FireServer()
            task.wait(1)
        end
    end, cleanup=function() _G._BR_COLLECT = false end}
}

print("[FlixHub] Game 98868317791094 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end