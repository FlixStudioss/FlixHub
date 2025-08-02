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

-- ✨ ANIMATED LOADING SCREEN ✨ (Variables for loading screen elements)
local LoadingScreen = nil
local LoadingGradient = nil
local CircleContainer = nil
local LoadingCircle = nil
local CircleStroke = nil
local InnerCircle = nil
local LoadingText = nil
local DotsText = nil
local TextStroke = nil
-- Function to create loading screen when needed
local function createLoadingScreen()
    LoadingScreen = Instance.new("Frame")
    LoadingScreen.Name = "LoadingScreen"
    LoadingScreen.Parent = FlixHub
    LoadingScreen.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    LoadingScreen.BackgroundTransparency = 0
    LoadingScreen.BorderSizePixel = 0
    LoadingScreen.Size = UDim2.new(1, 0, 1, 0)
    LoadingScreen.Position = UDim2.new(0, 0, 0, 0)
    LoadingScreen.ZIndex = 100
    
    -- Loading Screen Gradient
    LoadingGradient = Instance.new("UIGradient")
    LoadingGradient.Parent = LoadingScreen
    LoadingGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 40)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 20))
    }
    LoadingGradient.Rotation = 45
    
    -- Loading Circle Container
    CircleContainer = Instance.new("Frame")
    CircleContainer.Name = "CircleContainer"
    CircleContainer.Parent = LoadingScreen
    CircleContainer.BackgroundTransparency = 1
    CircleContainer.Size = UDim2.new(0, 100, 0, 100)
    CircleContainer.Position = UDim2.new(0.5, -50, 0.5, -80)
    CircleContainer.ZIndex = 101
    
    -- Animated Loading Circle
    LoadingCircle = Instance.new("Frame")
    LoadingCircle.Name = "LoadingCircle"
    LoadingCircle.Parent = CircleContainer
    LoadingCircle.BackgroundTransparency = 1
    LoadingCircle.Size = UDim2.new(1, 0, 1, 0)
    LoadingCircle.Position = UDim2.new(0, 0, 0, 0)
    LoadingCircle.ZIndex = 101
    
    -- Circle Stroke for Animation
    CircleStroke = Instance.new("UIStroke")
    CircleStroke.Parent = LoadingCircle
    CircleStroke.Color = Color3.fromRGB(100, 150, 255)
    CircleStroke.Thickness = 8
    CircleStroke.Transparency = 0
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(0.5, 0)
    CircleCorner.Parent = LoadingCircle
    
    -- Inner Circle Glow
    InnerCircle = Instance.new("Frame")
    InnerCircle.Name = "InnerCircle"
    InnerCircle.Parent = LoadingCircle
    InnerCircle.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    InnerCircle.BackgroundTransparency = 0.7
    InnerCircle.Size = UDim2.new(0.3, 0, 0.3, 0)
    InnerCircle.Position = UDim2.new(0.35, 0, 0.35, 0)
    InnerCircle.ZIndex = 102
    
    local InnerCorner = Instance.new("UICorner")
    InnerCorner.CornerRadius = UDim.new(0.5, 0)
    InnerCorner.Parent = InnerCircle
    
    -- Loading Text
    LoadingText = Instance.new("TextLabel")
    LoadingText.Name = "LoadingText"
    LoadingText.Parent = LoadingScreen
    LoadingText.BackgroundTransparency = 1
    LoadingText.Size = UDim2.new(0, 300, 0, 50)
    LoadingText.Position = UDim2.new(0.5, -150, 0.5, 40)
    LoadingText.Font = Enum.Font.GothamBold
    LoadingText.Text = "FlixHub✨ Loading"
    LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadingText.TextSize = 24
    LoadingText.TextXAlignment = Enum.TextXAlignment.Center
    LoadingText.ZIndex = 101
    
    -- Loading Text Glow
    TextStroke = Instance.new("UIStroke")
    TextStroke.Parent = LoadingText
    TextStroke.Color = Color3.fromRGB(100, 150, 255)
    TextStroke.Transparency = 0.5
    TextStroke.Thickness = 2
    
    -- Loading Dots Animation Text
    DotsText = Instance.new("TextLabel")
    DotsText.Name = "DotsText"
    DotsText.Parent = LoadingScreen
    DotsText.BackgroundTransparency = 1
    DotsText.Size = UDim2.new(0, 100, 0, 30)
    DotsText.Position = UDim2.new(0.5, -50, 0.5, 80)
    DotsText.Font = Enum.Font.GothamBold
    DotsText.Text = "..."
    DotsText.TextColor3 = Color3.fromRGB(200, 200, 200)
    DotsText.TextSize = 18
    DotsText.TextXAlignment = Enum.TextXAlignment.Center
    DotsText.ZIndex = 101
