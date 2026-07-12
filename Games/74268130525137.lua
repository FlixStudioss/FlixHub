local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer

F.GAME_TOGGLES[74268130525137] = {
	{
		label = "TP to PowerUp",
		isButton = true,
		callback = function()
			local char = LP.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			if root then
				local folder = workspace:FindFirstChild("PowerUps")
				if folder then
					for _, child in ipairs(folder:GetChildren()) do
						if child:IsA("Model") and (child.Name:find("x3") or child.Name:find("Power") or child.Name:find("x2")) then
							root.CFrame = child:GetPivot() * CFrame.new(0, 8, 0)
							break
						end
					end
				end
			end
		end,
	},
	{
		label = "Invisible",
		callback = function(on)
			if on then
				_G.FLIX_STEAL_INVIS = true
				_G._STEAL_INVIS_PARTS = {}
				local char = LP.Character
				if char then
					for _, v in ipairs(char:GetDescendants()) do
						if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
							table.insert(_G._STEAL_INVIS_PARTS, v)
							v.Transparency = 1
						elseif v:IsA("Decal") then
							v.Transparency = 1
						end
					end
				end
				return nil
			else
				_G.FLIX_STEAL_INVIS = false
				if _G._STEAL_INVIS_PARTS then
					for _, v in ipairs(_G._STEAL_INVIS_PARTS) do
						if v and v.Parent then v.Transparency = 0 end
					end
					_G._STEAL_INVIS_PARTS = {}
				end
			end
		end,
		cleanup = function()
			_G.FLIX_STEAL_INVIS = false
			if _G._STEAL_INVIS_PARTS then
				for _, v in ipairs(_G._STEAL_INVIS_PARTS) do
					if v and v.Parent then v.Transparency = 0 end
				end
				_G._STEAL_INVIS_PARTS = {}
			end
		end,
	},
	{
		label = "WalkSpeed Lock",
		callback = function(on)
			if on then
				_G.FLIX_STEAL_WS = true
				_G._STEAL_WS_VAL = 30
				if _G._STEAL_WS_CONN then _G._STEAL_WS_CONN:Disconnect() end
				_G._STEAL_WS_CONN = game:GetService("RunService").Heartbeat:Connect(function()
					if not _G.FLIX_STEAL_WS then return end
					local char = LP.Character
					if char then
						local hum = char:FindFirstChild("Humanoid")
						if hum then hum.WalkSpeed = _G._STEAL_WS_VAL end
					end
				end)
				return nil
			else
				_G.FLIX_STEAL_WS = false
				if _G._STEAL_WS_CONN then _G._STEAL_WS_CONN:Disconnect() _G._STEAL_WS_CONN = nil end
			end
		end,
		cleanup = function()
			_G.FLIX_STEAL_WS = false
			if _G._STEAL_WS_CONN then _G._STEAL_WS_CONN:Disconnect() _G._STEAL_WS_CONN = nil end
		end,
	},
	{
		label = "Extend Safe Zone",
		isButton = true,
		callback = function()
			local folder = workspace:FindFirstChild("Safe Zones")
			if folder then
				local mainPart = folder:FindFirstChild("Main")
				if mainPart and mainPart:IsA("BasePart") then
					mainPart.Size = Vector3.new(mainPart.Size.X * 2, mainPart.Size.Y, mainPart.Size.Z * 2)
				end
			end
		end,
	},
	{
		label = "Kill Aura",
		callback = function(on)
			if on then
				_G.FLIX_STEAL_KILLAURA = true
				_G._STEAL_KILLAURA_CONN = game:GetService("RunService").Heartbeat:Connect(function()
					if not _G.FLIX_STEAL_KILLAURA then return end
					local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
					if not myRoot then return end
					for _, plr in ipairs(game.Players:GetPlayers()) do
						if plr ~= LP and plr.Character then
							local theirRoot = plr.Character:FindFirstChild("HumanoidRootPart")
							if theirRoot then
								local dist = (theirRoot.Position - myRoot.Position).Magnitude
								if dist < 25 and dist > 5 then
									myRoot.CFrame = theirRoot.CFrame * CFrame.new(0, 5, 0)
									break
								end
							end
						end
					end
				end)
				return nil
			else
				_G.FLIX_STEAL_KILLAURA = false
				if _G._STEAL_KILLAURA_CONN then _G._STEAL_KILLAURA_CONN:Disconnect() _G._STEAL_KILLAURA_CONN = nil end
			end
		end,
		cleanup = function()
			_G.FLIX_STEAL_KILLAURA = false
			if _G._STEAL_KILLAURA_CONN then _G._STEAL_KILLAURA_CONN:Disconnect() _G._STEAL_KILLAURA_CONN = nil end
		end,
	},
	{
		label = "Fake Lag",
		callback = function(on)
			if on then
				_G.FLIX_STEAL_FAKELAG = true
				_G._STEAL_FAKELAG_CONN = game:GetService("RunService").Heartbeat:Connect(function()
					if not _G.FLIX_STEAL_FAKELAG then return end
					local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
					if root then
						root.AssemblyLinearVelocity = Vector3.new(math.random(-12, 12), 0, math.random(-12, 12))
					end
				end)
				return nil
			else
				_G.FLIX_STEAL_FAKELAG = false
				if _G._STEAL_FAKELAG_CONN then _G._STEAL_FAKELAG_CONN:Disconnect() _G._STEAL_FAKELAG_CONN = nil end
			end
		end,
		cleanup = function()
			_G.FLIX_STEAL_FAKELAG = false
			if _G._STEAL_FAKELAG_CONN then _G._STEAL_FAKELAG_CONN:Disconnect() _G._STEAL_FAKELAG_CONN = nil end
		end,
	},
	{
		label = "Damage Multiplier (2x)",
		isButton = true,
		callback = function()
			_G._STEAL_DMG_MULT = 2
			if not _G._STEAL_DMG_HOOKED then
				_G._STEAL_DMG_HOOKED = true
				game.Players.PlayerAdded:Connect(function(plr)
					plr.CharacterAdded:Connect(function(char)
						local hum = char:WaitForChild("Humanoid", 3)
						if hum then
							local oldTake = hum.TakeDamage
							hum.TakeDamage = function(self, amount)
								oldTake(self, amount * (_G._STEAL_DMG_MULT or 2))
							end
						end
					end)
				end)
				for _, plr in ipairs(game.Players:GetPlayers()) do
					if plr ~= LP then
						plr.CharacterAdded:Connect(function(char)
							local hum = char:WaitForChild("Humanoid", 3)
							if hum then
								local oldTake = hum.TakeDamage
								hum.TakeDamage = function(self, amount)
									oldTake(self, amount * (_G._STEAL_DMG_MULT or 2))
								end
							end
						end)
					end
				end
			end
		end,
	},
}

print("[FlixHub] Steal FPS toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end
