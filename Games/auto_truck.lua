-- ================================================================
--   EMERGENCY HAMBURG  |  Auto Truck Job  |  v1
-- ================================================================
if _G.EH_TRUCK then _G.EH_TRUCK:Disconnect(); _G.EH_TRUCK = nil end
if _G.EH_TRUCK_GUI then _G.EH_TRUCK_GUI:Destroy(); _G.EH_TRUCK_GUI = nil end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer

-- ══ Safe networking access ══════════════════════════════════════
local RuntimeLib = require(RS:WaitForChild("Code"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local networking = require(RS.Code.modules.networking)
local ClientEvents = networking.ClientEvents
local ClientFunctions = networking.ClientFunctions

-- ══ Safe producer access ════════════════════════════════════════
local producer = require(LP.PlayerScripts.Code.producer).producer

-- ══ Colors ══════════════════════════════════════════════════════
local C = {
    BG       = Color3.fromRGB(12, 12, 22),
    PANEL    = Color3.fromRGB(20, 20, 36),
    ACCENT   = Color3.fromRGB(80, 120, 255),
    GREEN    = Color3.fromRGB(72, 199, 116),
    YELLOW   = Color3.fromRGB(255, 200, 50),
    RED      = Color3.fromRGB(255, 70, 70),
    WHITE    = Color3.new(1, 1, 1),
    DIM      = Color3.fromRGB(140, 140, 175),
    TAB_ACT  = Color3.fromRGB(80, 120, 255),
    TAB_INACT= Color3.fromRGB(30, 30, 50),
}

-- ══ State ═══════════════════════════════════════════════════════
local State = {
    AutoMode = false,
    InShift = false,
    DeliveryCount = 0,
    Status = "Idle",
    Running = false,
    TruckCompanyPos = Vector3.new(713, 12, 1441),
}

-- ══ Helpers ═════════════════════════════════════════════════════
local function getHRP()
    local ch = LP.Character
    return ch and ch:FindFirstChild("HumanoidRootPart")
end

local function teleportTo(pos)
    local hrp = getHRP()
    if not hrp then return false end
    hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
    return true
end

-- ══ UI ══════════════════════════════════════════════════════════
local sg = Instance.new("ScreenGui")
sg.Name = "EH_TruckGUI"; sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.IgnoreGuiInset = true; sg.Parent = game.CoreGui
_G.EH_TRUCK_GUI = sg

local W, H = 300, 420
local main = Instance.new("Frame", sg)
main.Name = "Main"; main.Size = UDim2.new(0, W, 0, H)
main.Position = UDim2.new(0, 30, 0, 80)
main.BackgroundColor3 = C.BG; main.BorderSizePixel = 0
main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = C.ACCENT; mainStroke.Thickness = 1.5

-- Title bar
local tb = Instance.new("Frame", main)
tb.Name = "TitleBar"; tb.Size = UDim2.new(1, 0, 0, 40)
tb.BackgroundColor3 = C.ACCENT; tb.BorderSizePixel = 0
Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 14)
local tbFill = Instance.new("Frame", tb)
tbFill.Size = UDim2.new(1, 0, 0.5, 0); tbFill.Position = UDim2.new(0, 0, 0.5, 0)
tbFill.BackgroundColor3 = C.ACCENT; tbFill.BorderSizePixel = 0

local titleLbl = Instance.new("TextLabel", tb)
titleLbl.Size = UDim2.new(1, -46, 1, 0); titleLbl.Position = UDim2.new(0, 12, 0, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "Truck Auto Job"
titleLbl.TextColor3 = C.WHITE; titleLbl.Font = Enum.Font.GothamBold
titleLbl.TextSize = 14; titleLbl.TextXAlignment = Enum.TextXAlignment.Left

local xBtn = Instance.new("TextButton", tb)
xBtn.Size = UDim2.new(0, 26, 0, 26); xBtn.Position = UDim2.new(1, -32, 0, 7)
xBtn.BackgroundColor3 = Color3.fromRGB(210, 50, 50)
xBtn.Text = "X"; xBtn.TextColor3 = C.WHITE
xBtn.Font = Enum.Font.GothamBold; xBtn.TextSize = 13; xBtn.BorderSizePixel = 0
Instance.new("UICorner", xBtn).CornerRadius = UDim.new(0, 6)

-- Tab bar
local tabBar = Instance.new("Frame", main)
tabBar.Size = UDim2.new(1, -16, 0, 32); tabBar.Position = UDim2.new(0, 8, 0, 44)
tabBar.BackgroundColor3 = C.PANEL; tabBar.BorderSizePixel = 0
Instance.new("UICorner", tabBar).CornerRadius = UDim.new(0, 8)
local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
tabLayout.Padding = UDim.new(0, 2)
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
Instance.new("UIPadding", tabBar).PaddingLeft = UDim.new(0, 4)

local contentFrame = Instance.new("Frame", main)
contentFrame.Size = UDim2.new(1, -16, 1, -90); contentFrame.Position = UDim2.new(0, 8, 0, 82)
contentFrame.BackgroundTransparency = 1

local tabPages = {}
local activeTab = nil

local function makeTab(name, icon)
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(0, 100, 0, 26); btn.BackgroundColor3 = C.TAB_INACT
    btn.Text = icon .. " " .. name; btn.TextColor3 = C.DIM
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 11; btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local page = Instance.new("ScrollingFrame", contentFrame)
    page.Name = "Page_" .. name
    page.Size = UDim2.new(1, 0, 1, 0); page.Position = UDim2.new(0, 0, 0, 0)
    page.BackgroundTransparency = 1; page.ScrollBarThickness = 3
    page.CanvasSize = UDim2.new(0, 0, 0, 0); page.Visible = false
    page.ScrollBarImageColor3 = C.ACCENT; page.BorderSizePixel = 0
    local pl = Instance.new("UIListLayout", page)
    pl.Padding = UDim.new(0, 6); pl.SortOrder = Enum.SortOrder.LayoutOrder
    pl.HorizontalAlignment = Enum.HorizontalAlignment.Center
    local t = { btn = btn, page = page, layout = pl }
    table.insert(tabPages, t)
    btn.MouseButton1Click:Connect(function()
        for _, tp in ipairs(tabPages) do
            tp.page.Visible = false
            TweenService:Create(tp.btn, TweenInfo.new(0.15), { BackgroundColor3 = C.TAB_INACT, TextColor3 = C.DIM }):Play()
        end
        page.Visible = true
        TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = C.TAB_ACT, TextColor3 = C.WHITE }):Play()
        activeTab = name
    end)
    return t
