-- Fly Test
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local LP = game:GetService("Players").LocalPlayer
local hui = gethui and gethui() or game:GetService("CoreGui")

print("FlyTest 起動")

-- 状態
local FlyOn = false
local D = {F=false, B=false, L=false, R=false, U=false, Dn=false}

-- UI
local sg = Instance.new("ScreenGui")
sg.Name = "FlyTest"
sg.ResetOnSpawn = false
sg.Parent = hui

-- トグルボタン
local btn = Instance.new("TextButton")
btn.Text = "Fly: OFF"
btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.5, -75, 0, 100)
btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextSize = 18
btn.Font = Enum.Font.GothamBold
btn.Parent = sg

-- フライパッド
local pad = Instance.new("Frame")
pad.Size = UDim2.new(0, 220, 0, 220)
pad.Position = UDim2.new(1, -240, 0.5, -110)
pad.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
pad.BackgroundTransparency = 0.2
pad.Visible = false
pad.Parent = sg
Instance.new("UICorner", pad).CornerRadius = UDim.new(0, 16)

-- ボタン作成
local function mkBtn(txt, pos, dir)
    local b = Instance.new("TextButton")
    b.Text = txt
    b.Size = UDim2.new(0, 60, 0, 60)
    b.Position = pos
    b.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 24
    b.Font = Enum.Font.GothamBold
    b.Parent = pad
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 12)
    
    b.MouseButton1Down:Connect(function()
        D[dir] = true
        b.BackgroundColor3 = Color3.fromRGB(80, 180, 120)
    end)
    b.MouseButton1Up:Connect(function()
        D[dir] = false
        b.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    end)
    b.MouseLeave:Connect(function()
        D[dir] = false
        b.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    end)
end

mkBtn("↑", UDim2.new(0.5, -30, 0, 10), "F")
mkBtn("↓", UDim2.new(0.5, -30, 1, -70), "B")
mkBtn("←", UDim2.new(0, 10, 0.5, -30), "L")
mkBtn("→", UDim2.new(1, -70, 0.5, -30), "R")
mkBtn("U", UDim2.new(1, -70, 0, 10), "U")
mkBtn("D", UDim2.new(0, 10, 1, -70), "Dn")

-- トグル
btn.MouseButton1Click:Connect(function()
    FlyOn = not FlyOn
    btn.Text = FlyOn and "Fly: ON" or "Fly: OFF"
    btn.BackgroundColor3 = FlyOn and Color3.fromRGB(60, 120, 90) or Color3.fromRGB(40, 40, 60)
    pad.Visible = FlyOn
    
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = FlyOn end
end)

-- Flyループ
RS.RenderStepped:Connect(function(dt)
    if not FlyOn then return end
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local cam = workspace.CurrentCamera
    
    local move = Vector3.zero
    local speed = 2
    
    -- キーボード
    if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end
    
    -- スマホパッド
    if D.F then move = move + cam.CFrame.LookVector end
    if D.B then move = move - cam.CFrame.LookVector end
    if D.L then move = move - cam.CFrame.RightVector end
    if D.R then move = move + cam.CFrame.RightVector end
    if D.U then move = move + Vector3.new(0, 1, 0) end
    if D.Dn then move = move - Vector3.new(0, 1, 0) end
    
    if move.Magnitude > 0 then
        hrp.CFrame = hrp.CFrame + move.Unit * speed
        hrp.Velocity = Vector3.zero
    end
end)

print("FlyTest OK")