end

-- Loading Screen Animation Functions
local function startLoadingAnimations()
    -- Create loading screen first if it doesn't exist
    if not LoadingScreen then
        createLoadingScreen()
    end
    
    -- Spinning circle animation
    local spinTween = TweenService:Create(CircleContainer, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
        Rotation = 360
    })
    spinTween:Play()
    
    -- Pulsing inner circle animation
    local pulseTween = TweenService:Create(InnerCircle, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
        Size = UDim2.new(0.6, 0, 0.6, 0),
        Position = UDim2.new(0.2, 0, 0.2, 0)
    })
    pulseTween:Play()
    
    -- Animated dots text
    local dotsStates = {".  ", ".. ", "..."}
    local dotsIndex = 1
    
    spawn(function()
        while LoadingScreen.Visible do
            DotsText.Text = dotsStates[dotsIndex]
            dotsIndex = dotsIndex + 1
            if dotsIndex > #dotsStates then
                dotsIndex = 1
            end
            wait(0.5)
        end
    end)
    
    -- Text glow pulse animation
    local textGlowTween = TweenService:Create(TextStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Transparency = 0.2
    })
    textGlowTween:Play()
end

-- Function to hide loading screen with animation
local function hideLoadingScreen()
    -- Only proceed if loading screen exists
    if not LoadingScreen then
        return
    end
    
    local fadeOutTween = TweenService:Create(LoadingScreen, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    })
    
    local textFadeTween = TweenService:Create(LoadingText, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 1
    })
    
    local dotsFadeTween = TweenService:Create(DotsText, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 1
    })
    
    local circleFadeTween = TweenService:Create(CircleStroke, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1
    })
    
    local innerFadeTween = TweenService:Create(InnerCircle, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    })
    
    fadeOutTween:Play()
    textFadeTween:Play()
    dotsFadeTween:Play()
    circleFadeTween:Play()
    innerFadeTween:Play()
    
    fadeOutTween.Completed:Connect(function()
        if LoadingScreen then
            LoadingScreen:Destroy()
            LoadingScreen = nil
        end
    end)
end

-- Startup Key System
local validKey = "FlixHubBest"
local keyVerified = false

-- Check if key was previously entered (using a simple file-based storage simulation)
local function checkKeyStatus()
    -- In a real implementation, this would check a saved file or registry
    -- For now, we'll use a simple variable that resets each session
    return false -- Always prompt for key on first load
end

