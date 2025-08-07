-- FlixHubModern - Ultra Modern Roblox Script Hub
-- Next-Generation UI/UX Design with Glassmorphism & Animations
-- Created by FlixHub Team

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Modern Color Schemes
local themes = {
    Dark = {
        primary = Color3.fromRGB(15, 15, 20),
        secondary = Color3.fromRGB(25, 25, 35),
        accent = Color3.fromRGB(100, 150, 255),
        text = Color3.fromRGB(255, 255, 255),
        textSecondary = Color3.fromRGB(180, 180, 200),
        success = Color3.fromRGB(50, 205, 50),
        error = Color3.fromRGB(255, 75, 75),
        warning = Color3.fromRGB(255, 165, 0)
    },
    Neon = {
        primary = Color3.fromRGB(10, 10, 25),
        secondary = Color3.fromRGB(20, 20, 40),
        accent = Color3.fromRGB(0, 255, 255),
        text = Color3.fromRGB(255, 255, 255),
        textSecondary = Color3.fromRGB(200, 200, 255),
        success = Color3.fromRGB(0, 255, 128),
        error = Color3.fromRGB(255, 50, 100),
        warning = Color3.fromRGB(255, 200, 0)
    },
    Sunset = {
        primary = Color3.fromRGB(25, 15, 35),
        secondary = Color3.fromRGB(40, 25, 50),
        accent = Color3.fromRGB(255, 100, 150),
        text = Color3.fromRGB(255, 255, 255),
        textSecondary = Color3.fromRGB(220, 200, 220),
        success = Color3.fromRGB(100, 255, 150),
        error = Color3.fromRGB(255, 100, 100),
        warning = Color3.fromRGB(255, 180, 100)
    },
    Cyber = {
        primary = Color3.fromRGB(5, 5, 15),
        secondary = Color3.fromRGB(15, 15, 30),
        accent = Color3.fromRGB(0, 255, 170),
        text = Color3.fromRGB(0, 255, 170),
        textSecondary = Color3.fromRGB(100, 255, 200),
        success = Color3.fromRGB(0, 255, 0),
        error = Color3.fromRGB(255, 0, 100),
        warning = Color3.fromRGB(255, 255, 0)
    }
}

