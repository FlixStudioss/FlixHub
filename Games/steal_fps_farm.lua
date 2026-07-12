-- ================================================================
--   STEAL FPS FROM OTHERS  |  Auto Farm  |  v3
--   Safe: uses Humanoid:MoveTo + tool:Activate(), no physics hacks
-- ================================================================
if _G.EH_FPS then _G.EH_FPS:Disconnect(); _G.EH_FPS = nil end
if _G.EH_FPS_GUI then _G.EH_FPS_GUI:Destroy(); _G.EH_FPS_GUI = nil end
if _G.EH_FPS_LOOP then _G.EH_FPS_LOOP = false end
task.wait(0.5)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer

local C = {
    BG       = Color3.fromRGB(14, 14, 24),
    PANEL    = Color3.fromRGB(22, 22, 38),
    ACCENT   = Color3.fromRGB(80, 130, 255),
    GREEN    = Color3.fromRGB(72, 199, 116),
    YELLOW   = Color3.fromRGB(255, 200, 50),
    RED      = Color3.fromRGB(255, 70, 70),
    WHITE    = Color3.new(1, 1, 1),
    DIM      = Color3.fromRGB(140, 140, 175),
}

local State = {
    Enabled = false,
    AutoSwing = true,
    AutoCollect = true,
    Status = "Starting...",
    StartFps = 0,
    StartKills = 0,
    Swings = 0,
    Kills = 0,
    AttackCount = 0,
}

local function getMyFps()
    local ls = LP:FindFirstChild("leaderstats")
    return ls and ls:FindFirstChild("Fps") and ls.Fps.Value or 0
end

local function getMyKills()
    local ls = LP:FindFirstChild("leaderstats")
    return ls and ls:FindFirstChild("Kills") and ls.Kills.Value or 0
end

local function getHRP()
    local ch = LP.Character
    return ch and ch:FindFirstChild("HumanoidRootPart")
end

local function getHumanoid()
    local ch = LP.Character
    return ch and ch:FindFirstChildOfClass("Humanoid")
end

local function getTool()
    local ch = LP.Character
    return ch and ch:FindFirstChildOfClass("Tool")
end

local function ensureSwordEquipped()
    local ch = LP.Character
    if not ch then return false end
    local hum = ch:FindFirstChildOfClass("Humanoid")
    if not hum then return false end

    if ch:FindFirstChildOfClass("Tool") then return true end

    local bp = LP:FindFirstChild("Backpack")
    if bp then
        for _, t in pairs(bp:GetChildren()) do
            if t:IsA("Tool") then
                hum:EquipTool(t)
                task.wait(0.3)
                return ch:FindFirstChildOfClass("Tool") ~= nil
            end
        end
    end
    return false
end

local function findTarget()
    local myHRP = getHRP()
    if not myHRP then return nil, math.huge end

    local bestTarget = nil
    local bestDist = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LP and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local dist = (hrp.Position - myHRP.Position).Magnitude
                if dist < bestDist then
                    bestDist = dist
                    bestTarget = player
                end
            end
        end
    end

    return bestTarget, bestDist
end

local function findNearestPowerup()
    local myHRP = getHRP()
    if not myHRP then return nil end

    local best = nil
    local bestDist = 50

    for _, folder in pairs({workspace:FindFirstChild("PowerUps"), workspace:FindFirstChild("Boosts")}) do
        if folder then
            for _, obj in pairs(folder:GetChildren()) do
                local part = obj:IsA("BasePart") and obj or obj.PrimaryPart
                if part then
                    local dist = (part.Position - myHRP.Position).Magnitude
                    if dist < bestDist then
                        bestDist = dist
                        best = part
                    end
                end
            end
        end
    end

    return best
end

local function dismissPopups()
    pcall(function()
        for _, gui in pairs(LP.PlayerGui:GetChildren()) do
            if gui.Name == "FPSStore" or gui.Name == "ConfirmItemUse" then
                gui.Enabled = false
            end
            local close = gui:FindFirstChild("Close")
            if close and close:IsA("TextButton") then
                pcall(function() close.MouseButton1Click:Fire() end)
            end
            local xBtn = gui:FindFirstChild("X")
            if xBtn and xBtn:IsA("TextButton") then
                pcall(function() xBtn.MouseButton1Click:Fire() end)
            end
        end
    end)
end

local function swingSword()
    local tool = getTool()
    if not tool then return end
    pcall(function() tool:Activate() end)
    State.Swings = State.Swings + 1
    State.AttackCount = State.AttackCount + 1
end