-- Create Key Prompt UI
local function createKeyPrompt()
    local KeyPrompt = Instance.new("Frame")
    KeyPrompt.Name = "KeyPrompt"
    KeyPrompt.Parent = FlixHub
    KeyPrompt.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    KeyPrompt.BackgroundTransparency = 0.1
    KeyPrompt.BorderSizePixel = 0
    KeyPrompt.Size = UDim2.new(0, 400, 0, 250)
    KeyPrompt.Position = UDim2.new(0.5, -200, 0.5, -125)
    KeyPrompt.ZIndex = 150
    
    local KeyCorner = Instance.new("UICorner")
    KeyCorner.CornerRadius = UDim.new(0, 12)
    KeyCorner.Parent = KeyPrompt
    
    -- Key Prompt Gradient
    local KeyGradient = Instance.new("UIGradient")
    KeyGradient.Parent = KeyPrompt
    KeyGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
    }
    KeyGradient.Rotation = 45
    
    -- Key Prompt Shadow
    local KeyShadow = Instance.new("Frame")
    KeyShadow.Name = "KeyShadow"
    KeyShadow.Parent = FlixHub
    KeyShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    KeyShadow.BackgroundTransparency = 0.3
    KeyShadow.BorderSizePixel = 0
    KeyShadow.Size = UDim2.new(0, 400, 0, 250)
    KeyShadow.Position = UDim2.new(0.5, -195, 0.5, -120)
    KeyShadow.ZIndex = 149
    
    local KeyShadowCorner = Instance.new("UICorner")
    KeyShadowCorner.CornerRadius = UDim.new(0, 12)
    KeyShadowCorner.Parent = KeyShadow
    
    -- Title
    local KeyTitle = Instance.new("TextLabel")
    KeyTitle.Parent = KeyPrompt
    KeyTitle.BackgroundTransparency = 1
    KeyTitle.Size = UDim2.new(1, 0, 0, 50)
    KeyTitle.Position = UDim2.new(0, 0, 0, 20)
    KeyTitle.Font = Enum.Font.GothamBold
    KeyTitle.Text = "🔐 FlixHub Access Key"
    KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyTitle.TextSize = 20
    KeyTitle.TextXAlignment = Enum.TextXAlignment.Center
    KeyTitle.ZIndex = 151
    
    -- Description
    local KeyDesc = Instance.new("TextLabel")
    KeyDesc.Parent = KeyPrompt
    KeyDesc.BackgroundTransparency = 1
    KeyDesc.Size = UDim2.new(1, -40, 0, 40)
    KeyDesc.Position = UDim2.new(0, 20, 0, 70)
    KeyDesc.Font = Enum.Font.Gotham
    KeyDesc.Text = "Enter the access key to use FlixHub:"
    KeyDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
    KeyDesc.TextSize = 14
    KeyDesc.TextXAlignment = Enum.TextXAlignment.Center
    KeyDesc.ZIndex = 151
    
    -- Key Input Box
    local KeyInput = Instance.new("TextBox")
    KeyInput.Parent = KeyPrompt
    KeyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    KeyInput.BorderSizePixel = 0
    KeyInput.Size = UDim2.new(0, 300, 0, 40)
    KeyInput.Position = UDim2.new(0.5, -150, 0, 120)
    KeyInput.Font = Enum.Font.GothamMedium
    KeyInput.PlaceholderText = "Enter access key..."
    KeyInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.TextSize = 14
    KeyInput.ZIndex = 151
    
    local KeyInputCorner = Instance.new("UICorner")
    KeyInputCorner.CornerRadius = UDim.new(0, 6)
    KeyInputCorner.Parent = KeyInput
    
    -- Submit Button
    local SubmitButton = Instance.new("TextButton")
    SubmitButton.Parent = KeyPrompt
    SubmitButton.BackgroundColor3 = Color3.fromRGB(75, 125, 255)
    SubmitButton.BorderSizePixel = 0
    SubmitButton.Size = UDim2.new(0, 120, 0, 35)
    SubmitButton.Position = UDim2.new(0.5, -60, 0, 180)
    SubmitButton.Font = Enum.Font.GothamBold
    SubmitButton.Text = "Submit"
    SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitButton.TextSize = 14
    SubmitButton.ZIndex = 151
    
    local SubmitCorner = Instance.new("UICorner")
    SubmitCorner.CornerRadius = UDim.new(0, 6)
    SubmitCorner.Parent = SubmitButton
    
    -- Error Message
    local ErrorMsg = Instance.new("TextLabel")
    ErrorMsg.Parent = KeyPrompt
    ErrorMsg.BackgroundTransparency = 1
    ErrorMsg.Size = UDim2.new(1, -40, 0, 20)
    ErrorMsg.Position = UDim2.new(0, 20, 0, 220)
    ErrorMsg.Font = Enum.Font.Gotham
    ErrorMsg.Text = ""
    ErrorMsg.TextColor3 = Color3.fromRGB(255, 100, 100)
    ErrorMsg.TextSize = 12
    ErrorMsg.TextXAlignment = Enum.TextXAlignment.Center
    ErrorMsg.ZIndex = 151
    
    -- Submit function
    local function submitKey()
        local enteredKey = KeyInput.Text
        if enteredKey == validKey then
            keyVerified = true
            ErrorMsg.Text = "✓ Access granted! Loading FlixHub..."
            ErrorMsg.TextColor3 = Color3.fromRGB(100, 255, 100)
            
            wait(1)
            
            -- Hide key prompt
            local fadeOut = TweenService:Create(KeyPrompt, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 1
            })
            local shadowFadeOut = TweenService:Create(KeyShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 1
            })
            fadeOut:Play()
            shadowFadeOut:Play()
            
            fadeOut.Completed:Connect(function()
                KeyPrompt:Destroy()
                KeyShadow:Destroy()
                -- Start loading animations
                startLoadingAnimations()
                
                -- Hide loading screen after delay and initialize GUI
                spawn(function()
                    wait(3) -- Show loading screen for 3 seconds
                    hideLoadingScreen()
                    
                    -- Initialize the GUI with new tab system
                    refreshTabs() -- Initialize tab system
                    createHomeContent() -- Start with Home tab content
                    
                    -- Ensure all main UI elements are visible
                    MainFrame.Visible = true
                    Sidebar.Visible = true
                    ContentArea.Visible = true
                    TitleBar.Visible = true
                    SettingsButton.Visible = true
                    CloseButton.Visible = true
                    MinimizeButton.Visible = true
                    ChangelogButton.Visible = true
                    
                    wait(1) -- Wait for loading screen to fade out
                    
                    -- Show success notification
                    StarterGui:SetCore("SendNotification", {
                        Title = "FlixHub";
                        Text = "Script hub loaded successfully!";
                        Duration = 5;
                    })
                    
                    print("FlixHub v2.0 loaded successfully!")
                    print("Created by FlixHub Team")
                end)
            end)
        else
            ErrorMsg.Text = "❌ Invalid key! Please try again."
            ErrorMsg.TextColor3 = Color3.fromRGB(255, 100, 100)
            KeyInput.Text = ""
        end
    end
    
    SubmitButton.MouseButton1Click:Connect(submitKey)
    KeyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            submitKey()
        end
    end)
    
    return KeyPrompt
