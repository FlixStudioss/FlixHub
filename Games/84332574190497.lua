local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- +1 Wings for brainrot
-- Developed by wirlypirly12

local player = game:GetService("Players").LocalPlayer

local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]

_G._BR_FARMING = false

local worldPositions = {
    cosmic = Vector3.new(169, 42, 6124),
    spawn = Vector3.new(22, 71, -133)
}

local function getSpawnData(name)
    local item = workspace:FindFirstChild("ItemSpawners")
    if not item then return end
    local data = item:FindFirstChild(name)
    return data
end

local function waitForUnpause()
    while player.GameplayPaused do
        task.wait(0.1)
    end
end

local function teleportTo(pos)
    pos = typeof(pos) == "Vector3" and CFrame.new(pos) or pos
    player.Character.HumanoidRootPart.CFrame = pos
    local waitTime = ((ping:GetValue() * 4) / 1000)
    task.wait(waitTime)
    waitForUnpause()
end

local function putToolsAway()
    for i, part in player.Character:GetChildren() do
        if part:IsA("Tool") then
            part.Parent = player.Backpack
        end
    end
end

local function getBrainrot(rot)
    local brainrotMesh = rot:WaitForChild("Mesh", 3)
    if not brainrotMesh then return end

    local proximityPrompt = brainrotMesh:FindFirstChildWhichIsA("ProximityPrompt")
    if not proximityPrompt then return end

    teleportTo(rot.WorldPivot)
    fireproximityprompt(proximityPrompt)

    task.wait()

    teleportTo(worldPositions.spawn)

    task.wait()

    putToolsAway()

    return true
end

local function doFarm(rotContainer)
    for i, v in rotContainer:GetChildren() do
        if getBrainrot(v) then
            teleportTo(worldPositions.cosmic)
        end
    end
end

task.spawn(function()
    while task.wait() do
        if _G._BR_FARMING == false then continue end
        local cosmics = getSpawnData("Cosmic")
        if cosmics == nil then
            teleportTo(worldPositions.cosmic)
            continue
        end
        doFarm(cosmics)
    end
end)

TOGGLES[84332574190497] = {
    {label="Farming", callback=function(on)
        _G._BR_FARMING = on
    end, cleanup=function() _G._BR_FARMING = false end},

    {label="Teleport to spawn", isButton=true, callback=function()
        teleportTo(worldPositions.spawn)
    end}
}

print("[FlixHub] Game 84332574190497 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end