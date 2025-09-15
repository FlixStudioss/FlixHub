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

-- Key Authentication System
local CORRECT_KEY = "FlixHubBest"
local KEY_FILE = "FlixHub_Auth.txt"

-- Function to check if key is already authenticated
local function isKeyAuthenticated()
    if readfile and isfile then
        if isfile(KEY_FILE) then
            local savedKey = readfile(KEY_FILE)
            return savedKey == CORRECT_KEY
        end
    end
    return false
end

-- Function to save authentication
local function saveAuthentication()
    if writefile then
        writefile(KEY_FILE, CORRECT_KEY)
    end
end

-- Function to create and show key screen
local function createKeyScreen()
    local KeyScreen = Instance.new("ScreenGui")
    KeyScreen.Name = "FlixHubKeyScreen"
    KeyScreen.Parent = playerGui
    KeyScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    KeyScreen.ResetOnSpawn = false
    
    -- Background overlay
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Parent = KeyScreen
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BackgroundTransparency = 0.3
    Background.BorderSizePixel = 0
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.ZIndex = 1
    
    -- Key panel
    local KeyPanel = Instance.new("Frame")
    KeyPanel.Name = "KeyPanel"
    KeyPanel.Parent = KeyScreen
    KeyPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    KeyPanel.BackgroundTransparency = 0.1
    KeyPanel.BorderSizePixel = 0
    KeyPanel.Position = UDim2.new(0.5, -200, 0.5, -100)
    KeyPanel.Size = UDim2.new(0, 400, 0, 200)
    KeyPanel.ZIndex = 5
    
    -- Panel gradient
    local PanelGradient = Instance.new("UIGradient")
    PanelGradient.Parent = KeyPanel
    PanelGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 25, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
    }
    PanelGradient.Rotation = 45
    
    local PanelCorner = Instance.new("UICorner")
    PanelCorner.CornerRadius = UDim.new(0, 12)
    PanelCorner.Parent = KeyPanel
    
    -- Panel glow
    local PanelStroke = Instance.new("UIStroke")
    PanelStroke.Parent = KeyPanel
    PanelStroke.Color = Color3.fromRGB(100, 150, 255)
    PanelStroke.Transparency = 0.7
    PanelStroke.Thickness = 2
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = KeyPanel
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 0, 0, 20)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "🔐 FlixHub Authentication"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20
    Title.TextXAlignment = Enum.TextXAlignment.Center
    Title.ZIndex = 6
    
    -- Title glow
    local TitleStroke = Instance.new("UIStroke")
    TitleStroke.Parent = Title
    TitleStroke.Color = Color3.fromRGB(100, 150, 255)
    TitleStroke.Transparency = 0.5
    TitleStroke.Thickness = 1
    
    -- Instructions
    local Instructions = Instance.new("TextLabel")
    Instructions.Name = "Instructions"
    Instructions.Parent = KeyPanel
    Instructions.BackgroundTransparency = 1
    Instructions.Position = UDim2.new(0, 20, 0, 70)
    Instructions.Size = UDim2.new(1, -40, 0, 20)
    Instructions.Font = Enum.Font.Gotham
    Instructions.Text = "Enter the access key to continue:"
    Instructions.TextColor3 = Color3.fromRGB(200, 200, 200)
    Instructions.TextSize = 14
    Instructions.TextXAlignment = Enum.TextXAlignment.Left
    Instructions.ZIndex = 6
    
    -- Key input box
    local KeyInput = Instance.new("TextBox")
    KeyInput.Name = "KeyInput"
    KeyInput.Parent = KeyPanel
    KeyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    KeyInput.BorderSizePixel = 0
    KeyInput.Position = UDim2.new(0, 20, 0, 100)
    KeyInput.Size = UDim2.new(1, -120, 0, 35)
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.PlaceholderText = "Enter key here..."
    KeyInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.TextSize = 14
    KeyInput.ZIndex = 6
    
    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 6)
    InputCorner.Parent = KeyInput
    
    -- Submit button
    local SubmitButton = Instance.new("TextButton")
    SubmitButton.Name = "SubmitButton"
    SubmitButton.Parent = KeyPanel
    SubmitButton.BackgroundColor3 = Color3.fromRGB(85, 135, 255)
    SubmitButton.BorderSizePixel = 0
    SubmitButton.Position = UDim2.new(1, -90, 0, 100)
    SubmitButton.Size = UDim2.new(0, 70, 0, 35)
    SubmitButton.Font = Enum.Font.GothamMedium
    SubmitButton.Text = "Submit"
    SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitButton.TextSize = 12
    SubmitButton.ZIndex = 6
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = SubmitButton
    
    -- Error message
    local ErrorMessage = Instance.new("TextLabel")
    ErrorMessage.Name = "ErrorMessage"
    ErrorMessage.Parent = KeyPanel
    ErrorMessage.BackgroundTransparency = 1
    ErrorMessage.Position = UDim2.new(0, 20, 0, 145)
    ErrorMessage.Size = UDim2.new(1, -40, 0, 20)
    ErrorMessage.Font = Enum.Font.Gotham
    ErrorMessage.Text = ""
    ErrorMessage.TextColor3 = Color3.fromRGB(255, 100, 100)
    ErrorMessage.TextSize = 12
    ErrorMessage.TextXAlignment = Enum.TextXAlignment.Left
    ErrorMessage.Visible = false
    ErrorMessage.ZIndex = 6
    
    -- Authentication function
    local function authenticateKey()
        local enteredKey = KeyInput.Text
        if enteredKey == CORRECT_KEY then
            -- Save authentication for future use
            saveAuthentication()
            
            -- Show success animation
            ErrorMessage.Text = "✅ Authentication successful! Loading FlixHub..."
            ErrorMessage.TextColor3 = Color3.fromRGB(100, 255, 100)
            ErrorMessage.Visible = true
            
            -- Wait briefly to show success message, then load FlixHub
            wait(1)
            
            -- Destroy key screen and create main FlixHub
            KeyScreen:Destroy()
            createMainFlixHub() -- Create the main FlixHub interface
        else
            -- Show error
            ErrorMessage.Text = "❌ Invalid key. Please try again."
            ErrorMessage.TextColor3 = Color3.fromRGB(255, 100, 100)
            ErrorMessage.Visible = true
            
            -- Clear input
            KeyInput.Text = ""
            
            -- Shake animation
            local shake = TweenService:Create(KeyPanel, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                Position = UDim2.new(0.5, -190, 0.5, -100)
            })
            shake:Play()
            
            shake.Completed:Connect(function()
                local returnPos = TweenService:Create(KeyPanel, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                    Position = UDim2.new(0.5, -200, 0.5, -100)
                })
                returnPos:Play()
            end)
        end
    end
    
    -- Event connections
    SubmitButton.MouseButton1Click:Connect(authenticateKey)
    KeyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            authenticateKey()
        end
    end)
end

-- Function to create the main FlixHub (will be moved below)
local function createMainFlixHub()

-- Create main ScreenGui
local FlixHub = Instance.new("ScreenGui")
FlixHub.Name = "FlixHub"
FlixHub.Parent = playerGui
FlixHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FlixHub.ResetOnSpawn = false

-- Main Frame (Hub Window) with Modern Glassmorphism
local MainFrame = Instance.new("Frame")
MainFrame.Name = "FlixHub"
MainFrame.Parent = FlixHub
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BackgroundTransparency = 0.1 -- More transparency for glass effect
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.ZIndex = 2
MainFrame.Active = true
MainFrame.Draggable = false -- Disabled to prevent shadow artifacts

-- Modern Gradient Overlay
local GradientFrame = Instance.new("Frame")
GradientFrame.Name = "GradientOverlay"
GradientFrame.Parent = MainFrame
GradientFrame.BackgroundTransparency = 1
GradientFrame.BorderSizePixel = 0
GradientFrame.Size = UDim2.new(1, 0, 1, 0)
GradientFrame.ZIndex = 1

local GradientBG = Instance.new("UIGradient")
GradientBG.Parent = MainFrame
GradientBG.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
}
GradientBG.Rotation = 45

-- Corner rounding for main frame
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Enhanced Multi-Layered Shadow System
local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Parent = FlixHub
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.3 -- Darker for more depth
Shadow.BorderSizePixel = 0
Shadow.Position = UDim2.new(0.5, -242, 0.5, -167)
Shadow.Size = UDim2.new(0, 500, 0, 350)
Shadow.ZIndex = 0

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 12)
ShadowCorner.Parent = Shadow

-- Secondary Shadow for Extra Depth
local Shadow2 = Instance.new("Frame")
Shadow2.Name = "Shadow2"
Shadow2.Parent = FlixHub
Shadow2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow2.BackgroundTransparency = 0.6
Shadow2.BorderSizePixel = 0
Shadow2.Position = UDim2.new(0.5, -248, 0.5, -173)
Shadow2.Size = UDim2.new(0, 500, 0, 350)
Shadow2.ZIndex = -1

local Shadow2Corner = Instance.new("UICorner")
Shadow2Corner.CornerRadius = UDim.new(0, 12)
Shadow2Corner.Parent = Shadow2

-- Ambient Shadow (Soft Glow)
local AmbientShadow = Instance.new("Frame")
AmbientShadow.Name = "AmbientShadow"
AmbientShadow.Parent = FlixHub
AmbientShadow.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
AmbientShadow.BackgroundTransparency = 0.9
AmbientShadow.BorderSizePixel = 0
AmbientShadow.Position = UDim2.new(0.5, -260, 0.5, -185)
AmbientShadow.Size = UDim2.new(0, 520, 0, 370)
AmbientShadow.ZIndex = -2

local AmbientCorner = Instance.new("UICorner")
AmbientCorner.CornerRadius = UDim.new(0, 20)
AmbientCorner.Parent = AmbientShadow

-- Modern Title Bar with Gradient
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
TitleBar.BackgroundTransparency = 0.1
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 40) -- Slightly taller for modern look
TitleBar.ZIndex = 3

-- Title Bar Gradient
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Parent = TitleBar
TitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 70)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 50))
}
TitleGradient.Rotation = 90

-- Title Bar Glow Effect
local TitleGlow = Instance.new("Frame")
TitleGlow.Name = "TitleGlow"
TitleGlow.Parent = TitleBar
TitleGlow.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
TitleGlow.BackgroundTransparency = 0.8
TitleGlow.BorderSizePixel = 0
TitleGlow.Size = UDim2.new(1, 0, 0, 2)
TitleGlow.Position = UDim2.new(0, 0, 1, -2)
TitleGlow.ZIndex = 4

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

-- Custom Drag Controls with Shadow Synchronization
local isDragging = false
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                isDragging = false
                connection:Disconnect()
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local newPosition = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
        
        -- Move main frame
        MainFrame.Position = newPosition
        
        -- Move all shadows with main frame
        Shadow.Position = UDim2.new(
            newPosition.X.Scale, newPosition.X.Offset + 8,
            newPosition.Y.Scale, newPosition.Y.Offset + 8
        )
        
        Shadow2.Position = UDim2.new(
            newPosition.X.Scale, newPosition.X.Offset + 2,
            newPosition.Y.Scale, newPosition.Y.Offset + 2
        )
        
        AmbientShadow.Position = UDim2.new(
            newPosition.X.Scale, newPosition.X.Offset - 10,
            newPosition.Y.Scale, newPosition.Y.Offset - 10
        )
    end
end)

-- Modern Title Text with Enhanced Typography
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 20, 0, 0)
TitleText.Size = UDim2.new(0, 250, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "✨ FlixHub v2.0"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.ZIndex = 4

-- Title Text Glow Effect
local TitleTextStroke = Instance.new("UIStroke")
TitleTextStroke.Parent = TitleText
TitleTextStroke.Color = Color3.fromRGB(100, 150, 255)
TitleTextStroke.Transparency = 0.7
TitleTextStroke.Thickness = 1

-- Modern Close Button with Gradient
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 85, 85)
CloseButton.BackgroundTransparency = 0.1
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -40, 0, 8)
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.ZIndex = 4

-- Close Button Gradient
local CloseGradient = Instance.new("UIGradient")
CloseGradient.Parent = CloseButton
CloseGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 95, 95)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 65, 65))
}
CloseGradient.Rotation = 45

-- Close Button Glow Effect
local CloseStroke = Instance.new("UIStroke")
CloseStroke.Parent = CloseButton
CloseStroke.Color = Color3.fromRGB(255, 120, 120)
CloseStroke.Transparency = 0.6
CloseStroke.Thickness = 1

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Modern Minimize Button with Gradient
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(120, 120, 140)
MinimizeButton.BackgroundTransparency = 0.1
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -75, 0, 8)
MinimizeButton.Size = UDim2.new(0, 28, 0, 28)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16
MinimizeButton.ZIndex = 4