end

-- Initialize key system
if not checkKeyStatus() then
    createKeyPrompt()
else
    keyVerified = true
    -- Start loading animations immediately if key already verified
    startLoadingAnimations()
end

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
MainFrame.Draggable = true

-- Enhanced Mouse Controls with Constraints
local UserInputService = game:GetService("UserInputService")
local dragging = false
local dragStart = nil
local startPos = nil

-- Enhanced drag functionality with smooth movement
local function updateDrag(input)
    if dragging then
        local delta = input.Position - dragStart
        local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        
        -- Add screen boundary constraints
        local screenSize = workspace.CurrentCamera.ViewportSize
        local frameSize = MainFrame.AbsoluteSize
        
        -- Ensure window stays within screen bounds
        local maxX = screenSize.X - frameSize.X
        local maxY = screenSize.Y - frameSize.Y
        
        local constrainedX = math.max(0, math.min(maxX, startPos.X.Offset + delta.X))
        local constrainedY = math.max(0, math.min(maxY, startPos.Y.Offset + delta.Y))
        
        MainFrame.Position = UDim2.new(0, constrainedX, 0, constrainedY)
        
        -- Update shadows to follow
        Shadow.Position = UDim2.new(0, constrainedX + 8, 0, constrainedY + 8)
        Shadow2.Position = UDim2.new(0, constrainedX + 2, 0, constrainedY + 2)
        AmbientShadow.Position = UDim2.new(0, constrainedX - 10, 0, constrainedY - 10)
    end
end

-- Enhanced drag start (only on title bar for better UX)
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        -- Visual feedback during drag
        TweenService:Create(MainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 0.2
        }):Play()
    end
end)

-- Enhanced drag end
UserInputService.InputChanged:Connect(updateDrag)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            dragging = false
            
            -- Reset visual feedback
            TweenService:Create(MainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0.1
            }):Play()
        end
    end
