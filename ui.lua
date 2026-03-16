-- Simple UI Library for Delta Donate
local Library = {}
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")

function Library:CreateWindow(config)
    -- Create ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "DeltaDonateUI"
    gui.Parent = players.LocalPlayer:WaitForChild("PlayerGui")
    
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
    
    -- Container for tabs/content
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 1, -70)
    container.Position = UDim2.new(0, 10, 0, 50)
    container.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    container.BorderSizePixel = 1
    container.BorderColor3 = Color3.new(1, 0.5, 0)
    container.Parent = frame
    
    local window = {
        _gui = gui,
        _frame = frame,
        _container = container,
        _tabs = {}
    }
    
    function window:CreateTab(name)
        local tab = {_buttons = {}, _labels = {}}
        
        -- Tab button
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 80, 0, 25)
        tabButton.Position = UDim2.new(0, (#window._tabs * 85) + 10, 0, 0)
        tabButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        tabButton.Text = name
        tabButton.TextColor3 = Color3.new(1, 1, 1)
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 14
        tabButton.Parent = container
        
        -- Content frame for this tab
        local content = Instance.new("ScrollingFrame")
        content.Size = UDim2.new(1, -10, 1, -35)
        content.Position = UDim2.new(0, 5, 0, 30)
        content.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        content.BorderSizePixel = 0
        content.ScrollBarThickness = 8
        content.CanvasSize = UDim2.new(0, 0, 0, 0)
        content.Visible = (#window._tabs == 0)
        content.Parent = container
        
        tab._content = content
        
        -- Tab switching
        tabButton.MouseButton1Click:Connect(function()
            for _, otherTab in ipairs(window._tabs) do
                otherTab._content.Visible = false
            end
            content.Visible = true
        end)
        
        table.insert(window._tabs, tab)
        
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
            
            table.insert(tab._buttons, btn)
            content.CanvasSize = UDim2.new(0, 0, 0, y + 40)
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
        
        return tab
    end
    
    function window:OnClose(callback)
        -- Implementation for close handling
        userInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Delete then
                self._gui:Destroy()
                callback()
            end
        end)
    end
    
    return window
end

return Library
