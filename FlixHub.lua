-- FlixHub v3.0 - Modern Script Hub with Luna UI
-- Created by FlixHub Team
-- Features: Luna Interface, Categories, Keyless Scripts

-- Load Luna Interface Suite
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()

-- Create Luna Window
local Window = Luna:CreateWindow({
    Name = "FlixHub v3.0",
    Subtitle = "Modern Script Hub",
    LogoID = nil,
    LoadingEnabled = true,
    LoadingTitle = "FlixHub v3.0",
    LoadingSubtitle = "by FlixHub Team",
    
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "FlixHub"
    },
    
    KeySystem = false,
    KeySettings = {
        Title = "FlixHub Key System",
        Subtitle = "Access Required",
        Note = "FlixHub is keyless! No key required.",
        SaveKey = false,
        Key = {"no-key-required"}
    }
})

-- Create Home Tab
local HomeTab = Window:CreateHomeTab({
    SupportedExecutors = {"Synapse X", "Script-Ware", "Krnl", "Fluxus", "Delta", "Electron"},
    DiscordInvite = "flixhub",
    Icon = 1
})

-- Create Universal Tab
local UniversalTab = Window:CreateTab({
    Name = "Universal",
    Icon = "globe",
    ImageSource = "Lucide",
    ShowTitle = true
})

UniversalTab:CreateSection("Admin & Utility Scripts")

UniversalTab:CreateButton({
    Name = "Infinite Yield",
    Description = "Admin commands script with tons of features",
    Callback = function()
        Luna:Notification({
            Title = "FlixHub",
            Icon = "check",
            ImageSource = "Lucide",
            Content = "Executing Infinite Yield..."
        })
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

UniversalTab:CreateButton({
    Name = "Dark Dex V3",
    Description = "Advanced explorer for Roblox games",
    Callback = function()
        Luna:Notification({
            Title = "FlixHub",
            Icon = "check",
            ImageSource = "Lucide",
            Content = "Executing Dark Dex V3..."
        })
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
    end
})

UniversalTab:CreateButton({
    Name = "Simple Spy",
    Description = "Remote spy for debugging and scripting",
    Callback = function()
        Luna:Notification({
            Title = "FlixHub",
            Icon = "check",
            ImageSource = "Lucide",
            Content = "Executing Simple Spy..."
        })
        loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
    end
})

UniversalTab:CreateButton({
    Name = "Universal ESP",
    Description = "See players through walls",
    Callback = function()
        Luna:Notification({
            Title = "FlixHub",
            Icon = "check",
            ImageSource = "Lucide",
            Content = "Executing Universal ESP..."
        })
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua"))()
    end
})

UniversalTab:CreateButton({
    Name = "Chat Spammer",
    Description = "Spam chat with custom messages",
    Callback = function()
        Luna:Notification({
            Title = "FlixHub",
            Icon = "check",
            ImageSource = "Lucide",
            Content = "Executing Chat Spammer..."
        })
        loadstring(game:HttpGet("https://raw.githubusercontent.com/koonpeatch/PeatEX/master/SLPRM"))()
    end
})

-- Create Grow A Garden Tab
local GardenTab = Window:CreateTab({
    Name = "Grow A Garden",
    Icon = "flower-2",
    ImageSource = "Lucide",
    ShowTitle = true
})

GardenTab:CreateSection("Garden Scripts")

GardenTab:CreateButton({
    Name = "No Lag",
    Description = "Reduces lag and improves performance",
    Callback = function()
        Luna:Notification({
            Title = "FlixHub",
            Icon = "check",
            ImageSource = "Lucide",
            Content = "Executing No Lag..."
        })
        loadstring(game:HttpGet('https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Garden/Garden-V1.lua'))()
    end
})

GardenTab:CreateButton({
    Name = "eF Hub",
    Description = "Multi-purpose exploit hub",
    Callback = function()
        Luna:Notification({
            Title = "FlixHub",
            Icon = "check",
            ImageSource = "Lucide",
            Content = "Executing eF Hub..."
        })
        loadstring(game:HttpGet('https://api.exploitingis.fun/loader', true))()
    end
})

-- Create Poop Simulator Tab
local PoopTab = Window:CreateTab({
    Name = "Poop Simulator",
    Icon = "zap",
    ImageSource = "Lucide",
    ShowTitle = true
})

PoopTab:CreateSection("Automation Scripts")

PoopTab:CreateButton({
    Name = "AUTO Poop & AUTO Sell",
    Description = "Automatic pooping and selling features",
    Callback = function()
        Luna:Notification({
            Title = "FlixHub",
            Icon = "check",
            ImageSource = "Lucide",
            Content = "Executing Auto Poop & Sell..."
        })
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sylolua/mine/refs/heads/main/Poop",true))()
    end
})

-- Create Slippery Stairs Tab
local StairsTab = Window:CreateTab({
    Name = "Slippery Stairs",
    Icon = "trending-up",
    ImageSource = "Lucide",
    ShowTitle = true
})

StairsTab:CreateSection("Crystal Scripts")

StairsTab:CreateButton({
    Name = "INF CRYSTALS",
    Description = "Infinite crystals exploit",
    Callback = function()
        Luna:Notification({
            Title = "FlixHub",
            Icon = "check",
            ImageSource = "Lucide",
            Content = "Executing Infinite Crystals..."
        })
        loadstring(game:HttpGet("https://pastebin.com/raw/5ez3xPtJ"))()
    end
})

-- Create The Strongest Battleground Tab
local TSBTab = Window:CreateTab({
    Name = "TSB",
    Icon = "sword",
    ImageSource = "Lucide",
    ShowTitle = true
})

TSBTab:CreateSection("Battleground Scripts")

TSBTab:CreateButton({
    Name = "TSB Auto Farm",
    Description = "Auto farm script for The Strongest Battleground",
    Callback = function()
        Luna:Notification({
            Title = "FlixHub",
            Icon = "check",
            ImageSource = "Lucide",
            Content = "Executing TSB Auto Farm..."
        })
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Viunze/ZeCuree2/refs/heads/main/Zertex.lua"))()
    end
})

-- Luna UI creates and manages everything automatically!
-- No need for manual UI creation or event handling

-- Show success notification
Luna:Notification({
    Title = "FlixHub v3.0",
    Icon = "check-circle",
    ImageSource = "Lucide",
    Content = "Modern script hub loaded successfully! ✨"
})

print("FlixHub v2.0 loaded successfully!")
print("Created by FlixHub Team")
print("Features: Search, Categories, Keyless Scripts")