local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- fake a brainrot

local plr = game:GetService("Players").LocalPlayer

local plots = workspace.Plots
local lazerevent = game:GetService("ReplicatedStorage").Events.LaserVisibility
local fakeevent = game:GetService("ReplicatedStorage").Events.FakeSystem_StartFake

_G._BR_FARMING = false
_G._BR_FAKEE = "Tim Cheese"

TOGGLES[110627433764494] = {
    {label="Farm Stealing", callback=function(on)
        _G._BR_FARMING = on
        if not on then return end

        while _G._BR_FARMING do
            fakeevent:FireServer(_G._BR_FAKEE)

            local connection
            local complete = false

            task.spawn(function()
                while not complete do
                    plr.Character.Humanoid:MoveTo(Vector3.new(
                        math.random(-37, 80),
                        0,
                        math.random(-399, -119)
                    ))
                    task.wait(math.random(1, 5))
                end
            end)

            connection = lazerevent.OnClientEvent:Connect(function(userId, isOn)
                if isOn then return end

                for i,v in pairs(plots:GetChildren()) do
                    if v:GetAttribute("OwnerUserId") == userId then
                        local hasBr = false
                        for _, br in pairs(v.Slots:GetChildren()) do
                            if not br:FindFirstChild("PlacedBrainrot") then
                                continue
                            end

                            hasBr = true

                            plr.Character:MoveTo(br.PlacedBrainrot.PrimaryPart.Position)

                            repeat
                                fireproximityprompt(br.StealPrompt)
                                task.wait()
                            until not br.StealPrompt.Enabled

                            plr.Character:MoveTo(v.CollectAllZone.Position)

                            task.wait(1)

                            complete = true
                        end
                        if not hasBr then
                            complete = true
                        end
                    end
                end
                connection:Disconnect()
            end)

            repeat
                task.wait(0.5)
            until complete
        end
    end, cleanup=function() _G._BR_FARMING = false end}
}

print("[FlixHub] Game 110627433764494 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end