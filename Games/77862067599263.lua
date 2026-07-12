local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- Obby as a Brainrot

local plr = game:GetService("Players").LocalPlayer

_G._BR_FARMING = false
_G._BR_UPGRADE = false
_G._BR_COLLECT = false
_G._BR_REBIRTH = false

TOGGLES[77862067599263] = {
    {label="Farm Disco Meowl", callback=function(on)
        _G._BR_FARMING = on
        if not _G._BR_FARMING then return end

        while _G._BR_FARMING do
            plr.Character:MoveTo(Vector3.new(9, 19, -493))
            task.wait(0.5)
            local Event = game:GetService("ReplicatedStorage").ThrowLuckyBlockRemotes.ThrowZoneBatVisual
            Event:FireServer(true)
            task.wait()
            local Event = game:GetService("ReplicatedStorage").ThrowLuckyBlockRemotes.ThrowStarted
            Event:FireServer()
            task.wait()
            local Event = game:GetService("ReplicatedStorage").ThrowLuckyBlockRemotes.ThrowBatHit
            Event:FireServer(nil, false)
            task.wait()
            local Event = game:GetService("ReplicatedStorage").ThrowLuckyBlockRemotes.ThrowBatTimingVfxCleanup
            Event:FireServer()
            task.wait()
            local Event = game:GetService("ReplicatedStorage").ThrowLuckyBlockRemotes.LuckyBlockLanded
            Event:FireServer({
                LandingPosition = Vector3.new(4, -99, 4514),
                ItemName = "Meowl",
                Rarity = "OG",
                BlockName = "Uncommon Lucky Block",
                LandingRarity = "OG",
                Mutation = "Disco",
                Power = 10.642112568062
            })
            task.wait(0.5)
            plr.Character:MoveTo(Vector3.new(8, 21, -558))
            task.wait(0.5)
        end
    end, cleanup=function() _G._BR_FARMING = false end},

    {label="Auto Upgrade", callback=function(on)
        _G._BR_UPGRADE = on
        if not _G._BR_UPGRADE then return end

        while _G._BR_UPGRADE do
            for i = 1, 10 do
                local Event = game:GetService("ReplicatedStorage").Events.RequestSlotUpgrade
                Event:FireServer("Floor1", "Slot" .. tostring(i))
            end
            for i = 1, 10 do
                local Event = game:GetService("ReplicatedStorage").Events.RequestSlotUpgrade
                Event:FireServer("Floor2", "Slot" .. tostring(i))
            end
            for i = 1, 10 do
                local Event = game:GetService("ReplicatedStorage").Events.RequestSlotUpgrade
                Event:FireServer("Floor3", "Slot" .. tostring(i))
            end
            task.wait(0.1)
        end
    end, cleanup=function() _G._BR_UPGRADE = false end},

    {label="Auto Collect", callback=function(on)
        _G._BR_COLLECT = on
        if not _G._BR_COLLECT then return end

        while _G._BR_COLLECT do
            for i, v in pairs(workspace["Plot_" .. plr.Name].Floor1.Slots:GetChildren()) do
                firetouchinterest(plr.Character.Head, v.CollectTouch, true)
                task.wait()
                firetouchinterest(plr.Character.Head, v.CollectTouch, false)
            end
            for i, v in pairs(workspace["Plot_" .. plr.Name].Floor2.Slots:GetChildren()) do
                firetouchinterest(plr.Character.Head, v.CollectTouch, true)
                task.wait()
                firetouchinterest(plr.Character.Head, v.CollectTouch, false)
            end
            for i, v in pairs(workspace["Plot_" .. plr.Name].Floor3.Slots:GetChildren()) do
                firetouchinterest(plr.Character.Head, v.CollectTouch, true)
                task.wait()
                firetouchinterest(plr.Character.Head, v.CollectTouch, false)
            end
            task.wait(0.1)
        end
    end, cleanup=function() _G._BR_COLLECT = false end},

    {label="Auto Rebirth", callback=function(on)
        _G._BR_REBIRTH = on
        if not _G._BR_REBIRTH then return end

        while _G._BR_REBIRTH do
            local Event = game:GetService("ReplicatedStorage").Events.RequestRebirth
            Event:FireServer()
            task.wait(3)
        end
    end, cleanup=function() _G._BR_REBIRTH = false end}
}

print("[FlixHub] Game 77862067599263 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end