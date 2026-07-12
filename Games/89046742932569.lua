local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- sail for brainrots

_G._BR_FARMING = false
_G._BR_SELLING = false
_G._BR_CHOSENZONE = nil
_G._BR_MAXPRICE = 0

local player = game:GetService("Players").LocalPlayer
local zonesFold = workspace.Zones

local function parseValue(str)
    local suffixes = {
        K = 1e3,
        M = 1e6,
        B = 1e9,
        T = 1e12,
        Q = 1e15,
    }

    local num, suffix = str:match("^([%d%.]+)([A-Za-z]*)")

    if not num then return 0 end

    num = tonumber(num) or 0
    suffix = suffix:upper()

    if suffixes[suffix] then
        return num * suffixes[suffix]
    end

    return num
end

TOGGLES[89046742932569] = {
    {label="Autofarm", callback=function(on)
        if on then
            _G._BR_FARMING = true

            while _G._BR_FARMING do
                local char = player.Character
                if not char then continue end

                for _, brainrot in pairs(_G._BR_CHOSENZONE.Objects:GetChildren()) do
                    if not _G._BR_FARMING then return end

                    char:MoveTo(brainrot.PrimaryPart.Position)
                    repeat
                        fireproximityprompt(brainrot.ProximityPrompt)
                        task.wait()
                    until brainrot == nil or brainrot.Parent ~= _G._BR_CHOSENZONE.Objects

                    char:MoveTo(workspace.Bases[player.Name].Root.Position)
                    task.wait(0.5)
                end

                task.wait(1)
            end
        else
            _G._BR_FARMING = false
        end
    end, cleanup=function() _G._BR_FARMING = false end},

    {label="Auto Sell", callback=function(on)
        if on then
            _G._BR_SELLING = true

            while _G._BR_SELLING do
                local char = player.Character
                if not char then continue end

                for _, brainrot in pairs(player.Backpack:GetChildren()) do
                    if brainrot.Name == "Bat" then continue end
                    spawn(function()
                        pcall(function()
                            if parseValue(brainrot.Handle.ObjectInfo.Value.ValueLabel.Text) <= _G._BR_MAXPRICE then
                                local Event = game:GetService("ReplicatedStorage").Shared.Classes.RemoteFunction.Remotes.EntityShared_SellEntity
                                Event:InvokeServer(brainrot.Name)
                            end
                        end)
                    end)
                end

                task.wait(3)
            end
        else
            _G._BR_SELLING = false
        end
    end, cleanup=function() _G._BR_SELLING = false end},

    {label="Redeem Codes", isButton=true, callback=function()
        local codes = {"Stop Looking", "TommysHouse", "Phew", "GoldStatue", "FreeSpin"}

        for i, v in pairs(codes) do
            local Event = game:GetService("ReplicatedStorage").Shared.Classes.RemoteFunction.Remotes.CodeShared_Redeem
            Event:InvokeServer(v)
            task.wait()
        end
    end}
}

print("[FlixHub] Game 89046742932569 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end