end

local mainTab = makeTab("Auto", "Auto")
local infoTab = makeTab("Info", "Info")
mainTab.page.Visible = true
TweenService:Create(mainTab.btn, TweenInfo.new(0.15), { BackgroundColor3 = C.TAB_ACT, TextColor3 = C.WHITE }):Play()
activeTab = "Auto"

-- ══ UI Builders ═════════════════════════════════════════════════
local function mkSectionLabel(parent, text, order)
    local lbl = Instance.new("TextLabel", parent)
    lbl.LayoutOrder = order or 0
    lbl.Size = UDim2.new(1, 0, 0, 18); lbl.BackgroundTransparency = 1
    lbl.Text = text; lbl.TextColor3 = C.DIM
    lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

local function mkToggle(parent, icon, labelText, onCol, initOn, order, callback)
    local state = initOn
    local row = Instance.new("Frame", parent)
    row.LayoutOrder = order or 0
    row.Size = UDim2.new(1, 0, 0, 40); row.BackgroundColor3 = C.PANEL
    row.BorderSizePixel = 0
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
    local ic = Instance.new("TextLabel", row)
    ic.Size = UDim2.new(0, 28, 1, 0); ic.Position = UDim2.new(0, 8, 0, 0)
    ic.BackgroundTransparency = 1; ic.Text = icon
    ic.TextSize = 18; ic.Font = Enum.Font.GothamBold
    local lb = Instance.new("TextLabel", row)
    lb.Size = UDim2.new(1, -90, 1, 0); lb.Position = UDim2.new(0, 38, 0, 0)
    lb.BackgroundTransparency = 1; lb.Text = labelText
    lb.TextColor3 = C.WHITE; lb.Font = Enum.Font.Gotham
    lb.TextSize = 12; lb.TextXAlignment = Enum.TextXAlignment.Left
    local pill = Instance.new("Frame", row)
    pill.Size = UDim2.new(0, 42, 0, 20); pill.Position = UDim2.new(1, -50, 0.5, -10)
    pill.BackgroundColor3 = state and onCol or Color3.fromRGB(50, 50, 72)
    pill.BorderSizePixel = 0
    Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)
    local knob = Instance.new("Frame", pill)
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    knob.BackgroundColor3 = C.WHITE; knob.BorderSizePixel = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    local hit = Instance.new("TextButton", row)
    hit.Size = UDim2.new(1, 0, 1, 0); hit.BackgroundTransparency = 1; hit.Text = ""
    local function set(on)
        state = on
        TweenService:Create(pill, TweenInfo.new(0.18), { BackgroundColor3 = on and onCol or Color3.fromRGB(50, 50, 72) }):Play()
        TweenService:Create(knob, TweenInfo.new(0.18), { Position = on and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7) }):Play()
        if callback then callback(on) end
    end
    hit.MouseButton1Click:Connect(function() set(not state) end)
    return { get = function() return state end, set = set, row = row }
