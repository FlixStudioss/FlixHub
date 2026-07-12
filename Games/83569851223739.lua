local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- +1 speed evolve

local plr = game:GetService("Players").LocalPlayer

_G._BR_FARMWINS = false
_G._BR_FARMEVOLVE = false
_G._BR_AUTOSPEED = false

local winsFold = workspace.Wins

TOGGLES[83569851223739] = {
    {label="Auto speed", callback=function(on)
        _G._BR_AUTOSPEED = on
        if not on then return end

        while _G._BR_AUTOSPEED do
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Shared"):WaitForChild("RemoteEventService"):WaitForChild("AddSpeedRemoteEvent"):FireServer()
            task.wait()
        end
    end, cleanup=function() _G._BR_AUTOSPEED = false end},

    {label="Auto win", callback=function(on)
        _G._BR_FARMWINS = on
        if not on then return end

        while _G._BR_FARMWINS do
            for i, v in pairs(winsFold:GetChildren()) do
                plr.Character:PivotTo(v:GetPivot())
                task.wait(1)
            end
            task.wait(0.25)
        end
    end, cleanup=function() _G._BR_FARMWINS = false end},

    {label="Auto evolve", callback=function(on)
        _G._BR_FARMEVOLVE = on
        if not on then return end

        while _G._BR_FARMEVOLVE do
            local args = {
                {
                    Action = "Evolve"
                }
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Shared"):WaitForChild("RemoteEventService"):WaitForChild("EvolutionRemoteEvent"):FireServer(unpack(args))
            task.wait(1)
        end
    end, cleanup=function() _G._BR_FARMEVOLVE = false end}
}

print("[FlixHub] Game 83569851223739 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end