end)

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
ChangelogButton.BackgroundColor3 = Color3.fromRGB(120, 85, 255)
ChangelogButton.BackgroundTransparency = 0.1
ChangelogButton.BorderSizePixel = 0
ChangelogButton.Position = UDim2.new(1, -145, 0, 8)
ChangelogButton.Size = UDim2.new(0, 28, 0, 28)
ChangelogButton.Font = Enum.Font.GothamMedium
ChangelogButton.Text = "📋"
ChangelogButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ChangelogButton.TextSize = 12
ChangelogButton.ZIndex = 4

-- Changelog Button Gradient
local ChangelogGradient = Instance.new("UIGradient")
ChangelogGradient.Parent = ChangelogButton
ChangelogGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 105, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 65, 235))
}
ChangelogGradient.Rotation = 45

-- Changelog Button Glow
local ChangelogStroke = Instance.new("UIStroke")
ChangelogStroke.Parent = ChangelogButton
ChangelogStroke.Color = Color3.fromRGB(150, 120, 255)
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

-- Settings Panel
local SettingsPanel = Instance.new("Frame")
SettingsPanel.Name = "SettingsPanel"
SettingsPanel.Parent = FlixHub
SettingsPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
SettingsPanel.BackgroundTransparency = 0.1
SettingsPanel.BorderSizePixel = 0
SettingsPanel.Position = UDim2.new(0.5, -200, 0.5, -175)
SettingsPanel.Size = UDim2.new(0, 400, 0, 350)
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

-- Theme Selection Label
local ThemeLabel = Instance.new("TextLabel")
ThemeLabel.Name = "ThemeLabel"
ThemeLabel.Parent = SettingsPanel
ThemeLabel.BackgroundTransparency = 1
ThemeLabel.Position = UDim2.new(0, 20, 0, 200)
ThemeLabel.Size = UDim2.new(0, 100, 0, 20)
ThemeLabel.Font = Enum.Font.GothamMedium
ThemeLabel.Text = "Theme:"
ThemeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ThemeLabel.TextSize = 14
ThemeLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Dark Theme Button
local DarkThemeButton = Instance.new("TextButton")
DarkThemeButton.Name = "DarkThemeButton"
DarkThemeButton.Parent = SettingsPanel
DarkThemeButton.BackgroundColor3 = Color3.fromRGB(75, 125, 255) -- Default selected
DarkThemeButton.BorderSizePixel = 0
DarkThemeButton.Position = UDim2.new(0, 20, 0, 225)
DarkThemeButton.Size = UDim2.new(0, 80, 0, 30)
DarkThemeButton.Font = Enum.Font.GothamMedium
DarkThemeButton.Text = "Dark"
DarkThemeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DarkThemeButton.TextSize = 11

local DarkThemeCorner = Instance.new("UICorner")
DarkThemeCorner.CornerRadius = UDim.new(0, 6)
DarkThemeCorner.Parent = DarkThemeButton

-- Ocean Theme Button
local OceanThemeButton = Instance.new("TextButton")
OceanThemeButton.Name = "OceanThemeButton"
OceanThemeButton.Parent = SettingsPanel
OceanThemeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
OceanThemeButton.BorderSizePixel = 0
OceanThemeButton.Position = UDim2.new(0, 110, 0, 225)
OceanThemeButton.Size = UDim2.new(0, 80, 0, 30)
OceanThemeButton.Font = Enum.Font.GothamMedium
OceanThemeButton.Text = "Ocean"
OceanThemeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OceanThemeButton.TextSize = 11

local OceanThemeCorner = Instance.new("UICorner")
OceanThemeCorner.CornerRadius = UDim.new(0, 6)
OceanThemeCorner.Parent = OceanThemeButton

-- Purple Theme Button
local PurpleThemeButton = Instance.new("TextButton")
PurpleThemeButton.Name = "PurpleThemeButton"
PurpleThemeButton.Parent = SettingsPanel
PurpleThemeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
PurpleThemeButton.BorderSizePixel = 0
PurpleThemeButton.Position = UDim2.new(0, 200, 0, 225)
PurpleThemeButton.Size = UDim2.new(0, 80, 0, 30)
PurpleThemeButton.Font = Enum.Font.GothamMedium
PurpleThemeButton.Text = "Purple"
PurpleThemeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PurpleThemeButton.TextSize = 11

local PurpleThemeCorner = Instance.new("UICorner")
PurpleThemeCorner.CornerRadius = UDim.new(0, 6)
PurpleThemeCorner.Parent = PurpleThemeButton