end

local function mkButton(parent, text, order, color, callback)
    local btn = Instance.new("TextButton", parent)
    btn.LayoutOrder = order or 0
    btn.Size = UDim2.new(1, 0, 0, 36); btn.BackgroundColor3 = color or C.ACCENT
    btn.Text = text; btn.TextColor3 = C.WHITE
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 12; btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(function() if callback then callback() end end)
    return btn
end

local function mkStatus(parent, order)
    local fr = Instance.new("Frame", parent)
    fr.LayoutOrder = order or 0; fr.Size = UDim2.new(1, 0, 0, 50)
    fr.BackgroundColor3 = C.PANEL; fr.BorderSizePixel = 0
    Instance.new("UICorner", fr).CornerRadius = UDim.new(0, 8)
    local lbl = Instance.new("TextLabel", fr)
    lbl.Size = UDim2.new(1, -12, 1, 0); lbl.Position = UDim2.new(0, 6, 0, 0)
    lbl.BackgroundTransparency = 1; lbl.TextColor3 = C.DIM
    lbl.Font = Enum.Font.Gotham; lbl.TextSize = 11
    lbl.TextWrapped = true; lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = "Status: Idle"
    return { frame = fr, label = lbl }
end

local function mkStatRow(parent, label, valueText, order)
    local row = Instance.new("Frame", parent)
    row.LayoutOrder = order or 0; row.Size = UDim2.new(1, 0, 0, 28)
    row.BackgroundColor3 = C.PANEL; row.BorderSizePixel = 0
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.5, -8, 1, 0); lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1; lbl.Text = label
    lbl.TextColor3 = C.DIM; lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 11; lbl.TextXAlignment = Enum.TextXAlignment.Left
    local val = Instance.new("TextLabel", row)
    val.Size = UDim2.new(0.5, -8, 1, 0); val.Position = UDim2.new(0.5, 0, 0, 0)
    val.BackgroundTransparency = 1; val.Text = valueText or "0"
    val.TextColor3 = C.WHITE; val.Font = Enum.Font.GothamBold
    val.TextSize = 11; val.TextXAlignment = Enum.TextXAlignment.Right
    return { row = row, valueLabel = val }
