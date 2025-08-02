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

-- Modern Settings Button with Gradient
local SettingsButton = Instance.new("TextButton")
SettingsButton.Name = "SettingsButton"
SettingsButton.Parent = TitleBar
SettingsButton.BackgroundColor3 = Color3.fromRGB(85, 135, 255)
SettingsButton.BackgroundTransparency = 0.1
SettingsButton.BorderSizePixel = 0
SettingsButton.Position = UDim2.new(1, -110, 0, 8)
SettingsButton.Size = UDim2.new(0, 28, 0, 28)
SettingsButton.Font = Enum.Font.GothamMedium
SettingsButton.Text = "⚙"
SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsButton.TextSize = 14
SettingsButton.ZIndex = 4

-- Settings Button Gradient
local SettingsGradient = Instance.new("UIGradient")
SettingsGradient.Parent = SettingsButton
SettingsGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(65, 115, 235))
}
SettingsGradient.Rotation = 45

-- Settings Button Glow
local SettingsStroke = Instance.new("UIStroke")
SettingsStroke.Parent = SettingsButton
SettingsStroke.Color = Color3.fromRGB(120, 170, 255)
SettingsStroke.Transparency = 0.6
SettingsStroke.Thickness = 1

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 6)
SettingsCorner.Parent = SettingsButton

-- Modern Changelog Button with Gradient
local ChangelogButton = Instance.new("TextButton")
ChangelogButton.Name = "ChangelogButton"
ChangelogButton.Parent = TitleBar
ChangelogButton.BackgroundColor3 = Color3.fromRGB(85, 200, 85)
ChangelogButton.BackgroundTransparency = 0.1
ChangelogButton.BorderSizePixel = 0
ChangelogButton.Position = UDim2.new(1, -145, 0, 8)
ChangelogButton.Size = UDim2.new(0, 28, 0, 28)
ChangelogButton.Font = Enum.Font.GothamMedium
ChangelogButton.Text = "📋"
ChangelogButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ChangelogButton.TextSize = 14
ChangelogButton.ZIndex = 4

-- Changelog Button Gradient
local ChangelogGradient = Instance.new("UIGradient")
ChangelogGradient.Parent = ChangelogButton
ChangelogGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 220, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(65, 180, 65))
}
ChangelogGradient.Rotation = 45

-- Changelog Button Glow
local ChangelogStroke = Instance.new("UIStroke")
ChangelogStroke.Parent = ChangelogButton
ChangelogStroke.Color = Color3.fromRGB(120, 240, 120)
ChangelogStroke.Transparency = 0.6
ChangelogStroke.Thickness = 1

local ChangelogCorner = Instance.new("UICorner")
ChangelogCorner.CornerRadius = UDim.new(0, 6)
ChangelogCorner.Parent = ChangelogButton

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

-- ===== BRAND NEW SETTINGS PANEL =====
-- Modern Settings Panel with Clean Implementation
local NewSettingsPanel = Instance.new("Frame")
NewSettingsPanel.Name = "NewSettingsPanel"
NewSettingsPanel.Parent = FlixHub
NewSettingsPanel.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
NewSettingsPanel.BackgroundTransparency = 0.05
NewSettingsPanel.BorderSizePixel = 0
NewSettingsPanel.Position = UDim2.new(0.5, -200, 0.5, -150)
NewSettingsPanel.Size = UDim2.new(0, 400, 0, 300)
NewSettingsPanel.Visible = false
NewSettingsPanel.ZIndex = 20

-- Settings Panel Corner
local NewSettingsCorner = Instance.new("UICorner")
NewSettingsCorner.CornerRadius = UDim.new(0, 15)
NewSettingsCorner.Parent = NewSettingsPanel

-- Settings Panel Gradient
local NewSettingsGradient = Instance.new("UIGradient")
NewSettingsGradient.Parent = NewSettingsPanel
NewSettingsGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 35, 45)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 30, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 25, 35))
}
NewSettingsGradient.Rotation = 45

-- Settings Panel Shadow
local NewSettingsShadow = Instance.new("Frame")
NewSettingsShadow.Name = "NewSettingsShadow"
NewSettingsShadow.Parent = FlixHub
NewSettingsShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
NewSettingsShadow.BackgroundTransparency = 0.7
NewSettingsShadow.BorderSizePixel = 0
NewSettingsShadow.Position = UDim2.new(0.5, -195, 0.5, -145)
NewSettingsShadow.Size = UDim2.new(0, 400, 0, 300)
NewSettingsShadow.Visible = false
NewSettingsShadow.ZIndex = 19

local NewShadowCorner = Instance.new("UICorner")
NewShadowCorner.CornerRadius = UDim.new(0, 15)
NewShadowCorner.Parent = NewSettingsShadow

-- Settings Title
local NewSettingsTitle = Instance.new("TextLabel")
NewSettingsTitle.Name = "NewSettingsTitle"
NewSettingsTitle.Parent = NewSettingsPanel
NewSettingsTitle.BackgroundTransparency = 1
NewSettingsTitle.Position = UDim2.new(0, 0, 0, 15)
NewSettingsTitle.Size = UDim2.new(1, 0, 0, 35)
NewSettingsTitle.Font = Enum.Font.GothamBold
NewSettingsTitle.Text = "⚙️ FlixHub Settings"
NewSettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
NewSettingsTitle.TextSize = 18
NewSettingsTitle.TextXAlignment = Enum.TextXAlignment.Center
NewSettingsTitle.ZIndex = 21