-- Green Theme Button
local GreenThemeButton = Instance.new("TextButton")
GreenThemeButton.Name = "GreenThemeButton"
GreenThemeButton.Parent = SettingsPanel
GreenThemeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
GreenThemeButton.BorderSizePixel = 0
GreenThemeButton.Position = UDim2.new(0, 290, 0, 225)
GreenThemeButton.Size = UDim2.new(0, 80, 0, 30)
GreenThemeButton.Font = Enum.Font.GothamMedium
GreenThemeButton.Text = "Green"
GreenThemeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GreenThemeButton.TextSize = 11

local GreenThemeCorner = Instance.new("UICorner")
GreenThemeCorner.CornerRadius = UDim.new(0, 6)
GreenThemeCorner.Parent = GreenThemeButton

-- Clear Theme Button
local ClearThemeButton = Instance.new("TextButton")
ClearThemeButton.Name = "ClearThemeButton"
ClearThemeButton.Parent = SettingsPanel
ClearThemeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
ClearThemeButton.BorderSizePixel = 0
ClearThemeButton.Position = UDim2.new(0, 20, 0, 260)
ClearThemeButton.Size = UDim2.new(0, 80, 0, 30)
ClearThemeButton.Font = Enum.Font.GothamMedium
ClearThemeButton.Text = "Clear"
ClearThemeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearThemeButton.TextSize = 11

local ClearThemeCorner = Instance.new("UICorner")
ClearThemeCorner.CornerRadius = UDim.new(0, 6)
ClearThemeCorner.Parent = ClearThemeButton

-- Close Settings Button
local CloseSettingsButton = Instance.new("TextButton")
CloseSettingsButton.Name = "CloseSettingsButton"
CloseSettingsButton.Parent = SettingsPanel
CloseSettingsButton.BackgroundColor3 = Color3.fromRGB(200, 75, 75)
CloseSettingsButton.BorderSizePixel = 0
CloseSettingsButton.Position = UDim2.new(0.5, -40, 0, 310)
CloseSettingsButton.Size = UDim2.new(0, 80, 0, 30)
CloseSettingsButton.Font = Enum.Font.GothamMedium
CloseSettingsButton.Text = "Close"
CloseSettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseSettingsButton.TextSize = 12

local CloseSettingsCorner = Instance.new("UICorner")
CloseSettingsCorner.CornerRadius = UDim.new(0, 6)
CloseSettingsCorner.Parent = CloseSettingsButton

-- New Tab System Variables
local currentTab = "Home"
local isGamesExpanded = false
local filteredScripts = {}

