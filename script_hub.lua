--[[
	FLIXHUB - Modern Vertical Tab UI v2
	PlaceId-aware: loads game scripts from Games/<PlaceId>.lua
]]

print("[FlixHub] Loading...")

local Players           = game:GetService("Players")
local TweenService      = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")
local RS                = game:GetService("ReplicatedStorage")
local LP                = Players.LocalPlayer
local playerGui         = LP:WaitForChild("PlayerGui")
local CURRENT_PLACE_ID  = game.PlaceId

_G.FlixHub = _G.FlixHub or {}
_G.FlixHub.GAME_TOGGLES = _G.FlixHub.GAME_TOGGLES or {}

local GAME_TOGGLES = _G.FlixHub.GAME_TOGGLES

local oldGui = game:GetService("CoreGui"):FindFirstChild("FlixHub")
if oldGui then pcall(function() oldGui:Destroy() end) end
for _, g in ipairs({"FLIX_POOP","FLIX_SELL","FLIX_BUYFOOD","FLIX_USEFOOD","FLIX_INSTPP","FLIX_INSTPP_CONN","FLIX_STEAL_INVIS","FLIX_STEAL_WS","FLIX_STEAL_KILLAURA","FLIX_STEAL_FAKELAG","_STEAL_INVIS_PARTS","_STEAL_WS_CONN","_STEAL_KILLAURA_CONN","_STEAL_FAKELAG_CONN","_STEAL_DMG_MULT","_STEAL_DMG_HOOKED","FLIX_DISABLE3D"}) do
	_G[g] = nil
end

local THEME = {
	Background  = Color3.fromRGB(24, 25, 31),
	Sidebar     = Color3.fromRGB(19, 20, 25),
	Card        = Color3.fromRGB(31, 32, 39),
	Accent      = Color3.fromRGB(99, 102, 241),
	Green       = Color3.fromRGB(72, 199, 116),
	Red         = Color3.fromRGB(240, 90, 90),
	TextPrimary = Color3.fromRGB(235, 235, 245),
	TextMuted   = Color3.fromRGB(148, 150, 165),
	Stroke      = Color3.fromRGB(45, 46, 56),
}

local WINDOW_SIZE    = UDim2.fromOffset(760, 520)
local SIDEBAR_WIDTH  = 190
local TOPBAR_HEIGHT  = 50
local CORNER_RADIUS  = 18

local GITHUB_RAW = "https://raw.githubusercontent.com/flixstu/FlixHub/main"

local GAMES = {}
do
	local ok, data = pcall(function()
		return loadstring(readfile("gameslist.lua"))()
	end)
	if ok and type(data) == "table" then
		GAMES = data
		print("[FlixHub] Loaded gameslist.lua (" .. #GAMES .. " games)")
	else
		-- try fetching from github
		local ok2, src = pcall(function()
			return game:HttpGet(GITHUB_RAW .. "/gameslist.lua")
		end)
		if ok2 and src and src ~= "" then
			local ok3, d2 = pcall(function() return loadstring(src)() end)
			if ok3 and type(d2) == "table" then
				GAMES = d2
				print("[FlixHub] Loaded gameslist from GitHub (" .. #GAMES .. " games)")
			end
		end
		if #GAMES == 0 then
			GAMES = {
			{ placeId = 85050171250159,  name = "Poop a Big Poop" },
			{ placeId = 74268130525137,  name = "Steal FPS from Others" },
			{ placeId = 100070667273689, name = "Survive Flood for Brainrots" },
			{ placeId = 100964511576728, name = "Smash Crate for Brainrots" },
			{ placeId = 105215477731035, name = "Pole Obby for Brainrots" },
			{ placeId = 106772177198260, name = "Reel for Brainrots" },
			{ placeId = 108207853263201, name = "Rizz Tower" },
			{ placeId = 109908567838703, name = "Nuke for Brainrots" },
			{ placeId = 110373292461174, name = "Paper Plane for Brainrot" },
			{ placeId = 110627433764494, name = "Fake a Brainrot" },
			{ placeId = 112500097711893, name = "Lick a Brainrot" },
			{ placeId = 114640202062357, name = "Swing Obby for Brainrots" },
			{ placeId = 135882949571046, name = "Dream for Brainrots" },
			{ placeId = 136919941417380, name = "Bike Obby for Brainrots" },
			{ placeId = 137069154816703, name = "Hack Vault for Brainrots" },
			{ placeId = 137233438285284, name = "Chicken Farm" },
			{ placeId = 71213902019049,  name = "Cross Rivers for Brainrots" },
			{ placeId = 74277864669743,  name = "Fly for Brainrots" },
			{ placeId = 77862067599263,  name = "Obby as a Brainrot" },
			{ placeId = 80234914611737,  name = "+1 Jetpack for Brainrots" },
			{ placeId = 83569851223739,  name = "+1 Speed Evolve" },
			{ placeId = 84332574190497,  name = "+1 Wings for Brainrot" },
			{ placeId = 85411355002110,  name = "+1 Dash for Brainrots" },
			{ placeId = 86614757217732,  name = "+1 Health for Brainrot" },
			{ placeId = 89046742932569,  name = "Sail for Brainrots" },
			{ placeId = 89072926726733,  name = "Cross Road for Brainrots" },
			{ placeId = 94780005879799,  name = "Scream for Brainrots" },
			{ placeId = 95082159892680,  name = "+1 Speed Keyboard Escape" },
			{ placeId = 97508801613157,  name = "Parkour Run for Brainrots" },
			{ placeId = 97931184538536,  name = "Skate for Brainrots" },
			{ placeId = 98868317791094,  name = "Dump" },
			{ placeId = 99255447043899,  name = "Become a Brainrot" },
			{ placeId = 99435399946069,  name = "Reel for Brainrots (New)" },
			{ placeId = 104522435597696, name = "The Animal Hospital" },
		}
		print("[FlixHub] Using built-in games list (" .. #GAMES .. " games)")
		end
	end
end

-- ============================================================
-- HELPERS
-- ============================================================

local function new(class, props, children)
	local inst = Instance.new(class)
	for prop, value in pairs(props or {}) do inst[prop] = value end
	for _, child in ipairs(children or {}) do child.Parent = inst end
	return inst
end

local function corner(radius)
	return new("UICorner", { CornerRadius = UDim.new(0, radius or 10) })
end

local function stroke(color, thickness)
	return new("UIStroke", {
		Color = color or THEME.Stroke,
		Thickness = thickness or 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	})
end

local function tween(obj, props, time, style)
	local t = TweenService:Create(
		obj,
		TweenInfo.new(time or 0.2, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		props
	)
	t:Play()
	return t
end

local function part(inst, prop)
	return { inst = inst, prop = prop or "BackgroundColor3" }
end

local function setIconColor(parts, color, animate)
	for _, p in ipairs(parts) do
		if animate then tween(p.inst, { [p.prop] = color }, 0.15)
		else p.inst[p.prop] = color end
	end
end

-- ============================================================
-- VECTOR ICONS
-- ============================================================

local function iconHouse(color)
	local box = new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(18, 18) })
	local roof = new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(12, 12), Position = UDim2.fromOffset(3, 1), Rotation = 45, Parent = box }, { corner(3) })
	local base = new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(12, 8), Position = UDim2.fromOffset(3, 9), Parent = box }, { corner(2) })
	return box, { part(roof), part(base) }
