-- FlixHub - Advanced Roblox Script Hub
-- Created by FlixHub Team
-- Features: Search, Categories, Keyless Scripts

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create main ScreenGui
local FlixHub = Instance.new("ScreenGui")
FlixHub.Name = "FlixHub"
FlixHub.Parent = playerGui
FlixHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FlixHub.ResetOnSpawn = false

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = FlixHub
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

-- Corner rounding for main frame
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Drop shadow effect
local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Parent = MainFrame
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.7
Shadow.BorderSizePixel = 0
Shadow.Position = UDim2.new(0, 5, 0, 5)
Shadow.Size = UDim2.new(1, 0, 1, 0)
Shadow.ZIndex = -1

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 12)
ShadowCorner.Parent = Shadow

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

-- Title Text
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Size = UDim2.new(0, 200, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "FlixHub v2.0"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 75)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton

-- Settings Button
local SettingsButton = Instance.new("TextButton")
SettingsButton.Name = "SettingsButton"
SettingsButton.Parent = TitleBar
SettingsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
SettingsButton.BorderSizePixel = 0
SettingsButton.Position = UDim2.new(1, -105, 0, 5)
SettingsButton.Size = UDim2.new(0, 30, 0, 30)
SettingsButton.Font = Enum.Font.GothamBold
SettingsButton.Text = "⚙"
SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsButton.TextSize = 14

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 6)
SettingsCorner.Parent = SettingsButton

-- Search Bar Container
local SearchContainer = Instance.new("Frame")
SearchContainer.Name = "SearchContainer"
SearchContainer.Parent = MainFrame
SearchContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
SearchContainer.BorderSizePixel = 0
SearchContainer.Position = UDim2.new(0, 15, 0, 55)
SearchContainer.Size = UDim2.new(1, -30, 0, 35)

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 8)
SearchCorner.Parent = SearchContainer

-- Search TextBox
local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Parent = SearchContainer
SearchBox.BackgroundTransparency = 1
SearchBox.Position = UDim2.new(0, 10, 0, 0)
SearchBox.Size = UDim2.new(1, -50, 1, 0)
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "Search for scripts..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 14
SearchBox.TextXAlignment = Enum.TextXAlignment.Left

-- Search Icon
local SearchIcon = Instance.new("TextLabel")
SearchIcon.Name = "SearchIcon"
SearchIcon.Parent = SearchContainer
SearchIcon.BackgroundTransparency = 1
SearchIcon.Position = UDim2.new(1, -35, 0, 0)
SearchIcon.Size = UDim2.new(0, 35, 1, 0)
SearchIcon.Font = Enum.Font.GothamBold
SearchIcon.Text = "🔍"
SearchIcon.TextColor3 = Color3.fromRGB(150, 150, 150)
SearchIcon.TextSize = 16

-- Category Container (Scrollable)
local CategoryContainer = Instance.new("ScrollingFrame")
CategoryContainer.Name = "CategoryContainer"
CategoryContainer.Parent = MainFrame
CategoryContainer.BackgroundTransparency = 1
CategoryContainer.BorderSizePixel = 0
CategoryContainer.Position = UDim2.new(0, 15, 0, 105)
CategoryContainer.Size = UDim2.new(1, -30, 0, 40)
CategoryContainer.ScrollingDirection = Enum.ScrollingDirection.X
CategoryContainer.ScrollBarThickness = 4
CategoryContainer.ScrollBarImageColor3 = Color3.fromRGB(75, 75, 100)
CategoryContainer.ScrollBarImageTransparency = 0.3
CategoryContainer.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be calculated dynamically

local CategoryLayout = Instance.new("UIListLayout")
CategoryLayout.Parent = CategoryContainer
CategoryLayout.FillDirection = Enum.FillDirection.Horizontal
CategoryLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
CategoryLayout.Padding = UDim.new(0, 10)

-- Script Container
local ScriptContainer = Instance.new("ScrollingFrame")
ScriptContainer.Name = "ScriptContainer"
ScriptContainer.Parent = MainFrame
ScriptContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ScriptContainer.BorderSizePixel = 0
ScriptContainer.Position = UDim2.new(0, 15, 0, 160)
ScriptContainer.Size = UDim2.new(1, -30, 1, -175)
ScriptContainer.ScrollBarThickness = 6
ScriptContainer.ScrollBarImageColor3 = Color3.fromRGB(75, 75, 100)

local ScriptCorner = Instance.new("UICorner")
ScriptCorner.CornerRadius = UDim.new(0, 8)
ScriptCorner.Parent = ScriptContainer