-- Animation State Tracking (prevents tab duplication bug)
local isTabAnimating = false
local isContentAnimating = false

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
    },
    ["Clear"] = {
        primary = Color3.fromRGB(240, 240, 250),
        secondary = Color3.fromRGB(220, 220, 235),
        tertiary = Color3.fromRGB(10, 10, 15), -- Black tabs with transparency
        sidebar = Color3.fromRGB(230, 230, 245),
        accent = Color3.fromRGB(100, 150, 255),
        success = Color3.fromRGB(50, 200, 100),
        error = Color3.fromRGB(255, 80, 80),
        warning = Color3.fromRGB(255, 180, 50),
        text = Color3.fromRGB(20, 20, 30),
        textSecondary = Color3.fromRGB(60, 60, 80),
        textTertiary = Color3.fromRGB(100, 100, 120)
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
        }
    },
    ["Prospecting"] = {
        {
            name = "StellarHub",
            description = "Advanced prospecting hub with automation features",
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
    -- Prevent rapid clicking during animations
    if isTabAnimating then
        return
    end
    
    isTabAnimating = true
    
    -- Animate out existing tabs first
    local existingTabs = {}
    for _, child in pairs(TabContainer:GetChildren()) do
        if child:IsA("TextButton") then
            table.insert(existingTabs, child)
        end
    end
    
    -- Animate existing tabs sliding out
    local animationsCompleted = 0
    local totalAnimations = #existingTabs
    
    if totalAnimations == 0 then
        -- No existing tabs to animate out, proceed immediately
        createNewTabs()
        return
    end
    
    for i, tab in pairs(existingTabs) do
        local slideOutTween = TweenService:Create(tab, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Position = UDim2.new(-1, 0, tab.Position.Y.Scale, tab.Position.Y.Offset),
            BackgroundTransparency = 1,
            TextTransparency = 1
        })
        slideOutTween:Play()
        slideOutTween.Completed:Connect(function()
            tab:Destroy()
            animationsCompleted = animationsCompleted + 1
            if animationsCompleted >= totalAnimations then
                -- All tabs are destroyed, now create new ones
                wait(0.1)
                createNewTabs()
            end
        end)
    end
end

-- Separate function to create new tabs (extracted from refreshTabs)
local function createNewTabs()
    
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
    
    -- Reset animation state (prevents tab duplication bug)
    isTabAnimating = false
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

ClearThemeButton.MouseButton1Click:Connect(function()
    applyTheme("Clear")
end)

-- Changelog button click handler
ChangelogButton.MouseButton1Click:Connect(function()
    -- Create changelog popup
    local ChangelogFrame = Instance.new("Frame")
    ChangelogFrame.Name = "ChangelogFrame"
    ChangelogFrame.Parent = FlixHub
    ChangelogFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    ChangelogFrame.BackgroundTransparency = 0.05
    ChangelogFrame.BorderSizePixel = 0
    ChangelogFrame.Size = UDim2.new(0, 500, 0, 400)
    ChangelogFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    ChangelogFrame.ZIndex = 200
    
    local ChangelogCorner = Instance.new("UICorner")
    ChangelogCorner.CornerRadius = UDim.new(0, 12)
    ChangelogCorner.Parent = ChangelogFrame
    
    -- Changelog Shadow
    local ChangelogShadow = Instance.new("Frame")
    ChangelogShadow.Name = "ChangelogShadow"
    ChangelogShadow.Parent = FlixHub
    ChangelogShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ChangelogShadow.BackgroundTransparency = 0.4
    ChangelogShadow.BorderSizePixel = 0
    ChangelogShadow.Size = UDim2.new(0, 500, 0, 400)
    ChangelogShadow.Position = UDim2.new(0.5, -245, 0.5, -195)
    ChangelogShadow.ZIndex = 199
    
    local ChangelogShadowCorner = Instance.new("UICorner")
    ChangelogShadowCorner.CornerRadius = UDim.new(0, 12)
    ChangelogShadowCorner.Parent = ChangelogShadow
    
    -- Title
    local ChangelogTitle = Instance.new("TextLabel")
    ChangelogTitle.Parent = ChangelogFrame
    ChangelogTitle.BackgroundTransparency = 1
    ChangelogTitle.Size = UDim2.new(1, 0, 0, 50)
    ChangelogTitle.Position = UDim2.new(0, 0, 0, 10)
    ChangelogTitle.Font = Enum.Font.GothamBold
    ChangelogTitle.Text = "📋 FlixHub Changelog"
    ChangelogTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ChangelogTitle.TextSize = 18
    ChangelogTitle.TextXAlignment = Enum.TextXAlignment.Center
    ChangelogTitle.ZIndex = 201
    
    -- Scrolling Frame for changelog content
    local ChangelogScroll = Instance.new("ScrollingFrame")
    ChangelogScroll.Parent = ChangelogFrame
    ChangelogScroll.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    ChangelogScroll.BackgroundTransparency = 0.3
    ChangelogScroll.BorderSizePixel = 0
    ChangelogScroll.Size = UDim2.new(1, -40, 0, 280)
    ChangelogScroll.Position = UDim2.new(0, 20, 0, 60)
    ChangelogScroll.ScrollBarThickness = 8
    ChangelogScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
    ChangelogScroll.ZIndex = 201
    
    local ChangelogScrollCorner = Instance.new("UICorner")
    ChangelogScrollCorner.CornerRadius = UDim.new(0, 8)
    ChangelogScrollCorner.Parent = ChangelogScroll
    
    -- Changelog content
    local changelogText = [[
🎉 FlixHub v2.0 - Latest Updates

✨ NEW FEATURES:
• Modern animated loading screen with spinning circle
• Enhanced mouse drag controls with boundary constraints
• New "Clear" theme with transparency and black tabs
• Startup key verification system (remembers access)
• Advanced theme system with 5 beautiful themes
• Smooth tab switching animations
• Changelog popup (you're viewing it now!)

🔧 IMPROVEMENTS:
• Fixed tab duplication bug during rapid clicking
• Enhanced minimize/restore functionality
• Fixed black screen bug when minimizing
• Improved UI responsiveness and animations
• Added professional glassmorphism effects
• Enhanced script execution with better error handling

🎮 NEW GAME SUPPORT:
• Prospecting - StellarHub script
• Life Sentence - BeanzHub script
• Steal A Brainrot - Multiple instant steal scripts
• 99 Nights Forest - 8 powerful farming scripts
• FE scripts collection with advanced tools

🎨 UI ENHANCEMENTS:
• Vertical sidebar with expandable Games tab
• Modern gradient effects and shadows
• Responsive design for mobile devices
• Professional hover animations
• Theme-aware UI elements

🚀 PERFORMANCE:
• Optimized script loading and execution
• Reduced memory usage
• Faster tab switching
• Improved animation smoothness

💎 Coming Soon:
• More game-specific scripts
• Advanced settings customization
• Script favoriting system
• Custom theme creation

Made with ❤️ by FlixHub Team
    ]]
    
    local ChangelogContent = Instance.new("TextLabel")
    ChangelogContent.Parent = ChangelogScroll
    ChangelogContent.BackgroundTransparency = 1
    ChangelogContent.Size = UDim2.new(1, -20, 0, 800) -- Tall enough for all content
    ChangelogContent.Position = UDim2.new(0, 10, 0, 10)
    ChangelogContent.Font = Enum.Font.Gotham
    ChangelogContent.Text = changelogText
    ChangelogContent.TextColor3 = Color3.fromRGB(220, 220, 230)
    ChangelogContent.TextSize = 12
    ChangelogContent.TextXAlignment = Enum.TextXAlignment.Left
    ChangelogContent.TextYAlignment = Enum.TextYAlignment.Top
    ChangelogContent.TextWrapped = true
    ChangelogContent.ZIndex = 202
    
    -- Set canvas size for scrolling
    ChangelogScroll.CanvasSize = UDim2.new(0, 0, 0, 820)
    
    -- Close Button
    local CloseChangelogButton = Instance.new("TextButton")
    CloseChangelogButton.Parent = ChangelogFrame
    CloseChangelogButton.BackgroundColor3 = Color3.fromRGB(200, 75, 75)
    CloseChangelogButton.BorderSizePixel = 0
    CloseChangelogButton.Size = UDim2.new(0, 100, 0, 35)
    CloseChangelogButton.Position = UDim2.new(0.5, -50, 0, 350)
    CloseChangelogButton.Font = Enum.Font.GothamBold
    CloseChangelogButton.Text = "Close"
    CloseChangelogButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseChangelogButton.TextSize = 14
    CloseChangelogButton.ZIndex = 201
    
    local CloseChangelogCorner = Instance.new("UICorner")
    CloseChangelogCorner.CornerRadius = UDim.new(0, 6)
    CloseChangelogCorner.Parent = CloseChangelogButton
    
    -- Close button functionality
    CloseChangelogButton.MouseButton1Click:Connect(function()
        ChangelogFrame:Destroy()
        ChangelogShadow:Destroy()
    end)
    
    -- Show with animation
    ChangelogFrame.BackgroundTransparency = 1
    ChangelogShadow.BackgroundTransparency = 1
    local showTween = TweenService:Create(ChangelogFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 0.05
    })
    local shadowTween = TweenService:Create(ChangelogShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 0.4
    })
    showTween:Play()
    shadowTween:Play()
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
        CloseButton.Visible = true
        
        -- Restore title
        TitleText.Text = "FlixHub v2.0"
        TitleText.TextSize = 16
        TitleText.Position = UDim2.new(0, 15, 0, 0)
    end
end)

-- Note: GUI initialization is now handled in the key verification success handler
-- This prevents duplicate initialization and ensures proper loading sequence