end

local function iconController(color)
	local box = new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(18, 18) })
	local bs = stroke(color, 1.5)
	local body = new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(16, 9), Position = UDim2.fromOffset(1, 5), Parent = box }, { corner(4), bs })
	new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(2, 6), Position = UDim2.fromOffset(3, 1.5), Parent = body }, { corner(1) })
	new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(6, 2), Position = UDim2.fromOffset(1, 3.5), Parent = body }, { corner(1) })
	new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(3, 3), Position = UDim2.fromOffset(11, 1), Parent = body }, { corner(2) })
	new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(3, 3), Position = UDim2.fromOffset(11, 5), Parent = body }, { corner(2) })
	return box, { part(bs, "Color") }
end

local function iconList(color)
	local box = new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(18, 18) })
	local b1 = new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(14, 2), Position = UDim2.fromOffset(2, 4), Parent = box }, { corner(1) })
	local b2 = new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(14, 2), Position = UDim2.fromOffset(2, 8), Parent = box }, { corner(1) })
	local b3 = new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(14, 2), Position = UDim2.fromOffset(2, 12), Parent = box }, { corner(1) })
	return box, { part(b1), part(b2), part(b3) }
end

local function iconSliders(color)
	local box = new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(18, 18) })
	local l1 = new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(2, 14), Position = UDim2.fromOffset(3, 2), Parent = box }, { corner(1) })
	local k1 = new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(5, 5), Position = UDim2.fromOffset(1.5, 6), Parent = box }, { corner(2.5) })
	local l2 = new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(2, 14), Position = UDim2.fromOffset(8, 2), Parent = box }, { corner(1) })
	local k2 = new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(5, 5), Position = UDim2.fromOffset(6.5, 10), Parent = box }, { corner(2.5) })
	local l3 = new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(2, 14), Position = UDim2.fromOffset(13, 2), Parent = box }, { corner(1) })
	local k3 = new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(5, 5), Position = UDim2.fromOffset(11.5, 4), Parent = box }, { corner(2.5) })
	return box, { part(l1), part(k1), part(l2), part(k2), part(l3), part(k3) }
end

local function iconInfo(color)
	local box = new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(18, 18) })
	local cs = stroke(color, 1.5)
	local circle = new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(16, 16), Position = UDim2.fromOffset(1, 1), Parent = box }, { corner(8), cs })
	local dot = new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(2, 2), Position = UDim2.fromOffset(8, 5), Parent = box }, { corner(1) })
	local stem = new("Frame", { BackgroundColor3 = color, Size = UDim2.fromOffset(2, 6), Position = UDim2.fromOffset(8, 9), Parent = box }, { corner(1) })
	return box, { part(dot), part(stem), part(cs, "Color") }
end

-- ============================================================
-- SCREEN GUI
-- ============================================================

local screenGui = new("ScreenGui", {
	Name = "FlixHub",
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	IgnoreGuiInset = true,
	DisplayOrder = 9999,
	Parent = game:GetService("CoreGui"),
})

