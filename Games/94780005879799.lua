local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- scream for brainrots

_G._BR_ADDINGSPINS = false
_G._BR_AUTOSLEEPY = false
_G._BR_AUTOOG = false

TOGGLES[94780005879799] = {
    {label="Add Inf Spins", callback=function(on)
        if on then
            _G._BR_ADDINGSPINS = true

            while _G._BR_ADDINGSPINS do
                local Event = game:GetService("ReplicatedStorage").Remotes.AddSpin
                Event:FireServer()
                task.wait()
            end
        else
            _G._BR_ADDINGSPINS = false
        end
    end, cleanup=function() _G._BR_ADDINGSPINS = false end},

    {label="Auto Spin Sleepy Mutation", callback=function(on)
        if on then
            _G._BR_AUTOSLEEPY = true

            while _G._BR_AUTOSLEEPY do
                local Event = game:GetService("ReplicatedStorage").Remotes.SpinEventWheel
                Event:FireServer(5)
                task.wait(0.5)
            end
        else
            _G._BR_AUTOSLEEPY = false
        end
    end, cleanup=function() _G._BR_AUTOSLEEPY = false end},

    {label="Auto Spin OG", callback=function(on)
        if on then
            _G._BR_AUTOOG = true

            while _G._BR_AUTOOG do
                local Event = game:GetService("ReplicatedStorage").Remotes.SpinEventWheel
                Event:FireServer(4)
                task.wait(0.5)
            end
        else
            _G._BR_AUTOOG = false
        end
    end, cleanup=function() _G._BR_AUTOOG = false end}
}

print("[FlixHub] Game 94780005879799 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end