-- Real Game Scripts Database from FlixHub.lua
local GameScripts = {
    ["Grow A Garden"] = {
        {
            name = "No Lag",
            description = "Reduces lag and improves performance",
            script = [[loadstring(game:HttpGet('https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Garden/Garden-V1.lua'))()]]
        },
        {
            name = "eF Hub",
            description = "Multi-purpose exploit hub",
            script = [[loadstring(game:HttpGet('https://api.exploitingis.fun/loader', true))()]]
        },
        {
            name = "IdiotHub",
            description = "IdiotHub script loader for Grow A Garden",
            script = [[loadstring(game:HttpGet('https://raw.githubusercontent.com/Idiot121314/IdiotHub/main/Loader.lua'))()]]
        },
        {
            name = "BlackHub",
            description = "BlackHub script for Grow A Garden",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Skibidiking123/Fisch1/refs/heads/main/FischMain"))()]]
        },
        {
            name = "ShovelHub (Not Good)",
            description = "ShovelHub script - quality may vary",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/shvl00/shvled/refs/heads/main/l04d3r.bf"))()]]
        }
    },
    ["Poop Simulator"] = {
        {
            name = "AUTO Poop & AUTO Sell",
            description = "Automatic pooping and selling features",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/sylolua/mine/refs/heads/main/Poop",true))()]]
        }
    },
    ["Slippery Stairs"] = {
        {
            name = "INF CRYSTALS",
            description = "Infinite crystals exploit",
            script = [[loadstring(game:HttpGet("https://pastebin.com/raw/5ez3xPtJ"))()]]
        }
    },
    ["Strongest Battle"] = {
        {
            name = "TSB Auto Farm",
            description = "Auto farm script for The Strongest Battleground",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Viunze/ZeCuree2/refs/heads/main/Zertex.lua"))()]]
        }
    },
    ["99 Nights Forest"] = {
        {
            name = "eF Hub (Only PC)",
            description = "Overpowered farming script for 99 Nights",
            script = [[loadstring(game:HttpGet('https://api.exploitingis.fun/loader', true))()]]
        },
        {
            name = "GoaHub",
            description = "GOA Hub script for 99 Nights in the Forest",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Nevcit/GOA_HUB/refs/heads/main/99%20Nights%20In%20The%20Forest"))()]]
        },
        {
            name = "SolunaHub (Solo)",
            description = "SolunaHub solo farming script",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/SolunaScripts/SolunaHub/main/SolunaHub%20Solo"))()]]
        },
        {
            name = "FastHub (Only PC)",
            description = "Fast farming hub for 99 Nights in the Forest",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/adibhub1/99-nighit-in-forest/refs/heads/main/99%20night%20in%20forest"))()]]
        },
        {
            name = "OP Script",
            description = "Best overpowered script for 99 Nights in the Forest",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Iliankytb/Iliankytb/main/Best99NightsInTheForest"))()]]
        },
        {
            name = "LinuxHub",
            description = "LinuxHub script for 99 Nights in the Forest",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/LinuxDevBr/99-Nights-In-the-Forest/refs/heads/main/Script.txt"))()]]
        },
        {
            name = "HutaoHub",
            description = "Hutao Hub script for 99 Nights in the Forest",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/SLK-gaming/Hutao-Hub/refs/heads/main/99-Nights-In-The-Forest.txt"))()]]
        },
        {
            name = "Vape Script (Not The Best)",
            description = "Vape script for 99 Nights in the Forest (basic version)",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VWExtra/main/NightsInTheForest.lua", true))()]]
        },
        {
            name = "RingstaUI",
            description = "RingstaUI script for 99 Nights in the Forest",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/wefwef127382/99daysloader.github.io/refs/heads/main/ringta.lua"))()]]
        }
    },
    ["Ink Game"] = {
        {
            name = "NeoxHub (Not Tested)",
            description = "Automated farming script for Ink Game",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/NEOXHUBMAIN/refs/heads/main/InkGame"))()]]
        }
    },
    ["Steal A Brainrot"] = {
        {
            name = "Instant Steal (Not Working)",
            description = "Instant steal script for Steal A Brainrot game",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StealaBrainrotMOD"))()]]
        },
        {
            name = "Brainrot Stealer",
            description = "Brainrot stealing script",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/BrainrotStealer/StealBrainrot/main/Steal%20Brainrot"))()]]
        }
    },
    ["Life Sentence"] = {
        {
            name = "BeanzHub",
            description = "BeanzHub script for Life Sentence game",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/pid4k/scripts/main/BeanzHub.lua", true))()]]
        },
        {
            name = "Astral",
            description = "Astral script for Life Sentence game",
            script = [[loadstring(game:HttpGet("https://api.astral.gold/script"))()]]
        }
    },
    ["Build A Boat"] = {
        {
            name = "Inf Save Slots",
            description = "Get unlimited save slots for your boats",
            script = [[local slotsyouwant = 100 -- Put the amount of slots you want
-- ignore
for i = 1, slotsyouwant do
    task.spawn(function()
        local args = {
            [1] = 1,
            [2] = tostring(i) .. "\0", 
            [3] = 0,
            [4] = ""
        }
        workspace:WaitForChild("UpdateSlotOrderRE"):FireServer(unpack(args))
    end)
end]]
        },
        {
            name = "Auto Farm",
            description = "Automatic farming script for Build A Boat",
            script = [[loadstring(game:HttpGet("https://orbitsc.net/babft"))()]]
        }
    },
    ["Fisch"] = {
        {
            name = "SpeedHub X",
            description = "SpeedHub X script for Fisch game",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()]]
        }
    },
    ["VolleyBall Legends"] = {
        {
            name = "SigmaHub",
            description = "SigmaHub script for VolleyBall Legends game",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Xm2iufas09ijmF/sigma-hub/refs/heads/main/temp.lua"))()]]
        }
    }
}

-- Universal Scripts (Not in Games category)
local UniversalScripts = {
    {
        name = "Infinite Yield",
        description = "Admin commands script with tons of features",
        script = [[loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()]]
    },
    {
        name = "Dark Dex V3",
        description = "Advanced explorer for Roblox games",
        script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()]]
    },
    {
        name = "Simple Spy",
        description = "Remote spy for debugging and scripting",
        script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()]]
    },
    {
        name = "Universal ESP",
        description = "See players through walls",
        script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua"))()]]
    },
    {
        name = "Solara Hub",
        description = "Really Good Scripts",
        script = [[loadstring(game:HttpGet("https://pastebin.com/raw/ixdvHv2g"))()]]
    }
}

