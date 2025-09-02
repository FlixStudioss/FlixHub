-- FlixHub - Working Version
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create main ScreenGui
local FlixHub = Instance.new("ScreenGui")
FlixHub.Name = "FlixHub"
FlixHub.Parent = playerGui
FlixHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FlixHub.ResetOnSpawn = false

-- Main Frame (Hub Window)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "FlixHub"
MainFrame.Parent = FlixHub
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
MainFrame.Size = UDim2.new(0, 800, 0, 500)
MainFrame.Active = true
MainFrame.Draggable = true

-- Corner rounding
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Shadow
local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Parent = FlixHub
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.7
Shadow.BorderSizePixel = 0
Shadow.Position = UDim2.new(0.5, -395, 0.5, -245)
Shadow.Size = UDim2.new(0, 800, 0, 500)
Shadow.ZIndex = 1

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 12)
ShadowCorner.Parent = Shadow

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.ZIndex = 3

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
TitleText.Text = "FlixHub v0.9.6"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.ZIndex = 4

-- Button Container
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Parent = TitleBar
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Position = UDim2.new(1, -120, 0, 12)
ButtonContainer.Size = UDim2.new(0, 110, 0, 26)
ButtonContainer.ZIndex = 4

-- Minimize functionality
local isMinimized = false

-- Minimize Icon (separate from main frame)
local MinimizeIcon = Instance.new("Frame")
MinimizeIcon.Name = "MinimizeIcon"
MinimizeIcon.Parent = FlixHub
MinimizeIcon.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MinimizeIcon.BorderSizePixel = 0
MinimizeIcon.Size = UDim2.new(0, 60, 0, 60)
MinimizeIcon.Position = UDim2.new(1, -80, 1, -80)
MinimizeIcon.Visible = false
MinimizeIcon.ZIndex = 100

local MinimizeIconCorner = Instance.new("UICorner")
MinimizeIconCorner.CornerRadius = UDim.new(0, 12)
MinimizeIconCorner.Parent = MinimizeIcon

-- Icon text (sparkles when minimized)
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

-- Minimize button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = ButtonContainer
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(0, 0, 0, 0)
MinimizeButton.Size = UDim2.new(0, 26, 0, 26)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.TextSize = 16
MinimizeButton.ZIndex = 5

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 4)
MinimizeCorner.Parent = MinimizeButton

-- Fullscreen button
local FullscreenButton = Instance.new("TextButton")
FullscreenButton.Name = "FullscreenButton"
FullscreenButton.Parent = ButtonContainer
FullscreenButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FullscreenButton.BorderSizePixel = 0
FullscreenButton.Position = UDim2.new(0, 28, 0, 0)
FullscreenButton.Size = UDim2.new(0, 26, 0, 26)
FullscreenButton.Font = Enum.Font.GothamBold
FullscreenButton.Text = "⛶"
FullscreenButton.TextColor3 = Color3.fromRGB(200, 200, 200)
FullscreenButton.TextSize = 12
FullscreenButton.ZIndex = 5

local FullscreenCorner = Instance.new("UICorner")
FullscreenCorner.CornerRadius = UDim.new(0, 4)
FullscreenCorner.Parent = FullscreenButton

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = ButtonContainer
CloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0, 56, 0, 0)
CloseButton.Size = UDim2.new(0, 26, 0, 26)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseButton.TextSize = 16
CloseButton.ZIndex = 5

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseButton

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.Size = UDim2.new(0, 250, 1, -50)
Sidebar.ZIndex = 3

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 0)
SidebarCorner.Parent = Sidebar

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame
ContentArea.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ContentArea.BorderSizePixel = 0
ContentArea.Position = UDim2.new(0, 250, 0, 50)
ContentArea.Size = UDim2.new(1, -250, 1, -50)
ContentArea.ZIndex = 3

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 0)
ContentCorner.Parent = ContentArea

-- Tab Container
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = Sidebar
TabContainer.BackgroundTransparency = 1
TabContainer.BorderSizePixel = 0
TabContainer.Position = UDim2.new(0, 0, 0, 20)
TabContainer.Size = UDim2.new(1, 0, 1, -80)
TabContainer.ScrollingDirection = Enum.ScrollingDirection.Y
TabContainer.ScrollBarThickness = 0
TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
TabContainer.ZIndex = 4

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabContainer
TabLayout.FillDirection = Enum.FillDirection.Vertical
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 5)

-- Script Container
local ScriptContainer = Instance.new("ScrollingFrame")
ScriptContainer.Name = "ScriptContainer"
ScriptContainer.Parent = ContentArea
ScriptContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ScriptContainer.BorderSizePixel = 0
ScriptContainer.Position = UDim2.new(0, 15, 0, 15)
ScriptContainer.Size = UDim2.new(1, -30, 1, -30)
ScriptContainer.ScrollBarThickness = 6
ScriptContainer.ScrollBarImageColor3 = Color3.fromRGB(75, 75, 100)
ScriptContainer.ZIndex = 4