-- Minimize Button Gradient
local MinimizeGradient = Instance.new("UIGradient")
MinimizeGradient.Parent = MinimizeButton
MinimizeGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 140, 160)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 120))
}
MinimizeGradient.Rotation = 45

-- Minimize Button Glow
local MinimizeStroke = Instance.new("UIStroke")
MinimizeStroke.Parent = MinimizeButton
MinimizeStroke.Color = Color3.fromRGB(150, 150, 180)
MinimizeStroke.Transparency = 0.6
MinimizeStroke.Thickness = 1

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton

-- Favorites Button
local FavoritesButton = Instance.new("TextButton")
FavoritesButton.Name = "FavoritesButton"
FavoritesButton.Parent = TitleBar
FavoritesButton.BackgroundColor3 = Color3.fromRGB(255, 150, 150)
FavoritesButton.BackgroundTransparency = 0.1
FavoritesButton.BorderSizePixel = 0
FavoritesButton.Position = UDim2.new(1, -145, 0, 8)
FavoritesButton.Size = UDim2.new(0, 28, 0, 28)
FavoritesButton.Font = Enum.Font.GothamBold
FavoritesButton.Text = "❤️"
FavoritesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FavoritesButton.TextSize = 12
FavoritesButton.ZIndex = 4

-- Favorites Button Gradient
local FavoritesGradient = Instance.new("UIGradient")
FavoritesGradient.Parent = FavoritesButton
FavoritesGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 80, 120))
}
FavoritesGradient.Rotation = 45

-- Favorites Button Glow
local FavoritesStroke = Instance.new("UIStroke")
FavoritesStroke.Parent = FavoritesButton
FavoritesStroke.Color = Color3.fromRGB(255, 150, 180)
FavoritesStroke.Transparency = 0.6
FavoritesStroke.Thickness = 1

local FavoritesCorner = Instance.new("UICorner")
FavoritesCorner.CornerRadius = UDim.new(0, 6)
FavoritesCorner.Parent = FavoritesButton

-- Settings Button for Minimize Icon
local SettingsButton = Instance.new("TextButton")
SettingsButton.Name = "SettingsButton"
SettingsButton.Parent = TitleBar
SettingsButton.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
SettingsButton.BackgroundTransparency = 0.1
SettingsButton.BorderSizePixel = 0
SettingsButton.Position = UDim2.new(1, -110, 0, 8)
SettingsButton.Size = UDim2.new(0, 28, 0, 28)
SettingsButton.Font = Enum.Font.GothamBold
SettingsButton.Text = "⚙️"
SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsButton.TextSize = 12
SettingsButton.ZIndex = 4

-- Settings Button Gradient
local SettingsGradient = Instance.new("UIGradient")
SettingsGradient.Parent = SettingsButton
SettingsGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 140, 160)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 120))
}
SettingsGradient.Rotation = 45

-- Settings Button Glow
local SettingsStroke = Instance.new("UIStroke")
SettingsStroke.Parent = SettingsButton
SettingsStroke.Color = Color3.fromRGB(150, 150, 180)
SettingsStroke.Transparency = 0.6
SettingsStroke.Thickness = 1

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 6)
SettingsCorner.Parent = SettingsButton

-- Search Button for ScriptBlox (initially hidden)
local SearchButton = Instance.new("TextButton")
SearchButton.Name = "SearchButton"
SearchButton.Parent = TitleBar
SearchButton.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
SearchButton.BackgroundTransparency = 0.1
SearchButton.BorderSizePixel = 0
SearchButton.Position = UDim2.new(1, -145, 0, 8)
SearchButton.Size = UDim2.new(0, 28, 0, 28)
SearchButton.Font = Enum.Font.GothamBold
SearchButton.Text = "🔍"
SearchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchButton.TextSize = 12
SearchButton.ZIndex = 4
SearchButton.Visible = false -- Hidden by default

-- Search Button Gradient
local SearchGradient = Instance.new("UIGradient")
SearchGradient.Parent = SearchButton
SearchGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 140, 160)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 120))
}
SearchGradient.Rotation = 45

-- Search Button Glow
local SearchStroke = Instance.new("UIStroke")
SearchStroke.Parent = SearchButton
SearchStroke.Color = Color3.fromRGB(150, 150, 180)
SearchStroke.Transparency = 0.6
SearchStroke.Thickness = 1

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchButton

-- Modern Sidebar with Glassmorphism
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
Sidebar.BackgroundTransparency = 0.2
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 160, 1, -40) -- Slightly wider
Sidebar.ZIndex = 3

-- Sidebar Gradient
local SidebarGradient = Instance.new("UIGradient")
SidebarGradient.Parent = Sidebar
SidebarGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 55)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 25, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 35))
}
SidebarGradient.Rotation = 15

-- Sidebar Glow Border
local SidebarStroke = Instance.new("UIStroke")
SidebarStroke.Parent = Sidebar
SidebarStroke.Color = Color3.fromRGB(80, 120, 255)
SidebarStroke.Transparency = 0.7
SidebarStroke.Thickness = 1

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 0) -- Sharp corners for sidebar
SidebarCorner.Parent = Sidebar

-- Sidebar Tabs Container (Scrollable)
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = Sidebar
TabContainer.BackgroundTransparency = 1
TabContainer.BorderSizePixel = 0
TabContainer.Position = UDim2.new(0, 0, 0, 10)
TabContainer.Size = UDim2.new(1, 0, 1, -10)
TabContainer.ScrollingDirection = Enum.ScrollingDirection.Y
TabContainer.ScrollBarThickness = 4
TabContainer.ScrollBarImageColor3 = Color3.fromRGB(75, 75, 100)
TabContainer.ScrollBarImageTransparency = 0.3
TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be calculated dynamically

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabContainer
TabLayout.FillDirection = Enum.FillDirection.Vertical
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 5)

-- Modern Content Area with Enhanced Design
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame
ContentArea.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
ContentArea.BackgroundTransparency = 0.3
ContentArea.BorderSizePixel = 0
ContentArea.Position = UDim2.new(0, 160, 0, 40)
ContentArea.Size = UDim2.new(1, -160, 1, -40)
ContentArea.ZIndex = 3

-- Content Area Gradient
local ContentGradient = Instance.new("UIGradient")
ContentGradient.Parent = ContentArea
ContentGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 32, 48)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(25, 25, 38)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 35))
}
ContentGradient.Rotation = -15

-- Content Area Subtle Glow
local ContentStroke = Instance.new("UIStroke")
ContentStroke.Parent = ContentArea
ContentStroke.Color = Color3.fromRGB(60, 100, 255)
ContentStroke.Transparency = 0.8
ContentStroke.Thickness = 1

-- Search Container (Now in Content Area)
local SearchContainer = Instance.new("Frame")
SearchContainer.Name = "SearchContainer"
SearchContainer.Parent = ContentArea
SearchContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
SearchContainer.BorderSizePixel = 0
SearchContainer.Position = UDim2.new(0, 15, 0, 15)
SearchContainer.Size = UDim2.new(1, -30, 0, 35)

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 8)
SearchCorner.Parent = SearchContainer

local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Parent = SearchContainer
SearchBox.BackgroundTransparency = 1
SearchBox.Position = UDim2.new(0, 35, 0, 0)
SearchBox.Size = UDim2.new(1, -35, 1, 0)
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "Search scripts..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 14
SearchBox.TextXAlignment = Enum.TextXAlignment.Left

local SearchIcon = Instance.new("TextLabel")
SearchIcon.Name = "SearchIcon"
SearchIcon.Parent = SearchContainer
SearchIcon.BackgroundTransparency = 1
SearchIcon.Position = UDim2.new(0, 10, 0, 0)
SearchIcon.Size = UDim2.new(0, 20, 1, 0)
SearchIcon.Font = Enum.Font.GothamMedium
SearchIcon.Text = "🔍"
SearchIcon.TextColor3 = Color3.fromRGB(150, 150, 150)
SearchIcon.TextSize = 16

-- Script Container (Now in Content Area)
local ScriptContainer = Instance.new("ScrollingFrame")
ScriptContainer.Name = "ScriptContainer"
ScriptContainer.Parent = ContentArea
ScriptContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ScriptContainer.BorderSizePixel = 0
ScriptContainer.Position = UDim2.new(0, 15, 0, 65) -- Below search bar
ScriptContainer.Size = UDim2.new(1, -30, 1, -80) -- Full content area minus margins
ScriptContainer.ScrollBarThickness = 6
ScriptContainer.ScrollBarImageColor3 = Color3.fromRGB(75, 75, 100)

local ScriptCorner = Instance.new("UICorner")
ScriptCorner.CornerRadius = UDim.new(0, 8)
ScriptCorner.Parent = ScriptContainer

local ScriptLayout = Instance.new("UIListLayout")
ScriptLayout.Parent = ScriptContainer
ScriptLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScriptLayout.Padding = UDim.new(0, 5)

-- Favorites Panel (Initially Hidden)
local FavoritesPanel = Instance.new("Frame")
FavoritesPanel.Name = "FavoritesPanel"
FavoritesPanel.Parent = ContentArea
FavoritesPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
FavoritesPanel.BorderSizePixel = 0
FavoritesPanel.Position = UDim2.new(0, 15, 0, 15)
FavoritesPanel.Size = UDim2.new(1, -30, 1, -30)
FavoritesPanel.Visible = false
FavoritesPanel.ZIndex = 5

local FavoritesPanelCorner = Instance.new("UICorner")
FavoritesPanelCorner.CornerRadius = UDim.new(0, 8)
FavoritesPanelCorner.Parent = FavoritesPanel

-- Favorites Panel Title
local FavoritesTitle = Instance.new("TextLabel")
FavoritesTitle.Name = "FavoritesTitle"
FavoritesTitle.Parent = FavoritesPanel
FavoritesTitle.BackgroundTransparency = 1
FavoritesTitle.Position = UDim2.new(0, 15, 0, 10)
FavoritesTitle.Size = UDim2.new(1, -30, 0, 30)
FavoritesTitle.Font = Enum.Font.GothamBold
FavoritesTitle.Text = "❤️ Favorite Scripts"
FavoritesTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
FavoritesTitle.TextSize = 18
FavoritesTitle.TextXAlignment = Enum.TextXAlignment.Left
FavoritesTitle.ZIndex = 6

-- Favorites Container (Scrollable)
local FavoritesContainer = Instance.new("ScrollingFrame")
FavoritesContainer.Name = "FavoritesContainer"
FavoritesContainer.Parent = FavoritesPanel
FavoritesContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
FavoritesContainer.BorderSizePixel = 0
FavoritesContainer.Position = UDim2.new(0, 15, 0, 50)
FavoritesContainer.Size = UDim2.new(1, -30, 1, -65)
FavoritesContainer.ScrollBarThickness = 6
FavoritesContainer.ScrollBarImageColor3 = Color3.fromRGB(75, 75, 100)
FavoritesContainer.ZIndex = 6

local FavoritesContainerCorner = Instance.new("UICorner")
FavoritesContainerCorner.CornerRadius = UDim.new(0, 6)
FavoritesContainerCorner.Parent = FavoritesContainer

local FavoritesLayout = Instance.new("UIListLayout")
FavoritesLayout.Parent = FavoritesContainer
FavoritesLayout.SortOrder = Enum.SortOrder.LayoutOrder
FavoritesLayout.Padding = UDim.new(0, 5)











-- New Tab System Variables
local currentTab = "Home"
local isGamesExpanded = false
local isVisualExpanded = false
local filteredScripts = {}

-- Favorites System Variables
local favoriteScripts = {}
local isFavoritesOpen = false
local FAVORITES_FILE = "FlixHub_Favorites.json"

-- Theme Persistence Variables
local THEME_FILE = "FlixHub_Theme.txt"

-- Function to save current theme
local function saveTheme()
    if writefile then
        writefile(THEME_FILE, currentTheme)
    end
end

-- Function to load saved theme
local function loadTheme()
    if readfile and isfile then
        if isfile(THEME_FILE) then
            local savedTheme = readfile(THEME_FILE)
            if themes[savedTheme] then
                currentTheme = savedTheme
                return savedTheme
            end
        end
    end
    return "Dark" -- Default theme
end

-- Favorites Storage Functions
local function saveFavorites()
    if writefile then
        local success, result = pcall(function()
            return HttpService:JSONEncode(favoriteScripts)
        end)
        if success then
            writefile(FAVORITES_FILE, result)
        end
    end
