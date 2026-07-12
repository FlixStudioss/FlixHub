local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- smash crate for brainrots

local plr = game:GetService("Players").LocalPlayer

local visualCrates = workspace.Crates
local serverCrates = workspace.ServerInfo
local brainrotsFold = workspace.Brainrots

_G._BR_FARMING = false
_G._BR_CRATERARITY = "common"

local function parseSuffixedNumber(str)
    str = str:gsub("[%$,%s]", "")
    local numberPart, suffixPart = str:match("^(-?%d*%.?%d+)(%a*)$")
    local base = tonumber(numberPart)
    if suffixPart == "" then return base end
    local suffixes = {
        K=1e3, M=1e6, B=1e9, T=1e12, Qd=1e15, Qn=1e18, Sx=1e21, Sp=1e24,
        Oc=1e27, No=1e30, De=1e33
    }
    local multiplier = suffixes[suffixPart]
    return base * (multiplier or 1)
end

TOGGLES[100964511576728] = {
    {label="Farm Brainrots", callback=function(on)
        _G._BR_FARMING = on
        if not on then return end

        while _G._BR_FARMING do
            pcall(function()
                for i, v in pairs(visualCrates:GetChildren()) do
                    if v:GetAttribute("Rarity"):lower() == _G._BR_CRATERARITY then
                        plr.Character:MoveTo(v.PrimaryPart.Position + Vector3.new(0, 4, 0))
                        local crateServer = serverCrates["1"].Crates:FindFirstChild(v.Name)
                        if crateServer then
                            for i, v in pairs(plr.Backpack:GetChildren()) do
                                if v:GetAttribute("Cooldown") ~= nil then
                                    plr.Character.Humanoid:EquipTool(v)
                                end
                            end

                            task.wait()
                            local Event = game:GetService("ReplicatedStorage").Remotes.HammerActivated
                            repeat
                                Event:FireServer(crateServer)
                                task.wait()
                            until not v or v.Parent ~= visualCrates
                            task.wait(0.5)
                            firetouchinterest(plr.Character.Head, workspace.Scripted.EnterSpawnTouch, true)
                            task.wait()
                            firetouchinterest(plr.Character.Head, workspace.Scripted.EnterSpawnTouch, false)
                            task.wait(1)
                            plr.Character.Humanoid:UnequipTools()
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end, cleanup=function() _G._BR_FARMING = false end}
}

print("[FlixHub] Game 100964511576728 toggles loaded")

if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end