-- Anti-AFK
pcall(function()
    local VirtualUser = game:GetService("VirtualUser")
    LP.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

-- Auto-close popups periodically
task.spawn(function()
    while true do
        task.wait(2)
        pcall(dismissPopups)
    end
end)

-- ══ UI ══════════════════════════════════════════════════════════
local sg = Instance.new("ScreenGui")
sg.Name = "EH_FpsGUI"; sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.IgnoreGuiInset = true; sg.Parent = game.CoreGui
_G.EH_FPS_GUI = sg

local W, H = 280, 380
local main = Instance.new("Frame", sg)
main.Name = "Main"; main.Size = UDim2.new(0, W, 0, H)
main.Position = UDim2.new(0, 30, 0, 80)
main.BackgroundColor3 = C.BG; main.BorderSizePixel = 0
main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = C.ACCENT; mainStroke.Thickness = 1.5

local tb = Instance.new("Frame", main)
tb.Name = "TitleBar"; tb.Size = UDim2.new(1, 0, 0, 36)
tb.BackgroundColor3 = C.ACCENT; tb.BorderSizePixel = 0
Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 14)
local tbFill = Instance.new("Frame", tb)
tbFill.Size = UDim2.new(1, 0, 0.5, 0); tbFill.Position = UDim2.new(0, 0, 0.5, 0)
tbFill.BackgroundColor3 = C.ACCENT; tbFill.BorderSizePixel = 0

local titleLbl = Instance.new("TextLabel", tb)
titleLbl.Size = UDim2.new(1, -40, 1, 0); titleLbl.Position = UDim2.new(0, 12, 0, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "FPS Auto Farm v3"
titleLbl.TextColor3 = C.WHITE; titleLbl.Font = Enum.Font.GothamBold
titleLbl.TextSize = 14; titleLbl.TextXAlignment = Enum.TextXAlignment.Left

local xBtn = Instance.new("TextButton", tb)
xBtn.Size = UDim2.new(0, 24, 0, 24); xBtn.Position = UDim2.new(1, -30, 0, 6)
xBtn.BackgroundColor3 = C.RED
xBtn.Text = "X"; xBtn.TextColor3 = C.WHITE
xBtn.Font = Enum.Font.GothamBold; xBtn.TextSize = 12; xBtn.BorderSizePixel = 0
Instance.new("UICorner", xBtn).CornerRadius = UDim.new(0, 6)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -16, 1, -46); content.Position = UDim2.new(0, 8, 0, 42)
content.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0, 5); layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function mkToggle(parent, text, order, initOn, callback)
    local state = initOn
    local row = Instance.new("Frame", parent)
    row.LayoutOrder = order; row.Size = UDim2.new(1, 0, 0, 32)
    row.BackgroundColor3 = C.PANEL; row.BorderSizePixel = 0
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
    local lb = Instance.new("TextLabel", row)
    lb.Size = UDim2.new(1, -60, 1, 0); lb.Position = UDim2.new(0, 10, 0, 0)
    lb.BackgroundTransparency = 1; lb.Text = text
    lb.TextColor3 = C.WHITE; lb.Font = Enum.Font.Gotham; lb.TextSize = 11
    lb.TextXAlignment = Enum.TextXAlignment.Left
    local pill = Instance.new("Frame", row)
    pill.Size = UDim2.new(0, 38, 0, 18); pill.Position = UDim2.new(1, -46, 0.5, -9)
    pill.BackgroundColor3 = state and C.GREEN or Color3.fromRGB(50, 50, 72)
    pill.BorderSizePixel = 0
    Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)
    local knob = Instance.new("Frame", pill)
    knob.Size = UDim2.new(0, 12, 0, 12)
    knob.Position = state and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
    knob.BackgroundColor3 = C.WHITE; knob.BorderSizePixel = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    local hit = Instance.new("TextButton", row)
    hit.Size = UDim2.new(1, 0, 1, 0); hit.BackgroundTransparency = 1; hit.Text = ""
    local function setVal(v)
        state = v
        TweenService:Create(pill, TweenInfo.new(0.15), {BackgroundColor3 = state and C.GREEN or Color3.fromRGB(50, 50, 72)}):Play()
        TweenService:Create(knob, TweenInfo.new(0.15), {Position = state and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)}):Play()
        if callback then callback(state) end
    end
    hit.MouseButton1Click:Connect(function() setVal(not state) end)
    return {get = function() return state end, set = setVal}
end

local function mkLabel(parent, text, order, color)
    local lbl = Instance.new("TextLabel", parent)
    lbl.LayoutOrder = order; lbl.Size = UDim2.new(1, 0, 0, 18)
    lbl.BackgroundTransparency = 1; lbl.Text = text
    lbl.TextColor3 = color or C.DIM; lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 10; lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

local function mkStatRow(parent, label, order)
    local row = Instance.new("Frame", parent)
    row.LayoutOrder = order; row.Size = UDim2.new(1, 0, 0, 22)
    row.BackgroundColor3 = C.PANEL; row.BorderSizePixel = 0
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.5, -6, 1, 0); lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1; lbl.Text = label
    lbl.TextColor3 = C.DIM; lbl.Font = Enum.Font.Gotham; lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    local val = Instance.new("TextLabel", row)
    val.Size = UDim2.new(0.5, -6, 1, 0); val.Position = UDim2.new(0.5, 0, 0, 0)
    val.BackgroundTransparency = 1; val.Text = "0"
    val.TextColor3 = C.WHITE; val.Font = Enum.Font.GothamBold; val.TextSize = 10
    val.TextXAlignment = Enum.TextXAlignment.Right
    return {valueLabel = val}