-- Hub Size Section
local SizeSection = Instance.new("TextLabel")
SizeSection.Name = "SizeSection"
SizeSection.Parent = NewSettingsPanel
SizeSection.BackgroundTransparency = 1
SizeSection.Position = UDim2.new(0, 25, 0, 60)
SizeSection.Size = UDim2.new(1, -50, 0, 25)
SizeSection.Font = Enum.Font.GothamMedium
SizeSection.Text = "🔧 Hub Size"
SizeSection.TextColor3 = Color3.fromRGB(200, 220, 255)
SizeSection.TextSize = 14
SizeSection.TextXAlignment = Enum.TextXAlignment.Left
SizeSection.ZIndex = 21

-- Size Buttons Container
local SizeContainer = Instance.new("Frame")
SizeContainer.Name = "SizeContainer"
SizeContainer.Parent = NewSettingsPanel
SizeContainer.BackgroundTransparency = 1
SizeContainer.Position = UDim2.new(0, 25, 0, 90)
SizeContainer.Size = UDim2.new(1, -50, 0, 70)
SizeContainer.ZIndex = 21

-- Very Small Button (Direct Creation)
local VerySmallBtn = Instance.new("TextButton")
VerySmallBtn.Name = "VerySmallBtn"
VerySmallBtn.Parent = SizeContainer
VerySmallBtn.BackgroundColor3 = Color3.fromRGB(85, 135, 255) -- Default selected
VerySmallBtn.BorderSizePixel = 0
VerySmallBtn.Position = UDim2.new(0, 0, 0, 0)
VerySmallBtn.Size = UDim2.new(0.5, -2.5, 0, 30)
VerySmallBtn.Font = Enum.Font.GothamMedium
VerySmallBtn.Text = "Very Small"
VerySmallBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerySmallBtn.TextSize = 11
VerySmallBtn.ZIndex = 22

local VerySmallCorner = Instance.new("UICorner")
VerySmallCorner.CornerRadius = UDim.new(0, 8)
VerySmallCorner.Parent = VerySmallBtn

-- Small Button
local SmallBtn = Instance.new("TextButton")
SmallBtn.Name = "SmallBtn"
SmallBtn.Parent = SizeContainer
SmallBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
SmallBtn.BorderSizePixel = 0
SmallBtn.Position = UDim2.new(0.5, 5, 0, 0)
SmallBtn.Size = UDim2.new(0.5, -2.5, 0, 30)
SmallBtn.Font = Enum.Font.GothamMedium
SmallBtn.Text = "Small"
SmallBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SmallBtn.TextSize = 11
SmallBtn.ZIndex = 22

local SmallCorner = Instance.new("UICorner")
SmallCorner.CornerRadius = UDim.new(0, 8)
SmallCorner.Parent = SmallBtn

-- Medium Button
local MediumBtn = Instance.new("TextButton")
MediumBtn.Name = "MediumBtn"
MediumBtn.Parent = SizeContainer
MediumBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
MediumBtn.BorderSizePixel = 0
MediumBtn.Position = UDim2.new(0, 0, 0, 35)
MediumBtn.Size = UDim2.new(0.5, -2.5, 0, 30)
MediumBtn.Font = Enum.Font.GothamMedium
MediumBtn.Text = "Medium"
MediumBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MediumBtn.TextSize = 11
MediumBtn.ZIndex = 22

local MediumCorner = Instance.new("UICorner")
MediumCorner.CornerRadius = UDim.new(0, 8)
MediumCorner.Parent = MediumBtn

-- Large Button
local LargeBtn = Instance.new("TextButton")
LargeBtn.Name = "LargeBtn"
LargeBtn.Parent = SizeContainer
LargeBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
LargeBtn.BorderSizePixel = 0
LargeBtn.Position = UDim2.new(0.5, 5, 0, 35)
LargeBtn.Size = UDim2.new(0.5, -2.5, 0, 30)
LargeBtn.Font = Enum.Font.GothamMedium
LargeBtn.Text = "Large"
LargeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LargeBtn.TextSize = 11
LargeBtn.ZIndex = 22

local LargeCorner = Instance.new("UICorner")
LargeCorner.CornerRadius = UDim.new(0, 8)
LargeCorner.Parent = LargeBtn

-- Theme Section
local ThemeSection = Instance.new("TextLabel")
ThemeSection.Name = "ThemeSection"
ThemeSection.Parent = NewSettingsPanel
ThemeSection.BackgroundTransparency = 1
ThemeSection.Position = UDim2.new(0, 25, 0, 170)
ThemeSection.Size = UDim2.new(1, -50, 0, 25)
ThemeSection.Font = Enum.Font.GothamMedium
ThemeSection.Text = "🎨 Theme"
ThemeSection.TextColor3 = Color3.fromRGB(200, 220, 255)
ThemeSection.TextSize = 14
ThemeSection.TextXAlignment = Enum.TextXAlignment.Left
ThemeSection.ZIndex = 21