end

-- ══ AUTO TAB ════════════════════════════════════════════════════
local aPage = mainTab.page
mkSectionLabel(aPage, "  CONTROLS", 1)

local statusUI = mkStatus(aPage, 5)

local tAuto = mkToggle(aPage, "Auto", "Full Auto Truck Job", C.GREEN, false, 2, function(val)
    State.AutoMode = val
    if val then
        State.Running = true
        task.spawn(function() autoLoop() end)
    else
        State.Running = false
        State.Status = "Stopped"
    end
end)

mkSectionLabel(aPage, "  ACTIONS", 3)
local btnGoTo = mkButton(aPage, "Go to Truck Company", 4, C.ACCENT, function()
    task.spawn(function()
        State.Status = "Teleporting to Truck Company..."
        teleportTo(State.TruckCompanyPos)
        task.wait(0.5)
        State.Status = "At Truck Company"
    end)
end)

local btnStartShift = mkButton(aPage, "Start Shift", 6, C.GREEN, function()
    task.spawn(function()
        State.Status = "Starting shift..."
        pcall(function() ClientEvents.startShift:fire("TruckCompany") end)
        task.wait(2)
        State.InShift = true
        State.Status = "Shift started! Wait for delivery menu..."
    end)
end)

local btnEndShift = mkButton(aPage, "End Shift", 7, C.RED, function()
    task.spawn(function()
        State.Status = "Ending shift..."
        pcall(function() ClientEvents.endShift:fire() end)
        task.wait(1)
        State.InShift = false
        State.Status = "Shift ended"
    end)
end)

mkSectionLabel(aPage, "  STATS", 8)
local statDelivery = mkStatRow(aPage, "Deliveries:", "0", 9)
local statMoney = mkStatRow(aPage, "Truck XP:", "0", 10)

aPage.CanvasSize = UDim2.new(0, 0, 0, 400)

-- ══ INFO TAB ════════════════════════════════════════════════════
local iPage = infoTab.page
mkSectionLabel(iPage, "  HOW IT WORKS", 1)
local infoLines = {
    { "1. Teleports to Truck Company at harbor", C.DIM },
    { "2. Starts your shift via game events", C.DIM },
    { "3. Waits for delivery menu to appear", C.DIM },
    { "4. Clicks delivery using game's own API", C.DIM },
    { "5. Teleports to delivery destinations", C.DIM },
    { "6. Loops for continuous earnings", C.DIM },
    { "", C.DIM },
    { "REQUIREMENTS:", C.YELLOW },
    { "- Must own a truck from the Dealership", C.YELLOW },
    { "- Must be in the TruckCompany group/team", C.YELLOW },
    { "", C.DIM },
    { "SAFETY:", C.GREEN },
    { "- CFrame teleport only (no speed hacks)", C.GREEN },
    { "- No physics objects created", C.GREEN },
    { "- Uses game's own ClientEvents API", C.GREEN },
    { "- WalkSpeed/JumpHeight untouched", C.GREEN },
}
for i, info in ipairs(infoLines) do
    local lbl = Instance.new("TextLabel", iPage)
    lbl.LayoutOrder = i + 1
    lbl.Size = UDim2.new(1, -16, 0, 18); lbl.BackgroundTransparency = 1
    lbl.Text = "  " .. info[1]; lbl.TextColor3 = info[2]
    lbl.Font = Enum.Font.Gotham; lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end
iPage.CanvasSize = UDim2.new(0, 0, 0, 400)

-- ══ Close button ════════════════════════════════════════════════
xBtn.MouseButton1Click:Connect(function()
    State.AutoMode = false
    State.Running = false
    sg:Destroy()
    _G.EH_TRUCK_GUI = nil
end)

