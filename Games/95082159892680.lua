local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- +1 speed keyboard escape

local plr = game:GetService("Players").LocalPlayer

_G._BR_FARMING = false
_G._BR_WINSTAGE = 1

local part = Instance.new("Part")
part.Anchored = true
part.Size = Vector3.new(10, 1, 546)
part.Position = Vector3.new(1, 75, 1090)
part.Parent = workspace

TOGGLES[95082159892680] = {
    {label="Autofarm", callback=function(on)
        _G._BR_FARMING = on

        if not on then return end

        spawn(function()
            while _G._BR_FARMING do
                local args = {
                    "Walking"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UpdateSpeed"):FireServer(unpack(args))
                task.wait()
            end
        end)

        while _G._BR_FARMING do
            pcall(function()
                plr.Character.Humanoid:MoveTo(Vector3.new(2, 9, 282))
                plr.Character.Humanoid.MoveToFinished:Wait()
                if _G._BR_WINSTAGE == 1 then
                    plr.Character.Humanoid:MoveTo(workspace.Structure.Stage2.WinBlock1.Position)
                    plr.Character.Humanoid.MoveToFinished:Wait()
                    task.wait(1)
                    return
                end
                plr.Character.Humanoid:MoveTo(Vector3.new(70, 9, 398))
                plr.Character.Humanoid.MoveToFinished:Wait()
                plr.Character.Humanoid:MoveTo(Vector3.new(1, 9, 505))
                plr.Character.Humanoid.MoveToFinished:Wait()
                if _G._BR_WINSTAGE == 2 then
                    plr.Character.Humanoid:MoveTo(workspace.Structure.Stage3.WinBlock2.Position)
                    plr.Character.Humanoid.MoveToFinished:Wait()
                    task.wait(1)
                    return
                end

                plr.Character.Humanoid:MoveTo(Vector3.new(19, 9, 541))
                plr.Character.Humanoid.MoveToFinished:Wait()
                plr.Character.Humanoid:MoveTo(Vector3.new(20, 77, 754))
                plr.Character.Humanoid.MoveToFinished:Wait()
                if _G._BR_WINSTAGE == 3 then
                    plr.Character.Humanoid:MoveTo(workspace.Structure.Stage4.WinBlock3.Position)
                    plr.Character.Humanoid.MoveToFinished:Wait()
                    task.wait(1)
                    return
                end

                plr.Character.Humanoid:MoveTo(Vector3.new(1, 77, 817))
                plr.Character.Humanoid.MoveToFinished:Wait()
                plr.Character.Humanoid:MoveTo(Vector3.new(1, 77, 1042))
                plr.Character.Humanoid.MoveToFinished:Wait()
                if _G._BR_WINSTAGE == 4 then
                    plr.Character.Humanoid:MoveTo(workspace.Structure.Stage5.WinBlock4.Position)
                    plr.Character.Humanoid.MoveToFinished:Wait()
                    task.wait(1)
                    return
                end

                plr.Character.Humanoid:MoveTo(Vector3.new(2, 77, 1363))
                plr.Character.Humanoid.MoveToFinished:Wait()
                if _G._BR_WINSTAGE == 5 then
                    plr.Character.Humanoid:MoveTo(workspace.Structure.Stage6.WinBlock5.Position)
                    plr.Character.Humanoid.MoveToFinished:Wait()
                    task.wait(1)
                    return
                end
            end)
        end
    end, cleanup=function() _G._BR_FARMING = false end}
}

print("[FlixHub] Game 95082159892680 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end