local ScriptLayout = Instance.new("UIListLayout")
ScriptLayout.Parent = ScriptContainer
ScriptLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScriptLayout.Padding = UDim.new(0, 5)

-- Settings Panel
local SettingsPanel = Instance.new("Frame")
SettingsPanel.Name = "SettingsPanel"
SettingsPanel.Parent = FlixHub
SettingsPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
SettingsPanel.BackgroundTransparency = 0.1
SettingsPanel.BorderSizePixel = 0
SettingsPanel.Position = UDim2.new(0.5, -150, 0.5, -100)
SettingsPanel.Size = UDim2.new(0, 300, 0, 220)
SettingsPanel.Visible = false
SettingsPanel.ZIndex = 10

local SettingsPanelCorner = Instance.new("UICorner")
SettingsPanelCorner.CornerRadius = UDim.new(0, 12)
SettingsPanelCorner.Parent = SettingsPanel

-- Settings Panel Shadow
local SettingsShadow = Instance.new("Frame")
SettingsShadow.Name = "SettingsShadow"
SettingsShadow.Parent = FlixHub
SettingsShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SettingsShadow.BackgroundTransparency = 0.8
SettingsShadow.BorderSizePixel = 0
SettingsShadow.Position = UDim2.new(0.5, -145, 0.5, -95)
SettingsShadow.Size = UDim2.new(0, 300, 0, 220)
SettingsShadow.Visible = false
SettingsShadow.ZIndex = 9

local SettingsShadowCorner = Instance.new("UICorner")
SettingsShadowCorner.CornerRadius = UDim.new(0, 12)
SettingsShadowCorner.Parent = SettingsShadow

-- Settings Title
local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Name = "SettingsTitle"
SettingsTitle.Parent = SettingsPanel
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Position = UDim2.new(0, 0, 0, 10)
SettingsTitle.Size = UDim2.new(1, 0, 0, 30)
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.Text = "FlixHub Settings"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTitle.TextSize = 16
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Center

-- Size Label
local SizeLabel = Instance.new("TextLabel")
SizeLabel.Name = "SizeLabel"
SizeLabel.Parent = SettingsPanel
SizeLabel.BackgroundTransparency = 1
SizeLabel.Position = UDim2.new(0, 20, 0, 50)
SizeLabel.Size = UDim2.new(0, 100, 0, 25)
SizeLabel.Font = Enum.Font.GothamMedium
SizeLabel.Text = "Hub Size:"
SizeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SizeLabel.TextSize = 14
SizeLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Very Small Size Button (Mobile)
local VerySmallButton = Instance.new("TextButton")
VerySmallButton.Name = "VerySmallButton"
VerySmallButton.Parent = SettingsPanel
VerySmallButton.BackgroundColor3 = Color3.fromRGB(75, 125, 255)  -- Highlighted as default
VerySmallButton.BorderSizePixel = 0
VerySmallButton.Position = UDim2.new(0, 20, 0, 80)
VerySmallButton.Size = UDim2.new(0, 120, 0, 30)
VerySmallButton.Font = Enum.Font.GothamMedium
VerySmallButton.Text = "Very Small (Mobile)"
VerySmallButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VerySmallButton.TextSize = 10

local VerySmallCorner = Instance.new("UICorner")
VerySmallCorner.CornerRadius = UDim.new(0, 6)
VerySmallCorner.Parent = VerySmallButton

-- Small Size Button
local SmallButton = Instance.new("TextButton")
SmallButton.Name = "SmallButton"
SmallButton.Parent = SettingsPanel
SmallButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
SmallButton.BorderSizePixel = 0
SmallButton.Position = UDim2.new(0, 160, 0, 80)
SmallButton.Size = UDim2.new(0, 120, 0, 30)
SmallButton.Font = Enum.Font.GothamMedium
SmallButton.Text = "Small"
SmallButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SmallButton.TextSize = 12

local SmallCorner = Instance.new("UICorner")
SmallCorner.CornerRadius = UDim.new(0, 6)
SmallCorner.Parent = SmallButton

-- Medium Size Button
local MediumButton = Instance.new("TextButton")
MediumButton.Name = "MediumButton"
MediumButton.Parent = SettingsPanel
MediumButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MediumButton.BorderSizePixel = 0
MediumButton.Position = UDim2.new(0, 20, 0, 120)
MediumButton.Size = UDim2.new(0, 120, 0, 30)
MediumButton.Font = Enum.Font.GothamMedium
MediumButton.Text = "Medium"
MediumButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MediumButton.TextSize = 12

