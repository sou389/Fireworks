--// Fireworks v5.3
local hui = gethui and gethui() or game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local State = {
    WalkSpeed = 16, JumpPower = 50, InfiniteJump = false,
    Fly = false, FlySpeed = 60, Invisible = false, ESP = false,
    GodMode = false, Noclip = false, FullBright = false, RainbowUI = true,
}

local function Create(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do inst[k] = v end
    return inst
end

local function RainbowColor(speed)
    local t = tick() * (speed or 1)
    return Color3.new(
        math.sin(t) * 0.5 + 0.5,
        math.sin(t + 2.094) * 0.5 + 0.5,
        math.sin(t + 4.188) * 0.5 + 0.5
    )
end

local function GetHRP()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
end

local function GetHumanoid()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChildOfClass("Humanoid")
end

local RainbowStrokes = {}

task.spawn(function()
    while task.wait(0.03) do
        if State.RainbowUI then
            for i = #RainbowStrokes, 1, -1 do
                local item = RainbowStrokes[i]
                if item.stroke and item.stroke.Parent then
                    item.stroke.Color = RainbowColor(item.speed)
                else
                    table.remove(RainbowStrokes, i)
                end
            end
        end
    end
end)

local ScreenGui = Create("ScreenGui", {
    Name = "FireworksUI", ResetOnSpawn = false,
    IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = hui,
})

-- ★ 上部の「Fireworks」ボタン（タップで開閉）
local TopBtn = Create("TextButton", {
    Text = "Fireworks",
    Size = UDim2.new(0, 100, 0, 28),
    Position = UDim2.new(0.5, -50, 0, 5),
    BackgroundColor3 = Color3.fromRGB(20, 20, 35),
    BackgroundTransparency = 0.2,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    TextColor3 = Color3.fromRGB(240, 240, 255),
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    Parent = ScreenGui,
})
Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = TopBtn })
local TopStroke = Create("UIStroke", { Color = RainbowColor(1), Thickness = 1.5, Parent = TopBtn })
table.insert(RainbowStrokes, { stroke = TopStroke, speed = 1 })

-- メインウィンドウ
local Main = Create("Frame", {
    Size = UDim2.new(0, 170, 0, 340),
    Position = UDim2.new(0.5, -85, 0.5, -170),
    BackgroundColor3 = Color3.fromRGB(12, 12, 20),
    BackgroundTransparency = 0.1, BorderSizePixel = 0,
    Visible = false,
    Parent = ScreenGui,
})
Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = Main })
local MainStroke = Create("UIStroke", { Color = RainbowColor(1), Thickness = 2, Parent = Main })
table.insert(RainbowStrokes, { stroke = MainStroke, speed = 1 })

-- ★ 上部ボタンをタップでメインウィンドウ開閉
TopBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

local Header = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 32),
    BackgroundColor3 = Color3.fromRGB(22, 22, 38),
    BackgroundTransparency = 0.2, BorderSizePixel = 0, Parent = Main,
})
Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = Header })

Create("TextLabel", {
    Text = "Fireworks", Size = UDim2.new(1, -70, 1, 0),
    Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(240, 240, 255), Font = Enum.Font.GothamBold,
    TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Parent = Header,
})

-- 閉じるボタン
local CloseBtn = Create("TextButton", {
    Text = "×", Size = UDim2.new(0, 24, 0, 24),
    Position = UDim2.new(1, -28, 0.5, -12),
    BackgroundColor3 = Color3.fromRGB(80, 40, 50),
    BackgroundTransparency = 0.2, BorderSizePixel = 0,
    AutoButtonColor = false, TextColor3 = Color3.fromRGB(255, 200, 200),
    Font = Enum.Font.GothamBold, TextSize = 18, Parent = Header,
})
Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = CloseBtn })

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

-- ドラッグ
local dragging, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + d.X,
            startPos.Y.Scale, startPos.Y.Offset + d.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local function MakeToggle(y, label, key, callback)
    local btn = Create("TextButton", {
        Text = "", Size = UDim2.new(1, -16, 0, 24),
        Position = UDim2.new(0, 8, 0, y),
        BackgroundColor3 = Color3.fromRGB(40, 40, 60),
        BackgroundTransparency = 0.15, BorderSizePixel = 0,
        AutoButtonColor = false, Parent = Main,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = btn })
    local st = Create("UIStroke", { Color = Color3.fromRGB(70, 70, 110), Thickness = 1, Parent = btn })
    table.insert(RainbowStrokes, { stroke = st, speed = 0.8 })

    Create("TextLabel", {
        Text = label, Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(240, 240, 255), Font = Enum.Font.GothamMedium,
        TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left, Parent = btn,
    })

    local status = Create("TextLabel", {
        Text = "OFF", Size = UDim2.new(0, 40, 1, 0),
        Position = UDim2.new(1, -45, 0, 0), BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(150, 150, 190), Font = Enum.Font.GothamBold,
        TextSize = 10, TextXAlignment = Enum.TextXAlignment.Right, Parent = btn,
    })

    btn.MouseButton1Click:Connect(function()
        State[key] = not State[key]
        status.Text = State[key] and "ON" or "OFF"
        status.TextColor3 = State[key] and Color3.fromRGB(100, 255, 180) or Color3.fromRGB(150, 150, 190)
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = State[key] and Color3.fromRGB(60, 120, 90) or Color3.fromRGB(40, 40, 60)
        }):Play()
        if callback then
            local ok, err = pcall(callback, State[key])
            if not ok then warn("[Fireworks]", err) end
        end
    end)
