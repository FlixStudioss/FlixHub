local F = _G.FlixHub
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer
local TOGGLES = F.GAME_TOGGLES

local function makeESP(part, text, color, tagName)
	if not part or not part.Parent then return end
	local bbg = Instance.new("BillboardGui")
	bbg.Name = tagName
	bbg.Size = UDim2.new(0, 140, 0, 24)
	bbg.StudsOffset = Vector3.new(0, 3, 0)
	bbg.AlwaysOnTop = true
	bbg.LightInfluence = 0
	bbg.Adornee = part
	bbg.Parent = part
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 1, 0)
	lbl.BackgroundTransparency = 0.5
	lbl.BackgroundColor3 = Color3.new(0, 0, 0)
	lbl.Text = text
	lbl.TextColor3 = color or Color3.new(1, 1, 1)
	lbl.TextScaled = true
	lbl.Font = Enum.Font.GothamBold
	lbl.Parent = bbg
	return bbg
end

local function clearESP(tag)
	for _, desc in pairs(workspace:GetDescendants()) do
		if desc:IsA("BillboardGui") and desc.Name == tag then
			desc:Destroy()
		end
	end
end

local function isMonster(npc)
	local name = npc.Name:lower()
	if npc:HasTag("GhostAnomaly") or name:find("ghost") then return true end
	if npc:HasTag("AnomalyShadow") or name:find("shadow") then return true end
	if name:find("stalker") then return true end
	if name:find("tallmonster") then return true end
	if name:find("monsterbed") then return true end
	if npc:HasTag("Skinwalker") or name:find("skinwalker") then return true end
	for _, child in pairs(npc:GetDescendants()) do
		if child:IsA("Model") and child.Name == "Skinwalker" then return true end
	end
	if npc:HasTag("Anomaly") then return true end
	return false
end