local main = new("Frame", {
	Name = "Main",
	Size = WINDOW_SIZE,
	Position = UDim2.new(0.5, -WINDOW_SIZE.X.Offset / 2, 0.5, -WINDOW_SIZE.Y.Offset / 2),
	BackgroundColor3 = THEME.Background,
	ClipsDescendants = true,
	Parent = screenGui,
}, { corner(CORNER_RADIUS), stroke(THEME.Stroke, 1) })

new("ImageLabel", {
	Name = "Shadow", BackgroundTransparency = 1,
	Image = "rbxassetid://1316045217", ImageColor3 = Color3.new(0, 0, 0),
	ImageTransparency = 0.45, ScaleType = Enum.ScaleType.Slice,
	SliceCenter = Rect.new(10, 10, 118, 118),
	Size = UDim2.new(1, 40, 1, 40), Position = UDim2.new(0, -20, 0, -20),
	ZIndex = 0, Parent = main,
})

-- ============================================================
-- TOP BAR
-- ============================================================

local topBar = new("Frame", { Name = "TopBar", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, TOPBAR_HEIGHT), Parent = main })

new("TextLabel", {
	Text = "FlixHub", Font = Enum.Font.GothamBold, TextSize = 18,
	TextColor3 = THEME.TextPrimary, BackgroundTransparency = 1,
	TextXAlignment = Enum.TextXAlignment.Left,
	Position = UDim2.fromOffset(20, 0), Size = UDim2.new(0, 200, 1, 0),
	Parent = topBar,
})

local closeBtn = new("TextButton", { Name = "Close", Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.fromOffset(24, 24), Position = UDim2.new(1, -36, 0.5, -12), Parent = topBar })
local xBar1 = new("Frame", { BackgroundColor3 = THEME.TextMuted, Size = UDim2.fromOffset(14, 2), Position = UDim2.fromOffset(5, 11), Rotation = 45, Parent = closeBtn }, { corner(1) })
local xBar2 = new("Frame", { BackgroundColor3 = THEME.TextMuted, Size = UDim2.fromOffset(14, 2), Position = UDim2.fromOffset(5, 11), Rotation = -45, Parent = closeBtn }, { corner(1) })

closeBtn.MouseEnter:Connect(function() tween(xBar1, { BackgroundColor3 = THEME.Red }, 0.15); tween(xBar2, { BackgroundColor3 = THEME.Red }, 0.15) end)
closeBtn.MouseLeave:Connect(function() tween(xBar1, { BackgroundColor3 = THEME.TextMuted }, 0.15); tween(xBar2, { BackgroundColor3 = THEME.TextMuted }, 0.15) end)
closeBtn.MouseButton1Click:Connect(function()
	tween(main, { Size = UDim2.new(0, WINDOW_SIZE.X.Offset, 0, 0) }, 0.2)
	task.wait(0.2)
	screenGui.Enabled = false
	if _G.FlixHub.killAllThreads then _G.FlixHub.killAllThreads() end
end)

local minimizeBtn = new("TextButton", { Name = "Minimize", Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.fromOffset(24, 24), Position = UDim2.new(1, -70, 0.5, -12), Parent = topBar })
local dash = new("Frame", { BackgroundColor3 = THEME.TextMuted, Size = UDim2.fromOffset(14, 2), Position = UDim2.fromOffset(5, 11), Parent = minimizeBtn }, { corner(1) })

minimizeBtn.MouseEnter:Connect(function() tween(dash, { BackgroundColor3 = THEME.TextPrimary }, 0.15) end)
minimizeBtn.MouseLeave:Connect(function() tween(dash, { BackgroundColor3 = THEME.TextMuted }, 0.15) end)

local isMinimized = false
local savedPosition = main.Position
local minimizedIcon

minimizeBtn.MouseButton1Click:Connect(function()
	if isMinimized then return end
	isMinimized = true
	savedPosition = main.Position
	tween(main, { Size = UDim2.new(0, 0, 0, 0) }, 0.18)
	task.wait(0.18)
	main.Visible = false
	main.Size = WINDOW_SIZE
	minimizedIcon.Position = savedPosition
	minimizedIcon.Size = UDim2.fromOffset(0, 0)
	minimizedIcon.Visible = true
	tween(minimizedIcon, { Size = UDim2.fromOffset(54, 54) }, 0.2, Enum.EasingStyle.Back)
end)

new("Frame", { BackgroundColor3 = THEME.Stroke, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, 0), Parent = topBar })

-- ============================================================
-- MINIMIZED ICON
-- ============================================================

minimizedIcon = new("TextButton", {
	Name = "MinimizedIcon", Text = "F", Font = Enum.Font.GothamBlack, TextSize = 24,
	TextColor3 = Color3.new(1, 1, 1), BackgroundColor3 = THEME.Accent,
	AutoButtonColor = false, Size = UDim2.fromOffset(0, 0), Visible = false,
	Parent = screenGui,
}, { corner(16), stroke(THEME.Stroke, 1) })

new("ImageLabel", {
	BackgroundTransparency = 1, Image = "rbxassetid://1316045217",
	ImageColor3 = Color3.new(0, 0, 0), ImageTransparency = 0.5,
	ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(10, 10, 118, 118),
	Size = UDim2.new(1, 30, 1, 30), Position = UDim2.new(0, -15, 0, -15),
	ZIndex = 0, Parent = minimizedIcon,
})