end

local function loadFavorites()
    if readfile and isfile then
        if isfile(FAVORITES_FILE) then
            local success, result = pcall(function()
                local data = readfile(FAVORITES_FILE)
                return HttpService:JSONDecode(data)
            end)
            if success and result then
                favoriteScripts = result
            end
        end
    end
end

-- Load favorites and theme on startup
loadFavorites()
currentTheme = loadTheme()

-- Function to refresh favorites display
local function refreshFavorites()
    -- Clear existing favorites
    for _, child in pairs(FavoritesContainer:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local index = 1
    for scriptId, scriptData in pairs(favoriteScripts) do
        local FavoriteItem = Instance.new("Frame")
        FavoriteItem.Name = "FavoriteItem" .. index
        FavoriteItem.Parent = FavoritesContainer
        FavoriteItem.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        FavoriteItem.BorderSizePixel = 0
        FavoriteItem.Size = UDim2.new(1, -12, 0, 70)
        
        local FavoriteItemCorner = Instance.new("UICorner")
        FavoriteItemCorner.CornerRadius = UDim.new(0, 8)
        FavoriteItemCorner.Parent = FavoriteItem
        
        -- Script Name
        local FavScriptName = Instance.new("TextLabel")
        FavScriptName.Parent = FavoriteItem
        FavScriptName.BackgroundTransparency = 1
        FavScriptName.Position = UDim2.new(0, 15, 0, 5)
        FavScriptName.Size = UDim2.new(0.6, 0, 0, 25)
        FavScriptName.Font = Enum.Font.GothamBold
        FavScriptName.Text = scriptData.name
        FavScriptName.TextColor3 = Color3.fromRGB(255, 255, 255)
        FavScriptName.TextSize = 14
        FavScriptName.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Script Description
        local FavScriptDesc = Instance.new("TextLabel")
        FavScriptDesc.Parent = FavoriteItem
        FavScriptDesc.BackgroundTransparency = 1
        FavScriptDesc.Position = UDim2.new(0, 15, 0, 30)
        FavScriptDesc.Size = UDim2.new(0.6, 0, 0, 35)
        FavScriptDesc.Font = Enum.Font.Gotham
        FavScriptDesc.Text = scriptData.description
        FavScriptDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
        FavScriptDesc.TextSize = 11
        FavScriptDesc.TextWrapped = true
        FavScriptDesc.TextXAlignment = Enum.TextXAlignment.Left
        FavScriptDesc.TextYAlignment = Enum.TextYAlignment.Top
        
        -- Remove from Favorites Button
        local RemoveFavButton = Instance.new("TextButton")
        RemoveFavButton.Parent = FavoriteItem
        RemoveFavButton.BackgroundColor3 = Color3.fromRGB(200, 75, 75)
        RemoveFavButton.BorderSizePixel = 0
        RemoveFavButton.Position = UDim2.new(1, -85, 0, 20)
        RemoveFavButton.Size = UDim2.new(0, 30, 0, 30)
        RemoveFavButton.Font = Enum.Font.GothamBold
        RemoveFavButton.Text = "💔"
        RemoveFavButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        RemoveFavButton.TextSize = 14
        
        local RemoveFavCorner = Instance.new("UICorner")
        RemoveFavCorner.CornerRadius = UDim.new(0, 6)
        RemoveFavCorner.Parent = RemoveFavButton
        
        -- Execute Button
        local FavExecuteButton = Instance.new("TextButton")
        FavExecuteButton.Parent = FavoriteItem
        FavExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 200, 75)
        FavExecuteButton.BorderSizePixel = 0
        FavExecuteButton.Position = UDim2.new(1, -50, 0, 20)
        FavExecuteButton.Size = UDim2.new(0, 30, 0, 30)
        FavExecuteButton.Font = Enum.Font.GothamBold
        FavExecuteButton.Text = "▶"
        FavExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        FavExecuteButton.TextSize = 16
        
        local FavExecuteCorner = Instance.new("UICorner")
        FavExecuteCorner.CornerRadius = UDim.new(0, 6)
        FavExecuteCorner.Parent = FavExecuteButton
        
        -- Remove from favorites click
        RemoveFavButton.MouseButton1Click:Connect(function()
            favoriteScripts[scriptId] = nil
            saveFavorites()
            refreshFavorites()
            
            StarterGui:SetCore("SendNotification", {
                Title = "FlixHub Favorites";
                Text = "Removed " .. scriptData.name .. " from favorites";
                Duration = 2;
            })
        end)
        
        -- Execute script click
        FavExecuteButton.MouseButton1Click:Connect(function()
            FavExecuteButton.Text = "⏳"
            FavExecuteButton.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
            
            local success, error = pcall(function()
                local func = loadstring(scriptData.script)
                if func then
                    func()
                else
                    error("Failed to load script")
                end
            end)
            
            if success then
                FavExecuteButton.Text = "✓"
                FavExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 200, 75)
                wait(2)
                FavExecuteButton.Text = "▶"
            else
                FavExecuteButton.Text = "✗"
                FavExecuteButton.BackgroundColor3 = Color3.fromRGB(200, 75, 75)
                wait(2)
                FavExecuteButton.Text = "▶"
                FavExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 200, 75)
            end
        end)
        
        index = index + 1
    end
    
    -- Update canvas size
    FavoritesContainer.CanvasSize = UDim2.new(0, 0, 0, index * 75)
end

-- Function to toggle favorites panel
local function toggleFavorites()
    isFavoritesOpen = not isFavoritesOpen
    
    if isFavoritesOpen then
        -- Show favorites panel
        FavoritesPanel.Visible = true
        SearchContainer.Visible = false
        ScriptContainer.Visible = false
        refreshFavorites()
        
        StarterGui:SetCore("SendNotification", {
            Title = "FlixHub Favorites";
            Text = "Showing favorite scripts";
            Duration = 1;
        })
    else
        -- Hide favorites panel
        FavoritesPanel.Visible = false
        SearchContainer.Visible = true
        ScriptContainer.Visible = true
        
        StarterGui:SetCore("SendNotification", {
            Title = "FlixHub Favorites";
            Text = "Favorites panel closed";
            Duration = 1;
        })
    end
end

-- Theme System Variables
local currentTheme = "Dark" -- Default theme
local themes = {
    ["Dark"] = {
        primary = Color3.fromRGB(25, 25, 35),
        secondary = Color3.fromRGB(35, 35, 50),
        tertiary = Color3.fromRGB(40, 40, 55),
        sidebar = Color3.fromRGB(20, 20, 30),
        accent = Color3.fromRGB(75, 125, 255),
        success = Color3.fromRGB(75, 200, 75),
        error = Color3.fromRGB(200, 75, 75),
        warning = Color3.fromRGB(255, 150, 50),
        text = Color3.fromRGB(255, 255, 255),
        textSecondary = Color3.fromRGB(200, 200, 200),
        textTertiary = Color3.fromRGB(180, 180, 180)
    },
    ["Purple"] = {
        primary = Color3.fromRGB(35, 20, 45),
        secondary = Color3.fromRGB(50, 35, 65),
        tertiary = Color3.fromRGB(60, 45, 75),
        sidebar = Color3.fromRGB(25, 15, 35),
        accent = Color3.fromRGB(150, 100, 255),
        success = Color3.fromRGB(120, 200, 120),
        error = Color3.fromRGB(255, 100, 150),
        warning = Color3.fromRGB(255, 150, 100),
        text = Color3.fromRGB(255, 255, 255),
        textSecondary = Color3.fromRGB(220, 200, 240),
        textTertiary = Color3.fromRGB(180, 160, 200)
    },
    ["Black"] = {
        primary = Color3.fromRGB(15, 15, 15),
        secondary = Color3.fromRGB(25, 25, 25),
        tertiary = Color3.fromRGB(35, 35, 35),
        sidebar = Color3.fromRGB(10, 10, 10),
        accent = Color3.fromRGB(255, 255, 255),
        success = Color3.fromRGB(100, 255, 100),
        error = Color3.fromRGB(255, 100, 100),
        warning = Color3.fromRGB(255, 200, 100),
        text = Color3.fromRGB(255, 255, 255),
        textSecondary = Color3.fromRGB(200, 200, 200),
        textTertiary = Color3.fromRGB(150, 150, 150)
    },
    ["Ocean"] = {
        primary = Color3.fromRGB(15, 30, 45),
        secondary = Color3.fromRGB(25, 45, 65),
        tertiary = Color3.fromRGB(35, 55, 75),
        sidebar = Color3.fromRGB(10, 25, 40),
        accent = Color3.fromRGB(100, 180, 255),
        success = Color3.fromRGB(100, 220, 150),
        error = Color3.fromRGB(255, 100, 120),
        warning = Color3.fromRGB(255, 180, 100),
        text = Color3.fromRGB(255, 255, 255),
        textSecondary = Color3.fromRGB(200, 220, 240),
        textTertiary = Color3.fromRGB(160, 180, 200)
    },
    ["Green"] = {
        primary = Color3.fromRGB(20, 35, 25),
        secondary = Color3.fromRGB(30, 50, 35),
        tertiary = Color3.fromRGB(40, 60, 45),
        sidebar = Color3.fromRGB(15, 25, 20),
        accent = Color3.fromRGB(100, 255, 150),
        success = Color3.fromRGB(80, 220, 120),
        error = Color3.fromRGB(255, 120, 120),
        warning = Color3.fromRGB(255, 200, 100),
        text = Color3.fromRGB(255, 255, 255),
        textSecondary = Color3.fromRGB(200, 240, 220),
        textTertiary = Color3.fromRGB(160, 200, 180)
    },
    ["Red"] = {
        primary = Color3.fromRGB(45, 20, 20),
        secondary = Color3.fromRGB(60, 30, 30),
        tertiary = Color3.fromRGB(75, 40, 40),
        sidebar = Color3.fromRGB(35, 15, 15),
        accent = Color3.fromRGB(255, 100, 100),
        success = Color3.fromRGB(100, 255, 100),
        error = Color3.fromRGB(255, 50, 50),
        warning = Color3.fromRGB(255, 150, 100),
        text = Color3.fromRGB(255, 255, 255),
        textSecondary = Color3.fromRGB(240, 200, 200),
        textTertiary = Color3.fromRGB(200, 160, 160)
    },
    ["Blue"] = {
        primary = Color3.fromRGB(20, 25, 45),
        secondary = Color3.fromRGB(30, 35, 60),
        tertiary = Color3.fromRGB(40, 45, 75),
        sidebar = Color3.fromRGB(15, 20, 35),
        accent = Color3.fromRGB(100, 150, 255),
        success = Color3.fromRGB(100, 255, 150),
        error = Color3.fromRGB(255, 100, 100),
        warning = Color3.fromRGB(255, 200, 100),
        text = Color3.fromRGB(255, 255, 255),
        textSecondary = Color3.fromRGB(200, 220, 255),
        textTertiary = Color3.fromRGB(160, 180, 220)
    }
}

-- Theme Application Function
local function applyTheme(themeName)
    local theme = themes[themeName]
    if not theme then return end
    
    currentTheme = themeName
    saveTheme() -- Save the selected theme
    
    -- Main UI Elements with smooth transitions
    local transitionInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Main Frame
    TweenService:Create(MainFrame, transitionInfo, {BackgroundColor3 = theme.primary}):Play()
    TweenService:Create(TitleBar, transitionInfo, {BackgroundColor3 = theme.secondary}):Play()
    TweenService:Create(Sidebar, transitionInfo, {BackgroundColor3 = theme.sidebar}):Play()
    TweenService:Create(SearchContainer, transitionInfo, {BackgroundColor3 = theme.secondary}):Play()
    TweenService:Create(ScriptContainer, transitionInfo, {BackgroundColor3 = theme.tertiary}):Play()
    TweenService:Create(FavoritesPanel, transitionInfo, {BackgroundColor3 = theme.tertiary}):Play()
    TweenService:Create(FavoritesContainer, transitionInfo, {BackgroundColor3 = theme.secondary}):Play()
    
    -- Update text colors
    TitleText.TextColor3 = theme.text
    SearchBox.TextColor3 = theme.text
    SearchBox.PlaceholderColor3 = theme.textTertiary
    SearchIcon.TextColor3 = theme.textTertiary
    FavoritesTitle.TextColor3 = theme.text
    
    -- Refresh tabs with new theme
    refreshTabs()
    
    -- Update theme buttons if they exist
    if _G.themeButtons then
        for themeName, button in pairs(_G.themeButtons) do
            if button and button.Parent then
                button.BackgroundColor3 = themeName == currentTheme and theme.accent or Color3.fromRGB(60, 60, 80)
            end
        end
    end
    
    -- Show notification
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub Theme";
        Text = "Theme changed to " .. themeName;
        Duration = 2;
    })