end

local function MakeSlider(y, label, min, max, default, key)
    local c = Create("Frame", {
        Size = UDim2.new(1, -16, 0, 34),
        Position = UDim2.new(0, 8, 0, y),
        BackgroundColor3 = Color3.fromRGB(40, 40, 60),
        BackgroundTransparency = 0.15, BorderSizePixel = 0, Parent = Main,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = c })
    local st = Create("UIStroke", { Color = Color3.fromRGB(70, 70, 110), Thickness = 1, Parent = c })
    table.insert(RainbowStrokes, { stroke = st, speed = 0.6 })

    local lbl = Create("TextLabel", {
        Text = label .. ": " .. default, Size = UDim2.new(1, -16, 0, 14),
        Position = UDim2.new(0, 10, 0, 2), BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(240, 240, 255), Font = Enum.Font.GothamMedium,
        TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, Parent = c,
    })

    local track = Create("Frame", {
        Size = UDim2.new(1, -20, 0, 5), Position = UDim2.new(0, 10, 0, 22),
        BackgroundColor3 = Color3.fromRGB(25, 25, 40),
        BorderSizePixel = 0, Parent = c,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 3), Parent = track })

    local fill = Create("Frame", {
        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = RainbowColor(1), BorderSizePixel = 0, Parent = track,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 3), Parent = fill })

    local knob = Create("Frame", {
        Size = UDim2.new(0, 11, 0, 11),
        Position = UDim2.new((default - min) / (max - min), -5, 0.5, -5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0, Parent = track,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = knob })

    task.spawn(function()
        while fill.Parent do
            fill.BackgroundColor3 = RainbowColor(1)
            task.wait(0.05)
        end
    end)

    local drag = false
    local function update(input)
        local rel = math.clamp(
            (input.Position.X - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
        local v = math.floor(min + (max - min) * rel)
        fill.Size = UDim2.new(rel, 0, 1, 0)
        knob.Position = UDim2.new(rel, -5, 0.5, -5)
        lbl.Text = label .. ": " .. v
        State[key] = v
    end

    track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            update(i)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement
        or i.UserInputType == Enum.UserInputType.Touch) then update(i) end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then drag = false end
    end)
end

local ESP_Objects = {}

local function CreateESP(player)
    if player == LocalPlayer then return end
    if ESP_Objects[player] then return end

    local sg = Create("ScreenGui", {
        Name = "FW_ESP_" .. player.Name, ResetOnSpawn = false,
        IgnoreGuiInset = true, Parent = hui,
    })

    local box = Create("Frame", {
        BackgroundTransparency = 1, BorderSizePixel = 0,
        Visible = false, Parent = sg,
    })
    local st = Create("UIStroke", { Color = RainbowColor(1.5), Thickness = 1.5, Parent = box })

    local nameTag = Create("TextLabel", {
        BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold, TextSize = 10,
        TextStrokeTransparency = 0, Visible = false, Parent = sg,
    })

    local distTag = Create("TextLabel", {
        BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(200, 200, 255),
        Font = Enum.Font.Gotham, TextSize = 9,
        TextStrokeTransparency = 0, Visible = false, Parent = sg,
    })

    ESP_Objects[player] = { gui = sg, box = box, stroke = st, nameTag = nameTag, distTag = distTag }
end

local function RemoveESP(player)
    local obj = ESP_Objects[player]
    if obj and obj.gui then obj.gui:Destroy() end
    ESP_Objects[player] = nil
end

RunService.RenderStepped:Connect(function()
    if not State.ESP then
        for _, obj in pairs(ESP_Objects) do
            obj.box.Visible = false
            obj.nameTag.Visible = false
            obj.distTag.Visible = false
        end
        return
    end

    local cam = workspace.CurrentCamera
    if not cam then return end

    for player, obj in pairs(ESP_Objects) do
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if hrp and head and hum and hum.Health > 0 then
            local hrpPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
            local headPos = cam:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0))
            if onScreen then
                local height = math.abs(headPos.Y - hrpPos.Y) * 2.2
                local width = height * 0.6
                local x = hrpPos.X - width / 2
                local y = hrpPos.Y - height / 2

                obj.box.Visible = true
                obj.box.Position = UDim2.new(0, x, 0, y)
                obj.box.Size = UDim2.new(0, width, 0, height)
                obj.stroke.Color = RainbowColor(1.5)

                local dist = (cam.CFrame.Position - hrp.Position).Magnitude
                obj.nameTag.Visible = true
                obj.nameTag.Text = player.Name
                obj.nameTag.Position = UDim2.new(0, x, 0, y - 16)
                obj.nameTag.Size = UDim2.new(0, width, 0, 12)

                obj.distTag.Visible = true
                obj.distTag.Text = string.format("[%d m]", math.floor(dist))
                obj.distTag.Position = UDim2.new(0, x, 0, y + height + 2)
                obj.distTag.Size = UDim2.new(0, width, 0, 10)
            else
                obj.box.Visible = false
                obj.nameTag.Visible = false
                obj.distTag.Visible = false
            end
        else
            obj.box.Visible = false
            obj.nameTag.Visible = false
            obj.distTag.Visible = false
        end
    end