minimizedIcon.MouseEnter:Connect(function() tween(minimizedIcon, { BackgroundColor3 = Color3.fromRGB(120, 123, 250) }, 0.15) end)
minimizedIcon.MouseLeave:Connect(function() tween(minimizedIcon, { BackgroundColor3 = THEME.Accent }, 0.15) end)

minimizedIcon.MouseButton1Click:Connect(function()
	isMinimized = false
	tween(minimizedIcon, { Size = UDim2.fromOffset(0, 0) }, 0.15)
	task.wait(0.15)
	minimizedIcon.Visible = false
	main.Position = savedPosition
	main.Size = UDim2.new(0, 0, 0, 0)
	main.Visible = true
	tween(main, { Size = WINDOW_SIZE }, 0.2)
end)

do
	local dragging, dragStart, startPos = false, nil, nil
	minimizedIcon.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = input.Position; startPos = minimizedIcon.Position
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local d = input.Position - dragStart
			minimizedIcon.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
			savedPosition = minimizedIcon.Position
		end
	end)
end

-- ============================================================
-- BODY
-- ============================================================

local body = new("Frame", { Name = "Body", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -TOPBAR_HEIGHT), Position = UDim2.new(0, 0, 0, TOPBAR_HEIGHT), Parent = main })

local sidebar = new("Frame", {
	Name = "Sidebar", BackgroundColor3 = THEME.Sidebar,
	Size = UDim2.new(0, SIDEBAR_WIDTH, 1, 0), ClipsDescendants = true, Parent = body,
})

new("Frame", { BackgroundColor3 = THEME.Stroke, BorderSizePixel = 0, Size = UDim2.new(0, 1, 1, 0), Position = UDim2.new(0, SIDEBAR_WIDTH - 1, 0, 0), Parent = body })
new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = sidebar })
new("UIPadding", { PaddingTop = UDim.new(0, 16), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = sidebar })

local content = new("Frame", {
	Name = "Content", BackgroundTransparency = 1,
	Size = UDim2.new(1, -SIDEBAR_WIDTH, 1, 0), Position = UDim2.new(0, SIDEBAR_WIDTH, 0, 0),
	ClipsDescendants = true, Parent = body,
})
new("UIPadding", { PaddingTop = UDim.new(0, 20), PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24), PaddingBottom = UDim.new(0, 20), Parent = content })

-- ============================================================
-- PAGE HELPERS
-- ============================================================

local tabs = {}
local activeTab = nil

local function buildPage(name)
	local page = new("ScrollingFrame", {
		Name = name .. "Page", BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0), Visible = false,
		ScrollBarThickness = 3, ScrollBarImageColor3 = THEME.Accent,
		CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Parent = content,
	})
	new("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = page })
	return page
end

local function pageTitle(page, text, order)
	new("TextLabel", {
		Text = text, Font = Enum.Font.GothamBold, TextSize = 22,
		TextColor3 = THEME.TextPrimary, TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30),
		LayoutOrder = order or 0, Parent = page,
	})
end

local function pageSubtitle(page, text, order)
	new("TextLabel", {
		Text = text, Font = Enum.Font.Gotham, TextSize = 14,
		TextColor3 = THEME.TextMuted, TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 18),
		LayoutOrder = order, Parent = page,
	})
end

local function card(page, order, height)
	local c = new("Frame", {
		BackgroundColor3 = THEME.Card,
		Size = UDim2.new(1, 0, 0, height or 64),
		LayoutOrder = order, Parent = page,
	}, { corner(10), stroke(THEME.Stroke, 1) })
	return c
end

-- ============================================================
-- HOME PAGE
-- ============================================================

local homePage = buildPage("Home")
pageTitle(homePage, "Welcome back", 1)
pageSubtitle(homePage, "FlixHub v2 — PlaceId-aware auto farm hub", 2)

do
	local currentGame = "Unknown"
	for _, g in ipairs(GAMES) do
		if g.placeId == CURRENT_PLACE_ID then currentGame = g.name; break end
	end
	local c = card(homePage, 3, 64)
	new("UIPadding", { PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16), Parent = c })
	new("TextLabel", {
		Text = "Current Game: " .. currentGame,
		Font = Enum.Font.GothamMedium, TextSize = 15,
		TextColor3 = THEME.TextPrimary, TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = c,
	})
end

do
	local c = card(homePage, 4, 64)
	new("UIPadding", { PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16), Parent = c })
	new("TextLabel", {
		Text = "PlaceId: " .. tostring(CURRENT_PLACE_ID),
		Font = Enum.Font.GothamMedium, TextSize = 15,
		TextColor3 = THEME.TextMuted, TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = c,
	})
end

-- ============================================================
-- GAME PAGE (dynamic toggles)
-- ============================================================

local gamePage = buildPage("Game")
pageTitle(gamePage, "Game", 1)

local activeThreads = {}
local toggleInstances = {}

local function killAllThreads()
	for key, thread in pairs(activeThreads) do
		_G[key] = false
		activeThreads[key] = nil
	end
	local toggles = GAME_TOGGLES[CURRENT_PLACE_ID]
	if toggles then
		for _, t in ipairs(toggles) do
			if t.cleanup then pcall(t.cleanup) end
		end
	end