-- Theme Buttons Container
local ThemeContainer = Instance.new("Frame")
ThemeContainer.Name = "ThemeContainer"
ThemeContainer.Parent = NewSettingsPanel
ThemeContainer.BackgroundTransparency = 1
ThemeContainer.Position = UDim2.new(0, 25, 0, 200)
ThemeContainer.Size = UDim2.new(1, -50, 0, 35)
ThemeContainer.ZIndex = 21

-- Dark Theme Button (Direct Creation)
local DarkBtn = Instance.new("TextButton")
DarkBtn.Name = "DarkBtn"
DarkBtn.Parent = ThemeContainer
DarkBtn.BackgroundColor3 = Color3.fromRGB(85, 135, 255) -- Default selected
DarkBtn.BorderSizePixel = 0
DarkBtn.Position = UDim2.new(0, 0, 0, 0)
DarkBtn.Size = UDim2.new(0.25, -2, 0, 30)
DarkBtn.Font = Enum.Font.GothamMedium
DarkBtn.Text = "Dark"
DarkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DarkBtn.TextSize = 10
DarkBtn.ZIndex = 22

local DarkCorner = Instance.new("UICorner")
DarkCorner.CornerRadius = UDim.new(0, 8)
DarkCorner.Parent = DarkBtn

-- Ocean Theme Button
local OceanBtn = Instance.new("TextButton")
OceanBtn.Name = "OceanBtn"
OceanBtn.Parent = ThemeContainer
OceanBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 80)
OceanBtn.BorderSizePixel = 0
OceanBtn.Position = UDim2.new(0.25, 2, 0, 0)
OceanBtn.Size = UDim2.new(0.25, -2, 0, 30)
OceanBtn.Font = Enum.Font.GothamMedium
OceanBtn.Text = "Ocean"
OceanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OceanBtn.TextSize = 10
OceanBtn.ZIndex = 22

local OceanCorner = Instance.new("UICorner")
OceanCorner.CornerRadius = UDim.new(0, 8)
OceanCorner.Parent = OceanBtn

-- Purple Theme Button
local PurpleBtn = Instance.new("TextButton")
PurpleBtn.Name = "PurpleBtn"
PurpleBtn.Parent = ThemeContainer
PurpleBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 80)
PurpleBtn.BorderSizePixel = 0
PurpleBtn.Position = UDim2.new(0.5, 4, 0, 0)
PurpleBtn.Size = UDim2.new(0.25, -2, 0, 30)
PurpleBtn.Font = Enum.Font.GothamMedium
PurpleBtn.Text = "Purple"
PurpleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PurpleBtn.TextSize = 10
PurpleBtn.ZIndex = 22

local PurpleCorner = Instance.new("UICorner")
PurpleCorner.CornerRadius = UDim.new(0, 8)
PurpleCorner.Parent = PurpleBtn

-- Green Theme Button
local GreenBtn = Instance.new("TextButton")
GreenBtn.Name = "GreenBtn"
GreenBtn.Parent = ThemeContainer
GreenBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 40)
GreenBtn.BorderSizePixel = 0
GreenBtn.Position = UDim2.new(0.75, 6, 0, 0)
GreenBtn.Size = UDim2.new(0.25, -2, 0, 30)
GreenBtn.Font = Enum.Font.GothamMedium
GreenBtn.Text = "Green"
GreenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GreenBtn.TextSize = 10
GreenBtn.ZIndex = 22

local GreenCorner = Instance.new("UICorner")
GreenCorner.CornerRadius = UDim.new(0, 8)
GreenCorner.Parent = GreenBtn

-- Close Button
local NewCloseButton = Instance.new("TextButton")
NewCloseButton.Name = "NewCloseButton"
NewCloseButton.Parent = NewSettingsPanel
NewCloseButton.BackgroundColor3 = Color3.fromRGB(220, 85, 85)
NewCloseButton.BorderSizePixel = 0
NewCloseButton.Position = UDim2.new(0.5, -50, 0, 250)
NewCloseButton.Size = UDim2.new(0, 100, 0, 35)
NewCloseButton.Font = Enum.Font.GothamBold
NewCloseButton.Text = "✖️ Close"
NewCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NewCloseButton.TextSize = 12
NewCloseButton.ZIndex = 22

local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.CornerRadius = UDim.new(0, 10)
CloseButtonCorner.Parent = NewCloseButton

-- Modern Changelog Panel
local ChangelogPanel = Instance.new("ScrollingFrame")
ChangelogPanel.Name = "ChangelogPanel"
ChangelogPanel.Parent = FlixHub
ChangelogPanel.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
ChangelogPanel.BackgroundTransparency = 0.1
ChangelogPanel.BorderSizePixel = 0
ChangelogPanel.Position = UDim2.new(0.5, -250, 0.5, -200)
ChangelogPanel.Size = UDim2.new(0, 500, 0, 400)
ChangelogPanel.Visible = false
ChangelogPanel.ZIndex = 15
ChangelogPanel.ScrollBarThickness = 8
ChangelogPanel.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)

