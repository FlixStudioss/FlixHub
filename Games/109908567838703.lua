local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- nuke for brainrots

local brainrotFold = workspace.Camera.BrainrotContainer
local plr = game:GetService("Players").LocalPlayer

local powerAmt = plr.PlayerGui.HUD.BottomRight.Stats.Container.Power.CollectedText

_G._BR_AUTOMONEY = false
_G._BR_AUTOREBIRTH = false

TOGGLES[109908567838703] = {
    {label="Auto Money", callback=function(on)
        if on then
            _G._BR_AUTOMONEY = true

            while _G._BR_AUTOMONEY do
                task.spawn(function()
                    local Event = game:GetService("ReplicatedStorage").ModifiedPackages.Packet.RemoteEvent
                    Event:FireServer(buffer.fromstring("\x0E"))
                end)
                task.wait()
            end
        else
            _G._BR_AUTOMONEY = false
        end
    end, cleanup=function() _G._BR_AUTOMONEY = false end},

    {label="Auto Rebirth", callback=function(on)
        if on then
            _G._BR_AUTOREBIRTH = true

            while _G._BR_AUTOREBIRTH do
                local Event = game:GetService("ReplicatedStorage").ModifiedPackages.Packet.RemoteEvent
                Event:FireServer(buffer.fromstring("\x93"))
                task.wait(1)
            end
        else
            _G._BR_AUTOREBIRTH = false
        end
    end, cleanup=function() _G._BR_AUTOREBIRTH = false end}
}

print("[FlixHub] Game 109908567838703 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end