end
_G.FlixHub.killAllThreads = killAllThreads

local function buildGameToggles()
	for _, child in pairs(gamePage:GetChildren()) do
		if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then child:Destroy() end
	end
	for key, thread in pairs(activeThreads) do
		pcall(task.cancel, thread)
		activeThreads[key] = nil
	end
	toggleInstances = {}
	activeThreads = {}

	local toggles = GAME_TOGGLES[CURRENT_PLACE_ID]
	if not toggles then
		pageSubtitle(gamePage, "No scripts for this game (PlaceId: " .. CURRENT_PLACE_ID .. ")", 100)
		return
	end

	local gameName = "Current Game"
	for _, g in ipairs(GAMES) do
		if g.placeId == CURRENT_PLACE_ID then gameName = g.name; break end
	end
	pageSubtitle(gamePage, "Detected: " .. gameName, 1)
	pageSubtitle(gamePage, "Toggle features on/off below.", 2)

	local sectionCards = {}

	for i, toggleDef in ipairs(toggles) do
		local order = 10 + i
		local section = toggleDef.section

		if toggleDef.isButton and toggleDef.expandSection then
			local expanded = false
			local expandKey = toggleDef.expandSection
			local c = card(gamePage, order, 44)
			new("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = c })
			local arrow = new("TextLabel", {
				Text = ">", Font = Enum.Font.GothamBold, TextSize = 14,
				TextColor3 = THEME.Accent, BackgroundTransparency = 1,
				Size = UDim2.new(0, 20, 1, 0), Position = UDim2.new(1, -30, 0, 0),
				TextXAlignment = Enum.TextXAlignment.Center, Parent = c,
			})
			local btn = new("TextButton", {
				Text = toggleDef.label, Font = Enum.Font.GothamMedium, TextSize = 14,
				TextColor3 = THEME.TextPrimary, BackgroundColor3 = THEME.Accent,
				BackgroundTransparency = 0.85,
				Size = UDim2.new(1, 0, 1, 0), AutoButtonColor = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = c,
			}, { corner(8) })
			btn.MouseButton1Click:Connect(function()
				expanded = not expanded
				arrow.Text = expanded and "v" or ">"
				for _, item in ipairs(sectionCards[expandKey] or {}) do
					if item.card then item.card.Visible = expanded end
				end
			end)
		elseif section then
			local c = card(gamePage, order, 44)
			c.Visible = false
			new("UIPadding", { PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 12), Parent = c })
			new("TextLabel", {
				Text = toggleDef.label, Font = Enum.Font.GothamMedium, TextSize = 14,
				TextColor3 = THEME.TextPrimary, TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1, Size = UDim2.new(1, -60, 1, 0), Parent = c,
			})
			local pill = new("Frame", {
				BackgroundColor3 = Color3.fromRGB(60, 60, 72),
				Size = UDim2.fromOffset(44, 22),
				Position = UDim2.new(1, -54, 0.5, -11),
				Parent = c,
			}, { corner(11) })
			local knob = new("Frame", {
				BackgroundColor3 = Color3.new(1, 1, 1),
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(0, 3, 0.5, -8),
				Parent = pill,
			}, { corner(8) })
			local hitBtn = new("TextButton", {
				Text = "", BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0), AutoButtonColor = false, Parent = c,
			})
			local state = false
			local gKey = "_FLIX_TOGGLE_" .. i
			local function setToggle(v)
				state = v
				_G[gKey] = v
				tween(pill, { BackgroundColor3 = state and THEME.Green or Color3.fromRGB(60, 60, 72) }, 0.15)
				tween(knob, { Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8) }, 0.15)
				if state then
					local thread = toggleDef.callback(true)
					if thread then activeThreads[gKey] = thread end
				else
					_G[gKey] = false
					local thread = activeThreads[gKey]
					if thread then pcall(task.cancel, thread) end
					if toggleDef.cleanup then pcall(toggleDef.cleanup) end
					activeThreads[gKey] = nil
				end
			end
			hitBtn.MouseButton1Click:Connect(function() setToggle(not state) end)
			toggleInstances[i] = { pill = pill, knob = knob, setToggle = setToggle }

			if not sectionCards[section] then sectionCards[section] = {} end
			table.insert(sectionCards[section], { card = c, index = i })
		else
			if toggleDef.isButton then
				local c = card(gamePage, order, 44)
				new("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = c })
				local btn = new("TextButton", {
					Text = toggleDef.label, Font = Enum.Font.GothamMedium, TextSize = 14,
					TextColor3 = THEME.TextPrimary, BackgroundColor3 = THEME.Accent,
					BackgroundTransparency = 0.7,
					Size = UDim2.new(1, 0, 1, 0), AutoButtonColor = true,
					TextXAlignment = Enum.TextXAlignment.Center,
					Parent = c,
				}, { corner(8) })
				btn.MouseButton1Click:Connect(function()
					tween(btn, { BackgroundTransparency = 0.3 }, 0.08)
					pcall(function() toggleDef.callback() end)
					task.delay(0.2, function() tween(btn, { BackgroundTransparency = 0.7 }, 0.15) end)
				end)
			else
				local state = false
				local gKey = "_FLIX_TOGGLE_" .. i
				local c = card(gamePage, order, 44)
				new("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = c })
				new("TextLabel", {
					Text = toggleDef.label, Font = Enum.Font.GothamMedium, TextSize = 14,
					TextColor3 = THEME.TextPrimary, TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundTransparency = 1, Size = UDim2.new(1, -60, 1, 0), Parent = c,
				})
				local pill = new("Frame", {
					BackgroundColor3 = Color3.fromRGB(60, 60, 72),
					Size = UDim2.fromOffset(44, 22),
					Position = UDim2.new(1, -54, 0.5, -11),
					Parent = c,
				}, { corner(11) })
				local knob = new("Frame", {
					BackgroundColor3 = Color3.new(1, 1, 1),
					Size = UDim2.fromOffset(16, 16),
					Position = UDim2.new(0, 3, 0.5, -8),
					Parent = pill,
				}, { corner(8) })
				local hitBtn = new("TextButton", {
					Text = "", BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0), AutoButtonColor = false, Parent = c,
				})
				local function setToggle(v)
					state = v
					_G[gKey] = v
					tween(pill, { BackgroundColor3 = state and THEME.Green or Color3.fromRGB(60, 60, 72) }, 0.15)
					tween(knob, { Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8) }, 0.15)
					if state then
						local thread = toggleDef.callback(true)
						if thread then activeThreads[gKey] = thread end
					else
						_G[gKey] = false
						local thread = activeThreads[gKey]
						if thread then pcall(task.cancel, thread) end
						if toggleDef.cleanup then pcall(toggleDef.cleanup) end
						activeThreads[gKey] = nil
					end
				end
				hitBtn.MouseButton1Click:Connect(function() setToggle(not state) end)
				toggleInstances[i] = { pill = pill, knob = knob, setToggle = setToggle }
			end
		end
	end
