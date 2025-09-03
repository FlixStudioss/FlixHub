-- FlixHub Date Spoofer Script
-- Changes Roblox's date to September 7, 2025
-- Other scripts will see this spoofed date instead of the real date

local StarterGui = game:GetService("StarterGui")

-- Target date: September 7, 2025
local targetYear = 2025
local targetMonth = 9
local targetDay = 7
local targetHour = 12  -- Noon
local targetMinute = 0
local targetSecond = 0

-- Calculate the target timestamp (September 7, 2025 at 12:00:00)
local targetTimestamp = os.time({
    year = targetYear,
    month = targetMonth,
    day = targetDay,
    hour = targetHour,
    min = targetMinute,
    sec = targetSecond
})

-- Store original functions before hooking
local originalOsTime = os.time
local originalOsDate = os.date
local originalTick = tick

-- Hook os.time() to return our fake timestamp
local function spoofedOsTime(dateTable)
    if dateTable then
        -- If a date table is provided, use original function
        return originalOsTime(dateTable)
    else
        -- Return our spoofed timestamp
        return targetTimestamp
    end
end

-- Hook os.date() to return our fake date
local function spoofedOsDate(format, time)
    if time then
        -- If specific time is provided, use it with our spoofed base
        return originalOsDate(format, time)
    else
        -- Use our spoofed timestamp
        return originalOsDate(format, targetTimestamp)
    end
end

-- Hook tick() to return consistent spoofed time
local tickOffset = targetTimestamp - originalTick()
local function spoofedTick()
    return originalTick() + tickOffset
end

-- Apply the hooks
os.time = spoofedOsTime
os.date = spoofedOsDate
tick = spoofedTick

-- Also hook workspace.DistributedGameTime if it exists (some scripts use this)
pcall(function()
    local workspace = game:GetService("Workspace")
    if workspace.DistributedGameTime then
        -- Create a fake DistributedGameTime property
        local fakeGameTime = targetTimestamp - os.time({year=1970, month=1, day=1, hour=0, min=0, sec=0})
        
        -- Override the property getter
        local mt = getmetatable(workspace)
        if mt then
            local oldIndex = mt.__index
            mt.__index = function(self, key)
                if key == "DistributedGameTime" then
                    return fakeGameTime
                end
                return oldIndex(self, key)
            end
        end
    end
end)

-- Create a verification function to test if the spoofing works
local function testDateSpoof()
    local currentDate = os.date("*t")
    local currentTime = os.time()
    local currentTick = tick()
    
    print("=== Date Spoofer Test ===")
    print("Spoofed Date: " .. os.date("%B %d, %Y"))
    print("Spoofed Time: " .. os.date("%H:%M:%S"))
    print("Spoofed Timestamp: " .. currentTime)
    print("Spoofed Tick: " .. currentTick)
    print("Year: " .. currentDate.year)
    print("Month: " .. currentDate.month)
    print("Day: " .. currentDate.day)
    print("========================")
end

-- Notification to user
StarterGui:SetCore("SendNotification", {
    Title = "FlixHub Date Spoofer";
    Text = "Date changed to September 7, 2025! Other scripts will see this date.";
    Duration = 5;
})

-- Run test to show it's working
testDateSpoof()

-- Add a global function to reset date spoofing if needed
_G.resetDateSpoof = function()
    os.time = originalOsTime
    os.date = originalOsDate
    tick = originalTick
    
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub Date Spoofer";
        Text = "Date spoofing disabled! Real date restored.";
        Duration = 3;
    })
    
    print("Date spoofing reset - real date restored")
end

-- Add a global function to change the spoofed date
_G.changeSpoofedDate = function(year, month, day, hour, minute, second)
    hour = hour or 12
    minute = minute or 0
    second = second or 0
    
    local newTimestamp = os.time({
        year = year,
        month = month,
        day = day,
        hour = hour,
        min = minute,
        sec = second
    })
    
    targetTimestamp = newTimestamp
    tickOffset = targetTimestamp - originalTick()
    
    StarterGui:SetCore("SendNotification", {
        Title = "FlixHub Date Spoofer";
        Text = "Date changed to " .. originalOsDate("%B %d, %Y", newTimestamp);
        Duration = 3;
    })
    
    print("Date spoofed to: " .. originalOsDate("%B %d, %Y at %H:%M:%S", newTimestamp))
end

print("FlixHub Date Spoofer loaded successfully!")
print("Current spoofed date: September 7, 2025")
print("Use _G.resetDateSpoof() to disable spoofing")
print("Use _G.changeSpoofedDate(year, month, day) to change the spoofed date")
