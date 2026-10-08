local p = game.Players.LocalPlayer
local pg = p:WaitForChild("PlayerGui")
if pg:FindFirstChild("VoidUI") then pg.VoidUI:Destroy() end

local sg = Instance.new("ScreenGui", pg) sg.Name = "VoidUI" sg.ResetOnSpawn = false
local f = Instance.new("Frame", sg) f.Size = UDim2.new(0, 250, 0, 400) f.Position = UDim2.new(0.5, -125, 0.5, -200) f.BackgroundColor3 = Color3.fromRGB(30, 30, 35) f.Active = true f.Draggable = true
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)

local l = Instance.new("UIListLayout", f) l.Padding = UDim.new(0, 6) l.SortOrder = Enum.SortOrder.LayoutOrder

local title = Instance.new("TextLabel", f)
title.Size = UDim2.new(1, 0, 0, 30) title.Text = "Void" title.TextColor3 = Color3.fromRGB(0, 255, 150) title.Font = Enum.Font.GothamBold title.TextSize = 18 title.BackgroundTransparency = 1 title.LayoutOrder = 1

local top = Instance.new("Frame", f) top.Size = UDim2.new(1, -10, 0, 25) top.BackgroundTransparency = 1 top.LayoutOrder = 2

local close = Instance.new("TextButton", top)
close.Size = UDim2.new(0, 25, 1, 0) close.Position = UDim2.new(1, -25, 0, 0) close.Text = "X" close.BackgroundColor3 = Color3.fromRGB(40, 40, 45) close.TextColor3 = Color3.fromRGB(255, 100, 100) close.Font = Enum.Font.GothamBold
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)
close.MouseButton1Click:Connect(function() sg:Destroy() end)

local langBtn = Instance.new("TextButton", top)
langBtn.Size = UDim2.new(0, 60, 1, 0) langBtn.Position = UDim2.new(1, -90, 0, 0) langBtn.Text = "EN" langBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45) langBtn.TextColor3 = Color3.fromRGB(255, 255, 255) langBtn.Font = Enum.Font.Gotham langBtn.TextSize = 12
Instance.new("UICorner", langBtn).CornerRadius = UDim.new(0, 6)

local flyBtn = Instance.new("TextButton", f)
flyBtn.Size = UDim2.new(1, -20, 0, 35) flyBtn.Text = "Fly: OFF" flyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45) flyBtn.TextColor3 = Color3.fromRGB(200, 200, 200) flyBtn.Font = Enum.Font.Gotham flyBtn.LayoutOrder = 3
Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0, 6)

local flying = false local bv, bg, conn
flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then flying = false return end
        bv = Instance.new("BodyVelocity", hrp) bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bg = Instance.new("BodyGyro", hrp) bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9) bg.P = 10000
        conn = game:GetService("RunService").RenderStepped:Connect(function()
            if not flying then return end
            local h = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if not h then return end
            local cam = workspace.CurrentCamera local dir = Vector3.new() local uis = game:GetService("UserInputService")
            if uis:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
            if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0, 1, 0) end
            bv.Velocity = dir * 50 bg.CFrame = cam.CFrame
        end)
        flyBtn.Text = "Fly: ON" flyBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
    else
        if bv then bv:Destroy() end if bg then bg:Destroy() end if conn then conn:Disconnect() end
        flyBtn.Text = "Fly: OFF" flyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)