end

buildGameToggles()
_G.FlixHub.buildGameToggles = buildGameToggles

-- ============================================================
-- GAMES LIST PAGE
-- ============================================================

local gamesPage = buildPage("Games")

local headerRow = new("Frame", {
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 36),
	LayoutOrder = 1, Parent = gamesPage,
})

new("TextLabel", {
	Text = "Games List", Font = Enum.Font.GothamBold, TextSize = 22,
	TextColor3 = THEME.TextPrimary, TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundTransparency = 1, Size = UDim2.new(0.4, 0, 1, 0),
	Parent = headerRow,
})

local searchFrame = new("Frame", {
	BackgroundColor3 = THEME.Card,
	Size = UDim2.new(0.55, 0, 0, 32),
	Position = UDim2.new(0.45, 0, 0.5, -16),
	Parent = headerRow,
}, { corner(8), stroke(THEME.Stroke, 1) })

local searchGlass = new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(14, 14), Position = UDim2.new(0, 10, 0.5, -7), Parent = searchFrame })
new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(8, 8), Position = UDim2.new(0, 0, 0, 0), Parent = searchGlass }, { corner(4), stroke(THEME.TextMuted, 1.5) })
new("Frame", { BackgroundColor3 = THEME.TextMuted, Size = UDim2.new(0, 2, 0, 5), Position = UDim2.new(0, 9, 0, 9), Rotation = 45, Parent = searchGlass }, { corner(1) })

local searchBox = new("TextBox", {
	Text = "", PlaceholderText = " ",
	Font = Enum.Font.Gotham, TextSize = 13,
	TextColor3 = THEME.TextPrimary, PlaceholderColor3 = THEME.TextMuted,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, -32, 1, 0), Position = UDim2.new(0, 28, 0, 0),
	ClearTextOnFocus = false, Parent = searchFrame,
})

local gamesContainer = new("Frame", {
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 0),
	AutomaticSize = Enum.AutomaticSize.Y,
	Position = UDim2.new(0, 0, 0, 46),
	LayoutOrder = 2,
	Parent = gamesPage,
})
new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = gamesContainer })

local function buildGamesList(filter)
	filter = filter and filter:lower() or ""
	for _, child in pairs(gamesContainer:GetChildren()) do
		if not child:IsA("UIListLayout") then child:Destroy() end
	end
	local order = 0
	for _, game in ipairs(GAMES) do
		if filter == "" or game.name:lower():find(filter, 1, true) then
			order = order + 1
			local loaded = GAME_TOGGLES[game.placeId] ~= nil
			local gc = new("Frame", {
				BackgroundColor3 = THEME.Card,
				Size = UDim2.new(1, 0, 0, 44),
				LayoutOrder = order, Parent = gamesContainer,
			}, { corner(8), stroke(THEME.Stroke, 1) })
			new("TextLabel", {
				Text = game.name, Font = Enum.Font.GothamMedium, TextSize = 14,
				TextColor3 = loaded and THEME.TextPrimary or THEME.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1, Size = UDim2.new(1, -80, 1, 0),
				Position = UDim2.new(0, 14, 0, 0), Parent = gc,
			})
			if loaded then
				local badge = new("TextLabel", {
					Text = "Loaded", Font = Enum.Font.GothamMedium, TextSize = 11,
					TextColor3 = THEME.Green, BackgroundColor3 = THEME.Green,
					BackgroundTransparency = 0.85,
					Size = UDim2.new(0, 56, 0, 22),
					Position = UDim2.new(1, -70, 0.5, -11),
					TextXAlignment = Enum.TextXAlignment.Center, Parent = gc,
				}, { corner(11) })
			else
				local badge = new("TextLabel", {
					Text = "Load script", Font = Enum.Font.Gotham, TextSize = 11,
					TextColor3 = THEME.TextMuted, BackgroundTransparency = 1,
					Size = UDim2.new(0, 70, 0, 22),
					Position = UDim2.new(1, -80, 0.5, -11),
					TextXAlignment = Enum.TextXAlignment.Right, Parent = gc,
				})
			end
		end
	end
	if order == 0 then
		new("TextLabel", {
			Text = "No games match your search.", Font = Enum.Font.Gotham,
			TextSize = 14, TextColor3 = THEME.TextMuted, BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 30), LayoutOrder = 999, Parent = gamesContainer,
		})
	end