-- Changelog Panel Gradient
local ChangelogGradientBG = Instance.new("UIGradient")
ChangelogGradientBG.Parent = ChangelogPanel
ChangelogGradientBG.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 30, 40)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 25, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 20, 30))
}
ChangelogGradientBG.Rotation = 45

local ChangelogPanelCorner = Instance.new("UICorner")
ChangelogPanelCorner.CornerRadius = UDim.new(0, 12)
ChangelogPanelCorner.Parent = ChangelogPanel

-- Changelog Panel Glow
local ChangelogPanelStroke = Instance.new("UIStroke")
ChangelogPanelStroke.Parent = ChangelogPanel
ChangelogPanelStroke.Color = Color3.fromRGB(120, 240, 120)
ChangelogPanelStroke.Transparency = 0.7
ChangelogPanelStroke.Thickness = 2

-- Changelog Shadow
local ChangelogShadow = Instance.new("Frame")
ChangelogShadow.Name = "ChangelogShadow"
ChangelogShadow.Parent = FlixHub
ChangelogShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ChangelogShadow.BackgroundTransparency = 0.3
ChangelogShadow.BorderSizePixel = 0
ChangelogShadow.Position = UDim2.new(0.5, -245, 0.5, -195)
ChangelogShadow.Size = UDim2.new(0, 500, 0, 400)
ChangelogShadow.Visible = false
ChangelogShadow.ZIndex = 14

local ChangelogShadowCorner = Instance.new("UICorner")
ChangelogShadowCorner.CornerRadius = UDim.new(0, 12)
ChangelogShadowCorner.Parent = ChangelogShadow

-- Changelog Title
local ChangelogTitle = Instance.new("TextLabel")
ChangelogTitle.Name = "ChangelogTitle"
ChangelogTitle.Parent = ChangelogPanel
ChangelogTitle.BackgroundTransparency = 1
ChangelogTitle.Position = UDim2.new(0, 20, 0, 20)
ChangelogTitle.Size = UDim2.new(1, -100, 0, 40)
ChangelogTitle.Font = Enum.Font.GothamBold
ChangelogTitle.Text = "📋 FlixHub v2.0 - Changelog"
ChangelogTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ChangelogTitle.TextSize = 20
ChangelogTitle.TextXAlignment = Enum.TextXAlignment.Left
ChangelogTitle.ZIndex = 16

-- Changelog Title Glow
local ChangelogTitleStroke = Instance.new("UIStroke")
ChangelogTitleStroke.Parent = ChangelogTitle
ChangelogTitleStroke.Color = Color3.fromRGB(120, 240, 120)
ChangelogTitleStroke.Transparency = 0.5
ChangelogTitleStroke.Thickness = 2

-- Changelog Content
local ChangelogContent = Instance.new("TextLabel")
ChangelogContent.Name = "ChangelogContent"
ChangelogContent.Parent = ChangelogPanel
ChangelogContent.BackgroundTransparency = 1
ChangelogContent.Position = UDim2.new(0, 20, 0, 80)
ChangelogContent.Size = UDim2.new(1, -40, 0, 1200) -- Large height for scrolling
ChangelogContent.Font = Enum.Font.Gotham
ChangelogContent.TextColor3 = Color3.fromRGB(220, 220, 220)
ChangelogContent.TextSize = 14
ChangelogContent.TextXAlignment = Enum.TextXAlignment.Left
ChangelogContent.TextYAlignment = Enum.TextYAlignment.Top
ChangelogContent.TextWrapped = true
ChangelogContent.ZIndex = 16
ChangelogContent.Text = [[
🚀 VERSION 2.0 - MAJOR UPDATE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ NEW FEATURES:
• Modern UI Redesign - Complete visual overhaul with glassmorphism effects
• 4 Theme System - Dark, Ocean, Purple, and Green themes with smooth transitions
• Animated Loading Screen - Beautiful spinning circle with "FlixHub✨ Loading"
• Enhanced Tab System - Vertical sidebar with expandable Games category
• Advanced Mouse Controls - Smooth dragging with screen boundary constraints
• Multi-Layer Shadows - Professional depth with primary, secondary, and ambient shadows

🎮 NEW GAME SUPPORT:
• Prospecting - Added StellarHub script for advanced automation
• 99 Nights Forest - 8 powerful scripts including eF Hub, GoaHub, SolunaHub
• FE Scripts Tab - 5 frontend exploit scripts for universal use
• Steal A Brainrot - Instant steal scripts (v1 and v2)
• Life Sentence - BeanzHub script integration

🔧 IMPROVEMENTS:
• Fixed minimize black screen bug - All shadow layers now properly position
• Tab duplication fix - Animation state tracking prevents rapid clicking issues
• Enhanced search - Now covers Universal, FE, and all game scripts
• Smooth animations - 60+ modern transitions and hover effects
• Better performance - Optimized script execution and UI rendering

🎨 UI ENHANCEMENTS:
• Gradient backgrounds on all major elements
• Glow effects on buttons and text
• Modern typography with enhanced spacing
• Professional button designs with hover scaling
• Smooth content transitions between tabs

⚙️ SETTINGS:
• Hub size options - Very Small (mobile), Small, Medium, Large
• Theme selection - 4 beautiful themes with instant preview
• Organized settings panel - Clean separation of size and theme options

🐛 BUG FIXES:
• Script execution errors resolved
• Minimize/restore functionality improved
• Theme switching stability enhanced
• Tab animation conflicts eliminated
• Search functionality refined

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💡 FlixHub v2.0 - The most advanced Roblox script hub
🌟 Created by FlixHub Team with ❤️
]]

