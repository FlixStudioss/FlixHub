local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- fly for brainrots

local plr = game:GetService("Players").LocalPlayer

_G._BR_FARMING = false
_G._BR_FARMWINGS = false
_G._BR_AUTOBEST = false
_G._BR_AUTOCOLLECT = false

TOGGLES[74277864669743] = {
    {label="Farm Brainrots", callback=function(on)
        if on then
            _G._BR_FARMING = true

            while _G._BR_FARMING do
                for _, v in pairs(workspace.Brainrots:GetChildren()) do
                    if v:GetAttribute("Rarity") ~= "ADMIN"
                    and v:GetAttribute("Rarity") ~= "Lucky"
                    and v:GetAttribute("Rarity") ~= "Ascendant"
                    and v:GetAttribute("Rarity") ~= "Transcendent"
                    and v:GetAttribute("Rarity") ~= "OG" then
                        continue
                    end

                    if v.PrimaryPart then
                        plr.Character:MoveTo(v.PrimaryPart.Position)
                        if v:FindFirstChildOfClass("Model"):FindFirstChildOfClass("MeshPart"):FindFirstChildOfClass("ProximityPrompt") then
                            repeat
                                fireproximityprompt(v:FindFirstChildOfClass("Model"):FindFirstChildOfClass("MeshPart"):FindFirstChildOfClass("ProximityPrompt"))
                                task.wait()
                            until not v or v.Parent ~= workspace.Brainrots
                            task.wait()
                            plr.Character:MoveTo(Vector3.new(7, 10, 44))
                            task.wait(0.25)
                        end
                    end
                end
                task.wait(0.1)
            end
        else
            _G._BR_FARMING = false
        end
    end, cleanup=function() _G._BR_FARMING = false end},

    {label="Auto Buy Speed", callback=function(on)
        if on then
            _G._BR_FARMWINGS = true

            while _G._BR_FARMWINGS do
                local Event = game:GetService("ReplicatedStorage").Libraries.Packet.RemoteEvent
                Event:FireServer(buffer.fromstring("\x15\x01"))
                task.wait()
            end
        else
            _G._BR_FARMWINGS = false
        end
    end, cleanup=function() _G._BR_FARMWINGS = false end},

    {label="Auto Equip Best", callback=function(on)
        if on then
            _G._BR_AUTOBEST = true

            while _G._BR_AUTOBEST do
                local Event = game:GetService("ReplicatedStorage").Libraries.Packet.RemoteEvent
                Event:FireServer(buffer.fromstring("\x0E"))
                task.wait(1)
            end
        else
            _G._BR_AUTOBEST = false
        end
    end, cleanup=function() _G._BR_AUTOBEST = false end},

    {label="Auto Collect", callback=function(on)
        if on then
            _G._BR_AUTOCOLLECT = true

            while _G._BR_AUTOCOLLECT do
                for _, v in pairs(workspace.Plots:GetChildren()) do
                    if v:GetAttribute("Owner") == plr.UserId then
                        for i, pod in pairs(v.Podiums:GetChildren()) do
                            if pod:FindFirstChild("Collect") then
                                firetouchinterest(plr.Character.Head, pod.Collect, true)
                                task.wait()
                                firetouchinterest(plr.Character.Head, pod.Collect, false)
                            end
                        end
                    end
                end
                task.wait(2)
            end
        else
            _G._BR_AUTOCOLLECT = false
        end
    end, cleanup=function() _G._BR_AUTOCOLLECT = false end}
}

print("[FlixHub] Game 74277864669743 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end