end

-- Universal Scripts (Not in Games category)
local UniversalScripts = {
    {
        name = "Infinite Yield",
        description = "Ultimate admin commands script",
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
        name = "Solara Hub (Key)",
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

-- Game Scripts (Inside Games expandable category)
local GameScripts = {
    ["Grow A Garden"] = {
        {
            name = "No Lag",
            description = "Reduces lag and improves performance",
            script = [[loadstring(game:HttpGet('https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Garden/Garden-V1.lua'))()]]
        },
        {
            name = "eF Hub (Key)",
            description = "Multi-purpose exploit hub",
            script = [[loadstring(game:HttpGet('https://cdn.exploitingis.fun/loader', true))()]]
        },
        {
            name = "Idiot Hub (Currently Down)",
            description = "IdiotHub script loader for Grow A Garden",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/IdiotHub/Scripts/main/Loader"))()]]
        },
        {
            name = "BlackHub (Key)",
            description = "BlackHub script for Grow A Garden",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Skibidiking123/Fisch1/refs/heads/main/FischMain"))()]]
        },
        {
            name = "ShovelHub (Not Good)",
            description = "ShovelHub script - quality may vary",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/shvl00/shvled/refs/heads/main/l04d3r.bf"))()]]
        },
        {
            name = "SpeedHubX (Keyless on Weekends)",
            description = "SpeedHubX script for Grow A Garden - keyless on weekends",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()]]
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
            name = "eF Hub (Key)",
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
            description = "Soluna Hub solo farming script for 99 Nights",
            script = [[loadstring(game:HttpGet("https://soluna-script.vercel.app/99-Nights-in-the-Forest.lua",true))()]]
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
        },
        {
            name = "Auto Farm Diamond",
            description = "Automated diamond farming script for 99 Nights in the Forest",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/collonroger/pigeonhub/refs/heads/main/autofarmdiamonds.lua"))()]]
        },
        {
            name = "VoidWare",
            description = "VoidWare script for 99 Nights in the Forest",
            script = [[loadstring(game:HttpGet("https://pastefy.app/RXzul28o/raw"))()]]
        },
        {
            name = "GFarm",
            description = "GFarm script for 99 Nights in the Forest",
            script = [[loadstring(game:HttpGet('https://raw.githubusercontent.com/MQPS7/99-Night-in-the-Forset/refs/heads/main/Gfarm'))()]]
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
            name = "Instant Steal v2 (Not Working)",
            description = "Second version of instant steal script (unverified)",
            script = [[loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/ffdfeadf0af798741806ea404682a938.lua"))()]]
        },
        {
            name = "MoonHub",
            description = "MoonHub script for Steal A Brainrot",
            script = [[loadstring(game:HttpGet('https://raw.githubusercontent.com/KaspikScriptsRb/steal-a-brainrot/refs/heads/main/.lua'))()]]
        },
        {
            name = "Chilli Hub",
            description = "Chilli Hub script for Steal A Brainrot",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()]]
        },
        {
            name = "CompHub (Key)",
            description = "CompHub script for Steal A Brainrot",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/robloxcomphub/comphub/refs/heads/main/comphub.lua"))()]]
        },
        {
            name = "BlindHub (Key)",
            description = "BlindHub script for Steal A Brainrot",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Blind-Man-Walking/Steal-a-brain-rot/refs/heads/main/Test4"))()]]
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
    ["Prospecting"] = {
        {
            name = "StellarHub",
            description = "StellarHub script for Prospecting game",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/loader/main/games/Prospecting.lua"))()]]
        }
    },
    ["VolleyBall Legends"] = {
        {
            name = "SigmaHub",
            description = "SigmaHub script for VolleyBall Legends game",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Xm2iufas09ijmF/sigma-hub/refs/heads/main/temp.lua"))()]]
        }
    },
    ["Fisch"] = {
        {
            name = "SpeedHub X",
            description = "SpeedHub X script for Fisch game",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()]]
        }
    },
    ["Underground War"] = {
        {
            name = "Aimbot",
            description = "Aimbot script for Underground War",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Roblox-HttpSpy/Random-Silly-stuff/refs/heads/main/UW2-Panel.lua"))()]]
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
    ["Basketball Legends"] = {
        {
            name = "Auto Green",
            description = "Auto Green and Ball Magnet script for Basketball Legends",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/vnausea/absence-mini/refs/heads/main/absencemini.lua"))()]]
        },
        {
            name = "Auto Green v2",
            description = "Second version of Auto Green script for Basketball Legends",
            script = [[loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/036662184673bfe9af11477616f25561.lua"))()]]
        }
    },
    ["Touch Football"] = {
        {
            name = "Auto Goal",
            description = "Auto Goal script for Touch Football game",
            script = [[loadstring(game:HttpGet("https://pastefy.app/HHVkOaR9/raw"))()]]
        }
    },
    ["Brainrot Evolution"] = {
        {
            name = "OP Auto Farm",
            description = "OP Auto Farm script for Brainrot Evolution game",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/BrySadW/BrainrotEvolution/refs/heads/main/Protected_9771535026490697.lua"))()]]
        }
    },
    ["Slap Tower"] = {
        {
            name = "Trolling Gui",
            description = "Trolling Gui script for Slap Tower game",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/Slap-Tower-Script"))()]]
        },
        {
            name = "Get All Slaps",
            description = "Get All Slaps script for Slap Tower game",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/DdeM3zz/TwinScripts/refs/heads/main/Slap%20Tower", true))()]]
        }
    },
    ["Arcade Basketball"] = {
        {
            name = "OP Script (Only PC)",
            description = "OP Script for Arcade Basketball game (PC Only)",
            script = [[loadstring(game:HttpGet("https://pastebin.com/raw/Vksx0XsH"))()]]
        }
    }
}

-- Visual Scripts (Not in Games category)
local VisualScripts = {
    ["Grow A Garden Visual"] = {
        {
            name = "Pet,Seed Spawner",
            description = "Visual script for Grow A Garden pet and seed spawning",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/veryimportantrr/x/refs/heads/main/gag_visual.lua", true))("discord.gg/csxu2nCkw9")]]
        }
    }
}

-- New Tab System Functions with Theme Support
local function createTab(tabName, isGameTab, indentLevel)
    local Tab = Instance.new("TextButton")
    Tab.Name = tabName
    Tab.Parent = TabContainer
    
    local theme = themes[currentTheme]
    local isSelected = tabName == currentTab or tabName:gsub("[🏠⚡👁️🎮▼▶]", ""):gsub(" ", "") == currentTab
    
    Tab.BackgroundColor3 = isSelected and theme.accent or theme.tertiary
    Tab.BorderSizePixel = 0
    Tab.Size = UDim2.new(1, -10, 0, 35) -- Full width minus margins, 35px height
    Tab.Font = Enum.Font.GothamMedium
    Tab.Text = (indentLevel and string.rep("  ", indentLevel) or "") .. tabName
    Tab.TextColor3 = theme.text
    Tab.TextSize = isGameTab and 10 or 12
    Tab.TextXAlignment = Enum.TextXAlignment.Left
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = Tab
    
    -- Add modern hover animations
    Tab.MouseEnter:Connect(function()
        if not isSelected then
            TweenService:Create(Tab, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = theme.secondary,
                Size = UDim2.new(1, -5, 0, 35) -- Slight scale effect
            }):Play()
        end
    end)
    
    Tab.MouseLeave:Connect(function()
        if not isSelected then
            TweenService:Create(Tab, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = theme.tertiary,
                Size = UDim2.new(1, -10, 0, 35) -- Return to normal
            }):Play()
        end
    end)
    
    -- Animate tab sliding in from the right
    Tab.Position = UDim2.new(1, 0, 0, 0) -- Start off-screen
    Tab.BackgroundTransparency = 1
    Tab.TextTransparency = 1
    
    local slideInTween = TweenService:Create(Tab, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 5, 0, 0),
        BackgroundTransparency = 0,
        TextTransparency = 0
    })
    slideInTween:Play()
    
    return Tab
end

-- Function to detect current game and return matching category
local function detectCurrentGame()
    local success, gameInfo = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    end)
    
    if not success then
        return nil, "Unknown Game"
    end
    
    local gameName = gameInfo.Name
    
    -- Game name mappings (case insensitive matching)
    local gameMap = {
        ["grow a garden"] = "Grow A Garden",
        ["poop simulator"] = "Poop Simulator",
        ["slippery stairs"] = "Slippery Stairs",
        ["strongest battle"] = "Strongest Battle",
        ["the strongest battleground"] = "Strongest Battle",
        ["the strongest battlegrounds"] = "Strongest Battle",
        ["99 nights forest"] = "99 Nights Forest",
        ["99 nights in the forest"] = "99 Nights Forest",
        ["ink game"] = "Ink Game",
        ["steal a brainrot"] = "Steal A Brainrot",
        ["life sentence"] = "Life Sentence",
        ["prospecting"] = "Prospecting",
        ["volleyball legends"] = "VolleyBall Legends",
        ["fisch"] = "Fisch",
        ["build a boat"] = "Build A Boat",
        ["build a boat for treasure"] = "Build A Boat",
        ["basketball legends"] = "Basketball Legends",
        ["touch football"] = "Touch Football",
        ["brainrot evolution"] = "Brainrot Evolution",
        ["slap tower"] = "Slap Tower",
        ["arcade basketball"] = "Arcade Basketball"
    }
    
    -- Check if current game matches any of our script categories
    local lowerGameName = gameName:lower()
    for pattern, category in pairs(gameMap) do
        if lowerGameName:find(pattern) then
            return category, gameName
        end
    end
    
    return nil, gameName
end