end)

Players.PlayerAdded:Connect(function(p)
    if State.ESP then task.wait(1) CreateESP(p) end
end)
Players.PlayerRemoving:Connect(RemoveESP)

local FlyVelocity, FlyGyro

local function StartFly()
    local hrp = GetHRP()
    if not hrp then return end
    FlyVelocity = Instance.new("BodyVelocity")
    FlyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    FlyVelocity.Velocity = Vector3.zero
    FlyVelocity.Parent = hrp

    FlyGyro = Instance.new("BodyGyro")
    FlyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    FlyGyro.P = 1000
    FlyGyro.D = 50
    FlyGyro.CFrame = hrp.CFrame
    FlyGyro.Parent = hrp

    local hum = GetHumanoid()
    if hum then hum.PlatformStand = true end
end

local function StopFly()
    if FlyVelocity then FlyVelocity:Destroy() FlyVelocity = nil end
    if FlyGyro then FlyGyro:Destroy() FlyGyro = nil end
    local hum = GetHumanoid()
    if hum then hum.PlatformStand = false end
end

task.spawn(function()
    while task.wait(0.03) do
        if State.Fly and FlyVelocity and FlyGyro then
            local hrp = GetHRP()
            local cam = workspace.CurrentCamera
            if hrp and cam then
                local move = Vector3.zero
                local speed = State.FlySpeed

                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end

                FlyVelocity.Velocity = move.Magnitude > 0 and move.Unit * speed or Vector3.zero
                FlyGyro.CFrame = cam.CFrame
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if State.Invisible then
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.LocalTransparencyModifier = 0.9 end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if State.GodMode then
            local hum = GetHumanoid()
            if hum then hum.Health = hum.MaxHealth end
        end
    end
end)

local NoclipConn
task.spawn(function()
    while task.wait(0.2) do
        if State.Noclip then
            if not NoclipConn then
                NoclipConn = RunService.Stepped:Connect(function()
                    local char = LocalPlayer.Character
                    if not char then return end
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end)
            end
        else
            if NoclipConn then NoclipConn:Disconnect() NoclipConn = nil end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if State.FullBright then
            Lighting.Brightness = 3
            Lighting.ClockTime = 12
            Lighting.Ambient = Color3.fromRGB(178, 178, 178)
            Lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
            Lighting.FogEnd = 100000
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        local hum = GetHumanoid()
        if hum then
            if hum.WalkSpeed ~= State.WalkSpeed then hum.WalkSpeed = State.WalkSpeed end
            if hum.JumpPower ~= State.JumpPower then hum.JumpPower = State.JumpPower end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if State.InfiniteJump then
        local hum = GetHumanoid()
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

MakeToggle(38, "Infinite Jump", "InfiniteJump")
MakeToggle(66, "Fly", "Fly", function(v)
    if v then StartFly() else StopFly() end
end)
MakeToggle(94, "Invisible", "Invisible")
MakeToggle(122, "ESP", "ESP", function(v)
    if v then
        for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
    else
        for p, _ in pairs(ESP_Objects) do RemoveESP(p) end
    end
end)
MakeToggle(150, "God Mode", "GodMode")
MakeToggle(178, "Noclip", "Noclip")
MakeToggle(206, "Full Bright", "FullBright")
MakeToggle(234, "Rainbow UI", "RainbowUI")

MakeSlider(266, "WalkSpeed", 1, 300, State.WalkSpeed, "WalkSpeed")
MakeSlider(302, "JumpPower", 1, 300, State.JumpPower, "JumpPower")
MakeSlider(338, "FlySpeed", 10, 300, State.FlySpeed, "FlySpeed")

print("[Fireworks v5.3] Loaded")