TOGGLES[104522435597696] = {
	{label="Infinite Sanity", callback=function(on)
		if not on then return end
		local Library = require(RS:WaitForChild("Lib"))
		local function keepSanityFull()
			pcall(function() LP:SetAttribute("Sanity", 100) end)
		end
		Library.Inject("PlayerLostSanity", keepSanityFull)
		LP:GetAttributeChangedSignal("Sanity"):Connect(keepSanityFull)
		local conn = RunService.Heartbeat:Connect(keepSanityFull)
		keepSanityFull()
		return conn
	end, cleanup=function() end},

	{label="ESP", expandSection="esp", isButton=true},

	{label="Players", section="esp", callback=function(on)
		_G._AH_ESP_PLAYERS = on
		if not on then
			clearESP("FlixESP_Players")
			return
		end
		return task.spawn(function()
			while _G._AH_ESP_PLAYERS do
				pcall(function()
					for _, plr in pairs(Players:GetPlayers()) do
						if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
							local hrp = plr.Character.HumanoidRootPart
							if not hrp:FindFirstChild("FlixESP_Players") then
								local dist = math.floor((LP.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
								makeESP(hrp, plr.Name .. " [" .. dist .. "m]", Color3.fromRGB(99, 102, 241), "FlixESP_Players")
							end
						end
					end
				end)
				task.wait(1)
			end
		end)
	end, cleanup=function() _G._AH_ESP_PLAYERS = false; clearESP("FlixESP_Players") end},

	{label="Anomalies", section="esp", callback=function(on)
		_G._AH_ESP_ANOMALIES = on
		if not on then
			clearESP("FlixESP_Anomalies")
			return
		end
		return task.spawn(function()
			while _G._AH_ESP_ANOMALIES do
				pcall(function()
					for _, npc in pairs(CollectionService:GetTagged("NPC")) do
						if npc:IsA("Model") and npc.Parent and isMonster(npc) then
							local hrp = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChildWhichIsA("BasePart")
							if hrp and not hrp:FindFirstChild("FlixESP_Anomalies") then
								makeESP(hrp, "Anomaly", Color3.fromRGB(255, 50, 50), "FlixESP_Anomalies")
							end
						end
					end
				end)
				task.wait(1)
			end
		end)
	end, cleanup=function() _G._AH_ESP_ANOMALIES = false; clearESP("FlixESP_Anomalies") end},

	{label="NPCs", section="esp", callback=function(on)
		_G._AH_ESP_NPCS = on
		if not on then
			clearESP("FlixESP_NPCs")
			return
		end
		return task.spawn(function()
			while _G._AH_ESP_NPCS do
				pcall(function()
					for _, npc in pairs(CollectionService:GetTagged("NPC")) do
						if npc:IsA("Model") and npc.Parent and not isMonster(npc) then
							local hrp = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChildWhichIsA("BasePart")
							if hrp and not hrp:FindFirstChild("FlixESP_NPCs") then
								makeESP(hrp, "Normal", Color3.fromRGB(72, 199, 116), "FlixESP_NPCs")
							end
						end
					end
				end)
				task.wait(2)
			end
		end)
	end, cleanup=function() _G._AH_ESP_NPCS = false; clearESP("FlixESP_NPCs") end},

	{label="Monsters", expandSection="monsters", isButton=true},

	{label="Eye", section="monsters", callback=function(on)
		_G._AH_MONSTER_EYE = on
		if not on then clearESP("FlixESP_Eye"); return end
		return task.spawn(function()
			while _G._AH_MONSTER_EYE do
				pcall(function()
					for _, npc in pairs(CollectionService:GetTagged("NPC")) do
						if npc:IsA("Model") and npc.Parent then
							if npc.Name:lower():find("stalker") then
								local hrp = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChildWhichIsA("BasePart")
								if hrp and not hrp:FindFirstChild("FlixESP_Eye") then
									makeESP(hrp, "Eye", Color3.fromRGB(255, 0, 80), "FlixESP_Eye")
								end
							end
						end
					end
				end)
				task.wait(1)
			end
		end)
	end, cleanup=function() _G._AH_MONSTER_EYE = false; clearESP("FlixESP_Eye") end},

	{label="Mask", section="monsters", callback=function(on)
		_G._AH_MONSTER_MASK = on
		if not on then clearESP("FlixESP_Mask"); return end
		return task.spawn(function()
			while _G._AH_MONSTER_MASK do
				pcall(function()
					for _, npc in pairs(CollectionService:GetTagged("NPC")) do
						if npc:IsA("Model") and npc.Parent then
							if npc:HasTag("AnomalyShadow") or npc.Name:lower():find("shadow") then
								local hrp = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChildWhichIsA("BasePart")
								if hrp and not hrp:FindFirstChild("FlixESP_Mask") then
									makeESP(hrp, "Mask", Color3.fromRGB(120, 0, 200), "FlixESP_Mask")
								end
							end
						end
					end
				end)
				task.wait(1)
			end
		end)
	end, cleanup=function() _G._AH_MONSTER_MASK = false; clearESP("FlixESP_Mask") end},

	{label="Ghost", section="monsters", callback=function(on)
		_G._AH_MONSTER_GHOST = on
		if not on then clearESP("FlixESP_Ghost"); return end
		return task.spawn(function()
			while _G._AH_MONSTER_GHOST do
				pcall(function()
					for _, npc in pairs(CollectionService:GetTagged("NPC")) do
						if npc:IsA("Model") and npc.Parent then
							if npc:HasTag("GhostAnomaly") or npc.Name:lower():find("ghost") then
								local hrp = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChildWhichIsA("BasePart")
								if hrp and not hrp:FindFirstChild("FlixESP_Ghost") then
									makeESP(hrp, "Ghost", Color3.fromRGB(200, 200, 255), "FlixESP_Ghost")
								end
							end
						end
					end
				end)
				task.wait(1)
			end
		end)
	end, cleanup=function() _G._AH_MONSTER_GHOST = false; clearESP("FlixESP_Ghost") end},
}

print("[FlixHub] Game 104522435597696 toggles loaded")

if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end