local MediumCorner = Instance.new("UICorner")
MediumCorner.CornerRadius = UDim.new(0, 6)
MediumCorner.Parent = MediumButton

-- Large Size Button
local LargeButton = Instance.new("TextButton")
LargeButton.Name = "LargeButton"
LargeButton.Parent = SettingsPanel
LargeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
LargeButton.BorderSizePixel = 0
LargeButton.Position = UDim2.new(0, 160, 0, 120)
LargeButton.Size = UDim2.new(0, 120, 0, 30)
LargeButton.Font = Enum.Font.GothamMedium
LargeButton.Text = "Large"
LargeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LargeButton.TextSize = 12

local LargeCorner = Instance.new("UICorner")
LargeCorner.CornerRadius = UDim.new(0, 6)
LargeCorner.Parent = LargeButton

-- Close Settings Button
local CloseSettingsButton = Instance.new("TextButton")
CloseSettingsButton.Name = "CloseSettingsButton"
CloseSettingsButton.Parent = SettingsPanel
CloseSettingsButton.BackgroundColor3 = Color3.fromRGB(200, 75, 75)
CloseSettingsButton.BorderSizePixel = 0
CloseSettingsButton.Position = UDim2.new(0.5, -40, 0, 170)
CloseSettingsButton.Size = UDim2.new(0, 80, 0, 30)
CloseSettingsButton.Font = Enum.Font.GothamMedium
CloseSettingsButton.Text = "Close"
CloseSettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseSettingsButton.TextSize = 12

local CloseSettingsCorner = Instance.new("UICorner")
CloseSettingsCorner.CornerRadius = UDim.new(0, 6)
CloseSettingsCorner.Parent = CloseSettingsButton

-- Script Database
local ScriptDatabase = {
    ["Universal"] = {
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
    },
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
    }
}

local currentCategory = "Universal"
local filteredScripts = {}

-- Functions
local function createCategoryButton(categoryName)
    local CategoryButton = Instance.new("TextButton")
    CategoryButton.Name = categoryName
    CategoryButton.Parent = CategoryContainer
    CategoryButton.BackgroundColor3 = categoryName == currentCategory and Color3.fromRGB(75, 125, 255) or Color3.fromRGB(50, 50, 65)
    CategoryButton.BorderSizePixel = 0
    CategoryButton.Size = UDim2.new(0, 100, 1, 0) -- Standard size, scrolling handles overflow
    CategoryButton.Font = Enum.Font.GothamMedium
    CategoryButton.Text = categoryName
    CategoryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CategoryButton.TextSize = 12
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = CategoryButton
    
    CategoryButton.MouseButton1Click:Connect(function()
        -- Update category selection
        for _, button in pairs(CategoryContainer:GetChildren()) do
            if button:IsA("TextButton") then
                button.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
            end
        end
        CategoryButton.BackgroundColor3 = Color3.fromRGB(75, 125, 255)
        currentCategory = categoryName
        updateScriptList()
    end)
    
    return CategoryButton
end

