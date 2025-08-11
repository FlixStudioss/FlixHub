-- ✨Flix Hub - Modern Script Hub for Roblox
-- Version: 3.0

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Script Data
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
    }
}

local VisualScripts = {
    ["Grow A Garden Visual"] = {
        {
            name = "Pet,Seed Spawner",
            description = "Visual script for Grow A Garden pet and seed spawning",
            script = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/veryimportantrr/x/refs/heads/main/gag_visual.lua", true))("discord.gg/csxu2nCkw9")]]
        }
    }
}

-- Theme
local theme = {
    Primary = Color3.fromRGB(35, 35, 45),
    Secondary = Color3.fromRGB(45, 45, 55),
    Accent = Color3.fromRGB(88, 166, 255),
    Background = Color3.fromRGB(25, 25, 35),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(200, 200, 200),
    Success = Color3.fromRGB(76, 175, 80),
    Error = Color3.fromRGB(244, 67, 54)
}

-- Helper Functions
local function createCorner(radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    return corner
end

local function notify(message, color)
    local notif = Instance.new("Frame")
    notif.Parent = playerGui
    notif.AnchorPoint = Vector2.new(1, 0)
    notif.Position = UDim2.new(1, -20, 0, 50)
    notif.Size = UDim2.new(0, 300, 0, 60)
    notif.BackgroundColor3 = theme.Secondary
    notif.ZIndex = 1000
    
    createCorner(8).Parent = notif
    
    local text = Instance.new("TextLabel")
    text.Parent = notif
    text.Size = UDim2.new(1, -20, 1, 0)
    text.Position = UDim2.new(0, 10, 0, 0)
    text.BackgroundTransparency = 1
    text.Text = message
    text.TextColor3 = color or theme.Text
    text.Font = Enum.Font.GothamMedium
    text.TextSize = 14
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextWrapped = true
    
    task.spawn(function()
        task.wait(3)
        notif:Destroy()
    end)
end

local function executeScript(scriptCode, scriptName)
    task.spawn(function()
        notify("Executing: " .. scriptName, theme.Accent)
        local success, err = pcall(function()
            loadstring(scriptCode)()
        end)
        
        if success then
            notify("✅ " .. scriptName .. " executed successfully!", theme.Success)
        else
            notify("❌ Error executing " .. scriptName, theme.Error)
            warn("FlixHub Error:", err)
        end
    end)
end

-- Create Main GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlixHubV3"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size = UDim2.new(0, 900, 0, 600)
mainFrame.BackgroundColor3 = theme.Primary
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

createCorner(12).Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Parent = mainFrame
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = theme.Background
createCorner(12).Parent = titleBar

local title = Instance.new("TextLabel")
title.Parent = titleBar
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "✨Flix Hub v3.0"
title.TextColor3 = theme.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton")
closeBtn.Parent = titleBar
closeBtn.AnchorPoint = Vector2.new(1, 0.5)
closeBtn.Position = UDim2.new(1, -15, 0.5, 0)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.BackgroundColor3 = theme.Error
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14

createCorner(6).Parent = closeBtn
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Parent = mainFrame
sidebar.Size = UDim2.new(0, 220, 1, -50)
sidebar.Position = UDim2.new(0, 0, 0, 50)
sidebar.BackgroundColor3 = theme.Background
createCorner(8).Parent = sidebar

local sidebarScroll = Instance.new("ScrollingFrame")
sidebarScroll.Parent = sidebar
sidebarScroll.Size = UDim2.new(1, -10, 1, -10)
sidebarScroll.Position = UDim2.new(0, 5, 0, 5)
sidebarScroll.BackgroundTransparency = 1
sidebarScroll.ScrollBarThickness = 4
sidebarScroll.ScrollBarImageColor3 = theme.Accent
sidebarScroll.CanvasSize = UDim2.new(0, 0, 0, 500)

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.Parent = sidebarScroll
sidebarLayout.Padding = UDim.new(0, 5)

local sidebarPadding = Instance.new("UIPadding")
sidebarPadding.Parent = sidebarScroll
sidebarPadding.PaddingAll = UDim.new(0, 10)

-- Content Area
local contentArea = Instance.new("Frame")
contentArea.Parent = mainFrame
contentArea.Size = UDim2.new(1, -230, 1, -60)
contentArea.Position = UDim2.new(0, 230, 0, 50)
contentArea.BackgroundColor3 = theme.Secondary
createCorner(8).Parent = contentArea

local contentScroll = Instance.new("ScrollingFrame")
contentScroll.Parent = contentArea
contentScroll.Size = UDim2.new(1, -20, 1, -20)
contentScroll.Position = UDim2.new(0, 10, 0, 10)
contentScroll.BackgroundTransparency = 1
contentScroll.ScrollBarThickness = 6
contentScroll.ScrollBarImageColor3 = theme.Accent
contentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local contentLayout = Instance.new("UIListLayout")
contentLayout.Parent = contentScroll
contentLayout.Padding = UDim.new(0, 10)

local contentPadding = Instance.new("UIPadding")
contentPadding.Parent = contentScroll
contentPadding.PaddingAll = UDim.new(0, 10)

-- Tab Creation
local function createTab(name, icon)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Parent = sidebarScroll
    tabBtn.Size = UDim2.new(1, 0, 0, 40)
    tabBtn.BackgroundColor3 = theme.Secondary
    tabBtn.Text = (icon or "") .. " " .. name
    tabBtn.TextColor3 = theme.TextSecondary
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.TextSize = 14
    tabBtn.TextXAlignment = Enum.TextXAlignment.Left
    
    createCorner(6).Parent = tabBtn
    
    local padding = Instance.new("UIPadding")
    padding.Parent = tabBtn
    padding.PaddingLeft = UDim.new(0, 15)
    
    return tabBtn
end

-- Script Item Creation
local function createScriptItem(scriptInfo)
    local itemFrame = Instance.new("Frame")
    itemFrame.Parent = contentScroll
    itemFrame.Size = UDim2.new(1, 0, 0, 80)
    itemFrame.BackgroundColor3 = theme.Primary
    createCorner(8).Parent = itemFrame
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = itemFrame
    nameLabel.Size = UDim2.new(1, -120, 0, 25)
    nameLabel.Position = UDim2.new(0, 15, 0, 10)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = scriptInfo.name
    nameLabel.TextColor3 = theme.Text
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 16
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Parent = itemFrame
    descLabel.Size = UDim2.new(1, -120, 0, 35)
    descLabel.Position = UDim2.new(0, 15, 0, 35)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = scriptInfo.description
    descLabel.TextColor3 = theme.TextSecondary
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 12
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextWrapped = true
    
    local executeBtn = Instance.new("TextButton")
    executeBtn.Parent = itemFrame
    executeBtn.AnchorPoint = Vector2.new(1, 0.5)
    executeBtn.Position = UDim2.new(1, -15, 0.5, 0)
    executeBtn.Size = UDim2.new(0, 80, 0, 35)
    executeBtn.BackgroundColor3 = theme.Accent
    executeBtn.Text = "Execute"
    executeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    executeBtn.Font = Enum.Font.GothamBold
    executeBtn.TextSize = 14
    
    createCorner(6).Parent = executeBtn
    
    executeBtn.MouseButton1Click:Connect(function()
        executeScript(scriptInfo.script, scriptInfo.name)
    end)
    
    return itemFrame
end

-- Home Tab Content
local function showHome()
    contentScroll:ClearAllChildren()
    contentLayout.Parent = contentScroll
    contentPadding.Parent = contentScroll
    
    local welcomeFrame = Instance.new("Frame")
    welcomeFrame.Parent = contentScroll
    welcomeFrame.Size = UDim2.new(1, 0, 0, 200)
    welcomeFrame.BackgroundColor3 = theme.Primary
    createCorner(12).Parent = welcomeFrame
    
    local playerLabel = Instance.new("TextLabel")
    playerLabel.Parent = welcomeFrame
    playerLabel.Size = UDim2.new(1, -30, 0, 50)
    playerLabel.Position = UDim2.new(0, 15, 0, 20)
    playerLabel.BackgroundTransparency = 1
    playerLabel.Text = "👋 Welcome, " .. player.Name .. "!"
    playerLabel.TextColor3 = theme.Text
    playerLabel.Font = Enum.Font.GothamBold
    playerLabel.TextSize = 24
    playerLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local gameLabel = Instance.new("TextLabel")
    gameLabel.Parent = welcomeFrame
    gameLabel.Size = UDim2.new(1, -30, 0, 40)
    gameLabel.Position = UDim2.new(0, 15, 0, 80)
    gameLabel.BackgroundTransparency = 1
    gameLabel.Text = "🎮 Current Game: " .. (game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown")
    gameLabel.TextColor3 = theme.TextSecondary
    gameLabel.Font = Enum.Font.GothamMedium
    gameLabel.TextSize = 16
    gameLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local statsLabel = Instance.new("TextLabel")
    statsLabel.Parent = welcomeFrame
    statsLabel.Size = UDim2.new(1, -30, 0, 40)
    statsLabel.Position = UDim2.new(0, 15, 0, 130)
    statsLabel.BackgroundTransparency = 1
    local totalScripts = #UniversalScripts + #FEScripts
    for _, gameScripts in pairs(GameScripts) do
        totalScripts = totalScripts + #gameScripts
    end
    for _, visualScripts in pairs(VisualScripts) do
        totalScripts = totalScripts + #visualScripts
    end
    statsLabel.Text = "📊 Total Scripts Available: " .. totalScripts
    statsLabel.TextColor3 = theme.TextSecondary
    statsLabel.Font = Enum.Font.GothamMedium
    statsLabel.TextSize = 14
    statsLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    contentScroll.CanvasSize = UDim2.new(0, 0, 0, 220)
end

-- Show Scripts Function
local function showScripts(scripts)
    contentScroll:ClearAllChildren()
    contentLayout.Parent = contentScroll
    contentPadding.Parent = contentScroll
    
    for _, scriptInfo in pairs(scripts) do
        createScriptItem(scriptInfo)
    end
    
    contentScroll.CanvasSize = UDim2.new(0, 0, 0, #scripts * 90 + 20)
end

-- Show Game Scripts
local function showGameScripts(gameName)
    if GameScripts[gameName] then
        showScripts(GameScripts[gameName])
    end
end

-- Tab Setup
local homeTab = createTab("Home", "🏠")
local universalTab = createTab("Universal", "🌍")
local feTab = createTab("FE", "⚡")
local gamesTab = createTab("Games", "🎮")
local visualTab = createTab("Visual", "👁️")

-- Game tabs (initially hidden)
local gameButtons = {}
for gameName, _ in pairs(GameScripts) do
    local gameTab = createTab(gameName, "")
    gameTab.Visible = false
    gameTab.Size = UDim2.new(1, -20, 0, 35)
    gameTab.Position = UDim2.new(0, 20, 0, 0)
    gameTab.BackgroundColor3 = theme.Primary
    gameTab.TextSize = 12
    gameButtons[gameName] = gameTab
    
    gameTab.MouseButton1Click:Connect(function()
        showGameScripts(gameName)
    end)
end

-- Tab Functionality
local currentTab = "Home"
local gamesExpanded = false

homeTab.MouseButton1Click:Connect(function()
    currentTab = "Home"
    showHome()
end)

universalTab.MouseButton1Click:Connect(function()
    currentTab = "Universal"
    showScripts(UniversalScripts)
end)

feTab.MouseButton1Click:Connect(function()
    currentTab = "FE"
    showScripts(FEScripts)
end)

gamesTab.MouseButton1Click:Connect(function()
    gamesExpanded = not gamesExpanded
    for _, gameBtn in pairs(gameButtons) do
        gameBtn.Visible = gamesExpanded
    end
    sidebarScroll.CanvasSize = UDim2.new(0, 0, 0, gamesExpanded and 800 or 400)
end)

visualTab.MouseButton1Click:Connect(function()
    currentTab = "Visual"
    contentScroll:ClearAllChildren()
    contentLayout.Parent = contentScroll
    contentPadding.Parent = contentScroll
    
    for categoryName, scripts in pairs(VisualScripts) do
        local categoryLabel = Instance.new("TextLabel")
        categoryLabel.Parent = contentScroll
        categoryLabel.Size = UDim2.new(1, 0, 0, 30)
        categoryLabel.BackgroundTransparency = 1
        categoryLabel.Text = categoryName
        categoryLabel.TextColor3 = theme.Accent
        categoryLabel.Font = Enum.Font.GothamBold
        categoryLabel.TextSize = 18
        categoryLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        for _, scriptInfo in pairs(scripts) do
            createScriptItem(scriptInfo)
        end
    end
    
    contentScroll.CanvasSize = UDim2.new(0, 0, 0, 200)
end)

-- Initialize
showHome()
notify("✨ Flix Hub v3.0 loaded successfully!", theme.Success)

print("✨ Flix Hub v3.0 - Modern Script Hub loaded successfully!")