-- Update canvas size for scrolling
ChangelogPanel.CanvasSize = UDim2.new(0, 0, 0, 1300)

-- Close Changelog Button
local CloseChangelogButton = Instance.new("TextButton")
CloseChangelogButton.Name = "CloseChangelogButton"
CloseChangelogButton.Parent = ChangelogPanel
CloseChangelogButton.BackgroundColor3 = Color3.fromRGB(200, 75, 75)
CloseChangelogButton.BackgroundTransparency = 0.1
CloseChangelogButton.BorderSizePixel = 0
CloseChangelogButton.Position = UDim2.new(1, -60, 0, 20)
CloseChangelogButton.Size = UDim2.new(0, 35, 0, 35)
CloseChangelogButton.Font = Enum.Font.GothamBold
CloseChangelogButton.Text = "×"
CloseChangelogButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseChangelogButton.TextSize = 18
CloseChangelogButton.ZIndex = 16

local CloseChangelogCorner = Instance.new("UICorner")
CloseChangelogCorner.CornerRadius = UDim.new(0, 6)
CloseChangelogCorner.Parent = CloseChangelogButton

-- Close Changelog Gradient
local CloseChangelogGradient = Instance.new("UIGradient")
CloseChangelogGradient.Parent = CloseChangelogButton
CloseChangelogGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 95, 95)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 65, 65))
}
CloseChangelogGradient.Rotation = 45

-- New Tab System Variables
local currentTab = "Home"
local isGamesExpanded = false
local filteredScripts = {}

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
    }
}

-- Theme Application Function
local function applyTheme(themeName)
    local theme = themes[themeName]
    if not theme then return end
    
    currentTheme = themeName
    
    -- Main UI Elements with smooth transitions
    local transitionInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Main Frame
    TweenService:Create(MainFrame, transitionInfo, {BackgroundColor3 = theme.primary}):Play()
    TweenService:Create(TitleBar, transitionInfo, {BackgroundColor3 = theme.secondary}):Play()
    TweenService:Create(Sidebar, transitionInfo, {BackgroundColor3 = theme.sidebar}):Play()
    TweenService:Create(SearchContainer, transitionInfo, {BackgroundColor3 = theme.secondary}):Play()
    TweenService:Create(ScriptContainer, transitionInfo, {BackgroundColor3 = theme.tertiary}):Play()
    
    -- Settings Panel
    TweenService:Create(SettingsPanel, transitionInfo, {BackgroundColor3 = theme.sidebar}):Play()
    TweenService:Create(SettingsShadow, transitionInfo, {BackgroundColor3 = theme.sidebar}):Play()
    
    -- Update text colors
    TitleText.TextColor3 = theme.text
    SearchBox.TextColor3 = theme.text
    SearchBox.PlaceholderColor3 = theme.textTertiary
    SearchIcon.TextColor3 = theme.textTertiary
    SizeLabel.TextColor3 = theme.textSecondary
    ThemeLabel.TextColor3 = theme.textSecondary
    
    -- Update theme button colors
    DarkThemeButton.BackgroundColor3 = themeName == "Dark" and theme.accent or Color3.fromRGB(60, 60, 80)
    OceanThemeButton.BackgroundColor3 = themeName == "Ocean" and theme.accent or Color3.fromRGB(60, 60, 80)
    PurpleThemeButton.BackgroundColor3 = themeName == "Purple" and theme.accent or Color3.fromRGB(60, 60, 80)
    GreenThemeButton.BackgroundColor3 = themeName == "Green" and theme.accent or Color3.fromRGB(60, 60, 80)
    
    -- Refresh tabs with new theme
    refreshTabs()
    
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

-- Game Scripts (Inside Games expandable category)
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
    HomeFrame.Size = UDim2.new(1, 0, 0, 200)
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
    
    -- Current Game
    local GameLabel = Instance.new("TextLabel")
    GameLabel.Name = "GameLabel"
    GameLabel.Parent = HomeFrame
    GameLabel.BackgroundTransparency = 1
    GameLabel.Position = UDim2.new(0, 20, 0, 60)
    GameLabel.Size = UDim2.new(1, -40, 0, 30)
    GameLabel.Font = Enum.Font.GothamMedium
    GameLabel.Text = "🎮 Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    GameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    GameLabel.TextSize = 14
    GameLabel.TextXAlignment = Enum.TextXAlignment.Left
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
    
    -- Create Games expandable tab
    local gamesTab = createTab("🎮 Games " .. (isGamesExpanded and "▼" or "▶"), false)
    gamesTab.LayoutOrder = 4
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
        local gameOrder = 5
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
    
    -- Refresh tabs for new size
    refreshTabsOnResize()
    
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

-- Theme button clicks with smooth animations
DarkThemeButton.MouseButton1Click:Connect(function()
    applyTheme("Dark")
end)