local ScriptCorner = Instance.new("UICorner")
ScriptCorner.CornerRadius = UDim.new(0, 8)
ScriptCorner.Parent = ScriptContainer

local ScriptLayout = Instance.new("UIListLayout")
ScriptLayout.Parent = ScriptContainer
ScriptLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScriptLayout.Padding = UDim.new(0, 5)

-- Variables
local currentTab = "Universal"
local isGamesExpanded = false
local isVisualExpanded = false

-- Scripts Data
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
        name = "Solara Hub",
        description = "Really Good Scripts",
        script = [[loadstring(game:HttpGet("https://pastebin.com/raw/ixdvHv2g"))()]]
    }
}

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

local VisualScripts = {
    ["Grow A Garden Visual"] = {
        {
            name = "Pet,Seed Spawner",
            description = "Visual script for Grow A Garden pet and seed spawning",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/veryimportantrr/x/refs/heads/main/gag_visual.lua", true))("discord.gg/csxu2nCkw9")]]
        },
        {
            name = "Garden Visualizer",
            description = "Enhanced visual effects for Grow A Garden",
            script = [[loadstring(game:HttpGet('https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Garden/Garden-V1.lua'))()]]
        }
    }
}

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
            script = [[loadstring(game:HttpGet('https://cdn.exploitingis.fun/loader', true))()]]
        },
        {
            name = "Idiot Hub (Currently Down)",
            description = "IdiotHub script loader for Grow A Garden",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/IdiotHub/Scripts/main/Loader"))()]]
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
            name = "eF Hub (Currently Down)",
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
            name = "CompHub",
            description = "CompHub script for Steal A Brainrot",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/robloxcomphub/comphub/refs/heads/main/comphub.lua"))()]]
        },
        {
            name = "BlindHub",
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

-- Functions
local function createTab(tabName, layoutOrder, isExpandable, indentLevel)
    local Tab = Instance.new("TextButton")
    Tab.Name = tabName
    Tab.Parent = TabContainer
    
    local cleanTabName = tabName:gsub("[▼▶]", ""):gsub(" ", "")
    local isSelected = cleanTabName == currentTab or tabName == currentTab
    
    Tab.BackgroundColor3 = isSelected and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(40, 40, 40)
    Tab.BorderSizePixel = 0
    Tab.Size = UDim2.new(1, -20, 0, 35)
    Tab.Position = UDim2.new(0, 10 + (indentLevel or 0) * 15, 0, 0)
    Tab.Font = Enum.Font.GothamMedium
    
    local expandIcon = ""
    if isExpandable then
        if tabName:find("Visual Script") then
            expandIcon = isVisualExpanded and " ▼" or " ▶"
        elseif tabName:find("Games") then
            expandIcon = isGamesExpanded and " ▼" or " ▶"
        end
    end
    
    Tab.Text = "  " .. (indentLevel and string.rep("  ", indentLevel) or "") .. tabName:gsub("[▼▶]", "") .. expandIcon
    Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab.TextSize = (indentLevel and indentLevel > 0) and 12 or 14
    Tab.TextXAlignment = Enum.TextXAlignment.Left
    Tab.LayoutOrder = layoutOrder
    Tab.ZIndex = 5
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = Tab
    
    return Tab
end

local function createScriptItem(scriptData, index)
    local ScriptItem = Instance.new("Frame")
    ScriptItem.Name = "ScriptItem" .. index
    ScriptItem.Parent = ScriptContainer
    ScriptItem.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ScriptItem.BorderSizePixel = 0
    ScriptItem.Size = UDim2.new(1, -12, 0, 70)
    ScriptItem.LayoutOrder = index
    ScriptItem.ZIndex = 5
    
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
    ScriptName.ZIndex = 6
    
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
    ScriptDesc.ZIndex = 6
    
    -- Execute Button
    local ExecuteButton = Instance.new("TextButton")
    ExecuteButton.Name = "ExecuteButton"
    ExecuteButton.Parent = ScriptItem
    ExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 200, 75)
    ExecuteButton.BorderSizePixel = 0
    ExecuteButton.Position = UDim2.new(1, -50, 0, 20)
    ExecuteButton.Size = UDim2.new(0, 30, 0, 30)
    ExecuteButton.Font = Enum.Font.GothamBold
    ExecuteButton.Text = "▶"
    ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteButton.TextSize = 16
    ExecuteButton.ZIndex = 6
    
    local ExecuteCorner = Instance.new("UICorner")
    ExecuteCorner.CornerRadius = UDim.new(0, 6)
    ExecuteCorner.Parent = ExecuteButton
    
    -- Execute Button Click
    ExecuteButton.MouseButton1Click:Connect(function()
        ExecuteButton.Text = "⏳"
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
            ExecuteButton.Text = "✓"
            ExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 200, 75)
            wait(2)
            ExecuteButton.Text = "▶"
        else
            ExecuteButton.Text = "✗"
            ExecuteButton.BackgroundColor3 = Color3.fromRGB(200, 75, 75)
            wait(2)
            ExecuteButton.Text = "▶"
            ExecuteButton.BackgroundColor3 = Color3.fromRGB(75, 200, 75)
        end
    end)
    
    return ScriptItem