-- ══ Auto Loop (defined BEFORE the toggle references it) ════════
function autoLoop()
    while State.AutoMode and State.Running do
        -- Step 1: Go to Truck Company
        State.Status = "1/6: Teleporting to Truck Company..."
        teleportTo(State.TruckCompanyPos)
        task.wait(2)
        if not State.AutoMode then break end

        -- Step 2: Start Shift
        State.Status = "2/6: Starting shift..."
        pcall(function() ClientEvents.startShift:fire("TruckCompany") end)
        task.wait(3)
        State.InShift = true
        if not State.AutoMode then break end

        -- Step 3: Wait for delivery menu
        State.Status = "3/6: Waiting for delivery menu..."
        local menuFound = false
        local currentState = nil
        for waitAttempt = 1, 20 do
            if not State.AutoMode then break end
            local ok, st = pcall(function() return producer:getState() end)
            if ok and st.deliverySystem and st.deliverySystem.showDeliveries then
                local deliveries = st.deliverySystem.showDeliveries
                if deliveries and #deliveries > 0 then
                    menuFound = true
                    currentState = st
                    State.Status = "3/6: Found " .. #deliveries .. " deliveries!"
                    break
                end
            end
            task.wait(1)
        end
        if not menuFound then
            State.Status = "3/6: No deliveries found, restarting..."
            task.wait(3)
            continue
        end
        if not State.AutoMode then break end

        -- Step 4: Accept a delivery via game API
        State.Status = "4/6: Accepting delivery..."
        local accepted = false
        for _, delivery in ipairs(currentState.deliverySystem.showDeliveries) do
            if not State.AutoMode then break end
            local ok2, result = pcall(function()
                ClientFunctions.startDelivery:invoke(delivery.id)
                producer.hideDeliveryMenu()
                return true
            end)
            if ok2 and result ~= false then
                accepted = true
                State.DeliveryCount = State.DeliveryCount + 1
                State.Status = "4/6: Delivery accepted! (#" .. State.DeliveryCount .. ")"
                break
            end
        end
        if not accepted then
            State.Status = "4/6: Failed to accept delivery"
            task.wait(3)
            continue
        end
        if not State.AutoMode then break end

        -- Step 5: Wait for navigation/route to appear, then teleport along it
        State.Status = "5/6: Navigating to delivery..."
        task.wait(3)

        -- Check for navigation target and teleport there
        for navAttempt = 1, 10 do
            if not State.AutoMode then break end
            local ok3, navState = pcall(function() return producer:getState() end)
            if ok3 then
                -- Try to find current waypoint/target from navigation system
                local navSys = navState.navigationSystem
                if navSys and navSys.currentTarget then
                    local targetPos = navSys.currentTarget.Position
                    if targetPos then
                        teleportTo(targetPos)
                        State.Status = "5/6: Teleported to waypoint"
                    end
                end
            end
            task.wait(5)
        end

        if not State.AutoMode then break end

        -- Step 6: Wait for delivery completion
        State.Status = "6/6: Completing delivery..."
        task.wait(10)

        State.Status = "Delivery done! Next in 3s..."
        task.wait(3)
    end

    State.Status = "Stopped"
    State.Running = false
end

-- ══ Update status display ══════════════════════════════════════
_G.EH_TRUCK = RunService.Heartbeat:Connect(function()
    if statusUI and statusUI.label then
        statusUI.label.Text = "Status: " .. State.Status
    end
    if statDelivery and statDelivery.valueLabel then
        statDelivery.valueLabel.Text = tostring(State.DeliveryCount)
    end
    if statMoney and statMoney.valueLabel then
        pcall(function()
            local state = producer:getState()
            local xp = 0
            if state.playerData and state.playerData.xp then
                xp = state.playerData.xp.TruckCompany or 0
            end
            statMoney.valueLabel.Text = tostring(xp)
        end)
    end
end)

print("[Emergency Hamburg Auto Truck Job v1] Loaded")
