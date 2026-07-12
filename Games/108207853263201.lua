local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- "Rizz Tower" because its the first result when searching 'vaehz'

local plr = game:GetService("Players").LocalPlayer

_G._BR_WINFARM = false

TOGGLES[108207853263201] = {
    {label="Win Farm", callback=function(on)
        if on then
            _G._BR_WINFARM = true

            while _G._BR_WINFARM do
                pcall(function()
                    plr.Character:MoveTo(Vector3.new(1, 477, -315))
                    task.wait()
                    firetouchinterest(plr.Character.Head, workspace.TeleportWin.Reward, true)
                    task.wait()
                    firetouchinterest(plr.Character.Head, workspace.TeleportWin.Reward, false)
                    task.wait()
                end)
            end
        else
            _G._BR_WINFARM = false
        end
    end, cleanup=function() _G._BR_WINFARM = false end}
}

print("[FlixHub] Game 108207853263201 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end