end

local function updateScriptDisplay()
    -- Clear existing scripts
    for _, child in pairs(ScriptContainer:GetChildren()) do
        if child:IsA("Frame") and child.Name:find("ScriptItem") then
            child:Destroy()
        end
    end
    
    local scriptsToShow = {}
    
    if currentTab == "Universal" then
        scriptsToShow = UniversalScripts
    elseif currentTab == "FE Scripts" then
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

local function refreshTabs()
    -- Clear existing tabs
    for _, child in pairs(TabContainer:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local layoutOrder = 1
    
    -- Universal Scripts tab
    local universalTab = createTab("Universal", layoutOrder, false, 0)
    universalTab.MouseButton1Click:Connect(function()
        currentTab = "Universal"
        refreshTabs()
        updateScriptDisplay()
    end)
    layoutOrder = layoutOrder + 1
    
    -- FE Scripts tab
    local feTab = createTab("FE Scripts", layoutOrder, false, 0)
    feTab.MouseButton1Click:Connect(function()
        currentTab = "FE Scripts"
        refreshTabs()
        updateScriptDisplay()
    end)
    layoutOrder = layoutOrder + 1
    
    -- Visual Script expandable category
    local visualTab = createTab("Visual Script", layoutOrder, true, 0)
    visualTab.MouseButton1Click:Connect(function()
        isVisualExpanded = not isVisualExpanded
        refreshTabs()
    end)
    layoutOrder = layoutOrder + 1
    
    -- Show Visual Script subcategories if expanded
    if isVisualExpanded then
        for visualName, _ in pairs(VisualScripts) do
            local visualSubTab = createTab(visualName:gsub(" Visual", ""), layoutOrder, false, 1)
            visualSubTab.MouseButton1Click:Connect(function()
                currentTab = visualName
                refreshTabs()
                updateScriptDisplay()
            end)
            layoutOrder = layoutOrder + 1
        end
    end
    
    -- Games expandable category
    local gamesTab = createTab("Games", layoutOrder, true, 0)
    gamesTab.MouseButton1Click:Connect(function()
        isGamesExpanded = not isGamesExpanded
        refreshTabs()
    end)
    layoutOrder = layoutOrder + 1
    
    -- Show game subcategories if expanded
    if isGamesExpanded then
        for gameName, _ in pairs(GameScripts) do
            local gameTab = createTab(gameName, layoutOrder, false, 1)
            gameTab.MouseButton1Click:Connect(function()
                currentTab = gameName
                refreshTabs()
                updateScriptDisplay()
            end)
            layoutOrder = layoutOrder + 1
        end
    end
    
    -- Update canvas size
    TabContainer.CanvasSize = UDim2.new(0, 0, 0, layoutOrder * 40)
end

-- Button functionality
CloseButton.MouseButton1Click:Connect(function()
    FlixHub:Destroy()
end)

FullscreenButton.MouseButton1Click:Connect(function()
    if MainFrame.Size == UDim2.new(0, 800, 0, 500) then
        MainFrame.Size = UDim2.new(0, 1200, 0, 700)
        MainFrame.Position = UDim2.new(0.5, -600, 0.5, -350)
        Shadow.Size = UDim2.new(0, 1200, 0, 700)
        Shadow.Position = UDim2.new(0.5, -595, 0.5, -345)
    else
        MainFrame.Size = UDim2.new(0, 800, 0, 500)
        MainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
        Shadow.Size = UDim2.new(0, 800, 0, 500)
        Shadow.Position = UDim2.new(0.5, -395, 0.5, -245)
    end
end)

-- Minimize button functionality
MinimizeButton.MouseButton1Click:Connect(function()
    if not isMinimized then
        MinimizeButton.Text = "✨"
        
        local fadeOut = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        })
        local shadowFadeOut = TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        })
        
        fadeOut:Play()
        shadowFadeOut:Play()
        
        fadeOut.Completed:Connect(function()
            MainFrame.Visible = false
            Shadow.Visible = false
            MinimizeIcon.Visible = true
        end)
        
        isMinimized = true
    end
end)

-- Minimize icon click functionality
MinimizeIconButton.MouseButton1Click:Connect(function()
    if isMinimized then
        MinimizeIcon.Visible = false
        MainFrame.Visible = true
        Shadow.Visible = true
        
        MainFrame.BackgroundTransparency = 0
        Shadow.BackgroundTransparency = 0.7
        
        MinimizeButton.Text = "−"
        isMinimized = false
    end
end)

-- Initialize
refreshTabs()
updateScriptDisplay()

-- Notification
StarterGui:SetCore("SendNotification", {
    Title = "FlixHub";
    Text = "Script hub loaded successfully!";
    Duration = 3;
})

print("FlixHub loaded successfully!")