local function createHomeContent()
    -- Clear script container and show home info
    for _, child in pairs(ScriptContainer:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UICorner") then
            child:Destroy()
        end
    end
    
    -- Create Home content
    local HomeFrame = Instance.new("Frame")
    HomeFrame.Name = "HomeFrame"
    HomeFrame.Parent = ScriptContainer
    HomeFrame.BackgroundTransparency = 1
    HomeFrame.Size = UDim2.new(1, 0, 0, 280)
    HomeFrame.LayoutOrder = 1
    
    -- Avatar Name
    local AvatarLabel = Instance.new("TextLabel")
    AvatarLabel.Name = "AvatarLabel"
    AvatarLabel.Parent = HomeFrame
    AvatarLabel.BackgroundTransparency = 1
    AvatarLabel.Position = UDim2.new(0, 20, 0, 20)
    AvatarLabel.Size = UDim2.new(1, -40, 0, 30)
    AvatarLabel.Font = Enum.Font.GothamBold
    AvatarLabel.Text = "👤 Player: " .. Players.LocalPlayer.Name
    AvatarLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    AvatarLabel.TextSize = 16
    AvatarLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Current Game Detection
    local detectedCategory, actualGameName = detectCurrentGame()
    
    local GameLabel = Instance.new("TextLabel")
    GameLabel.Name = "GameLabel"
    GameLabel.Parent = HomeFrame
    GameLabel.BackgroundTransparency = 1
    GameLabel.Position = UDim2.new(0, 20, 0, 60)
    GameLabel.Size = UDim2.new(1, -40, 0, 30)
    GameLabel.Font = Enum.Font.GothamMedium
    GameLabel.Text = "🎮 Game: " .. actualGameName
    GameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    GameLabel.TextSize = 14
    GameLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Game Support Status (no navigation button)
    local SupportStatusLabel = Instance.new("TextLabel")
    SupportStatusLabel.Name = "SupportStatusLabel"
    SupportStatusLabel.Parent = HomeFrame
    SupportStatusLabel.BackgroundTransparency = 1
    SupportStatusLabel.Position = UDim2.new(0, 20, 0, 110)
    SupportStatusLabel.Size = UDim2.new(1, -40, 0, 80)
    SupportStatusLabel.Font = Enum.Font.GothamMedium
    SupportStatusLabel.TextSize = 12
    SupportStatusLabel.TextWrapped = true
    SupportStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    SupportStatusLabel.TextYAlignment = Enum.TextYAlignment.Top
    
    if detectedCategory and GameScripts[detectedCategory] then
        -- Game is supported
        SupportStatusLabel.Text = "✅ Status: Supported\n📜 This game has scripts available in the " .. detectedCategory .. " category.\n\n💡 Navigate to the Games section to access scripts."
        SupportStatusLabel.TextColor3 = Color3.fromRGB(150, 220, 150)
    else
        -- Game is not supported
        SupportStatusLabel.Text = "❌ Status: Not Supported\n📜 This game doesn't have dedicated scripts yet.\n\n💡 Check out Universal or FE scripts that work in any game!"
        SupportStatusLabel.TextColor3 = Color3.fromRGB(220, 150, 150)
    end
end

local function refreshTabs()
    -- Animate out existing tabs first
    local existingTabs = {}
    for _, child in pairs(TabContainer:GetChildren()) do
        if child:IsA("TextButton") then
            table.insert(existingTabs, child)
        end
    end
    
    -- Animate existing tabs sliding out
    for i, tab in pairs(existingTabs) do
        local slideOutTween = TweenService:Create(tab, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Position = UDim2.new(-1, 0, tab.Position.Y.Scale, tab.Position.Y.Offset),
            BackgroundTransparency = 1,
            TextTransparency = 1
        })
        slideOutTween:Play()
        slideOutTween.Completed:Connect(function()
            tab:Destroy()
        end)
    end
    
    -- Wait a moment then create new tabs
    wait(0.25)
    
    local tabHeight = 35
    local tabSpacing = 5
    local totalTabs = 0
    
    -- Create Home Tab
    local homeTab = createTab("🏠 Home", false)
    homeTab.LayoutOrder = 1
    homeTab.MouseButton1Click:Connect(function()
        currentTab = "Home"
        refreshTabs()
        createHomeContent()
    end)
    totalTabs = totalTabs + 1
    
    -- Create Universal Tab
    local universalTab = createTab("⚡ Universal", false)
    universalTab.LayoutOrder = 2
    universalTab.MouseButton1Click:Connect(function()
        currentTab = "Universal"
        refreshTabs()
        updateScriptList()
    end)
    totalTabs = totalTabs + 1
    
    -- Create FE Tab
    local feTab = createTab("👁️ FE", false)
    feTab.LayoutOrder = 3
    feTab.MouseButton1Click:Connect(function()
        currentTab = "FE"
        refreshTabs()
        updateScriptList()
    end)
    totalTabs = totalTabs + 1
    
    -- Create Visual Script expandable tab (moved above Games)
    local visualTab = createTab("📱 Visual Script " .. (isVisualExpanded and "▼" or "▶"), false)
    visualTab.LayoutOrder = 4
    visualTab.MouseButton1Click:Connect(function()
        isVisualExpanded = not isVisualExpanded
        refreshTabs()
    end)
    totalTabs = totalTabs + 1
    
    -- Add Visual Script tabs if expanded
    if isVisualExpanded then
        -- Grow A Garden tab under Visual Script
        local growTab = createTab("   🌱 Grow A Garden", false)
        growTab.LayoutOrder = totalTabs + 1
        growTab.MouseButton1Click:Connect(function()
            currentTab = "Grow A Garden Visual"
            refreshTabs()
            updateScriptList()
        end)
        totalTabs = totalTabs + 1
    end
    
    -- Create Games expandable tab (moved below Visual Script)
    local gamesTab = createTab("🎮 Games " .. (isGamesExpanded and "▼" or "▶"), false)
    gamesTab.LayoutOrder = totalTabs + 1
    gamesTab.MouseButton1Click:Connect(function()
        isGamesExpanded = not isGamesExpanded
        refreshTabs()
        if currentTab == "Games" then
            -- Show games overview or first game
            currentTab = "Grow A Garden"
            updateScriptList()
        end
    end)
    totalTabs = totalTabs + 1
    
    -- Add game tabs if expanded
    if isGamesExpanded then
        local gameOrder = totalTabs + 1
        for gameName, _ in pairs(GameScripts) do
            local gameTab = createTab(gameName, true, 1) -- Indented
            gameTab.LayoutOrder = gameOrder
            gameTab.MouseButton1Click:Connect(function()
                currentTab = gameName
                refreshTabs()
                updateScriptList()
            end)
            totalTabs = totalTabs + 1
            gameOrder = gameOrder + 1
        end
    end
    
    -- Calculate canvas size
    local totalHeight = (totalTabs * tabHeight) + ((totalTabs - 1) * tabSpacing) + 20
    TabContainer.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

-- Function to refresh tabs when size changes (replaced old category system)
local function refreshTabsOnResize()
    -- Simply call refreshTabs as tab system handles its own sizing
    refreshTabs()
end

local function createScriptItem(scriptData, index)
    local theme = themes[currentTheme]
    
    local ScriptItem = Instance.new("Frame")
    ScriptItem.Name = "ScriptItem" .. index
    ScriptItem.Parent = ScriptContainer
    ScriptItem.BackgroundColor3 = theme.secondary
    ScriptItem.BorderSizePixel = 0
    ScriptItem.Size = UDim2.new(1, -12, 0, 70)
    
    local ItemCorner = Instance.new("UICorner")
    ItemCorner.CornerRadius = UDim.new(0, 8)
    ItemCorner.Parent = ScriptItem
    
    -- Add modern hover effect for script items with scale and glow
    local hoverConnection
    local leaveConnection
    
    hoverConnection = ScriptItem.MouseEnter:Connect(function()
        TweenService:Create(ScriptItem, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = theme.tertiary,
            Size = UDim2.new(1, -10, 0, 70), -- Slight scale up
            Position = UDim2.new(0, 5, 0, ScriptItem.Position.Y.Offset)
        }):Play()
    end)
    
    leaveConnection = ScriptItem.MouseLeave:Connect(function()
        TweenService:Create(ScriptItem, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = theme.secondary,
            Size = UDim2.new(1, -12, 0, 70), -- Return to normal
            Position = UDim2.new(0, 6, 0, ScriptItem.Position.Y.Offset)
        }):Play()
    end)
    
    -- Animate script item sliding in from the right
    ScriptItem.Position = UDim2.new(1, 0, 0, ScriptItem.Position.Y.Offset)
    ScriptItem.BackgroundTransparency = 1
    
    local slideDelay = (index - 1) * 0.05 -- Staggered animation
    wait(slideDelay)
    
    local slideInTween = TweenService:Create(ScriptItem, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 6, 0, ScriptItem.Position.Y.Offset),
        BackgroundTransparency = 0
    })
    slideInTween:Play()
    
    -- Script Name
    local ScriptName = Instance.new("TextLabel")
    ScriptName.Name = "ScriptName"
    ScriptName.Parent = ScriptItem
    ScriptName.BackgroundTransparency = 1
    ScriptName.Position = UDim2.new(0, 15, 0, 5)
    ScriptName.Size = UDim2.new(0.6, 0, 0, 25)
    ScriptName.Font = Enum.Font.GothamBold
    
    -- Check if script requires a key (has "(Key)" in name) but exclude SpeedHub X
    local hasKey = string.find(scriptData.name, "%(Key%)") and not string.find(scriptData.name, "SpeedHub X")
    ScriptName.Text = hasKey and "🔑 " .. scriptData.name or scriptData.name
    
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
    
    -- Favorite Button (Heart Icon)
    local scriptId = scriptData.name .. "_" .. scriptData.description -- Create unique ID
    local isFavorited = favoriteScripts[scriptId] ~= nil
    
    local FavoriteButton = Instance.new("TextButton")
    FavoriteButton.Name = "FavoriteButton"
    FavoriteButton.Parent = ScriptItem
    FavoriteButton.BackgroundColor3 = isFavorited and Color3.fromRGB(255, 100, 150) or Color3.fromRGB(100, 100, 120)
    FavoriteButton.BorderSizePixel = 0
    FavoriteButton.Position = UDim2.new(1, -85, 0, 20)
    FavoriteButton.Size = UDim2.new(0, 30, 0, 30)
    FavoriteButton.Font = Enum.Font.GothamBold
    FavoriteButton.Text = isFavorited and "❤️" or "🤍"
    FavoriteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    FavoriteButton.TextSize = 14
    
    local FavoriteCorner = Instance.new("UICorner")
    FavoriteCorner.CornerRadius = UDim.new(0, 6)
    FavoriteCorner.Parent = FavoriteButton
    
    -- Execute Button (Square with Play Icon)
    local ExecuteButton = Instance.new("TextButton")
    ExecuteButton.Name = "ExecuteButton"
    ExecuteButton.Parent = ScriptItem
    ExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 200, 75)
    ExecuteButton.BorderSizePixel = 0
    ExecuteButton.Position = UDim2.new(1, -50, 0, 20)
    ExecuteButton.Size = UDim2.new(0, 30, 0, 30) -- Square button
    ExecuteButton.Font = Enum.Font.GothamBold
    ExecuteButton.Text = "▶" -- Play icon
    ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteButton.TextSize = 16
    
    local ExecuteCorner = Instance.new("UICorner")
    ExecuteCorner.CornerRadius = UDim.new(0, 6)
    ExecuteCorner.Parent = ExecuteButton
    
    -- Favorite Button Click
    FavoriteButton.MouseButton1Click:Connect(function()
        local currentlyFavorited = favoriteScripts[scriptId] ~= nil
        
        if currentlyFavorited then
            -- Remove from favorites
            favoriteScripts[scriptId] = nil
            FavoriteButton.Text = "🤍"
            FavoriteButton.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
            
            StarterGui:SetCore("SendNotification", {
                Title = "FlixHub Favorites";
                Text = "Removed " .. scriptData.name .. " from favorites";
                Duration = 2;
            })
        else
            -- Add to favorites
            favoriteScripts[scriptId] = {
                name = scriptData.name,
                description = scriptData.description,
                script = scriptData.script
            }
            FavoriteButton.Text = "❤️"
            FavoriteButton.BackgroundColor3 = Color3.fromRGB(255, 100, 150)
            
            StarterGui:SetCore("SendNotification", {
                Title = "FlixHub Favorites";
                Text = "Added " .. scriptData.name .. " to favorites";
                Duration = 2;
            })
        end
        
        saveFavorites()
        refreshFavorites()
    end)
    
    -- Execute Button Click
    ExecuteButton.MouseButton1Click:Connect(function()
        ExecuteButton.Text = "⏳" -- Loading icon
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
            ExecuteButton.Text = "✓" -- Checkmark
            ExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 200, 75)
            wait(2)
            ExecuteButton.Text = "▶" -- Back to play icon
        else
            ExecuteButton.Text = "✗" -- X mark
            ExecuteButton.BackgroundColor3 = Color3.fromRGB(200, 75, 75)
            wait(2)
            ExecuteButton.Text = "▶" -- Back to play icon
            ExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 200, 75)
        end
    end)
    
    return ScriptItem
end

function updateScriptList()
    -- Don't show scripts on Home tab
    if currentTab == "Home" then
        return
    end
    
    -- Animate out existing content
    local existingItems = {}
    for _, child in pairs(ScriptContainer:GetChildren()) do
        if child:IsA("Frame") and (child.Name:find("ScriptItem") or child.Name == "HomeFrame") and currentTab ~= "Home" then
            table.insert(existingItems, child)
        end
    end
    
    -- Fade out existing items
    for _, item in pairs(existingItems) do
        local fadeOutTween = TweenService:Create(item, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            Position = UDim2.new(item.Position.X.Scale, item.Position.X.Offset - 50, item.Position.Y.Scale, item.Position.Y.Offset),
            BackgroundTransparency = 1
        })
        fadeOutTween:Play()
        fadeOutTween.Completed:Connect(function()
            item:Destroy()
        end)
    end
    
    wait(0.2) -- Small delay for smooth transition
    
    local scriptsToShow = {}
    
    -- Handle filtered search results
    if filteredScripts and #filteredScripts > 0 then
        scriptsToShow = filteredScripts
    -- Handle different tab types
    elseif currentTab == "Universal" then
        scriptsToShow = UniversalScripts
    elseif currentTab == "FE" then
        scriptsToShow = FEScripts
    elseif VisualScripts[currentTab] then
        scriptsToShow = VisualScripts[currentTab]
    elseif GameScripts[currentTab] then
        scriptsToShow = GameScripts[currentTab]
    end
    
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
    
    -- Search Universal Scripts
    for _, script in pairs(UniversalScripts) do
        if script.name:lower():find(query) or script.description:lower():find(query) then
            table.insert(filteredScripts, script)
        end
    end
    
    -- Search FE Scripts
    for _, script in pairs(FEScripts) do
        if script.name:lower():find(query) or script.description:lower():find(query) then
            table.insert(filteredScripts, script)
        end
    end
    
    -- Search Visual Scripts
    for category, scripts in pairs(VisualScripts) do
        for _, script in pairs(scripts) do
            if script.name:lower():find(query) or script.description:lower():find(query) then
                table.insert(filteredScripts, script)
            end
        end
    end
    
    -- Search Game Scripts
    for category, scripts in pairs(GameScripts) do
        for _, script in pairs(scripts) do
            if script.name:lower():find(query) or script.description:lower():find(query) then
                table.insert(filteredScripts, script)
            end
        end
    end
    
    updateScriptList()
