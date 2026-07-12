local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer

local remote = nil
pcall(function()
	remote = RS:WaitForChild("Packets"):WaitForChild("Packet"):WaitForChild("RemoteEvent", 5)
end)

local function firePacket(bufStr)
	if remote then
		pcall(function() remote:FireServer(table.unpack({ buffer.fromstring(bufStr) })) end)
	end
end

local function countTool(name)
	local n = 0
	local bp = LP:FindFirstChild("Backpack")
	local ch = LP.Character
	local function scan(inst)
		if not inst then return end
		for _, v in pairs(inst:GetChildren()) do
			if v:IsA("Tool") and v.Name == name then n = n + 1 end
		end
	end
	scan(bp); scan(ch)
	return n
end

local function equipAndUse(itemName)
	local bp = LP:FindFirstChild("Backpack")
	local ch = LP.Character
	local hum = ch and ch:FindFirstChildOfClass("Humanoid")
	if not hum then return false end
	local tool = (bp and bp:FindFirstChild(itemName)) or (ch and ch:FindFirstChild(itemName))
	if not tool or not tool:IsA("Tool") then return false end
	pcall(function() hum:EquipTool(tool) end)
	task.wait(0.05)
	pcall(function() tool:Activate() end)
	return true
end

local FOOD_NAMES = {
	"Lettuce", "Glazed Donut", "Hot Sauce", "Cola",
	"Banana", "Milk", "Golden Apple", "Energy Drink", "Pizza",
}
local FOOD_BUFS = {
	"\n\v\aLettuce\000", "\n\v\fGlazed Donut\000", "\n\v\tHot Sauce\000",
	"\n\v\004Cola\000", "\n\v\006Banana\000", "\n\v\004Milk\000",
	"\n\v\fGolden Apple\000", "\n\v\fEnergy Drink\000", "\n\v\005Pizza\000",
}

F.GAME_TOGGLES[85050171250159] = {
	{
		label = "Auto Poop",
		callback = function(on)
			if on then
				_G.FLIX_POOP = true
				return task.spawn(function()
					while task.wait(0.6) do
						if not _G.FLIX_POOP then break end
						firePacket("\000\000\000\000")
					end
				end)
			else
				_G.FLIX_POOP = false
			end
		end,
		cleanup = function() _G.FLIX_POOP = false end,
	},
	{
		label = "Auto Sell",
		callback = function(on)
			if on then
				_G.FLIX_SELL = true
				return task.spawn(function()
					while task.wait(0.4) do
						if not _G.FLIX_SELL then break end
						firePacket("\003\000")
					end
				end)
			else
				_G.FLIX_SELL = false
			end
		end,
		cleanup = function() _G.FLIX_SELL = false end,
	},
	{
		label = "Auto Buy Food",
		callback = function(on)
			if on then
				_G.FLIX_BUYFOOD = true
				return task.spawn(function()
					while task.wait(10) do
						if not _G.FLIX_BUYFOOD then break end
						for _, buf in ipairs(FOOD_BUFS) do
							if not _G.FLIX_BUYFOOD then break end
							firePacket(buf)
							task.wait(0.3)
						end
					end
				end)
			else
				_G.FLIX_BUYFOOD = false
			end
		end,
		cleanup = function() _G.FLIX_BUYFOOD = false end,
	},
	{
		label = "Auto Use Food",
		callback = function(on)
			if on then
				_G.FLIX_USEFOOD = true
				return task.spawn(function()
					while task.wait(1) do
						if not _G.FLIX_USEFOOD then break end
						for _, name in ipairs(FOOD_NAMES) do
							if not _G.FLIX_USEFOOD then break end
							if countTool(name) >= 1 then
								equipAndUse(name)
								task.wait(0.3)
							end
						end
					end
				end)
			else
				_G.FLIX_USEFOOD = false
			end
		end,
		cleanup = function() _G.FLIX_USEFOOD = false end,
	},
	{
		label = "Instant Prompts",
		callback = function(on)
			if on then
				_G.FLIX_INSTPP = true
				for _, desc in pairs(workspace:GetDescendants()) do
					if desc:IsA("ProximityPrompt") then
						pcall(function()
							desc.HoldDuration = 0
							desc.MaxActivationDistance = 100
						end)
					end
				end
				_G.FLIX_INSTPP_CONN = workspace.DescendantAdded:Connect(function(d)
					if d:IsA("ProximityPrompt") and _G.FLIX_INSTPP then
						pcall(function()
							d.HoldDuration = 0
							d.MaxActivationDistance = 100
						end)
					end
				end)
				return nil
			else
				_G.FLIX_INSTPP = false
				if _G.FLIX_INSTPP_CONN then
					_G.FLIX_INSTPP_CONN:Disconnect()
					_G.FLIX_INSTPP_CONN = nil
				end
			end
		end,
		cleanup = function()
			_G.FLIX_INSTPP = false
			if _G.FLIX_INSTPP_CONN then
				_G.FLIX_INSTPP_CONN:Disconnect()
				_G.FLIX_INSTPP_CONN = nil
			end
		end,
	},
}

print("[FlixHub] Poop toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end