-- Function to refresh category buttons when size changes
local function refreshCategoryButtons()
    -- Clear existing category buttons
    for _, child in pairs(CategoryContainer:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Recreate category buttons
    local totalCategories = 0
    for categoryName, _ in pairs(ScriptDatabase) do
        createCategoryButton(categoryName)
        totalCategories = totalCategories + 1
    end
    
    -- Calculate canvas size for horizontal scrolling
    local buttonWidth = 100
    local padding = 10
    local totalWidth = (totalCategories * buttonWidth) + ((totalCategories - 1) * padding) + 20 -- 20 for left/right margins
    CategoryContainer.CanvasSize = UDim2.new(0, totalWidth, 0, 40)
end

local function createScriptItem(scriptData, index)
    local ScriptItem = Instance.new("Frame")
    ScriptItem.Name = "ScriptItem" .. index
    ScriptItem.Parent = ScriptContainer
    ScriptItem.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    ScriptItem.BorderSizePixel = 0
    ScriptItem.Size = UDim2.new(1, -12, 0, 70)
    
    local ItemCorner = Instance.new("UICorner")
    ItemCorner.CornerRadius = UDim.new(0, 8)
    ItemCorner.Parent = ScriptItem
    
    -- Script Name
    local ScriptName = Instance.new("TextLabel")
    ScriptName.Name = "ScriptName"
    ScriptName.Parent = ScriptItem
    ScriptName.BackgroundTransparency = 1
    ScriptName.Position = UDim2.new(0, 15, 0, 5)
    ScriptName.Size = UDim2.new(0.6, 0, 0, 25)
    ScriptName.Font = Enum.Font.GothamBold
    ScriptName.Text = scriptData.name
    ScriptName.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptName.TextSize = 14
    ScriptName.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Script Description
    local ScriptDesc = Instance.new("TextLabel")
    ScriptDesc.Name = "ScriptDesc"
    ScriptDesc.Parent = ScriptItem
    ScriptDesc.BackgroundTransparency = 1
    ScriptDesc.Position = UDim2.new(0, 15, 0, 30)
    ScriptDesc.Size = UDim2.new(0.6, 0, 0, 35)
    ScriptDesc.Font = Enum.Font.Gotham
    ScriptDesc.Text = scriptData.description
    ScriptDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
    ScriptDesc.TextSize = 11
    ScriptDesc.TextWrapped = true
    ScriptDesc.TextXAlignment = Enum.TextXAlignment.Left
    ScriptDesc.TextYAlignment = Enum.TextYAlignment.Top
    
    -- Execute Button
    local ExecuteButton = Instance.new("TextButton")
    ExecuteButton.Name = "ExecuteButton"
    ExecuteButton.Parent = ScriptItem
    ExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 200, 75)
    ExecuteButton.BorderSizePixel = 0
    ExecuteButton.Position = UDim2.new(1, -120, 0, 20)
    ExecuteButton.Size = UDim2.new(0, 100, 0, 30)
    ExecuteButton.Font = Enum.Font.GothamBold
    ExecuteButton.Text = "Execute"
    ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteButton.TextSize = 12
    
    local ExecuteCorner = Instance.new("UICorner")
    ExecuteCorner.CornerRadius = UDim.new(0, 6)
    ExecuteCorner.Parent = ExecuteButton
    
    -- Execute Button Click
    ExecuteButton.MouseButton1Click:Connect(function()
        ExecuteButton.Text = "Executing..."
        ExecuteButton.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
        
        local success, error = pcall(function()
            local func = loadstring(scriptData.script)
            if func then
                func()
            else
                error("Failed to load script")
            end
        end)
        
        if success then
            ExecuteButton.Text = "Executed!"
            ExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 200, 75)
            wait(2)
            ExecuteButton.Text = "Execute"
        else
            ExecuteButton.Text = "Error!"
            ExecuteButton.BackgroundColor3 = Color3.fromRGB(200, 75, 75)
            wait(2)
            ExecuteButton.Text = "Execute"
            ExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 200, 75)
        end
    end)
    
    return ScriptItem
end

function updateScriptList()
    -- Clear existing scripts
    for _, child in pairs(ScriptContainer:GetChildren()) do
        if child:IsA("Frame") and child.Name:find("ScriptItem") then
            child:Destroy()
        end
    end
    
    local scriptsToShow = filteredScripts and #filteredScripts > 0 and filteredScripts or ScriptDatabase[currentCategory] or {}
    
    -- Create script items
    for i, scriptData in pairs(scriptsToShow) do
        createScriptItem(scriptData, i)
    end
    
    -- Update canvas size
    ScriptContainer.CanvasSize = UDim2.new(0, 0, 0, #scriptsToShow * 75)
end

local function searchScripts(query)
    if query == "" then
        filteredScripts = {}
        updateScriptList()
        return
    end
    
    filteredScripts = {}
    query = query:lower()
    
    for category, scripts in pairs(ScriptDatabase) do
        for _, script in pairs(scripts) do
            if script.name:lower():find(query) or script.description:lower():find(query) then
                table.insert(filteredScripts, script)
            end
        end
    end
    
    updateScriptList()
end

-- Create category buttons
for categoryName, _ in pairs(ScriptDatabase) do
    createCategoryButton(categoryName)
end

-- Search functionality
SearchBox.FocusLost:Connect(function()
    searchScripts(SearchBox.Text)
end)

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    if SearchBox.Text == "" then
        searchScripts("")
    end
end)

-- Settings functionality
local currentSize = "Very Small" -- Default size (mobile-friendly)