end

-- Connect search functionality
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    searchScripts(SearchBox.Text)
end)





-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    FlixHub:Destroy()
end)



-- Minimize functionality
local isMinimized = false
local currentHubSize = {width = 500, height = 350} -- Store current size

-- Create Minimize Icon (separate from main frame)
local MinimizeIcon = Instance.new("Frame")
MinimizeIcon.Name = "MinimizeIcon"
MinimizeIcon.Parent = FlixHub
MinimizeIcon.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MinimizeIcon.BorderSizePixel = 0
MinimizeIcon.Size = UDim2.new(0, 60, 0, 60)
MinimizeIcon.Position = UDim2.new(1, -80, 1, -80) -- Bottom right corner
MinimizeIcon.Visible = false
MinimizeIcon.ZIndex = 100

local MinimizeIconCorner = Instance.new("UICorner")
MinimizeIconCorner.CornerRadius = UDim.new(0, 12)
MinimizeIconCorner.Parent = MinimizeIcon

-- Icon gradient
local MinimizeIconGradient = Instance.new("UIGradient")
MinimizeIconGradient.Parent = MinimizeIcon
MinimizeIconGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
}
MinimizeIconGradient.Rotation = 45

-- Icon glow effect
local MinimizeIconStroke = Instance.new("UIStroke")
MinimizeIconStroke.Parent = MinimizeIcon
MinimizeIconStroke.Color = Color3.fromRGB(75, 125, 255)
MinimizeIconStroke.Transparency = 0.5
MinimizeIconStroke.Thickness = 2

-- Icon shadow
local MinimizeIconShadow = Instance.new("Frame")
MinimizeIconShadow.Name = "MinimizeIconShadow"
MinimizeIconShadow.Parent = FlixHub
MinimizeIconShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinimizeIconShadow.BackgroundTransparency = 0.3
MinimizeIconShadow.BorderSizePixel = 0
MinimizeIconShadow.Size = UDim2.new(0, 60, 0, 60)
MinimizeIconShadow.Position = UDim2.new(1, -75, 1, -75)
MinimizeIconShadow.Visible = false
MinimizeIconShadow.ZIndex = 99

local MinimizeIconShadowCorner = Instance.new("UICorner")
MinimizeIconShadowCorner.CornerRadius = UDim.new(0, 12)
MinimizeIconShadowCorner.Parent = MinimizeIconShadow

-- Icon text/symbol
local MinimizeIconText = Instance.new("TextLabel")
MinimizeIconText.Name = "MinimizeIconText"
MinimizeIconText.Parent = MinimizeIcon
MinimizeIconText.BackgroundTransparency = 1
MinimizeIconText.Size = UDim2.new(1, 0, 1, 0)
MinimizeIconText.Font = Enum.Font.GothamBold
MinimizeIconText.Text = "✨"
MinimizeIconText.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeIconText.TextSize = 24
MinimizeIconText.TextXAlignment = Enum.TextXAlignment.Center
MinimizeIconText.TextYAlignment = Enum.TextYAlignment.Center
MinimizeIconText.ZIndex = 101

-- Icon click detector
local MinimizeIconButton = Instance.new("TextButton")
MinimizeIconButton.Name = "MinimizeIconButton"
MinimizeIconButton.Parent = MinimizeIcon
MinimizeIconButton.BackgroundTransparency = 1
MinimizeIconButton.Size = UDim2.new(1, 0, 1, 0)
MinimizeIconButton.Text = ""
MinimizeIconButton.ZIndex = 102

-- Minimize Icon Settings Variables
local iconPosition = "bottom_right" -- default position
local iconMovable = false -- default not movable
local experimentalSearch = false -- experimental ScriptBlox search feature

-- Position mappings for the minimize icon
local iconPositions = {
    ["top_left"] = {anchor = UDim2.new(0, 20, 0, 20), shadow = UDim2.new(0, 25, 0, 25)},
    ["top_middle"] = {anchor = UDim2.new(0.5, -30, 0, 20), shadow = UDim2.new(0.5, -25, 0, 25)},
    ["top_right"] = {anchor = UDim2.new(1, -80, 0, 20), shadow = UDim2.new(1, -75, 0, 25)},
    ["bottom_left"] = {anchor = UDim2.new(0, 20, 1, -80), shadow = UDim2.new(0, 25, 1, -75)},
    ["bottom_middle"] = {anchor = UDim2.new(0.5, -30, 1, -80), shadow = UDim2.new(0.5, -25, 1, -75)},
    ["bottom_right"] = {anchor = UDim2.new(1, -80, 1, -80), shadow = UDim2.new(1, -75, 1, -75)}
}

-- Function to update minimize icon position
local function updateIconPosition(position)
    iconPosition = position
    local pos = iconPositions[position]
    if pos then
        MinimizeIcon.Position = pos.anchor
        MinimizeIconShadow.Position = pos.shadow
    end
end

-- Modern Settings Panel
local SettingsPanel = Instance.new("Frame")
SettingsPanel.Name = "SettingsPanel"
SettingsPanel.Parent = FlixHub
SettingsPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
SettingsPanel.BorderSizePixel = 0
SettingsPanel.Position = UDim2.new(0.5, -250, 0.5, -200)
SettingsPanel.Size = UDim2.new(0, 500, 0, 400)
SettingsPanel.Visible = false
SettingsPanel.ZIndex = 200

-- Settings Panel Gradient
local SettingsPanelGradient = Instance.new("UIGradient")
SettingsPanelGradient.Parent = SettingsPanel
SettingsPanelGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
}
SettingsPanelGradient.Rotation = 45

local SettingsPanelCorner = Instance.new("UICorner")
SettingsPanelCorner.CornerRadius = UDim.new(0, 12)
SettingsPanelCorner.Parent = SettingsPanel

-- Settings Panel Shadow
local SettingsPanelShadow = Instance.new("Frame")
SettingsPanelShadow.Name = "SettingsPanelShadow"
SettingsPanelShadow.Parent = FlixHub
SettingsPanelShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SettingsPanelShadow.BackgroundTransparency = 0.3
SettingsPanelShadow.BorderSizePixel = 0
SettingsPanelShadow.Position = UDim2.new(0.5, -245, 0.5, -195)
SettingsPanelShadow.Size = UDim2.new(0, 500, 0, 400)
SettingsPanelShadow.Visible = false
SettingsPanelShadow.ZIndex = 199

local SettingsPanelShadowCorner = Instance.new("UICorner")
SettingsPanelShadowCorner.CornerRadius = UDim.new(0, 12)
SettingsPanelShadowCorner.Parent = SettingsPanelShadow

-- Modern Settings Panel Title
local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Name = "SettingsTitle"
SettingsTitle.Parent = SettingsPanel
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Position = UDim2.new(0, 25, 0, 20)
SettingsTitle.Size = UDim2.new(1, -70, 0, 35)
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.Text = "⚙️ FlixHub Settings"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTitle.TextSize = 20
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
SettingsTitle.ZIndex = 201

-- Settings Title Glow
local SettingsTitleStroke = Instance.new("UIStroke")
SettingsTitleStroke.Parent = SettingsTitle
SettingsTitleStroke.Color = Color3.fromRGB(100, 150, 255)
SettingsTitleStroke.Transparency = 0.7
SettingsTitleStroke.Thickness = 1

-- Close Settings Button
local CloseSettingsButton = Instance.new("TextButton")
CloseSettingsButton.Name = "CloseSettingsButton"
CloseSettingsButton.Parent = SettingsPanel
CloseSettingsButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
CloseSettingsButton.BorderSizePixel = 0
CloseSettingsButton.Position = UDim2.new(1, -45, 0, 20)
CloseSettingsButton.Size = UDim2.new(0, 30, 0, 30)
CloseSettingsButton.Font = Enum.Font.GothamBold
CloseSettingsButton.Text = "×"
CloseSettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseSettingsButton.TextSize = 14
CloseSettingsButton.ZIndex = 201

local CloseSettingsCorner = Instance.new("UICorner")
CloseSettingsCorner.CornerRadius = UDim.new(0, 8)
CloseSettingsCorner.Parent = CloseSettingsButton

-- Theme Selection Section
local ThemeLabel = Instance.new("TextLabel")
ThemeLabel.Name = "ThemeLabel"
ThemeLabel.Parent = SettingsPanel
ThemeLabel.BackgroundTransparency = 1
ThemeLabel.Position = UDim2.new(0, 25, 0, 70)
ThemeLabel.Size = UDim2.new(1, -50, 0, 30)
ThemeLabel.Font = Enum.Font.GothamBold
ThemeLabel.Text = "🎨 Theme Selection"
ThemeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemeLabel.TextSize = 16
ThemeLabel.TextXAlignment = Enum.TextXAlignment.Left
ThemeLabel.ZIndex = 201

-- Theme Grid Container
local ThemeGrid = Instance.new("Frame")
ThemeGrid.Name = "ThemeGrid"
ThemeGrid.Parent = SettingsPanel
ThemeGrid.BackgroundTransparency = 1
ThemeGrid.Position = UDim2.new(0, 25, 0, 110)
ThemeGrid.Size = UDim2.new(1, -50, 0, 200)
ThemeGrid.ZIndex = 201

local ThemeGridLayout = Instance.new("UIGridLayout")
ThemeGridLayout.Parent = ThemeGrid
ThemeGridLayout.CellSize = UDim2.new(0, 140, 0, 45)
ThemeGridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
ThemeGridLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Global theme buttons storage
_G.themeButtons = {}

-- Function to create theme button
local function createThemeButton(themeName, layoutOrder)
    local themeData = themes[themeName]
    
    local ThemeButton = Instance.new("TextButton")
    ThemeButton.Name = themeName .. "ThemeButton"
    ThemeButton.Parent = ThemeGrid
    ThemeButton.BackgroundColor3 = themeName == currentTheme and themeData.accent or Color3.fromRGB(60, 60, 80)
    ThemeButton.BorderSizePixel = 0
    ThemeButton.Font = Enum.Font.GothamMedium
    ThemeButton.Text = themeName
    ThemeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ThemeButton.TextSize = 14
    ThemeButton.LayoutOrder = layoutOrder
    ThemeButton.ZIndex = 202
    
    local ThemeButtonCorner = Instance.new("UICorner")
    ThemeButtonCorner.CornerRadius = UDim.new(0, 8)
    ThemeButtonCorner.Parent = ThemeButton
    
    -- Theme button gradient
    local ThemeButtonGradient = Instance.new("UIGradient")
    ThemeButtonGradient.Parent = ThemeButton
    ThemeButtonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, themeData.secondary),
        ColorSequenceKeypoint.new(1, themeData.primary)
    }
    ThemeButtonGradient.Rotation = 45
    
    -- Store button reference
    _G.themeButtons[themeName] = ThemeButton
    
    -- Theme button click handler
    ThemeButton.MouseButton1Click:Connect(function()
        applyTheme(themeName)
    end)
    
    return ThemeButton
end

-- Create theme buttons
createThemeButton("Dark", 1)
createThemeButton("Purple", 2)
createThemeButton("Black", 3)
createThemeButton("Ocean", 4)
createThemeButton("Green", 5)
createThemeButton("Red", 6)
createThemeButton("Blue", 7)

-- Position Label
local PositionLabel = Instance.new("TextLabel")
PositionLabel.Name = "PositionLabel"
PositionLabel.Parent = SettingsPanel
PositionLabel.BackgroundTransparency = 1
PositionLabel.Position = UDim2.new(0, 20, 0, 60)
PositionLabel.Size = UDim2.new(1, -40, 0, 25)
PositionLabel.Font = Enum.Font.GothamMedium
PositionLabel.Text = "Icon Position:"
PositionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PositionLabel.TextSize = 14
PositionLabel.TextXAlignment = Enum.TextXAlignment.Left
PositionLabel.ZIndex = 201