local function createSlider(name, min, max, def, order, cb)
    local bg = Instance.new("Frame", f) bg.Size = UDim2.new(1, -20, 0, 45) bg.BackgroundColor3 = Color3.fromRGB(35, 35, 40) bg.LayoutOrder = order
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 6)
    local lbl = Instance.new("TextLabel", bg) lbl.Name = "NameLabel" lbl.Size = UDim2.new(0.6, 0, 0, 20) lbl.Position = UDim2.new(0, 10, 0, 5) lbl.Text = name lbl.TextColor3 = Color3.fromRGB(200, 200, 200) lbl.TextSize = 12 lbl.Font = Enum.Font.Gotham lbl.BackgroundTransparency = 1 lbl.TextXAlignment = Enum.TextXAlignment.Left
    local val = Instance.new("TextLabel", bg) val.Name = "ValueLabel" val.Size = UDim2.new(0, 40, 0, 20) val.Position = UDim2.new(1, -50, 0, 5) val.Text = tostring(def) val.TextColor3 = Color3.fromRGB(0, 255, 150) val.TextSize = 12 val.Font = Enum.Font.GothamBold val.BackgroundTransparency = 1
    local bar = Instance.new("Frame", bg) bar.Size = UDim2.new(1, -20, 0, 6) bar.Position = UDim2.new(0, 10, 1, -12) bar.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 3)
    local fill = Instance.new("Frame", bar) fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0) fill.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 3)
    local knob = Instance.new("TextButton", bar) knob.Size = UDim2.new(0, 16, 0, 16) knob.Position = UDim2.new(fill.Size.X.Scale, -8, 0.5, -8) knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200) knob.Text = ""
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 8)
    local dragging = false
    knob.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true end end)
    bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true end end)
    game:GetService("UserInputService").InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local rx = math.clamp((i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local v = math.floor(min + (max-min)*rx)
            val.Text = tostring(v) fill.Size = UDim2.new(rx, 0, 1, 0) knob.Position = UDim2.new(rx, -8, 0.5, -8) cb(v)
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
    return bg
end

local ws = createSlider("Walk Speed", 0, 200, 16, 4, function(v) if p.Character and p.Character:FindFirstChild("Humanoid") then p.Character.Humanoid.WalkSpeed = v end end)
local jp = createSlider("Jump Power", 0, 500, 50, 5, function(v) if p.Character and p.Character:FindFirstChild("Humanoid") then p.Character.Humanoid.UseJumpPower = true p.Character.Humanoid.JumpPower = v end end)
local tpBtn = Instance.new("TextButton", f) tpBtn.Size = UDim2.new(1, -20, 0, 35) tpBtn.Text = "Teleport: Select" tpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45) tpBtn.TextColor3 = Color3.fromRGB(200, 200, 200) tpBtn.Font = Enum.Font.Gotham tpBtn.LayoutOrder = 6
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 6)
local tpFrame = Instance.new("ScrollingFrame", f) tpFrame.Size = UDim2.new(1, -20, 0, 100) tpFrame.BackgroundTransparency = 1 tpFrame.ScrollBarThickness = 4 tpFrame.Visible = false tpFrame.LayoutOrder = 7
local tpl = Instance.new("UIListLayout", tpFrame) tpl.Padding = UDim.new(0, 4)
tpBtn.MouseButton1Click:Connect(function()
    tpFrame.Visible = not tpFrame.Visible
    if tpFrame.Visible then
        for _, c in ipairs(tpFrame:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        for _, pl in ipairs(game.Players:GetPlayers()) do
            if pl ~= p then
                local b = Instance.new("TextButton", tpFrame) b.Size = UDim2.new(1, -5, 0, 30) b.Text = pl.Name b.BackgroundColor3 = Color3.fromRGB(35, 35, 40) b.TextColor3 = Color3.fromRGB(200, 200, 200) b.Font = Enum.Font.Gotham b.TextSize = 12
                Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
                b.MouseButton1Click:Connect(function()
                    local char = pl.Character
                    if char and char:FindFirstChild("HumanoidRootPart") and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        p.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    end
                end)
            end
        end
    end
end)

langBtn.MouseButton1Click:Connect(function()
    if langBtn.Text == "EN" then
        langBtn.Text = "JA" flyBtn.Text = flying and "飛行: ON" or "飛行: OFF" tpBtn.Text = "デレポート: 選択"
        ws.NameLabel.Text = "歩行速度" jp.NameLabel.Text = "ジャンプ力"
    else
        langBtn.Text = "EN" flyBtn.Text = flying and "Fly: ON" or "Fly: OFF" tpBtn.Text = "Teleport: Select"
        ws.NameLabel.Text = "Walk Speed" jp.NameLabel.Text = "Jump Power"
    end
end)

p.CharacterAdded:Connect(function(char)
    task.wait(1)
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.UseJumpPower = true
        humanoid.JumpPower = 50
    end
end)