end

local function mkButton(parent, text, order, color, callback)
    local btn = Instance.new("TextButton", parent)
    btn.LayoutOrder = order; btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = color or C.ACCENT; btn.Text = text
    btn.TextColor3 = C.WHITE; btn.Font = Enum.Font.GothamBold; btn.TextSize = 11
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() if callback then callback() end end)
    return btn
end

mkLabel(content, "  CONTROLS", 1)
local tAuto
local tSwing = mkToggle(content, "Auto Swing", 3, true, function(v) State.AutoSwing = v end)
local tCollect = mkToggle(content, "Collect Orbs", 4, true, function(v) State.AutoCollect = v end)

mkLabel(content, "  STATS", 5)
local statStatus = mkStatRow(content, "Status:", 6)
local statFps = mkStatRow(content, "FPS Stolen:", 7)
local statKills = mkStatRow(content, "Kills Gained:", 8)
local statSwings = mkStatRow(content, "Swings:", 9)
local statAtk = mkStatRow(content, "Attacks:", 10)

mkLabel(content, "  ACTIONS", 11)
mkButton(content, "Equip Sword", 11.5, C.ACCENT, function()
    ensureSwordEquipped()
    State.Status = "Sword equipped!"
end)
mkButton(content, "Reset Character", 12, C.YELLOW, function()
    local hum = getHumanoid()
    if hum then hum.Health = 0 end
end)

tAuto = mkToggle(content, "Auto Farm", 2, false, function(v)
    State.Enabled = v
    if v then
        State.StartFps = getMyFps()
        State.StartKills = getMyKills()
        State.Swings = 0
        State.AttackCount = 0
        _G.EH_FPS_LOOP = true
        task.spawn(function() autoLoop() end)
    else
        _G.EH_FPS_LOOP = false
        State.Status = "Stopped"
        local hum = getHumanoid()
        if hum then
            local hrp = hum.RootPart
            if hrp then hum:MoveTo(hrp.Position) end
        end
    end
end)

xBtn.MouseButton1Click:Connect(function()
    State.Enabled = false
    _G.EH_FPS_LOOP = false
    sg:Destroy()
    _G.EH_FPS_GUI = nil
end)

-- ══ Auto Loop ══════════════════════════════════════════════════
function autoLoop()
    while _G.EH_FPS_LOOP and State.Enabled do
        pcall(dismissPopups)

        local char = LP.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")

        if not hum or not hrp or hum.Health <= 0 then
            State.Status = "Waiting for respawn..."
            task.wait(2)
            continue
        end

        if not char:FindFirstChildOfClass("Tool") then
            State.Status = "Equipping sword..."
            ensureSwordEquipped()
            task.wait(0.3)
            continue
        end

        if State.AutoCollect then
            local orb = findNearestPowerup()
            if orb then
                State.Status = "Collecting orb..."
                hum:MoveTo(orb.Position)
                task.wait(0.8)
                if State.AutoSwing then swingSword() end
                continue
            end
        end

        local target, dist = findTarget()
        if target and target.Character and dist < 80 then
            local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                hum:MoveTo(targetHRP.Position)

                if dist < 12 then
                    State.Status = "Attacking " .. target.Name .. "!"
                    swingSword()
                    task.wait(0.25)
                else
                    State.Status = "Chasing " .. target.Name .. " (" .. math.floor(dist) .. "m)"
                    task.wait(0.3)
                end
            else
                task.wait(0.3)
            end
        else
            State.Status = "Wandering... (" .. tostring(getMyFps()) .. " FPS)"
            local wanderX = hrp.Position.X + (math.random() - 0.5) * 30
            local wanderZ = hrp.Position.Z + (math.random() - 0.5) * 30
            wanderX = math.clamp(wanderX, -60, 60)
            wanderZ = math.clamp(wanderZ, -60, 60)
            hum:MoveTo(Vector3.new(wanderX, 3, wanderZ))
            if State.AutoSwing then swingSword() end
            task.wait(1 + math.random() * 0.5)
        end
    end

    State.Status = "Stopped"
end

-- ══ Update UI ══════════════════════════════════════════════════
_G.EH_FPS = RunService.Heartbeat:Connect(function()
    if statStatus and statStatus.valueLabel then
        statStatus.valueLabel.Text = State.Status
    end
    if statFps and statFps.valueLabel then
        local stolen = getMyFps() - State.StartFps
        statFps.valueLabel.Text = tostring(math.max(0, stolen))
    end
    if statKills and statKills.valueLabel then
        local kills = getMyKills() - State.StartKills
        statKills.valueLabel.Text = tostring(math.max(0, kills))
    end
    if statSwings and statSwings.valueLabel then
        statSwings.valueLabel.Text = tostring(State.Swings)
    end
    if statAtk and statAtk.valueLabel then
        statAtk.valueLabel.Text = tostring(State.AttackCount)
    end
end)

-- Auto-start after a brief delay
task.delay(1, function()
    tAuto.set(true)
end)

print("[Steal FPS Auto Farm v3] Loaded - starting in 1s...")