-- Position Buttons Container
local PositionGrid = Instance.new("Frame")
PositionGrid.Name = "PositionGrid"
PositionGrid.Parent = SettingsPanel
PositionGrid.BackgroundTransparency = 1
PositionGrid.Position = UDim2.new(0, 20, 0, 90)
PositionGrid.Size = UDim2.new(1, -40, 0, 120)
PositionGrid.ZIndex = 201

-- Position button data
local positionButtons = {
    {key = "top_left", text = "Top Left", pos = UDim2.new(0, 0, 0, 0)},
    {key = "top_middle", text = "Top Middle", pos = UDim2.new(0.33, 5, 0, 0)},
    {key = "top_right", text = "Top Right", pos = UDim2.new(0.66, 10, 0, 0)},
    {key = "bottom_left", text = "Bottom Left", pos = UDim2.new(0, 0, 0, 40)},
    {key = "bottom_middle", text = "Bottom Middle", pos = UDim2.new(0.33, 5, 0, 40)},
    {key = "bottom_right", text = "Bottom Right", pos = UDim2.new(0.66, 10, 0, 40)}
}

-- Create position buttons
for _, buttonData in pairs(positionButtons) do
    local button = Instance.new("TextButton")
    button.Name = buttonData.key .. "Button"
    button.Parent = PositionGrid
    button.BackgroundColor3 = (buttonData.key == iconPosition) and Color3.fromRGB(75, 125, 255) or Color3.fromRGB(40, 40, 60)
    button.BorderSizePixel = 0
    button.Position = buttonData.pos
    button.Size = UDim2.new(0.3, -5, 0, 35)
    button.Font = Enum.Font.GothamMedium
    button.Text = buttonData.text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 11
    button.ZIndex = 202
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    -- Button click handler
    button.MouseButton1Click:Connect(function()
        -- Update all buttons appearance
        for _, child in pairs(PositionGrid:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            end
        end
        -- Highlight selected button
        button.BackgroundColor3 = Color3.fromRGB(75, 125, 255)
        
        -- Update icon position
        updateIconPosition(buttonData.key)
        
        -- Show notification
        StarterGui:SetCore("SendNotification", {
            Title = "FlixHub Settings";
            Text = "Icon position changed to " .. buttonData.text;
            Duration = 2;
        })
    end)
end

-- Movable Toggle Label
local MovableLabel = Instance.new("TextLabel")
MovableLabel.Name = "MovableLabel"
MovableLabel.Parent = SettingsPanel
MovableLabel.BackgroundTransparency = 1
MovableLabel.Position = UDim2.new(0, 20, 0, 220)
MovableLabel.Size = UDim2.new(1, -40, 0, 25)
MovableLabel.Font = Enum.Font.GothamMedium
MovableLabel.Text = "Make Icon Draggable:"
MovableLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
MovableLabel.TextSize = 14
MovableLabel.TextXAlignment = Enum.TextXAlignment.Left
MovableLabel.ZIndex = 201

-- Movable Toggle Button
local MovableToggle = Instance.new("TextButton")
MovableToggle.Name = "MovableToggle"
MovableToggle.Parent = SettingsPanel
MovableToggle.BackgroundColor3 = iconMovable and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
MovableToggle.BorderSizePixel = 0
MovableToggle.Position = UDim2.new(0, 20, 0, 250)
MovableToggle.Size = UDim2.new(0, 100, 0, 30)
MovableToggle.Font = Enum.Font.GothamMedium
MovableToggle.Text = iconMovable and "Enabled" or "Disabled"
MovableToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
MovableToggle.TextSize = 12
MovableToggle.ZIndex = 202

local MovableToggleCorner = Instance.new("UICorner")
MovableToggleCorner.CornerRadius = UDim.new(0, 6)
MovableToggleCorner.Parent = MovableToggle

-- Experimental Search Label
local ExperimentalLabel = Instance.new("TextLabel")
ExperimentalLabel.Name = "ExperimentalLabel"
ExperimentalLabel.Parent = SettingsPanel
ExperimentalLabel.BackgroundTransparency = 1
ExperimentalLabel.Position = UDim2.new(0, 130, 0, 220)
ExperimentalLabel.Size = UDim2.new(1, -150, 0, 25)
ExperimentalLabel.Font = Enum.Font.GothamMedium
ExperimentalLabel.Text = "ScriptBlox Search:"
ExperimentalLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ExperimentalLabel.TextSize = 14
ExperimentalLabel.TextXAlignment = Enum.TextXAlignment.Left
ExperimentalLabel.ZIndex = 201

-- Experimental Search Toggle Button
local ExperimentalToggle = Instance.new("TextButton")
ExperimentalToggle.Name = "ExperimentalToggle"
ExperimentalToggle.Parent = SettingsPanel
ExperimentalToggle.BackgroundColor3 = experimentalSearch and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
ExperimentalToggle.BorderSizePixel = 0
ExperimentalToggle.Position = UDim2.new(0, 130, 0, 250)
ExperimentalToggle.Size = UDim2.new(0, 100, 0, 30)
ExperimentalToggle.Font = Enum.Font.GothamMedium
ExperimentalToggle.Text = experimentalSearch and "Enabled" or "Disabled"
ExperimentalToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ExperimentalToggle.TextSize = 12
ExperimentalToggle.ZIndex = 202

local ExperimentalToggleCorner = Instance.new("UICorner")
ExperimentalToggleCorner.CornerRadius = UDim.new(0, 6)
ExperimentalToggleCorner.Parent = ExperimentalToggle

-- Dragging variables
local dragging = false
local dragStart = nil
local startPos = nil

-- Function to enable/disable draggable behavior
local function updateMovableBehavior()
    if iconMovable then
        -- Enable dragging
        MinimizeIconButton.MouseButton1Down:Connect(function()
            if not dragging then
                dragging = true
                dragStart = UserInputService:GetMouseLocation()
                startPos = MinimizeIcon.Position
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = UserInputService:GetMouseLocation() - dragStart
                local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                
                -- Keep icon within screen bounds
                local clampedX = math.max(0, math.min(newPos.X.Offset, workspace.CurrentCamera.ViewportSize.X - 60))
                local clampedY = math.max(0, math.min(newPos.Y.Offset, workspace.CurrentCamera.ViewportSize.Y - 60))
                
                MinimizeIcon.Position = UDim2.new(0, clampedX, 0, clampedY)
                MinimizeIconShadow.Position = UDim2.new(0, clampedX + 5, 0, clampedY + 5)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end
end

-- Movable Toggle Click Handler
MovableToggle.MouseButton1Click:Connect(function()
    iconMovable = not iconMovable
    MovableToggle.BackgroundColor3 = iconMovable and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    MovableToggle.Text = iconMovable and "Enabled" or "Disabled"
    
    updateMovableBehavior()
    
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub Settings";
        Text = iconMovable and "Icon dragging enabled!" or "Icon dragging disabled!";
        Duration = 2;
    })
end)

-- Experimental Search Toggle Click Handler
ExperimentalToggle.MouseButton1Click:Connect(function()
    experimentalSearch = not experimentalSearch
    ExperimentalToggle.BackgroundColor3 = experimentalSearch and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    ExperimentalToggle.Text = experimentalSearch and "Enabled" or "Disabled"
    
    -- Show/hide search button based on experimental setting
    SearchButton.Visible = experimentalSearch
    
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub Experimental";
        Text = experimentalSearch and "ScriptBlox search enabled!" or "ScriptBlox search disabled!";
        Duration = 2;
    })
end)

-- Settings Button Click Handler
SettingsButton.MouseButton1Click:Connect(function()
    SettingsPanel.Visible = not SettingsPanel.Visible
    SettingsPanelShadow.Visible = SettingsPanel.Visible
    
    if SettingsPanel.Visible then
        StarterGui:SetCore("SendNotification", {
            Title = "FlixHub Settings";
            Text = "Settings panel opened!";
            Duration = 1;
        })
    end
end)

-- Close Settings Button Click Handler
CloseSettingsButton.MouseButton1Click:Connect(function()
    SettingsPanel.Visible = false
    SettingsPanelShadow.Visible = false
end)

-- ScriptBlox Search Panel
local SearchPanel = Instance.new("Frame")
SearchPanel.Name = "SearchPanel"
SearchPanel.Parent = FlixHub
SearchPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
SearchPanel.BorderSizePixel = 0
SearchPanel.Position = UDim2.new(0.5, -250, 0.5, -200)
SearchPanel.Size = UDim2.new(0, 500, 0, 400)
SearchPanel.Visible = false
SearchPanel.ZIndex = 300

local SearchPanelCorner = Instance.new("UICorner")
SearchPanelCorner.CornerRadius = UDim.new(0, 12)
SearchPanelCorner.Parent = SearchPanel

-- Search Panel Shadow
local SearchPanelShadow = Instance.new("Frame")
SearchPanelShadow.Name = "SearchPanelShadow"
SearchPanelShadow.Parent = FlixHub
SearchPanelShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SearchPanelShadow.BackgroundTransparency = 0.3
SearchPanelShadow.BorderSizePixel = 0
SearchPanelShadow.Position = UDim2.new(0.5, -245, 0.5, -195)
SearchPanelShadow.Size = UDim2.new(0, 500, 0, 400)
SearchPanelShadow.Visible = false
SearchPanelShadow.ZIndex = 299

local SearchPanelShadowCorner = Instance.new("UICorner")
SearchPanelShadowCorner.CornerRadius = UDim.new(0, 12)
SearchPanelShadowCorner.Parent = SearchPanelShadow

-- Search Panel Title
local SearchTitle = Instance.new("TextLabel")
SearchTitle.Name = "SearchTitle"
SearchTitle.Parent = SearchPanel
SearchTitle.BackgroundTransparency = 1
SearchTitle.Position = UDim2.new(0, 20, 0, 15)
SearchTitle.Size = UDim2.new(1, -40, 0, 30)
SearchTitle.Font = Enum.Font.GothamBold
SearchTitle.Text = "🔍 ScriptBlox Search (Experimental)"
SearchTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchTitle.TextSize = 16
SearchTitle.TextXAlignment = Enum.TextXAlignment.Left
SearchTitle.ZIndex = 301

-- Close Search Button
local CloseSearchButton = Instance.new("TextButton")
CloseSearchButton.Name = "CloseSearchButton"
CloseSearchButton.Parent = SearchPanel
CloseSearchButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
CloseSearchButton.BorderSizePixel = 0
CloseSearchButton.Position = UDim2.new(1, -35, 0, 10)
CloseSearchButton.Size = UDim2.new(0, 25, 0, 25)
CloseSearchButton.Font = Enum.Font.GothamBold
CloseSearchButton.Text = "×"
CloseSearchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseSearchButton.TextSize = 14
CloseSearchButton.ZIndex = 301

local CloseSearchCorner = Instance.new("UICorner")
CloseSearchCorner.CornerRadius = UDim.new(0, 4)
CloseSearchCorner.Parent = CloseSearchButton

-- Search Input Box
local SearchInput = Instance.new("TextBox")
SearchInput.Name = "SearchInput"
SearchInput.Parent = SearchPanel
SearchInput.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SearchInput.BorderSizePixel = 0
SearchInput.Position = UDim2.new(0, 20, 0, 60)
SearchInput.Size = UDim2.new(1, -120, 0, 35)
SearchInput.Font = Enum.Font.Gotham
SearchInput.PlaceholderText = "Search for scripts... (keyless & verified only)"
SearchInput.Text = ""
SearchInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
SearchInput.TextSize = 12
SearchInput.ZIndex = 301

local SearchInputCorner = Instance.new("UICorner")
SearchInputCorner.CornerRadius = UDim.new(0, 6)
SearchInputCorner.Parent = SearchInput

-- Search Execute Button
local SearchExecuteButton = Instance.new("TextButton")
SearchExecuteButton.Name = "SearchExecuteButton"
SearchExecuteButton.Parent = SearchPanel
SearchExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 125, 255)
SearchExecuteButton.BorderSizePixel = 0
SearchExecuteButton.Position = UDim2.new(1, -85, 0, 60)
SearchExecuteButton.Size = UDim2.new(0, 65, 0, 35)
SearchExecuteButton.Font = Enum.Font.GothamBold
SearchExecuteButton.Text = "Search"
SearchExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchExecuteButton.TextSize = 12
SearchExecuteButton.ZIndex = 301

local SearchExecuteCorner = Instance.new("UICorner")
SearchExecuteCorner.CornerRadius = UDim.new(0, 6)
SearchExecuteCorner.Parent = SearchExecuteButton