-- FE Scripts (Not in Games category)
local FEScripts = {
    {
        name = "FE Sus Hub",
        description = "Frontend exploit Sus Hub script",
        script = [[loadstring(game:HttpGet("https://protected-roblox-scripts.onrender.com/2219bf48b54cd405ed94c32097f07c21"))()]]
    },
    {
        name = "FE Troll Hub",
        description = "Frontend exploit Troll Hub script",
        script = [[loadstring(game:HttpGet("https://pastebin.com/raw/hkyuHQ7Y"))()]]
    },
    {
        name = "FE Jerk Off",
        description = "Frontend Jerk Off script for R6",
        script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/imalwaysad/universal-gui/refs/heads/main/jerk%20off%20r6"))()]]
    },
    {
        name = "FE Invisible",
        description = "Frontend invisible script",
        script = [[loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invisible-script-20557"))()]]
    },
    {
        name = "FE Fake Lag (R6 & R15)",
        description = "Frontend fake lag script for R6 and R15",
        script = [[loadstring(game:HttpGet('https://pastebin.com/raw/VM3b0Thg'))()]]
    }
}

-- Animation Functions
local function createTween(object, properties, duration, easingStyle)
    local tweenInfo = TweenInfo.new(duration or 0.3, easingStyle or Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    return TweenService:Create(object, tweenInfo, properties)
end

local function fadeIn(element, duration)
    element.Visible = true
    element.BackgroundTransparency = 1
    createTween(element, {BackgroundTransparency = 0.1}, duration or 0.5):Play()
end

local function fadeOut(element, duration)
    local tween = createTween(element, {BackgroundTransparency = 1}, duration or 0.3)
    tween.Completed:Connect(function() element.Visible = false end)
    tween:Play()
end

-- Modern UI Creation
local function createMainUI()
    local FlixHubModern = Instance.new("ScreenGui")
    FlixHubModern.Name = "FlixHubModern"
    FlixHubModern.Parent = playerGui
    FlixHubModern.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    FlixHubModern.ResetOnSpawn = false

    -- Main Container with Glassmorphism
    local MainContainer = Instance.new("Frame")
    MainContainer.Name = "MainContainer"
    MainContainer.Parent = FlixHubModern
    MainContainer.BackgroundColor3 = themes.Dark.primary
    MainContainer.BackgroundTransparency = 0.05
    MainContainer.BorderSizePixel = 0
    MainContainer.Position = UDim2.new(0.5, -400, 0.5, -300)
    MainContainer.Size = UDim2.new(0, 800, 0, 600)
    MainContainer.Visible = false
    MainContainer.ZIndex = 100

    -- Main Container Corner
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 20)
    MainCorner.Parent = MainContainer

    -- Main Container Stroke
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = themes.Dark.accent
    MainStroke.Thickness = 2
    MainStroke.Transparency = 0.7
    MainStroke.Parent = MainContainer

    -- Main Container Gradient
    local MainGradient = Instance.new("UIGradient")
    MainGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, themes.Dark.primary),
        ColorSequenceKeypoint.new(0.5, themes.Dark.secondary),
        ColorSequenceKeypoint.new(1, themes.Dark.primary)
    }
    MainGradient.Rotation = 45
    MainGradient.Parent = MainContainer

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainContainer
    TitleBar.BackgroundColor3 = themes.Dark.secondary
    TitleBar.BackgroundTransparency = 0.1
    TitleBar.BorderSizePixel = 0
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
    TitleBar.ZIndex = 101

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 20)
    TitleCorner.Parent = TitleBar

    -- Title Text
    local TitleText = Instance.new("TextLabel")
    TitleText.Name = "TitleText"
    TitleText.Parent = TitleBar
    TitleText.BackgroundTransparency = 1
    TitleText.Position = UDim2.new(0, 20, 0, 0)
    TitleText.Size = UDim2.new(0, 200, 1, 0)
    TitleText.Font = Enum.Font.GothamBold
    TitleText.Text = "✨ FlixHubModern"
    TitleText.TextColor3 = themes.Dark.accent
    TitleText.TextSize = 18
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.ZIndex = 102

    -- Control Buttons
    local Controls = {}
    
    -- Minimize Button
    Controls.Minimize = Instance.new("TextButton")
    Controls.Minimize.Name = "MinimizeButton"
    Controls.Minimize.Parent = TitleBar
    Controls.Minimize.BackgroundColor3 = themes.Dark.success
    Controls.Minimize.BackgroundTransparency = 0.2
    Controls.Minimize.BorderSizePixel = 0
    Controls.Minimize.Position = UDim2.new(1, -110, 0, 10)
    Controls.Minimize.Size = UDim2.new(0, 30, 0, 30)
    Controls.Minimize.Font = Enum.Font.GothamBold
    Controls.Minimize.Text = "−"
    Controls.Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
    Controls.Minimize.TextSize = 16
    Controls.Minimize.ZIndex = 102

    -- Settings Button
    Controls.Settings = Instance.new("TextButton")
    Controls.Settings.Name = "SettingsButton"
    Controls.Settings.Parent = TitleBar
    Controls.Settings.BackgroundColor3 = themes.Dark.accent
    Controls.Settings.BackgroundTransparency = 0.2
    Controls.Settings.BorderSizePixel = 0
    Controls.Settings.Position = UDim2.new(1, -75, 0, 10)
    Controls.Settings.Size = UDim2.new(0, 30, 0, 30)
    Controls.Settings.Font = Enum.Font.GothamMedium
    Controls.Settings.Text = "⚙"
    Controls.Settings.TextColor3 = Color3.fromRGB(255, 255, 255)
    Controls.Settings.TextSize = 14
    Controls.Settings.ZIndex = 102

    -- Close Button
    Controls.Close = Instance.new("TextButton")
    Controls.Close.Name = "CloseButton"
    Controls.Close.Parent = TitleBar
    Controls.Close.BackgroundColor3 = themes.Dark.error
    Controls.Close.BackgroundTransparency = 0.2
    Controls.Close.BorderSizePixel = 0
    Controls.Close.Position = UDim2.new(1, -40, 0, 10)
    Controls.Close.Size = UDim2.new(0, 30, 0, 30)
    Controls.Close.Font = Enum.Font.GothamBold
    Controls.Close.Text = "×"
    Controls.Close.TextColor3 = Color3.fromRGB(255, 255, 255)
    Controls.Close.TextSize = 16
    Controls.Close.ZIndex = 102

    -- Corner for buttons
    for _, button in pairs(Controls) do
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = button
    end

    -- Sidebar with Modern Design
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainContainer
    Sidebar.BackgroundColor3 = themes.Dark.secondary
    Sidebar.BackgroundTransparency = 0.05
    Sidebar.BorderSizePixel = 0
    Sidebar.Position = UDim2.new(0, 0, 0, 50)
    Sidebar.Size = UDim2.new(0, 200, 1, -50)
    Sidebar.ZIndex = 101

    -- Sidebar Gradient
    local SidebarGradient = Instance.new("UIGradient")
    SidebarGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, themes.Dark.secondary),
        ColorSequenceKeypoint.new(1, themes.Dark.primary)
    }
    SidebarGradient.Rotation = 90
    SidebarGradient.Parent = Sidebar

    -- Search Bar
    local SearchBar = Instance.new("TextBox")
    SearchBar.Name = "SearchBar"
    SearchBar.Parent = Sidebar
    SearchBar.BackgroundColor3 = themes.Dark.primary
    SearchBar.BackgroundTransparency = 0.3
    SearchBar.BorderSizePixel = 0
    SearchBar.Position = UDim2.new(0, 10, 0, 10)
    SearchBar.Size = UDim2.new(1, -20, 0, 35)
    SearchBar.Font = Enum.Font.GothamMedium
    SearchBar.PlaceholderText = "🔍 Search scripts..."
    SearchBar.Text = ""
    SearchBar.TextColor3 = themes.Dark.text
    SearchBar.TextSize = 12
    SearchBar.ZIndex = 102

    local SearchCorner = Instance.new("UICorner")
    SearchCorner.CornerRadius = UDim.new(0, 10)
    SearchCorner.Parent = SearchBar

    -- Search Stroke
    local SearchStroke = Instance.new("UIStroke")
    SearchStroke.Color = themes.Dark.accent
    SearchStroke.Transparency = 0.8
    SearchStroke.Thickness = 1
    SearchStroke.Parent = SearchBar

    -- Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Parent = MainContainer
    ContentArea.BackgroundTransparency = 1
    ContentArea.BorderSizePixel = 0
    ContentArea.Position = UDim2.new(0, 200, 0, 50)
    ContentArea.Size = UDim2.new(1, -200, 1, -50)
    ContentArea.ZIndex = 101

    -- Scripts Container
    local ScriptsContainer = Instance.new("ScrollingFrame")
    ScriptsContainer.Name = "ScriptsContainer"
    ScriptsContainer.Parent = ContentArea
    ScriptsContainer.BackgroundTransparency = 1
    ScriptsContainer.BorderSizePixel = 0
    ScriptsContainer.Position = UDim2.new(0, 20, 0, 20)
    ScriptsContainer.Size = UDim2.new(1, -40, 1, -40)
    ScriptsContainer.ScrollBarThickness = 6
    ScriptsContainer.ScrollBarImageColor3 = themes.Dark.accent
    ScriptsContainer.ZIndex = 102

    local ScriptsLayout = Instance.new("UIGridLayout")
    ScriptsLayout.Parent = ScriptsContainer
    ScriptsLayout.CellSize = UDim2.new(0, 280, 0, 120)
    ScriptsLayout.CellPadding = UDim2.new(0, 15, 0, 15)
    ScriptsLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Settings Panel
    local SettingsPanel = Instance.new("Frame")
    SettingsPanel.Name = "SettingsPanel"
    SettingsPanel.Parent = MainContainer
    SettingsPanel.BackgroundColor3 = themes.Dark.primary
    SettingsPanel.BackgroundTransparency = 0.05
    SettingsPanel.BorderSizePixel = 0
    SettingsPanel.Position = UDim2.new(0.5, -150, 0.5, -200)
    SettingsPanel.Size = UDim2.new(0, 300, 0, 400)
    SettingsPanel.Visible = false
    SettingsPanel.ZIndex = 200

    local SettingsCorner = Instance.new("UICorner")
    SettingsCorner.CornerRadius = UDim.new(0, 15)
    SettingsCorner.Parent = SettingsPanel

    local SettingsStroke = Instance.new("UIStroke")
    SettingsStroke.Color = themes.Dark.accent
    SettingsStroke.Thickness = 2
    SettingsStroke.Transparency = 0.7
    SettingsStroke.Parent = SettingsPanel

    -- Settings Title
    local SettingsTitle = Instance.new("TextLabel")
    SettingsTitle.Name = "SettingsTitle"
    SettingsTitle.Parent = SettingsPanel
    SettingsTitle.BackgroundTransparency = 1
    SettingsTitle.Position = UDim2.new(0, 0, 0, 20)
    SettingsTitle.Size = UDim2.new(1, 0, 0, 30)
    SettingsTitle.Font = Enum.Font.GothamBold
    SettingsTitle.Text = "Settings"
    SettingsTitle.TextColor3 = themes.Dark.accent
    SettingsTitle.TextSize = 18
    SettingsTitle.ZIndex = 201

    -- Initialize
    local currentTheme = "Dark"
    local currentCategory = "Universal"

    -- Theme Application
    local function applyTheme(themeName)
        currentTheme = themeName
        local theme = themes[themeName]
        
        -- Apply theme to all elements
        MainContainer.BackgroundColor3 = theme.primary
        TitleBar.BackgroundColor3 = theme.secondary
        Sidebar.BackgroundColor3 = theme.secondary
        
        -- Update strokes
        MainStroke.Color = theme.accent
        SettingsStroke.Color = theme.accent
        SearchStroke.Color = theme.accent
        
        -- Update text colors
        TitleText.TextColor3 = theme.accent
        SettingsTitle.TextColor3 = theme.accent
    end

    -- Create Script Cards
    local function createScriptCard(scriptData, index)
        local Card = Instance.new("Frame")
        Card.Name = "ScriptCard" .. index
        Card.Parent = ScriptsContainer
        Card.BackgroundColor3 = themes.Dark.secondary
        Card.BackgroundTransparency = 0.1
        Card.BorderSizePixel = 0
        Card.ZIndex = 103

        local CardCorner = Instance.new("UICorner")
        CardCorner.CornerRadius = UDim.new(0, 12)
        CardCorner.Parent = Card

        local CardStroke = Instance.new("UIStroke")
        CardStroke.Color = themes.Dark.accent
        CardStroke.Transparency = 0.8
        CardStroke.Thickness = 1
        CardStroke.Parent = Card

        -- Script Name
        local ScriptName = Instance.new("TextLabel")
        ScriptName.Name = "ScriptName"
        ScriptName.Parent = Card
        ScriptName.BackgroundTransparency = 1
        ScriptName.Position = UDim2.new(0, 15, 0, 15)
        ScriptName.Size = UDim2.new(1, -30, 0, 25)
        ScriptName.Font = Enum.Font.GothamBold
        ScriptName.Text = scriptData.name
        ScriptName.TextColor3 = themes.Dark.text
        ScriptName.TextSize = 14
        ScriptName.TextXAlignment = Enum.TextXAlignment.Left
        ScriptName.ZIndex = 104

        -- Script Description
        local ScriptDesc = Instance.new("TextLabel")
        ScriptDesc.Name = "ScriptDesc"
        ScriptDesc.Parent = Card
        ScriptDesc.BackgroundTransparency = 1
        ScriptDesc.Position = UDim2.new(0, 15, 0, 40)
        ScriptDesc.Size = UDim2.new(1, -30, 0, 45)
        ScriptDesc.Font = Enum.Font.GothamMedium
        ScriptDesc.Text = scriptData.description
        ScriptDesc.TextColor3 = themes.Dark.textSecondary
        ScriptDesc.TextSize = 11
        ScriptDesc.TextWrapped = true
        ScriptDesc.TextXAlignment = Enum.TextXAlignment.Left
        ScriptDesc.ZIndex = 104

        -- Execute Button
        local ExecuteButton = Instance.new("TextButton")
        ExecuteButton.Name = "ExecuteButton"
        ExecuteButton.Parent = Card
        ExecuteButton.BackgroundColor3 = themes.Dark.accent
        ExecuteButton.BackgroundTransparency = 0.2
        ExecuteButton.BorderSizePixel = 0
        ExecuteButton.Position = UDim2.new(0, 15, 1, -35)
        ExecuteButton.Size = UDim2.new(1, -30, 0, 25)
        ExecuteButton.Font = Enum.Font.GothamMedium
        ExecuteButton.Text = "Execute"
        ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ExecuteButton.TextSize = 12
        ExecuteButton.ZIndex = 104

        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = ExecuteButton

        -- Hover Effects
        ExecuteButton.MouseEnter:Connect(function()
            createTween(ExecuteButton, {BackgroundTransparency = 0.1}, 0.2):Play()
            createTween(CardStroke, {Transparency = 0.5}, 0.2):Play()
        end)

        ExecuteButton.MouseLeave:Connect(function()
            createTween(ExecuteButton, {BackgroundTransparency = 0.2}, 0.2):Play()
            createTween(CardStroke, {Transparency = 0.8}, 0.2):Play()
        end)

        -- Execute Script
        ExecuteButton.MouseButton1Click:Connect(function()
            ExecuteButton.Text = "Loading..."
            createTween(ExecuteButton, {BackgroundColor3 = themes.Dark.success}, 0.3):Play()
            
            task.spawn(function()
                local success, result = pcall(function()
                    loadstring(scriptData.script)()
                end)
                
                if success then
                    ExecuteButton.Text = "Executed!"
                    createTween(ExecuteButton, {BackgroundColor3 = themes.Dark.success}, 0.3):Play()
                    task.wait(1)
                    ExecuteButton.Text = "Execute"
                    createTween(ExecuteButton, {BackgroundColor3 = themes.Dark.accent}, 0.3):Play()
                else
                    ExecuteButton.Text = "Error"
                    createTween(ExecuteButton, {BackgroundColor3 = themes.Dark.error}, 0.3):Play()
                    task.wait(1)
                    ExecuteButton.Text = "Execute"
                    createTween(ExecuteButton, {BackgroundColor3 = themes.Dark.accent}, 0.3):Play()
                end
            end)
        end)

        return Card
    end

    -- Load Scripts for Category
    local function loadScripts(category)
        currentCategory = category
        
        -- Clear existing cards
        for _, child in pairs(ScriptsContainer:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end

        -- Load new cards from appropriate table
        local scripts = {}
        if category == "Universal" then
            scripts = UniversalScripts
        elseif category == "FE" then
            scripts = FEScripts
        else
            scripts = GameScripts[category] or {}
        end
        
        for index, scriptData in ipairs(scripts) do
            createScriptCard(scriptData, index)
        end
    end

    -- Create Sidebar Tabs
    local function createTab(name, position)
        local Tab = Instance.new("TextButton")
        Tab.Name = name .. "Tab"
        Tab.Parent = Sidebar
        Tab.BackgroundColor3 = themes.Dark.secondary
        Tab.BackgroundTransparency = 0.3
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0, 10, 0, 60 + (position * 45))
        Tab.Size = UDim2.new(1, -20, 0, 35)
        Tab.Font = Enum.Font.GothamMedium
        Tab.Text = name
        Tab.TextColor3 = themes.Dark.textSecondary
        Tab.TextSize = 12
        Tab.ZIndex = 103

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = Tab

        Tab.MouseButton1Click:Connect(function()
            loadScripts(name)
            
            -- Update tab colors
            for _, tab in pairs(Sidebar:GetChildren()) do
                if tab:IsA("TextButton") then
                    tab.BackgroundColor3 = themes.Dark.secondary
                    tab.TextColor3 = themes.Dark.textSecondary
                end
            end
            
            Tab.BackgroundColor3 = themes.Dark.accent
            Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        return Tab
    end

    -- Initialize Tabs
    local categories = {"Universal", "FE", "Grow A Garden", "Poop Simulator", "Slippery Stairs", "Strongest Battle", "99 Nights Forest", "Ink Game", "Steal A Brainrot", "Life Sentence", "Build A Boat", "Fisch", "VolleyBall Legends"}
    for i, category in ipairs(categories) do
        createTab(category, i - 1)
    end

    -- Search Functionality
    SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
        local searchText = SearchBar.Text:lower()
        
        -- Clear existing cards
        for _, child in pairs(ScriptsContainer:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end

        -- Search across all categories
        local foundScripts = {}
        for category, scripts in pairs(GameScripts) do
            for _, scriptData in ipairs(scripts) do
                if scriptData.name:lower():find(searchText) or 
                   scriptData.description:lower():find(searchText) then
                    table.insert(foundScripts, scriptData)
                end
            end
        end

        -- Display results
        for index, scriptData in ipairs(foundScripts) do
            createScriptCard(scriptData, index)
        end
    end)

    -- Control Button Events
    Controls.Minimize.MouseButton1Click:Connect(function()
        MainContainer.Visible = false
        StarterGui:SetCore("SendNotification", {
            Title = "FlixHubModern",
            Text = "Minimized to taskbar",
            Duration = 2
        })
    end)

    Controls.Settings.MouseButton1Click:Connect(function()
        SettingsPanel.Visible = not SettingsPanel.Visible
        createTween(SettingsPanel, {Size = SettingsPanel.Visible and UDim2.new(0, 300, 0, 400) or UDim2.new(0, 0, 0, 0)}, 0.3):Play()
    end)

    Controls.Close.MouseButton1Click:Connect(function()
        FlixHubModern:Destroy()
    end)

    -- Entrance Animation
    MainContainer.Visible = true
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    MainContainer.BackgroundTransparency = 1
    
    local entranceTween = createTween(MainContainer, {
        Size = UDim2.new(0, 800, 0, 600),
        BackgroundTransparency = 0.05
    }, 0.8, Enum.EasingStyle.Back)
    
    entranceTween:Play()
    
    -- Load initial scripts
    loadScripts("Universal")
    
    -- Welcome notification
    task.wait(1)
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHubModern",
        Text = "Modern UI loaded successfully!",
        Duration = 3
    })

    return FlixHubModern
end

-- Create the modern UI
createMainUI()