OceanThemeButton.MouseButton1Click:Connect(function()
    applyTheme("Ocean")
end)

PurpleThemeButton.MouseButton1Click:Connect(function()
    applyTheme("Purple")
end)

GreenThemeButton.MouseButton1Click:Connect(function()
    applyTheme("Green")
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

-- Current size tracking
local currentSize = "Very Small" -- Default size

-- Hub size change function
local function changeHubSize(sizeName, width, height)
    currentSize = sizeName
    
    -- Update main frame size
    local sizeTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
    })
    
    -- Update all shadow sizes
    local shadowTween = TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2 + 8, 0.5, -height/2 + 8)
    })
    
    local shadow2Tween = TweenService:Create(Shadow2, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2 + 2, 0.5, -height/2 + 2)
    })
    
    local ambientTween = TweenService:Create(AmbientShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width + 20, 0, height + 20),
        Position = UDim2.new(0.5, -width/2 - 10, 0.5, -height/2 - 10)
    })
    
    sizeTween:Play()
    shadowTween:Play()
    shadow2Tween:Play()
    ambientTween:Play()
    
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

-- Theme application function
local function applyTheme(themeName)
    currentTheme = themeName
    local theme = themes[themeName]
    
    -- Apply theme to main elements with smooth transitions
    local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        BackgroundColor3 = theme.primary
    })
    
    local sidebarTween = TweenService:Create(Sidebar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        BackgroundColor3 = theme.sidebar
    })
    
    local contentTween = TweenService:Create(ContentArea, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        BackgroundColor3 = theme.secondary
    })
    
    mainTween:Play()
    sidebarTween:Play()
    contentTween:Play()
    
    -- Update theme button colors
    DarkThemeButton.BackgroundColor3 = themeName == "Dark" and Color3.fromRGB(75, 125, 255) or Color3.fromRGB(60, 60, 80)
    OceanThemeButton.BackgroundColor3 = themeName == "Ocean" and Color3.fromRGB(75, 125, 255) or Color3.fromRGB(60, 60, 80)
    PurpleThemeButton.BackgroundColor3 = themeName == "Purple" and Color3.fromRGB(75, 125, 255) or Color3.fromRGB(60, 60, 80)
    GreenThemeButton.BackgroundColor3 = themeName == "Green" and Color3.fromRGB(75, 125, 255) or Color3.fromRGB(60, 60, 80)
    
    -- Show notification
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub Theme";
        Text = "Theme changed to " .. themeName;
        Duration = 2;
    })
end

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
        
        -- Fix all shadows for minimize
        local shadowMinimizeTween = TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 80, 0, 50),
            Position = UDim2.new(0.5, -38, 0.5, -23)
        })
        local shadow2MinimizeTween = TweenService:Create(Shadow2, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 80, 0, 50),
            Position = UDim2.new(0.5, -42, 0.5, -27)
        })
        local ambientMinimizeTween = TweenService:Create(AmbientShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 90, 0, 60),
            Position = UDim2.new(0.5, -45, 0.5, -30)
        })
        
        minimizeTween:Play()
        shadowMinimizeTween:Play()
        shadow2MinimizeTween:Play()
        ambientMinimizeTween:Play()
        isMinimized = true
        MinimizeButton.Text = "+"
        
        -- Hide other elements when minimized
        Sidebar.Visible = false
        ContentArea.Visible = false
        SettingsButton.Visible = false
        ChangelogButton.Visible = false
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
        
        -- Restore all shadows to original positions
        local shadowRestoreTween = TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, currentHubSize.width, 0, currentHubSize.height),
            Position = UDim2.new(0.5, -currentHubSize.width/2 + 8, 0.5, -currentHubSize.height/2 + 8)
        })
        local shadow2RestoreTween = TweenService:Create(Shadow2, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, currentHubSize.width, 0, currentHubSize.height),
            Position = UDim2.new(0.5, -currentHubSize.width/2 + 2, 0.5, -currentHubSize.height/2 + 2)
        })
        local ambientRestoreTween = TweenService:Create(AmbientShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, currentHubSize.width + 20, 0, currentHubSize.height + 20),
            Position = UDim2.new(0.5, -currentHubSize.width/2 - 10, 0.5, -currentHubSize.height/2 - 10)
        })
        
        restoreTween:Play()
        shadowRestoreTween:Play()
        shadow2RestoreTween:Play()
        ambientRestoreTween:Play()
        isMinimized = false
        MinimizeButton.Text = "-"
        
        -- Show other elements when restored
        Sidebar.Visible = true
        ContentArea.Visible = true
        SettingsButton.Visible = true
        ChangelogButton.Visible = true
        CloseButton.Visible = true
        
        -- Restore title
        TitleText.Text = "FlixHub v2.0"
        TitleText.TextSize = 16
        TitleText.Position = UDim2.new(0, 15, 0, 0)
    end
end)