-- Search Results Container
local SearchResultsContainer = Instance.new("ScrollingFrame")
SearchResultsContainer.Name = "SearchResultsContainer"
SearchResultsContainer.Parent = SearchPanel
SearchResultsContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
SearchResultsContainer.BorderSizePixel = 0
SearchResultsContainer.Position = UDim2.new(0, 20, 0, 110)
SearchResultsContainer.Size = UDim2.new(1, -40, 1, -130)
SearchResultsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
SearchResultsContainer.ScrollBarThickness = 8
SearchResultsContainer.ZIndex = 301

local SearchResultsCorner = Instance.new("UICorner")
SearchResultsCorner.CornerRadius = UDim.new(0, 8)
SearchResultsCorner.Parent = SearchResultsContainer

local SearchResultsLayout = Instance.new("UIListLayout")
SearchResultsLayout.Parent = SearchResultsContainer
SearchResultsLayout.SortOrder = Enum.SortOrder.LayoutOrder
SearchResultsLayout.Padding = UDim.new(0, 5)

-- Search Button Click Handler
SearchButton.MouseButton1Click:Connect(function()
    SearchPanel.Visible = not SearchPanel.Visible
    SearchPanelShadow.Visible = SearchPanel.Visible
    
    if SearchPanel.Visible then
        StarterGui:SetCore("SendNotification", {
            Title = "FlixHub Search";
            Text = "ScriptBlox search opened!";
            Duration = 1;
        })
    end
end)

-- Close Search Button Click Handler
CloseSearchButton.MouseButton1Click:Connect(function()
    SearchPanel.Visible = false
    SearchPanelShadow.Visible = false
end)

-- Function to create search result item
local function createSearchResultItem(scriptData, index)
    local ResultItem = Instance.new("Frame")
    ResultItem.Name = "SearchResult" .. index
    ResultItem.Parent = SearchResultsContainer
    ResultItem.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    ResultItem.BorderSizePixel = 0
    ResultItem.Size = UDim2.new(1, -10, 0, 80)
    ResultItem.ZIndex = 302
    
    local ResultCorner = Instance.new("UICorner")
    ResultCorner.CornerRadius = UDim.new(0, 8)
    ResultCorner.Parent = ResultItem
    
    -- Script Title
    local ScriptTitle = Instance.new("TextLabel")
    ScriptTitle.Name = "ScriptTitle"
    ScriptTitle.Parent = ResultItem
    ScriptTitle.BackgroundTransparency = 1
    ScriptTitle.Position = UDim2.new(0, 10, 0, 5)
    ScriptTitle.Size = UDim2.new(1, -120, 0, 25)
    ScriptTitle.Font = Enum.Font.GothamBold
    ScriptTitle.Text = scriptData.title or "Unknown Script"
    ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.TextSize = 12
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
    ScriptTitle.ZIndex = 303
    
    -- Script Game
    local ScriptGame = Instance.new("TextLabel")
    ScriptGame.Name = "ScriptGame"
    ScriptGame.Parent = ResultItem
    ScriptGame.BackgroundTransparency = 1
    ScriptGame.Position = UDim2.new(0, 10, 0, 30)
    ScriptGame.Size = UDim2.new(1, -120, 0, 20)
    ScriptGame.Font = Enum.Font.Gotham
    ScriptGame.Text = "Game: " .. (scriptData.game or "Universal")
    ScriptGame.TextColor3 = Color3.fromRGB(180, 180, 180)
    ScriptGame.TextSize = 10
    ScriptGame.TextXAlignment = Enum.TextXAlignment.Left
    ScriptGame.ZIndex = 303
    
    -- Script Status
    local ScriptStatus = Instance.new("TextLabel")
    ScriptStatus.Name = "ScriptStatus"
    ScriptStatus.Parent = ResultItem
    ScriptStatus.BackgroundTransparency = 1
    ScriptStatus.Position = UDim2.new(0, 10, 0, 50)
    ScriptStatus.Size = UDim2.new(1, -120, 0, 20)
    ScriptStatus.Font = Enum.Font.Gotham
    ScriptStatus.Text = "✅ Keyless & Verified"
    ScriptStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
    ScriptStatus.TextSize = 9
    ScriptStatus.TextXAlignment = Enum.TextXAlignment.Left
    ScriptStatus.ZIndex = 303
    
    -- Execute Button
    local ExecuteButton = Instance.new("TextButton")
    ExecuteButton.Name = "ExecuteButton"
    ExecuteButton.Parent = ResultItem
    ExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 125, 255)
    ExecuteButton.BorderSizePixel = 0
    ExecuteButton.Position = UDim2.new(1, -100, 0, 25)
    ExecuteButton.Size = UDim2.new(0, 80, 0, 30)
    ExecuteButton.Font = Enum.Font.GothamBold
    ExecuteButton.Text = "Execute"
    ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteButton.TextSize = 11
    ExecuteButton.ZIndex = 303
    
    local ExecuteCorner = Instance.new("UICorner")
    ExecuteCorner.CornerRadius = UDim.new(0, 6)
    ExecuteCorner.Parent = ExecuteButton
    
    -- Execute button functionality
    ExecuteButton.MouseButton1Click:Connect(function()
        if scriptData.script then
            pcall(function()
                loadstring(scriptData.script)()
            end)
            
            StarterGui:SetCore("SendNotification", {
                Title = "FlixHub Search";
                Text = "Executed: " .. (scriptData.title or "Script");
                Duration = 2;
            })
        end
    end)
    
    return ResultItem
end

-- Search Execute Button Click Handler
SearchExecuteButton.MouseButton1Click:Connect(function()
    local searchQuery = SearchInput.Text
    if searchQuery == "" then
        StarterGui:SetCore("SendNotification", {
            Title = "FlixHub Search";
            Text = "Please enter a search query!";
            Duration = 2;
        })
        return
    end
    
    -- Clear previous results
    for _, child in pairs(SearchResultsContainer:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Show loading message
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub Search";
        Text = "Searching ScriptBlox for: " .. searchQuery;
        Duration = 2;
    })
    
    -- Basic ScriptBlox API integration (simplified)
    spawn(function()
        pcall(function()
            local HttpService = game:GetService("HttpService")
            local apiUrl = "https://www.scriptblox.com/api/script/search?q=" .. HttpService:UrlEncode(searchQuery) .. "&mode=free"
            
            local success, response = pcall(function()
                return HttpService:GetAsync(apiUrl)
            end)
            
            if success then
                local data = HttpService:JSONDecode(response)
                
                if data.result and data.result.scripts then
                    local foundScripts = 0
                    
                    for i, script in pairs(data.result.scripts) do
                        -- Only show keyless and verified scripts
                        if script.key == false and script.verified == true and foundScripts < 10 then
                            foundScripts = foundScripts + 1
                            
                            local scriptData = {
                                title = script.title,
                                game = script.game and script.game.name or "Universal",
                                script = script.script
                            }
                            
                            createSearchResultItem(scriptData, foundScripts)
                        end
                    end
                    
                    -- Update canvas size
                    SearchResultsContainer.CanvasSize = UDim2.new(0, 0, 0, foundScripts * 85)
                    
                    if foundScripts == 0 then
                        StarterGui:SetCore("SendNotification", {
                            Title = "FlixHub Search";
                            Text = "No keyless & verified scripts found!";
                            Duration = 3;
                        })
                    else
                        StarterGui:SetCore("SendNotification", {
                            Title = "FlixHub Search";
                            Text = "Found " .. foundScripts .. " scripts!";
                            Duration = 2;
                        })
                    end
                else
                    StarterGui:SetCore("SendNotification", {
                        Title = "FlixHub Search";
                        Text = "No results found!";
                        Duration = 2;
                    })
                end
            else
                StarterGui:SetCore("SendNotification", {
                    Title = "FlixHub Search";
                    Text = "Search failed! Check your internet connection.";
                    Duration = 3;
                })
            end
        end)
    end)
end)

-- Function to get current size based on default values
local function getCurrentSizeValues()
    return 500, 350 -- Default size since settings are removed
end

-- Favorites button functionality
FavoritesButton.MouseButton1Click:Connect(function()
    toggleFavorites()
end)

-- Minimize button functionality
MinimizeButton.MouseButton1Click:Connect(function()
    if not isMinimized then
        -- Store current size before minimizing
        currentHubSize.width, currentHubSize.height = getCurrentSizeValues()
        
        -- Hide main frame completely with fade out animation
        local fadeOut = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        })
        local shadowFadeOut = TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        })
        local shadow2FadeOut = TweenService:Create(Shadow2, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        })
        local ambientFadeOut = TweenService:Create(AmbientShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        })
        
        fadeOut:Play()
        shadowFadeOut:Play()
        shadow2FadeOut:Play()
        ambientFadeOut:Play()
        
        -- After fade out, hide main frame and show minimize icon
        fadeOut.Completed:Connect(function()
            MainFrame.Visible = false
            Shadow.Visible = false
            Shadow2.Visible = false
            AmbientShadow.Visible = false
            
            -- Show minimize icon with animation
            MinimizeIcon.Visible = true
            MinimizeIconShadow.Visible = true
            
            local iconAppear = TweenService:Create(MinimizeIcon, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 60, 0, 60)
            })
            iconAppear:Play()
        end)
        
        isMinimized = true
        
        -- Show notification
        StarterGui:SetCore("SendNotification", {
            Title = "FlixHub";
            Text = "Hub minimized to icon. Click icon to restore.";
            Duration = 3;
        })
    end
end)

-- Minimize icon click functionality (restore hub)
MinimizeIconButton.MouseButton1Click:Connect(function()
    if isMinimized then
        -- Hide minimize icon with animation
        local iconDisappear = TweenService:Create(MinimizeIcon, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        })
        iconDisappear:Play()
        
        iconDisappear.Completed:Connect(function()
            MinimizeIcon.Visible = false
            MinimizeIconShadow.Visible = false
            
            -- Restore main frame
            MainFrame.Visible = true
            Shadow.Visible = true
            Shadow2.Visible = true
            AmbientShadow.Visible = true
            
            -- Reset transparencies and animate in
            MainFrame.BackgroundTransparency = 0.1
            Shadow.BackgroundTransparency = 0.3
            Shadow2.BackgroundTransparency = 0.15
            AmbientShadow.BackgroundTransparency = 0.8
            
            local fadeIn = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0.1
            })
            fadeIn:Play()
        end)
        
        isMinimized = false
        
        -- Show notification
        StarterGui:SetCore("SendNotification", {
            Title = "FlixHub";
            Text = "Hub restored successfully!";
            Duration = 2;
        })
    end
end)

-- Add hover effects to minimize icon
MinimizeIconButton.MouseEnter:Connect(function()
    TweenService:Create(MinimizeIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 70, 0, 70)
    }):Play()
    TweenService:Create(MinimizeIconStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Transparency = 0.2
    }):Play()
end)

MinimizeIconButton.MouseLeave:Connect(function()
    TweenService:Create(MinimizeIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 60, 0, 60)
    }):Play()
    TweenService:Create(MinimizeIconStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Transparency = 0.5
    }):Play()
end)

-- Duplicate function removed - using the original changeHubSize function

-- Function to apply theme with smooth transitions
local function applyTheme(themeName)
    local themeData = themes[themeName]
    if not themeData then
        print("Theme not found: " .. themeName)
        return
    end
    
    currentTheme = themeName
    
    -- Apply theme to main components with tweens
    local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        BackgroundColor3 = themeData.MainFrame
    })
    
    local sidebarTween = TweenService:Create(Sidebar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        BackgroundColor3 = themeData.Sidebar
    })
    
    local contentTween = TweenService:Create(ContentArea, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        BackgroundColor3 = themeData.ContentArea
    })
    
    local titleTween = TweenService:Create(TitleBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        BackgroundColor3 = themeData.TitleBar
    })
    
    mainTween:Play()
    sidebarTween:Play()
    contentTween:Play()
    titleTween:Play()
    
    -- Notification
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub";
        Text = "Theme changed to " .. themeName;
        Duration = 2;
    })
end





-- Initialize the GUI with new tab system
refreshTabs() -- Initialize tab system
createHomeContent() -- Start with Home tab content

-- Notification
StarterGui:SetCore("SendNotification", {
    Title = "FlixHub";
    Text = "Script hub loaded successfully!";
    Duration = 5;
})

print("FlixHub v2.0 loaded successfully!")
print("Created by FlixHub Team")
print("Features: Search, Categories, Keyless Scripts")

end -- End of createMainFlixHub function

-- Main initialization logic
if isKeyAuthenticated() then
    -- Key is already authenticated, create FlixHub directly
    createMainFlixHub()
else
    -- Show key authentication screen
    createKeyScreen()
end
