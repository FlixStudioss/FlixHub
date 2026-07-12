local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- hack vault for brainrots

local plr = game:GetService("Players").LocalPlayer
_G._BR_FARMROTS = false

TOGGLES[137069154816703] = {
    {label="Farm Brainrots", callback=function(on)
        if on then
            _G._BR_FARMROTS = true

            while _G._BR_FARMROTS do
                for _, br in pairs(workspace.EntitiesFolder:GetChildren()) do
                    plr.Character:MoveTo(Vector3.new(-2494, 4, -726))
                    task.wait(0.5)
                    if not br:GetAttribute("SpawnZone") == 22 then
                        continue
                    end

                    if not br.PrimaryPart then
                        continue
                    end

                    plr.Character:MoveTo(br.PrimaryPart.Position)
                    task.wait()
                    repeat fireproximityprompt(br.PrimaryPart.TakeBrainrotPrompt) task.wait() until not br.PrimaryPart or br.PrimaryPart:FindFirstChild("Attachment")
                    plr.Character:MoveTo(Vector3.new(77, 4, -729))
                    task.wait(1)
                end
                task.wait()
            end
        else
            _G._BR_FARMROTS = false
        end
    end, cleanup=function() _G._BR_FARMROTS = false end}
}

print("[FlixHub] Game 137069154816703 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end