-- Function to change hub size with smooth animations
local function changeHubSize(sizeName, width, height)
    currentHubSize.width = width
    currentHubSize.height = height
    
    -- Animate MainFrame
    local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
    })
    
    -- Animate all shadows
    local shadowTween = TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2 + 8, 0.5, -height/2 + 8)
    })
    
    local shadow2Tween = TweenService:Create(Shadow2, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2 + 2, 0.5, -height/2 + 2)
    })
    
    local ambientTween = TweenService:Create(AmbientShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width + 20, 0, height + 20),
        Position = UDim2.new(0.5, -width/2 - 10, 0.5, -height/2 - 10)
    })
    
    mainTween:Play()
    shadowTween:Play()
    shadow2Tween:Play()
    ambientTween:Play()
    
    -- Notification
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub";
        Text = "Hub size changed to " .. sizeName;
        Duration = 2;
    })
end

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

-- ===== NEW SETTINGS PANEL FUNCTIONALITY =====

-- Settings button click handler (updated for new panel)
SettingsButton.MouseButton1Click:Connect(function()
    NewSettingsPanel.Visible = not NewSettingsPanel.Visible
    NewSettingsShadow.Visible = NewSettingsPanel.Visible
end)

-- New Close Settings Button Handler
NewCloseButton.MouseButton1Click:Connect(function()
    NewSettingsPanel.Visible = false
    NewSettingsShadow.Visible = false
end)

-- ===== DIRECT BUTTON CLICK HANDLERS =====

-- Very Small Button Click Handler
VerySmallBtn.MouseButton1Click:Connect(function()
    -- Reset all size buttons
    VerySmallBtn.BackgroundColor3 = Color3.fromRGB(85, 135, 255)
    SmallBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    MediumBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    LargeBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    
    -- Resize to Very Small (500x350)
    local width, height = 500, 350
    currentHubSize.width = width
    currentHubSize.height = height
    
    local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
    })
    local shadowTween = TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2 + 8, 0.5, -height/2 + 8)
    })
    local shadow2Tween = TweenService:Create(Shadow2, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2 + 2, 0.5, -height/2 + 2)
    })
    local ambientTween = TweenService:Create(AmbientShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width + 20, 0, height + 20),
        Position = UDim2.new(0.5, -width/2 - 10, 0.5, -height/2 - 10)
    })
    
    mainTween:Play()
    shadowTween:Play()
    shadow2Tween:Play()
    ambientTween:Play()
    
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub Settings";
        Text = "Hub size changed to Very Small";
        Duration = 2;
    })
end)

-- Small Button Click Handler
SmallBtn.MouseButton1Click:Connect(function()
    -- Reset all size buttons
    VerySmallBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    SmallBtn.BackgroundColor3 = Color3.fromRGB(85, 135, 255)
    MediumBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    LargeBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    
    -- Resize to Small (600x400)
    local width, height = 600, 400
    currentHubSize.width = width
    currentHubSize.height = height
    
    local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
    })
    local shadowTween = TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2 + 8, 0.5, -height/2 + 8)
    })
    local shadow2Tween = TweenService:Create(Shadow2, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2 + 2, 0.5, -height/2 + 2)
    })
    local ambientTween = TweenService:Create(AmbientShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width + 20, 0, height + 20),
        Position = UDim2.new(0.5, -width/2 - 10, 0.5, -height/2 - 10)
    })
    
    mainTween:Play()
    shadowTween:Play()
    shadow2Tween:Play()
    ambientTween:Play()
    
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub Settings";
        Text = "Hub size changed to Small";
        Duration = 2;
    })
end)

-- Medium Button Click Handler
MediumBtn.MouseButton1Click:Connect(function()
    -- Reset all size buttons
    VerySmallBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    SmallBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    MediumBtn.BackgroundColor3 = Color3.fromRGB(85, 135, 255)
    LargeBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    
    -- Resize to Medium (700x500)
    local width, height = 700, 500
    currentHubSize.width = width
    currentHubSize.height = height
    
    local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
    })
    local shadowTween = TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2 + 8, 0.5, -height/2 + 8)
    })
    local shadow2Tween = TweenService:Create(Shadow2, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2 + 2, 0.5, -height/2 + 2)
    })
    local ambientTween = TweenService:Create(AmbientShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width + 20, 0, height + 20),
        Position = UDim2.new(0.5, -width/2 - 10, 0.5, -height/2 - 10)
    })
    
    mainTween:Play()
    shadowTween:Play()
    shadow2Tween:Play()
    ambientTween:Play()
    
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub Settings";
        Text = "Hub size changed to Medium";
        Duration = 2;
    })
end)

-- Large Button Click Handler
LargeBtn.MouseButton1Click:Connect(function()
    -- Reset all size buttons
    VerySmallBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    SmallBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    MediumBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    LargeBtn.BackgroundColor3 = Color3.fromRGB(85, 135, 255)
    
    -- Resize to Large (800x600)
    local width, height = 800, 600
    currentHubSize.width = width
    currentHubSize.height = height
    
    local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
    })
    local shadowTween = TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2 + 8, 0.5, -height/2 + 8)
    })
    local shadow2Tween = TweenService:Create(Shadow2, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width/2 + 2, 0.5, -height/2 + 2)
    })
    local ambientTween = TweenService:Create(AmbientShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, width + 20, 0, height + 20),
        Position = UDim2.new(0.5, -width/2 - 10, 0.5, -height/2 - 10)
    })
    
    mainTween:Play()
    shadowTween:Play()
    shadow2Tween:Play()
    ambientTween:Play()
    
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub Settings";
        Text = "Hub size changed to Large";
        Duration = 2;
    })