local function changeHubSize(sizeName, width, height)
    local newMainSize = UDim2.new(0, width, 0, height)
    local newShadowPos = UDim2.new(0.5, -(width/2 + 5), 0.5, -(height/2 + 5))
    local newShadowSize = UDim2.new(0, width, 0, height)
    
    -- Animate the size change
    local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = newMainSize,
        Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
    })
    
    local shadowTween = TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = newShadowSize,
        Position = newShadowPos
    })
    
    mainTween:Play()
    shadowTween:Play()
    
    currentSize = sizeName
    
    -- Refresh category buttons with new responsive sizes
    refreshCategoryButtons()
    
    -- Update button colors
    VerySmallButton.BackgroundColor3 = sizeName == "Very Small" and Color3.fromRGB(75, 125, 255) or Color3.fromRGB(60, 60, 80)
    SmallButton.BackgroundColor3 = sizeName == "Small" and Color3.fromRGB(75, 125, 255) or Color3.fromRGB(60, 60, 80)
    MediumButton.BackgroundColor3 = sizeName == "Medium" and Color3.fromRGB(75, 125, 255) or Color3.fromRGB(60, 60, 80)
    LargeButton.BackgroundColor3 = sizeName == "Large" and Color3.fromRGB(75, 125, 255) or Color3.fromRGB(60, 60, 80)
    
    -- Show notification
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub Settings";
        Text = "Hub size changed to " .. sizeName;
        Duration = 2;
    })
end

-- Settings button click
SettingsButton.MouseButton1Click:Connect(function()
    SettingsPanel.Visible = not SettingsPanel.Visible
    SettingsShadow.Visible = SettingsPanel.Visible
end)

-- Size button clicks
VerySmallButton.MouseButton1Click:Connect(function()
    changeHubSize("Very Small", 500, 350)
end)

SmallButton.MouseButton1Click:Connect(function()
    changeHubSize("Small", 600, 400)
end)

MediumButton.MouseButton1Click:Connect(function()
    changeHubSize("Medium", 700, 500)
end)

LargeButton.MouseButton1Click:Connect(function()
    changeHubSize("Large", 800, 600)
end)

-- Close settings button
CloseSettingsButton.MouseButton1Click:Connect(function()
    SettingsPanel.Visible = false
    SettingsShadow.Visible = false
end)

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    FlixHub:Destroy()
end)

-- Minimize functionality
local isMinimized = false
local currentHubSize = {width = 500, height = 350} -- Store current size

-- Function to get current size based on currentSize variable
local function getCurrentSizeValues()
    if currentSize == "Very Small" then
        return 500, 350
    elseif currentSize == "Small" then
        return 600, 400
    elseif currentSize == "Medium" then
        return 700, 500
    elseif currentSize == "Large" then
        return 800, 600
    else
        return 500, 350 -- Default fallback
    end
end

MinimizeButton.MouseButton1Click:Connect(function()
    if not isMinimized then
        -- Store current size before minimizing
        currentHubSize.width, currentHubSize.height = getCurrentSizeValues()
        
        -- Minimize to small Flix icon (80x50)
        local minimizeTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 80, 0, 50),
            Position = UDim2.new(0.5, -40, 0.5, -25)
        })
        local shadowMinimizeTween = TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 5, 0, 5)
        })
        minimizeTween:Play()
        shadowMinimizeTween:Play()
        isMinimized = true
        MinimizeButton.Text = "+"
        
        -- Hide other elements when minimized
        SearchContainer.Visible = false
        CategoryContainer.Visible = false
        ScriptContainer.Visible = false
        SettingsButton.Visible = false
        CloseButton.Visible = false
        
        -- Change title to just "Flix"
        TitleText.Text = "Flix"
        TitleText.TextSize = 14
        TitleText.Position = UDim2.new(0, 10, 0, 0)
    else
        -- Restore to previous size
        local restoreTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, currentHubSize.width, 0, currentHubSize.height),
            Position = UDim2.new(0.5, -currentHubSize.width/2, 0.5, -currentHubSize.height/2)
        })
        local shadowRestoreTween = TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 5, 0, 5)
        })
        restoreTween:Play()
        shadowRestoreTween:Play()
        isMinimized = false
        MinimizeButton.Text = "-"
        
        -- Show other elements when restored
        SearchContainer.Visible = true
        CategoryContainer.Visible = true
        ScriptContainer.Visible = true
        SettingsButton.Visible = true
        CloseButton.Visible = true
        
        -- Restore title
        TitleText.Text = "FlixHub v2.0"
        TitleText.TextSize = 16
        TitleText.Position = UDim2.new(0, 15, 0, 0)
    end
end)

-- Initialize the GUI
updateScriptList()

-- Notification
StarterGui:SetCore("SendNotification", {
    Title = "FlixHub";
    Text = "Script hub loaded successfully!";
    Duration = 5;
})

print("FlixHub v2.0 loaded successfully!")
print("Created by FlixHub Team")
print("Features: Search, Categories, Keyless Scripts")