end

buildGamesList("")
searchBox:GetPropertyChangedSignal("Text"):Connect(function() buildGamesList(searchBox.Text) end)
_G.FlixHub.buildGamesList = buildGamesList

-- ============================================================
-- SETTINGS PAGE
-- ============================================================

local settingsPage = buildPage("Settings")
pageTitle(settingsPage, "Settings", 1)

do
	local order = 10
	local state = false
	pcall(function() state = not UserSettings().GameSettings.GraphicsQualityLevel end)
	local c = card(settingsPage, order, 44)
	new("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = c })
	new("TextLabel", {
		Text = "Disable 3D Rendering", Font = Enum.Font.GothamMedium, TextSize = 14,
		TextColor3 = THEME.TextPrimary, TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1, Size = UDim2.new(1, -60, 1, 0), Parent = c,
	})
	local pill = new("Frame", {
		BackgroundColor3 = state and THEME.Green or Color3.fromRGB(60, 60, 72),
		Size = UDim2.fromOffset(44, 22),
		Position = UDim2.new(1, -54, 0.5, -11),
		Parent = c,
	}, { corner(11) })
	local knob = new("Frame", {
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(16, 16),
		Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
		Parent = pill,
	}, { corner(8) })
	local hitBtn = new("TextButton", {
		Text = "", BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0), AutoButtonColor = false, Parent = c,
	})
	local function setRendering3D(v)
		state = v
		tween(pill, { BackgroundColor3 = state and THEME.Green or Color3.fromRGB(60, 60, 72) }, 0.15)
		tween(knob, { Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8) }, 0.15)
		pcall(function()
			local rs = game:GetService("RunService")
			if rs.Set3dRenderingEnabled then rs:Set3dRenderingEnabled(not state) end
		end)
	end
	_G.FLIX_DISABLE3D = false
	hitBtn.MouseButton1Click:Connect(function()
		state = not state
		_G.FLIX_DISABLE3D = state
		setRendering3D(state)
	end)
end

do
	local order = 20
	local state = false
	local conn
	local c = card(settingsPage, order, 44)
	new("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = c })
	new("TextLabel", {
		Text = "Instant Proximity Prompts", Font = Enum.Font.GothamMedium, TextSize = 14,
		TextColor3 = THEME.TextPrimary, TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1, Size = UDim2.new(1, -60, 1, 0), Parent = c,
	})
	local pill = new("Frame", {
		BackgroundColor3 = Color3.fromRGB(60, 60, 72),
		Size = UDim2.fromOffset(44, 22),
		Position = UDim2.new(1, -54, 0.5, -11),
		Parent = c,
	}, { corner(11) })
	local knob = new("Frame", {
		BackgroundColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromOffset(16, 16),
		Position = UDim2.new(0, 3, 0.5, -8),
		Parent = pill,
	}, { corner(8) })
	local hitBtn = new("TextButton", {
		Text = "", BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0), AutoButtonColor = false, Parent = c,
	})
	local function setInstantPP(v)
		state = v
		_G.FLIX_INSTANT_PP = state
		tween(pill, { BackgroundColor3 = state and THEME.Green or Color3.fromRGB(60, 60, 72) }, 0.15)
		tween(knob, { Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8) }, 0.15)
		if state then
			for _, desc in pairs(workspace:GetDescendants()) do
				if desc:IsA("ProximityPrompt") then
					desc.HoldDuration = 0
				end
			end
			conn = workspace.DescendantAdded:Connect(function(desc)
				if state and desc:IsA("ProximityPrompt") then
					desc.HoldDuration = 0
				end
			end)
		else
			if conn then conn:Disconnect() conn = nil end
		end
	end
	hitBtn.MouseButton1Click:Connect(function()
		state = not state
		setInstantPP(state)
	end)
end

-- ============================================================
-- ABOUT PAGE
-- ============================================================

local aboutPage = buildPage("About")
pageTitle(aboutPage, "About FlixHub", 1)

do
	local c = card(aboutPage, 3, 64)
	new("UIPadding", { PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16), Parent = c })
	new("TextLabel", {
		Text = "FlixHub v2", Font = Enum.Font.GothamBold, TextSize = 15,
		TextColor3 = THEME.TextPrimary, TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = c,
	})
end

-- ============================================================
-- TAB BUTTONS
-- ============================================================