end)

-- Dark Theme Button Click Handler
DarkBtn.MouseButton1Click:Connect(function()
    -- Reset all theme buttons
    DarkBtn.BackgroundColor3 = Color3.fromRGB(85, 135, 255)
    OceanBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 80)
    PurpleBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 80)
    GreenBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 40)
    
    -- Apply Dark theme
    local selectedTheme = themes["Dark"]
    if selectedTheme then
        currentTheme = "Dark"
        local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.MainFrame
        })
        local sidebarTween = TweenService:Create(Sidebar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.Sidebar
        })
        local contentTween = TweenService:Create(ContentArea, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.ContentArea
        })
        local titleTween = TweenService:Create(TitleBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.TitleBar
        })
        
        mainTween:Play()
        sidebarTween:Play()
        contentTween:Play()
        titleTween:Play()
        
        StarterGui:SetCore("SendNotification", {
            Title = "FlixHub Settings";
            Text = "Theme changed to Dark";
            Duration = 2;
        })
    end
end)

-- Ocean Theme Button Click Handler
OceanBtn.MouseButton1Click:Connect(function()
    -- Reset all theme buttons
    DarkBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    OceanBtn.BackgroundColor3 = Color3.fromRGB(85, 135, 255)
    PurpleBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 80)
    GreenBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 40)
    
    -- Apply Ocean theme
    local selectedTheme = themes["Ocean"]
    if selectedTheme then
        currentTheme = "Ocean"
        local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.MainFrame
        })
        local sidebarTween = TweenService:Create(Sidebar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.Sidebar
        })
        local contentTween = TweenService:Create(ContentArea, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.ContentArea
        })
        local titleTween = TweenService:Create(TitleBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.TitleBar
        })
        
        mainTween:Play()
        sidebarTween:Play()
        contentTween:Play()
        titleTween:Play()
        
        StarterGui:SetCore("SendNotification", {
            Title = "FlixHub Settings";
            Text = "Theme changed to Ocean";
            Duration = 2;
        })
    end
end)

-- Purple Theme Button Click Handler
PurpleBtn.MouseButton1Click:Connect(function()
    -- Reset all theme buttons
    DarkBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    OceanBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 80)
    PurpleBtn.BackgroundColor3 = Color3.fromRGB(85, 135, 255)
    GreenBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 40)
    
    -- Apply Purple theme
    local selectedTheme = themes["Purple"]
    if selectedTheme then
        currentTheme = "Purple"
        local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.MainFrame
        })
        local sidebarTween = TweenService:Create(Sidebar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.Sidebar
        })
        local contentTween = TweenService:Create(ContentArea, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.ContentArea
        })
        local titleTween = TweenService:Create(TitleBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.TitleBar
        })
        
        mainTween:Play()
        sidebarTween:Play()
        contentTween:Play()
        titleTween:Play()
        
        StarterGui:SetCore("SendNotification", {
            Title = "FlixHub Settings";
            Text = "Theme changed to Purple";
            Duration = 2;
        })
    end
end)

-- Green Theme Button Click Handler
GreenBtn.MouseButton1Click:Connect(function()
    -- Reset all theme buttons
    DarkBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    OceanBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 80)
    PurpleBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 80)
    GreenBtn.BackgroundColor3 = Color3.fromRGB(85, 135, 255)
    
    -- Apply Green theme
    local selectedTheme = themes["Green"]
    if selectedTheme then
        currentTheme = "Green"
        local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.MainFrame
        })
        local sidebarTween = TweenService:Create(Sidebar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.Sidebar
        })
        local contentTween = TweenService:Create(ContentArea, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.ContentArea
        })
        local titleTween = TweenService:Create(TitleBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = selectedTheme.TitleBar
        })
        
        mainTween:Play()
        sidebarTween:Play()
        contentTween:Play()
        titleTween:Play()
        
        StarterGui:SetCore("SendNotification", {
            Title = "FlixHub Settings";
            Text = "Theme changed to Green";
            Duration = 2;
        })
    end
end)

-- Changelog button click handler
ChangelogButton.MouseButton1Click:Connect(function()
    ChangelogPanel.Visible = not ChangelogPanel.Visible
    ChangelogShadow.Visible = ChangelogPanel.Visible
end)

-- Close changelog button handler
CloseChangelogButton.MouseButton1Click:Connect(function()
    ChangelogPanel.Visible = false
    ChangelogShadow.Visible = false
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

-- Theme button clicks
DarkThemeButton.MouseButton1Click:Connect(function()
    applyTheme("Dark")
end)

OceanThemeButton.MouseButton1Click:Connect(function()
    applyTheme("Ocean")
end)

PurpleThemeButton.MouseButton1Click:Connect(function()
    applyTheme("Purple")
end)

GreenThemeButton.MouseButton1Click:Connect(function()
    applyTheme("Green")
end)

-- Close settings button
CloseSettingsButton.MouseButton1Click:Connect(function()
    SettingsPanel.Visible = false
    SettingsShadow.Visible = false
end)

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