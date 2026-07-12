-- Brainrot Police game toggle configs
-- Loaded by script_hub.lua for all brainrot games

return function(TOGGLES, RS, LP, firetouchinterest, fireproximityprompt)

local function getRemote(path)
	local obj = RS
	for _, name in ipairs(path) do
		obj = obj:WaitForChild(name, 5)
		if not obj then return nil end
	end
	return obj
end

-- 100070667273689 - Survive Flood for Brainrots
TOGGLES[100070667273689] = {
	{
		label = "Farm Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(1) do
						if not _G._BR_FARM then break end
						pcall(function()
							local folder = workspace.GameFolder.Brainrots
							local char = LP.Character
							for _, rarity in ipairs({"Infinity","Godly","Secret","Celestial"}) do
								local sub = folder:FindFirstChild(rarity)
								if sub then
									for _, br in pairs(sub:GetChildren()) do
										if not _G._BR_FARM then break end
										if br.PrimaryPart then
											char:MoveTo(br.PrimaryPart.Position)
											task.wait(0.5)
											fireproximityprompt(br.PrimaryPart.ProximityPrompt)
											task.wait(0.25)
											char:MoveTo(Vector3.new(-2, 4, 13))
											task.wait(0.5)
										end
									end
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 100964511576728 - Smash Crate for Brainrots
TOGGLES[100964511576728] = {
	{
		label = "Farm Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							local plr = LP
							local char = plr.Character
							for _, crate in pairs(workspace.Crates:GetChildren()) do
								if crate:GetAttribute("Rarity") and crate:GetAttribute("Rarity"):lower() == "common" then
									if crate.PrimaryPart then
										char:MoveTo(crate.PrimaryPart.Position + Vector3.new(0, 4, 0))
										local crateServer = workspace.ServerInfo["1"].Crates:FindFirstChild(crate.Name)
										if crateServer then
											for _, v in pairs(plr.Backpack:GetChildren()) do
												if v:GetAttribute("Cooldown") ~= nil then
													char.Humanoid:EquipTool(v)
												end
											end
											task.wait()
											local Event = RS.Remotes.HammerActivated
											Event:FireServer(crateServer)
											task.wait(0.5)
											firetouchinterest(char.Head, workspace.Scripted.EnterSpawnTouch, true)
											task.wait()
											firetouchinterest(char.Head, workspace.Scripted.EnterSpawnTouch, false)
											task.wait(1)
											char.Humanoid:UnequipTools()
										end
									end
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 105215477731035 - Pole Obby for Brainrots
TOGGLES[105215477731035] = {
	{
		label = "Farm Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							for _, v in pairs(workspace.Mobs:GetChildren()) do
								if v.PrimaryPart then
									local Rarity = v.PrimaryPart.OverheadAttach.AnimalOverhead.Rarity.Text
									if Rarity == "OG" or Rarity == "Admin" then
										char:MoveTo(v.PrimaryPart.Position)
										repeat fireproximityprompt(v.PrimaryPart.ProximityPrompt) task.wait() until not v or not v.PrimaryPart or v.PrimaryPart:FindFirstChild("MobCarryWeld")
										local Event = RS.Packages.Net["RE/SafeZoneEvent"]
										Event:FireServer()
										task.wait(0.1)
									end
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 106772177198260 - Reel for Brainrots
TOGGLES[106772177198260] = {
	{
		label = "Farming",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							RS.RemoteHandler.Fishing:FireServer("Caught", 3)
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
	{
		label = "Dupe Brainrot InHand",
		isButton = true,
		callback = function()
			pcall(function()
				local char = LP.Character
				local br = char:FindFirstChildOfClass("Tool")
				if br and br:GetAttribute("brainrot") then
					for plotNum = 1, 30 do
						RS.RemoteHandler.Plot:FireServer("Add", "Plot" .. plotNum, br.Name)
						task.wait(0.5)
					end
				end
			end)
		end,
	},
}

-- 108207853263201 - Rizz Tower
TOGGLES[108207853263201] = {
	{
		label = "Win Farm",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							LP.Character:MoveTo(Vector3.new(1, 477, -315))
							task.wait()
							firetouchinterest(LP.Character.Head, workspace.TeleportWin.Reward, true)
							task.wait()
							firetouchinterest(LP.Character.Head, workspace.TeleportWin.Reward, false)
							task.wait()
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 109908567838703 - Nuke for Brainrots
TOGGLES[109908567838703] = {
	{
		label = "Auto Money",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				local Event = RS.ModifiedPackages.Packet.RemoteEvent
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function() Event:FireServer(buffer.fromstring("\x0E")) end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
	{
		label = "Auto Rebirth",
		callback = function(on)
			if on then
				_G._BR_REBIRTH = true
				local Event = RS.ModifiedPackages.Packet.RemoteEvent
				return task.spawn(function()
					while task.wait(1) do
						if not _G._BR_REBIRTH then break end
						pcall(function() Event:FireServer(buffer.fromstring("\x93")) end)
					end
				end)
			else
				_G._BR_REBIRTH = false
			end
		end,
		cleanup = function() _G._BR_REBIRTH = false end,
	},
}

-- 110373292461174 - Paper Plane for Brainrot
TOGGLES[110373292461174] = {
	{
		label = "Farm Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(1) do
						if not _G._BR_FARM then break end
						pcall(function()
							RS.SharedModules.Network.RequestPendingFlight:FireServer()
							task.wait(1)
							local GameCore = require(RS.GameCore)
							RS.SharedModules.Network.RequestActiveFlight:InvokeServer({
								plotIndex = 3, intensity = 1, player = LP,
								flightUID = require(RS.UtilityCore).StringUtility.GenerateUID(),
								serverFloors = 10000000,
								visualStartPos = Vector3.new(-347.21, 89.04, 25.89),
								startTime = GameCore.GetSycnedTime(),
								startPos = Vector3.new(-347.21, 85.05, 25.89),
								serverStrength = 10000000,
							})
							task.wait(15)
							RS.SharedModules.Network.ClaimFlight:InvokeServer("uid")
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
	{
		label = "Farm Strength",
		callback = function(on)
			if on then
				_G._BR_STRENGTH = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_STRENGTH then break end
						pcall(function()
							RS.SharedModules.Network.RequestStrength:InvokeServer()
							RS.SharedModules.Network.RequestDoubleStrength:InvokeServer()
						end)
					end
				end)
			else
				_G._BR_STRENGTH = false
			end
		end,
		cleanup = function() _G._BR_STRENGTH = false end,
	},
}

-- 110627433764494 - Fake a Brainrot
TOGGLES[110627433764494] = {
	{
		label = "Farm Stealing",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.5) do
						if not _G._BR_FARM then break end
						pcall(function()
							RS.Events.FakeSystem_StartFake:FireServer("Tim Cheese")
							task.wait(3)
							local plots = workspace.Plots
							for _, v in pairs(plots:GetChildren()) do
								for _, br in pairs(v.Slots:GetChildren()) do
									if br:FindFirstChild("PlacedBrainrot") and br.PlacedBrainrot.PrimaryPart then
										LP.Character:MoveTo(br.PlacedBrainrot.PrimaryPart.Position)
										repeat fireproximityprompt(br.StealPrompt) task.wait() until not br.StealPrompt.Enabled
										LP.Character:MoveTo(v.CollectAllZone.Position)
										task.wait(1)
									end
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 112500097711893 - Lick a Brainrot
TOGGLES[112500097711893] = {
	{
		label = "Farm Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							RS.Remotes.OnCast:InvokeServer(1)
							RS.Remotes.StartRun:InvokeServer()
							RS.Remotes.FinishRun:InvokeServer(true)
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
	{
		label = "Farm Strength",
		callback = function(on)
			if on then
				_G._BR_STRENGTH = true
				return task.spawn(function()
					while task.wait(1) do
						if not _G._BR_STRENGTH then break end
						pcall(function()
							local gym = LP.Backpack:FindFirstChild("Gym")
							if gym then LP.Character.Humanoid:EquipTool(gym) end
							RS.Remotes.doubleStrength:FireServer()
						end)
					end
				end)
			else
				_G._BR_STRENGTH = false
			end
		end,
		cleanup = function() _G._BR_STRENGTH = false end,
	},
}

-- 114640202062357 - Swing Obby for Brainrots
TOGGLES[114640202062357] = {
	{
		label = "Autofarm",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				pcall(function() RS.Packages.Knit.Services.GameplayService.RF.ReturnToPlot:InvokeServer() end)
				task.wait()
				return task.spawn(function()
					while task.wait(1) do
						if not _G._BR_FARM then break end
						pcall(function()
							for _, v in pairs(workspace.ActiveBrainrots:GetChildren()) do
								if v:GetAttribute("Zone") == 14 or v:GetAttribute("Zone") == 13 then
									LP.Character:PivotTo(v.CFrame)
									repeat fireproximityprompt(v.Attachment.ProximityPrompt) task.wait() until not v or v.Parent ~= workspace.ActiveBrainrots
									task.wait()
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 135882949571046 - Dream for Brainrots
TOGGLES[135882949571046] = {
	{
		label = "Farming",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							RS.Remotes.DreamStateChanged:FireServer(true)
							RS.Remotes.RequestDreamBrainrots:FireServer()
							RS.Remotes.PickupDreamBrainrot:FireServer("60")
							task.wait()
							RS.Remotes.RequestDreamWallExit:FireServer()
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 136919941417380 - Bike Obby for Brainrots
TOGGLES[136919941417380] = {
	{
		label = "Farm Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							for zone, pos in ipairs({Vector3.new(-3394,1450,7887), Vector3.new(-3394,1450,6269), Vector3.new(-3394,1450,4732)}) do
								for _, v in pairs(workspace.ItemSpawns:WaitForChild(tostring(11 - zone)):GetChildren()) do
									if v:IsA("Model") and v.PrimaryPart then
										char:MoveTo(v.PrimaryPart.Position)
										repeat fireproximityprompt(v.PrimaryPart.ProximityPrompt) task.wait() until not v or v.Parent ~= workspace.ItemSpawns:WaitForChild(tostring(11 - zone))
										local br = char:WaitForChild("StackItem", 3)
										char:MoveTo(workspace.Zones.BikeSpawn.Position)
										if br then repeat task.wait() until not br or br.Parent ~= char end
										task.wait(0.1)
									end
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
	{
		label = "Auto Equip Best",
		callback = function(on)
			if on then
				_G._BR_EQUIP = true
				return task.spawn(function()
					while task.wait(5) do
						if not _G._BR_EQUIP then break end
						pcall(function() RS.Events.PlaceBestBrainrots:FireServer() end)
					end
				end)
			else
				_G._BR_EQUIP = false
			end
		end,
		cleanup = function() _G._BR_EQUIP = false end,
	},
}

-- 137069154816703 - Hack Vault for Brainrots
TOGGLES[137069154816703] = {
	{
		label = "Farm Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							for _, br in pairs(workspace.EntitiesFolder:GetChildren()) do
								if br:GetAttribute("SpawnZone") == 22 and br.PrimaryPart then
									char:MoveTo(br.PrimaryPart.Position)
									task.wait()
									repeat fireproximityprompt(br.PrimaryPart.TakeBrainrotPrompt) task.wait() until not br.PrimaryPart or br.PrimaryPart:FindFirstChild("Attachment")
									char:MoveTo(Vector3.new(77, 4, -729))
									task.wait(1)
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 137233438285284 - Chicken Farm
TOGGLES[137233438285284] = {
	{
		label = "Autofarm",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				local mainEvent = RS.Paper.Remotes.__remoteevent
				local mainFunction = RS.Paper.Remotes.__remotefunction
				return task.spawn(function()
					for _, v in pairs(workspace.Eggs:GetChildren()) do
						mainEvent:FireServer("Collect Egg", v.Name)
						task.wait()
						v:Destroy()
					end
					task.wait()
					mainFunction:InvokeServer("Deposit Eggs")
					while task.wait(1) do
						if not _G._BR_FARM then break end
						pcall(function()
							mainFunction:InvokeServer("Collect Cash")
							task.wait()
							mainFunction:InvokeServer("Upgrade Process Level")
							task.wait()
							mainFunction:InvokeServer("Buy Chickens", 1)
							task.wait()
							mainFunction:InvokeServer("Merge Chickens")
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 71213902019049 - Cross Rivers for Brainrots
TOGGLES[71213902019049] = {
	{
		label = "Farm Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(1) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							for _, v in pairs(workspace.SpawnedBrainrots:GetChildren()) do
								if v:GetAttribute("_ZoneIndex") == 10 and v.PrimaryPart then
									local prompt = v.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")
									if prompt then
										char:MoveTo(v.PrimaryPart.Position)
										repeat fireproximityprompt(prompt) task.wait() until not prompt or prompt.Parent ~= v.PrimaryPart
										task.wait(0.5)
										firetouchinterest(char.Head, workspace.MainGame.Map.Model.CrossWall, true)
										task.wait()
										firetouchinterest(char.Head, workspace.MainGame.Map.Model.CrossWall, false)
										task.wait(0.5)
									end
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
	{
		label = "Auto Upgrade",
		callback = function(on)
			if on then
				_G._BR_UPGRADE = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_UPGRADE then break end
						pcall(function()
							for i = 1, 30 do
								RS.Packages.Knit.Services.PadService.RF.UpgradePad:InvokeServer(tostring(i))
							end
						end)
					end
				end)
			else
				_G._BR_UPGRADE = false
			end
		end,
		cleanup = function() _G._BR_UPGRADE = false end,
	},
	{
		label = "Auto Collect",
		callback = function(on)
			if on then
				_G._BR_COLLECT = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_COLLECT then break end
						pcall(function()
							local char = LP.Character
							for _, plrPlot in pairs(workspace.MainGame.Plots:GetChildren()) do
								for _, pad in pairs(plrPlot.Pads:GetChildren()) do
									firetouchinterest(char.Head, pad.CollectPart, true)
									task.wait()
									firetouchinterest(char.Head, pad.CollectPart, false)
								end
							end
						end)
					end
				end)
			else
				_G._BR_COLLECT = false
			end
		end,
		cleanup = function() _G._BR_COLLECT = false end,
	},
}

-- 74277864669743 - Fly for Brainrots
TOGGLES[74277864669743] = {
	{
		label = "Farm Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							for _, v in pairs(workspace.Brainrots:GetChildren()) do
								if v:GetAttribute("Rarity") == "ADMIN" or v:GetAttribute("Rarity") == "Lucky" or v:GetAttribute("Rarity") == "Ascendant" or v:GetAttribute("Rarity") == "Transcendent" or v:GetAttribute("Rarity") == "OG" then
									if v.PrimaryPart then
										local meshPart = v:FindFirstChildOfClass("Model"):FindFirstChildOfClass("MeshPart")
										if meshPart then
											local pp = meshPart:FindFirstChildOfClass("ProximityPrompt")
											if pp then
												char:MoveTo(v.PrimaryPart.Position)
												repeat fireproximityprompt(pp) task.wait() until not v or v.Parent ~= workspace.Brainrots
												task.wait()
												char:MoveTo(Vector3.new(7, 10, 44))
												task.wait(0.25)
											end
										end
									end
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
	{
		label = "Auto Buy Speed",
		callback = function(on)
			if on then
				_G._BR_SPEED = true
				local Event = RS.Libraries.Packet.RemoteEvent
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_SPEED then break end
						pcall(function() Event:FireServer(buffer.fromstring("\x15\x01")) end)
					end
				end)
			else
				_G._BR_SPEED = false
			end
		end,
		cleanup = function() _G._BR_SPEED = false end,
	},
	{
		label = "Auto Equip Best",
		callback = function(on)
			if on then
				_G._BR_EQUIP = true
				local Event = RS.Libraries.Packet.RemoteEvent
				return task.spawn(function()
					while task.wait(1) do
						if not _G._BR_EQUIP then break end
						pcall(function() Event:FireServer(buffer.fromstring("\x0E")) end)
					end
				end)
			else
				_G._BR_EQUIP = false
			end
		end,
		cleanup = function() _G._BR_EQUIP = false end,
	},
	{
		label = "Auto Collect",
		callback = function(on)
			if on then
				_G._BR_COLLECT = true
				return task.spawn(function()
					while task.wait(2) do
						if not _G._BR_COLLECT then break end
						pcall(function()
							local char = LP.Character
							for _, plot in pairs(workspace.Plots:GetChildren()) do
								if plot:GetAttribute("Owner") == LP.UserId then
									for _, pod in pairs(plot.Podiums:GetChildren()) do
										if pod:FindFirstChild("Collect") then
											firetouchinterest(char.Head, pod.Collect, true)
											task.wait()
											firetouchinterest(char.Head, pod.Collect, false)
										end
									end
								end
							end
						end)
					end
				end)
			else
				_G._BR_COLLECT = false
			end
		end,
		cleanup = function() _G._BR_COLLECT = false end,
	},
}

-- 77862067599263 - Obby as a Brainrot
TOGGLES[77862067599263] = {
	{
		label = "Farm Disco Meowl",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.5) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							char:MoveTo(Vector3.new(9, 19, -493))
							task.wait(0.5)
							RS.ThrowLuckyBlockRemotes.ThrowZoneBatVisual:FireServer(true)
							task.wait()
							RS.ThrowLuckyBlockRemotes.ThrowStarted:FireServer()
							task.wait()
							RS.ThrowLuckyBlockRemotes.ThrowBatHit:FireServer(nil, false)
							task.wait()
							RS.ThrowLuckyBlockRemotes.ThrowBatTimingVfxCleanup:FireServer()
							task.wait()
							RS.ThrowLuckyBlockRemotes.LuckyBlockLanded:FireServer({
								LandingPosition = Vector3.new(4, -99, 4514),
								ItemName = "Meowl", Rarity = "OG",
								BlockName = "Uncommon Lucky Block",
								LandingRarity = "OG", Mutation = "Disco",
								Power = 10.642112568062,
							})
							task.wait(0.5)
							char:MoveTo(Vector3.new(8, 21, -558))
							task.wait(0.5)
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
	{
		label = "Auto Upgrade",
		callback = function(on)
			if on then
				_G._BR_UPGRADE = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_UPGRADE then break end
						pcall(function()
							for _, floor in ipairs({"Floor1","Floor2","Floor3"}) do
								for i = 1, 10 do
									RS.Events.RequestSlotUpgrade:FireServer(floor, "Slot" .. tostring(i))
								end
							end
						end)
					end
				end)
			else
				_G._BR_UPGRADE = false
			end
		end,
		cleanup = function() _G._BR_UPGRADE = false end,
	},
	{
		label = "Auto Collect",
		callback = function(on)
			if on then
				_G._BR_COLLECT = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_COLLECT then break end
						pcall(function()
							local char = LP.Character
							for _, floor in ipairs({"Floor1","Floor2","Floor3"}) do
								for _, slot in pairs(workspace["Plot_" .. LP.Name][floor].Slots:GetChildren()) do
									firetouchinterest(char.Head, slot.CollectTouch, true)
									task.wait()
									firetouchinterest(char.Head, slot.CollectTouch, false)
								end
							end
						end)
					end
				end)
			else
				_G._BR_COLLECT = false
			end
		end,
		cleanup = function() _G._BR_COLLECT = false end,
	},
	{
		label = "Auto Rebirth",
		callback = function(on)
			if on then
				_G._BR_REBIRTH = true
				return task.spawn(function()
					while task.wait(3) do
						if not _G._BR_REBIRTH then break end
						pcall(function() RS.Events.RequestRebirth:FireServer() end)
					end
				end)
			else
				_G._BR_REBIRTH = false
			end
		end,
		cleanup = function() _G._BR_REBIRTH = false end,
	},
}

-- 80234914611737 - +1 Jetpack for Brainrots
TOGGLES[80234914611737] = {
	{
		label = "Farm Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(1) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							char:MoveTo(Vector3.new(-93, 59, -9943))
							task.wait(1)
							for _, fold in pairs(workspace.Brainrots:GetChildren()) do
								for _, br in pairs(fold:GetChildren()) do
									if br.PrimaryPart then
										char:MoveTo(br.PrimaryPart.Position)
										local prox = br.AttachmentProximityPrompt:FindFirstChildOfClass("ProximityPrompt")
										if prox then
											repeat fireproximityprompt(prox) task.wait() until not br or br.Parent ~= fold
											task.wait()
											RS.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.Game.RF.ClaimRewards:InvokeServer()
											task.wait()
										end
									end
								end
							end
							char:MoveTo(Vector3.new(-104, 59, -7863))
							task.wait(1)
							for _, fold in pairs(workspace.Brainrots:GetChildren()) do
								for _, br in pairs(fold:GetChildren()) do
									if br.PrimaryPart then
										char:MoveTo(br.PrimaryPart.Position)
										local prox = br.AttachmentProximityPrompt:FindFirstChildOfClass("ProximityPrompt")
										if prox then
											repeat fireproximityprompt(prox) task.wait() until not br or br.Parent ~= fold
											task.wait()
											RS.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.Game.RF.ClaimRewards:InvokeServer()
											task.wait()
										end
									end
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 83569851223739 - +1 Speed Evolve
TOGGLES[83569851223739] = {
	{
		label = "Auto Speed",
		callback = function(on)
			if on then
				_G._BR_SPEED = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_SPEED then break end
						pcall(function()
							RS.Modules.Shared.RemoteEventService.AddSpeedRemoteEvent:FireServer()
						end)
					end
				end)
			else
				_G._BR_SPEED = false
			end
		end,
		cleanup = function() _G._BR_SPEED = false end,
	},
	{
		label = "Auto Win",
		callback = function(on)
			if on then
				_G._BR_WIN = true
				return task.spawn(function()
					while task.wait(0.25) do
						if not _G._BR_WIN then break end
						pcall(function()
							for _, v in pairs(workspace.Wins:GetChildren()) do
								LP.Character:PivotTo(v:GetPivot())
								task.wait(1)
							end
						end)
					end
				end)
			else
				_G._BR_WIN = false
			end
		end,
		cleanup = function() _G._BR_WIN = false end,
	},
	{
		label = "Auto Evolve",
		callback = function(on)
			if on then
				_G._BR_EVOLVE = true
				return task.spawn(function()
					while task.wait(1) do
						if not _G._BR_EVOLVE then break end
						pcall(function()
							RS.Modules.Shared.RemoteEventService.EvolutionRemoteEvent:FireServer({Action = "Evolve"})
						end)
					end
				end)
			else
				_G._BR_EVOLVE = false
			end
		end,
		cleanup = function() _G._BR_EVOLVE = false end,
	},
}

-- 84332574190497 - +1 Wings for Brainrot
TOGGLES[84332574190497] = {
	{
		label = "Farm Cosmic Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				local worldPositions = {
					cosmic = Vector3.new(169, 42, 6124),
					spawn = Vector3.new(22, 71, -133),
				}
				return task.spawn(function()
					while task.wait(0.5) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							local itemSpawners = workspace:FindFirstChild("ItemSpawners")
							if itemSpawners then
								local cosmics = itemSpawners:FindFirstChild("Cosmic")
								if cosmics then
									for _, rot in pairs(cosmics:GetChildren()) do
										local mesh = rot:FindFirstChild("Mesh", 3)
										if mesh then
											local pp = mesh:FindFirstChildWhichIsA("ProximityPrompt")
											if pp then
												char.HumanoidRootPart.CFrame = CFrame.new(rot.WorldPivot)
												task.wait(1)
												fireproximityprompt(pp)
												task.wait()
												char.HumanoidRootPart.CFrame = CFrame.new(worldPositions.spawn)
												task.wait(2)
											end
										end
									end
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
	{
		label = "Teleport to Spawn",
		isButton = true,
		callback = function()
			pcall(function()
				LP.Character.HumanoidRootPart.CFrame = CFrame.new(22, 71, -133)
			end)
		end,
	},
}

-- 85411355002110 - +1 Dash for Brainrots
TOGGLES[85411355002110] = {
	{
		label = "Farm Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							char:MoveTo(Vector3.new(-74, 63, 15784))
							local lastPlace = workspace.Map.Spawners:WaitForChild("???xLuck"):WaitForChild("???")
							for _, v in pairs(lastPlace:GetChildren()) do
								if v:IsA("Model") and v.PrimaryPart then
									char:MoveTo(v.PrimaryPart.Position)
									local prox = v.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")
									if prox then
										repeat fireproximityprompt(prox) task.wait() until not v or v.Parent ~= lastPlace
										task.wait(0.5)
										char:MoveTo(Vector3.new(-74, 20, -447))
										task.wait(1)
									end
									break
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 86614757217732 - +1 Health for Brainrot
TOGGLES[86614757217732] = {
	{
		label = "Farm Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.5) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							local topRot, bestAmt = nil, 0
							for _, br in pairs(workspace.SpawnedBrainrots:GetChildren()) do
								if br:GetAttribute("CashPerSec") >= bestAmt then
									bestAmt = br:GetAttribute("CashPerSec")
									topRot = br
								end
							end
							if topRot and topRot.PrimaryPart then
								char:MoveTo(topRot.PrimaryPart.Position)
								repeat fireproximityprompt(topRot.PickupHitbox.ProximityPrompt) task.wait() until not topRot or topRot.Parent ~= workspace.SpawnedBrainrots
								firetouchinterest(char.Head, workspace.Map.BrainrotCollectionPart, true)
								task.wait()
								firetouchinterest(char.Head, workspace.Map.BrainrotCollectionPart, false)
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 89046742932569 - Sail for Brainrots
TOGGLES[89046742932569] = {
	{
		label = "Autofarm",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(1) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							local zone = workspace.Zones:FindFirstChild("Zone13")
							if zone and zone.Objects then
								for _, brainrot in pairs(zone.Objects:GetChildren()) do
									if brainrot.PrimaryPart then
										char:MoveTo(brainrot.PrimaryPart.Position)
										repeat fireproximityprompt(brainrot.ProximityPrompt) task.wait() until brainrot == nil or brainrot.Parent ~= zone.Objects
										char:MoveTo(workspace.Bases[LP.Name].Root.Position)
										task.wait(0.5)
									end
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
	{
		label = "Auto Sell",
		callback = function(on)
			if on then
				_G._BR_SELL = true
				return task.spawn(function()
					while task.wait(3) do
						if not _G._BR_SELL then break end
						pcall(function()
							for _, brainrot in pairs(LP.Backpack:GetChildren()) do
								if brainrot.Name ~= "Bat" and brainrot:FindFirstChild("Handle") then
									RS.Shared.Classes.RemoteFunction.Remotes.EntityShared_SellEntity:InvokeServer(brainrot.Name)
								end
							end
						end)
					end
				end)
			else
				_G._BR_SELL = false
			end
		end,
		cleanup = function() _G._BR_SELL = false end,
	},
	{
		label = "Redeem Codes",
		isButton = true,
		callback = function()
			pcall(function()
				local codes = {"Stop Looking", "TommysHouse", "Phew", "GoldStatue", "FreeSpin"}
				for _, code in ipairs(codes) do
					RS.Shared.Classes.RemoteFunction.Remotes.CodeShared_Redeem:InvokeServer(code)
					task.wait()
				end
			end)
		end,
	},
}

-- 89072926726733 - Cross Road for Brainrots
TOGGLES[89072926726733] = {
	{
		label = "Farm Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							local hrp = char.HumanoidRootPart
							local function tp(pos) char:MoveTo(pos) task.wait(1) end
							tp(Vector3.new(345, 19, 2242))
							task.wait(1)
							local celestial = workspace.ItemSpawners:WaitForChild("Celestial", 5)
							if celestial then
								for _, br in pairs(celestial:GetChildren()) do
									if br.PrimaryPart then
										tp(br.PrimaryPart.Position)
										local prompt = br.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")
										if prompt then
											repeat fireproximityprompt(prompt) task.wait() until not br or br.Parent ~= celestial
											task.wait(0.5)
											tp(Vector3.new(343, 2, -15))
											task.wait(2)
										end
									end
								end
							end
							tp(Vector3.new(353, 2, 2092))
							task.wait(1)
							local secret = workspace.ItemSpawners:WaitForChild("Secret", 5)
							if secret then
								for _, br in pairs(secret:GetChildren()) do
									if br.PrimaryPart then
										tp(br.PrimaryPart.Position)
										local prompt = br.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")
										if prompt then
											repeat fireproximityprompt(prompt) task.wait() until not br or br.Parent ~= secret
											task.wait(0.5)
											tp(Vector3.new(343, 2, -15))
											task.wait(2)
										end
									end
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
	{
		label = "Remove Cars",
		isButton = true,
		callback = function()
			pcall(function() workspace.CarSpawn:Destroy() end)
		end,
	},
}

-- 94780005879799 - Scream for Brainrots
TOGGLES[94780005879799] = {
	{
		label = "Add Inf Spins",
		callback = function(on)
			if on then
				_G._BR_SPINS = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_SPINS then break end
						pcall(function() RS.Remotes.AddSpin:FireServer() end)
					end
				end)
			else
				_G._BR_SPINS = false
			end
		end,
		cleanup = function() _G._BR_SPINS = false end,
	},
	{
		label = "Auto Spin Sleepy",
		callback = function(on)
			if on then
				_G._BR_SLEEPY = true
				return task.spawn(function()
					while task.wait(0.5) do
						if not _G._BR_SLEEPY then break end
						pcall(function() RS.Remotes.SpinEventWheel:FireServer(5) end)
					end
				end)
			else
				_G._BR_SLEEPY = false
			end
		end,
		cleanup = function() _G._BR_SLEEPY = false end,
	},
	{
		label = "Auto Spin OG",
		callback = function(on)
			if on then
				_G._BR_OGSPIN = true
				return task.spawn(function()
					while task.wait(0.5) do
						if not _G._BR_OGSPIN then break end
						pcall(function() RS.Remotes.SpinEventWheel:FireServer(4) end)
					end
				end)
			else
				_G._BR_OGSPIN = false
			end
		end,
		cleanup = function() _G._BR_OGSPIN = false end,
	},
}

-- 95082159892680 - +1 Speed Keyboard Escape
TOGGLES[95082159892680] = {
	{
		label = "Autofarm",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							RS.Remotes.UpdateSpeed:FireServer("Walking")
							LP.Character.Humanoid:MoveTo(Vector3.new(2, 9, 282))
							task.wait(2)
							LP.Character.Humanoid:MoveTo(Vector3.new(70, 9, 398))
							task.wait(2)
							LP.Character.Humanoid:MoveTo(Vector3.new(1, 9, 505))
							task.wait(2)
							LP.Character.Humanoid:MoveTo(Vector3.new(19, 9, 541))
							task.wait(2)
							LP.Character.Humanoid:MoveTo(Vector3.new(20, 77, 754))
							task.wait(2)
							LP.Character.Humanoid:MoveTo(Vector3.new(1, 77, 817))
							task.wait(2)
							LP.Character.Humanoid:MoveTo(Vector3.new(1, 77, 1042))
							task.wait(2)
							LP.Character.Humanoid:MoveTo(Vector3.new(2, 77, 1363))
							task.wait(2)
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 97508801613157 - Parkour Run for Brainrots
TOGGLES[97508801613157] = {
	{
		label = "Farm Mythical",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							LP.Character:MoveTo(Vector3.new(12738, 1490, 231))
							for _, v in pairs(workspace.BG_BrainrotSpawner:GetChildren()) do
								if v.Name == "Mythical" then
									local br = v:FindFirstChildOfClass("Model")
									if br and br.PrimaryPart then
										local pp = br.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")
										if pp then
											repeat fireproximityprompt(pp) task.wait() until br.Parent ~= v
											RS.Packages._Index["sleitnick_net@0.2.0"].net["RE/BG_ReturnToBase"]:FireServer()
											task.wait(1)
										end
									end
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
}

-- 97931184538536 - Skate for Brainrots
TOGGLES[97931184538536] = {
	{
		label = "Farm OG+Celestial",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							for _, br in pairs(workspace.Bin.FieldBrainrots:GetChildren()) do
								if (br:GetAttribute("FieldName") == "CelestialField" or br:GetAttribute("FieldName") == "OGField") and br:GetAttribute("Traits") ~= "VIP" then
									char:MoveTo(br.Position)
									repeat fireproximityprompt(br:FindFirstChildOfClass("ProximityPrompt")) task.wait() until not br or br.Parent ~= workspace.Bin.FieldBrainrots
									task.wait()
									repeat char:MoveTo(Vector3.new(69, 30, 162)) task.wait() until not char:FindFirstChild("HeldFieldBrainrot")
									task.wait()
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
	{
		label = "Farm All Brainrots",
		callback = function(on)
			if on then
				_G._BR_FARMALL = true
				return task.spawn(function()
					while task.wait(0.1) do
						if not _G._BR_FARMALL then break end
						pcall(function()
							local char = LP.Character
							for _, br in pairs(workspace.Bin.FieldBrainrots:GetChildren()) do
								if br:GetAttribute("FieldName") ~= nil and br:GetAttribute("Traits") ~= "VIP" then
									char:MoveTo(br.Position)
									repeat fireproximityprompt(br:FindFirstChildOfClass("ProximityPrompt")) task.wait() until not br or br.Parent ~= workspace.Bin.FieldBrainrots
									task.wait()
									repeat char:MoveTo(Vector3.new(69, 30, 162)) task.wait() until not char:FindFirstChild("HeldFieldBrainrot")
									task.wait()
								end
							end
						end)
					end
				end)
			else
				_G._BR_FARMALL = false
			end
		end,
		cleanup = function() _G._BR_FARMALL = false end,
	},
}

-- 98868317791094 - Dump
TOGGLES[98868317791094] = {
	{
		label = "Steal from All",
		callback = function(on)
			if on then
				_G._BR_STEAL = true
				return task.spawn(function()
					while task.wait(1) do
						if not _G._BR_STEAL then break end
						pcall(function()
							local char = LP.Character
							for _, v in pairs(workspace.ActivePlots:GetChildren()) do
								if v.Name ~= "Plot" and v.Name ~= tostring(LP.UserId) then
									RS.Network.RemoteEvents.LockpickGateOpen:FireServer(v, 30)
									task.wait()
									for _, item in pairs(v.PlacedItems:GetChildren()) do
										char:MoveTo(item.PrimaryPart.Position)
										task.wait(0.5)
										fireproximityprompt(item.PrimaryPart.Attachment.ProximityPrompt)
										task.wait(0.5)
										char:MoveTo(workspace.ActivePlots[tostring(LP.UserId)].TeleportPoint.Position)
										task.wait(0.5)
									end
								end
								task.wait()
							end
						end)
					end
				end)
			else
				_G._BR_STEAL = false
			end
		end,
		cleanup = function() _G._BR_STEAL = false end,
	},
	{
		label = "Auto Dig",
		callback = function(on)
			if on then
				_G._BR_DIG = true
				return task.spawn(function()
					while task.wait(2) do
						if not _G._BR_DIG then break end
						pcall(function()
							RS.Network.RemoteFunctions.StartDigging:InvokeServer()
							task.wait(1)
							RS.Network.RemoteFunctions.GetSelectedItem:InvokeServer(2)
							RS.Network.RemoteEvents["0a1baf564dbb5375"]:FireServer(-1)
							RS.Network.RemoteEvents["0a1baf564dbb5375"]:FireServer(0)
							task.wait(2)
							RS.Network.RemoteEvents.EndDigging:FireServer("Succeeded", 3)
						end)
					end
				end)
			else
				_G._BR_DIG = false
			end
		end,
		cleanup = function() _G._BR_DIG = false end,
	},
	{
		label = "Auto Collect",
		callback = function(on)
			if on then
				_G._BR_COLLECT = true
				return task.spawn(function()
					while task.wait(1) do
						if not _G._BR_COLLECT then break end
						pcall(function() RS.Network.RemoteEvents.CollectSavedPlotMoney:FireServer() end)
					end
				end)
			else
				_G._BR_COLLECT = false
			end
		end,
		cleanup = function() _G._BR_COLLECT = false end,
	},
}

-- 99255447043899 - Become a Brainrot
TOGGLES[99255447043899] = {
	{
		label = "Autofarm",
		callback = function(on)
			if on then
				_G._BR_FARM = true
				return task.spawn(function()
					while task.wait(1) do
						if not _G._BR_FARM then break end
						pcall(function()
							local char = LP.Character
							firetouchinterest(char.Head, workspace.RunTrigger, true)
							task.wait()
							firetouchinterest(char.Head, workspace.RunTrigger, false)
							task.wait(0.5)
							char:MoveTo(Vector3.new(46, 4, -1816))
							repeat task.wait() until workspace.Locations.End.Brainrots:FindFirstChildOfClass("Model")
							local bestbr, mostval = nil, 0
							for _, v in pairs(workspace.Locations.End.Brainrots:GetChildren()) do
								if v.MoneyPerSecond.Value > mostval and v.PrimaryPart.ProximityPrompt.ActionText ~= "STEAL OP" then
									mostval = v.MoneyPerSecond.Value
									bestbr = v
								end
							end
							if bestbr then
								char:MoveTo(bestbr.PrimaryPart.Position)
								task.wait()
								repeat fireproximityprompt(bestbr.PrimaryPart.ProximityPrompt) task.wait() until not bestbr or bestbr.Parent ~= workspace.Locations.End.Brainrots
								task.wait()
								char:MoveTo(workspace.EscapeHitbox.Position)
							end
						end)
					end
				end)
			else
				_G._BR_FARM = false
			end
		end,
		cleanup = function() _G._BR_FARM = false end,
	},
	{
		label = "Auto Sell when Maxed",
		callback = function(on)
			if on then
				_G._BR_SELL = true
				pcall(function()
					RS.Events.Notify.OnClientEvent:Connect(function(arg1)
						if _G._BR_SELL and arg1:find("Max 75") then
							RS.Events.EquipBest:FireServer()
							task.wait(1)
							RS.Events.SellAllBrainrots:FireServer(LP.Backpack:GetChildren())
						end
					end)
				end)
			else
				_G._BR_SELL = false
			end
		end,
		cleanup = function() _G._BR_SELL = false end,
	},
}

-- 99435399946069 - Reel for Brainrots New Plr (same as 106772177198260)
TOGGLES[99435399946069] = TOGGLES[106772177198260]

end