local function createTab(name, iconBuilder, page, order)
	local btn = new("TextButton", {
		Name = name, Text = "", AutoButtonColor = false,
		BackgroundColor3 = THEME.Card, BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 42), LayoutOrder = order, Parent = sidebar,
	}, { corner(9) })
	local indicator = new("Frame", {
		BackgroundColor3 = THEME.Accent, Size = UDim2.new(0, 3, 0, 20),
		Position = UDim2.new(0, 0, 0.5, -10), BackgroundTransparency = 1, Parent = btn,
	}, { corner(2) })
	local iconBox, iconParts = iconBuilder(THEME.TextMuted)
	iconBox.Position = UDim2.fromOffset(14, 12)
	iconBox.Parent = btn
	local label = new("TextLabel", {
		Name = "Label", Text = name, Font = Enum.Font.GothamMedium, TextSize = 14,
		TextColor3 = THEME.TextMuted, TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1, Position = UDim2.fromOffset(42, 0),
		Size = UDim2.new(1, -50, 1, 0), Parent = btn,
	})
	local tabData = { name = name, button = btn, indicator = indicator, iconParts = iconParts, label = label, page = page }
	table.insert(tabs, tabData)
	return tabData
end

local homeTab     = createTab("Home", iconHouse, homePage, 1)
local gameTab     = createTab("Game", iconController, gamePage, 2)
local gamesTab    = createTab("Games List", iconList, gamesPage, 3)
local settingsTab = createTab("Settings", iconSliders, settingsPage, 4)
local aboutTab    = createTab("About", iconInfo, aboutPage, 5)

-- ============================================================
-- TAB SWITCHING
-- ============================================================

local function selectTab(tabData)
	if activeTab == tabData then return end
	activeTab = tabData
	for _, t in ipairs(tabs) do
		local isActive = (t == tabData)
		tween(t.button, { BackgroundTransparency = isActive and 0 or 1 }, 0.15)
		tween(t.indicator, { BackgroundTransparency = isActive and 0 or 1 }, 0.15)
		setIconColor(t.iconParts, isActive and THEME.Accent or THEME.TextMuted, true)
		tween(t.label, { TextColor3 = isActive and THEME.TextPrimary or THEME.TextMuted }, 0.15)
		t.page.Visible = isActive
	end
end

_G.FlixHub.selectTab = selectTab
_G.FlixHub.tabs = tabs

for _, t in ipairs(tabs) do
	t.button.MouseButton1Click:Connect(function() selectTab(t) end)
	t.button.MouseEnter:Connect(function() if activeTab ~= t then tween(t.button, { BackgroundTransparency = 0.7 }, 0.12) end end)
	t.button.MouseLeave:Connect(function() if activeTab ~= t then tween(t.button, { BackgroundTransparency = 1 }, 0.12) end end)
end

selectTab(homeTab)

-- ============================================================
-- DRAGGING
-- ============================================================

do
	local dragging, dragStart, startPos = false, nil, nil
	topBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = input.Position; startPos = main.Position
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local d = input.Position - dragStart
			main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
end

-- ============================================================
-- KEYBIND
-- ============================================================

local isTopLeft = false
local centerPosition = UDim2.new(0.5, -WINDOW_SIZE.X.Offset / 2, 0.5, -WINDOW_SIZE.Y.Offset / 2)
local topLeftPosition = UDim2.new(0, 10, 0, 10)

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.RightControl then
		screenGui.Enabled = not screenGui.Enabled
		if screenGui.Enabled then
			isMinimized = false; body.Visible = true
			main.Size = UDim2.new(0, WINDOW_SIZE.X.Offset, 0, 0)
			tween(main, { Size = WINDOW_SIZE }, 0.2)
		end
	elseif input.KeyCode == Enum.KeyCode.RightAlt then
		if screenGui.Enabled and main.Visible then
			isTopLeft = not isTopLeft
			local target = isTopLeft and topLeftPosition or centerPosition
			tween(main, { Position = target }, 0.2, Enum.EasingStyle.Quad)
		end
	end
end)

-- MenuOpen handler removed - CoreGui renders above pause menu

-- ============================================================
-- LOAD GAME SCRIPT
-- ============================================================

local gameScriptPath = "Games/" .. CURRENT_PLACE_ID .. ".lua"
local found = false
for _, g in ipairs(GAMES) do
	if g.placeId == CURRENT_PLACE_ID then found = true; break end
end

local function tryAutoLoad()
	-- try local file first
	local ok = pcall(function()
		local src = readfile(gameScriptPath)
		loadstring(src)()
	end)
	if ok then
		print("[FlixHub] Auto-loaded " .. gameScriptPath)
		return true
	end
	-- try github
	local ok2, src2 = pcall(function()
		return game:HttpGet(GITHUB_RAW .. "/Games/" .. CURRENT_PLACE_ID .. ".lua")
	end)
	if ok2 and src2 and src2 ~= "" then
		local ok3, _ = pcall(function() loadstring(src2)() end)
		if ok3 then
			print("[FlixHub] Loaded from GitHub: " .. CURRENT_PLACE_ID)
			return true
		end
	end
	return false
end

if found then
	if not tryAutoLoad() then
		print("[FlixHub] Run this to load game features:")
		print("[FlixHub] execute-file " .. gameScriptPath)
	end
else
	print("[FlixHub] No scripts for this game (PlaceId: " .. CURRENT_PLACE_ID .. ")")
end
