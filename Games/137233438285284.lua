local F = _G.FlixHub
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local TOGGLES = F.GAME_TOGGLES

-- chicken farm

local plr = game:GetService("Players").LocalPlayer

_G._BR_FARMING = false

local cashval = plr.PlayerGui.Main.Currencies.Cash.List.Amount

local mainEvent = game:GetService("ReplicatedStorage").Paper.Remotes.__remoteevent
local mainFunction = game:GetService("ReplicatedStorage").Paper.Remotes.__remotefunction
local buyBtns = workspace.Plots[plr.Name].Buttons.BuyChickens

local addedCon

local suffixes = {
    "K","M","B","T","Qd","Qn","Sx","Sp","Oc","No","De",
    "UDe","DDe","TDe","QdDe","QnDe","SxDe","SpDe","OcDe","NoDe","Vt",
    "UVt","DVt","TVt","QdVt","QnVt","SxVt","SpVt","OcVt","NoVt","Tg",
    "UTg","DTg","TTg","QdTg","QnTg","SxTg","SpTg","OcTg","NoTg","qg",
    "Uqg","Dqg","Tqg","Qdqg","Qnqg","Sxqg","Spqg","Ocqg","Noqg","Qg",
    "UQg","DQg","TQg","QdQg","QnQg","SxQg","SpQg","OcQg","NoQg","sg",
    "Usg","Dsg","Tsg","Qdsg","Qnsg","Sxsg","Spsg","Ocsg","Nosg","Sg",
    "USg","DSg","TSg","QdSg","QnSg","SxSg","SpSg","OcSg","NoSg","Og",
    "UOg","DOg","TOg","QdOg","QnOg","SxOg","SpOg","OcOg","NoOg","Ng",
    "UNg","DNg","TNg","QdNg","QnNg","SxNg","SpNg","OcNg","NoNg","Ce","UCe"
}

local suffixValue = {}
for i, suf in ipairs(suffixes) do
    suffixValue[suf] = 1000 ^ i
end

local function parseSuffixedNumber(str)
    str = str:gsub("[%$,%s]", "")
    local numberPart, suffixPart = str:match("^(-?%d*%.?%d+)(%a*)$")
    local base = tonumber(numberPart)
    if suffixPart == "" then return base end
    local multiplier = suffixValue[suffixPart]
    return base * multiplier
end

TOGGLES[137233438285284] = {
    {label="Autofarm", callback=function(on)
        _G._BR_FARMING = on

        if not _G._BR_FARMING then addedCon:Disconnect() return end

        for i, v in pairs(workspace.Eggs:GetChildren()) do
            mainEvent:FireServer("Collect Egg", v.Name)
            task.wait()
            v:Destroy()
        end

        task.wait()

        mainFunction:InvokeServer("Deposit Eggs")

        addedCon = workspace.Eggs.ChildAdded:Connect(function(c)
            task.wait(1)
            mainEvent:FireServer("Collect Egg", c.Name)
            task.wait()
            c:Destroy()
            mainFunction:InvokeServer("Deposit Eggs")
        end)

        while _G._BR_FARMING do
            mainFunction:InvokeServer("Collect Cash")
            task.wait()
            mainFunction:InvokeServer("Upgrade Process Level")
            task.wait()
            local tobuy = 0
            local result = parseSuffixedNumber(cashval.Text)
            if parseSuffixedNumber(buyBtns.Buy100.Button.UI.Cost.Text) <= result then
                tobuy = 100
            elseif parseSuffixedNumber(buyBtns.Buy25.Button.UI.Cost.Text) <= result then
                tobuy = 25
            elseif parseSuffixedNumber(buyBtns.Buy5.Button.UI.Cost.Text) <= result then
                tobuy = 5
            elseif parseSuffixedNumber(buyBtns.Buy1.Button.UI.Cost.Text) <= result then
                tobuy = 1
            end
            mainFunction:InvokeServer("Buy Chickens", tobuy)
            task.wait()
            mainFunction:InvokeServer("Merge Chickens")
            task.wait(1)
        end
    end, cleanup=function() _G._BR_FARMING = false end}
}

print("[FlixHub] Game 137233438285284 toggles loaded")
if _G.FlixHub and _G.FlixHub.buildGameToggles then
	_G.FlixHub.buildGameToggles()
end

if _G.FlixHub and _G.FlixHub.buildGamesList then
	_G.FlixHub.buildGamesList("")
end