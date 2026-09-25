--// Fireworks v6.6
local hui = gethui and gethui() or game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local LP = Players.LocalPlayer

local S = {
    WalkSpeed = 16, JumpPower = 50, InfiniteJump = false,
    ESP = false,
    GodMode = false, Noclip = false, FullBright = false, RainbowUI = true,
    BuildSize = 5,
}

local SavedPos = nil

local T = {
    Bg = Color3.fromRGB(15, 15, 25),
    Card = Color3.fromRGB(24, 24, 38),
    Text = Color3.fromRGB(245, 245, 255),
    Sub = Color3.fromRGB(140, 140, 180),
    A1 = Color3.fromRGB(140, 90, 255),
    A2 = Color3.fromRGB(80, 200, 255),
    A3 = Color3.fromRGB(255, 90, 180),
    On = Color3.fromRGB(80, 220, 140),
    Off = Color3.fromRGB(60, 60, 90),
}

local function C(c, p)
    local i = Instance.new(c)
    for k, v in pairs(p or {}) do i[k] = v end
    return i
end

local function RC(s)
    local t = tick() * (s or 1)
    return Color3.new(
        math.sin(t) * 0.5 + 0.5,
        math.sin(t + 2.094) * 0.5 + 0.5,
        math.sin(t + 4.188) * 0.5 + 0.5
    )
end

local function HUM()
    local c = LP.Character
    if not c then return nil end
    return c:FindFirstChildOfClass("Humanoid")
end

local function HRP()
    local c = LP.Character
    if not c then return nil end
    return c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
end

local RS = {}
task.spawn(function()
    while task.wait(0.03) do
        if S.RainbowUI then
            for i = #RS, 1, -1 do
                local it = RS[i]
                if it.s and it.s.Parent then
                    it.s.Color = RC(it.sp)
                else
                    table.remove(RS, i)
                end
            end
        end
    end
end)

local SG = C("ScreenGui", {
    Name = "FireworksUI", ResetOnSpawn = false,
    IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = hui,
})

local TB = C("TextButton", {
    Text = "FW", Size = UDim2.new(0, 60, 0, 26),
    Position = UDim2.new(0.5, -30, 0, 5),
    BackgroundColor3 = T.Card, BorderSizePixel = 0,
    AutoButtonColor = false, TextColor3 = T.Text,
    Font = Enum.Font.GothamBold, TextSize = 12, Parent = SG,
})
C("UICorner", { CornerRadius = UDim.new(0, 13), Parent = TB })
C("UIStroke", { Color = T.A1, Thickness = 1.5, Parent = TB })

local M = C("Frame", {
    Size = UDim2.new(0, 210, 0, 460),
    Position = UDim2.new(0.5, -105, 0.5, -230),
    BackgroundColor3 = T.Bg, BackgroundTransparency = 0.05,
    BorderSizePixel = 0, Visible = false, Parent = SG,
})
C("UICorner", { CornerRadius = UDim.new(0, 12), Parent = M })
C("UIStroke", { Color = T.A1, Thickness = 1.5, Parent = M })

TB.MouseButton1Click:Connect(function()
    M.Visible = not M.Visible
end)

local H = C("Frame", {
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundColor3 = T.Card, BackgroundTransparency = 0.3,
    BorderSizePixel = 0, Parent = M,
})
C("UICorner", { CornerRadius = UDim.new(0, 12), Parent = H })
C("TextLabel", {
    Text = "Fireworks", Size = UDim2.new(1, -40, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1, TextColor3 = T.Text,
    Font = Enum.Font.GothamBold, TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left, Parent = H,
})

local CB = C("TextButton", {
    Text = "×", Size = UDim2.new(0, 26, 0, 26),
    Position = UDim2.new(1, -30, 0.5, -13),
    BackgroundColor3 = Color3.fromRGB(80, 35, 50),
    BorderSizePixel = 0, AutoButtonColor = false,
    TextColor3 = Color3.fromRGB(255, 200, 220),
    Font = Enum.Font.GothamBold, TextSize = 18, Parent = H,
})
C("UICorner", { CornerRadius = UDim.new(0, 8), Parent = CB })
CB.MouseButton1Click:Connect(function()
    M.Visible = false
end)

local dragging = false
local dragStart, startPos
H.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = M.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        M.Position = UDim2.new(
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

local function MK(y, lbl, key, cb)
    local b = C("TextButton", {
        Text = "", Size = UDim2.new(1, -16, 0, 26),
        Position = UDim2.new(0, 8, 0, y),
        BackgroundColor3 = T.Card, BackgroundTransparency = 0.1,
        BorderSizePixel = 0, AutoButtonColor = false, Parent = M,
    })
    C("UICorner", { CornerRadius = UDim.new(0, 8), Parent = b })
    local st = C("UIStroke", {
        Color = T.Off, Thickness = 1.2, Transparency = 0.4, Parent = b
    })
    C("TextLabel", {
        Text = lbl, Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        BackgroundTransparency = 1, TextColor3 = T.Text,
        Font = Enum.Font.GothamMedium, TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = b,
    })
    local stt = C("TextLabel", {
        Text = "OFF", Size = UDim2.new(0, 35, 1, 0),
        Position = UDim2.new(1, -40, 0, 0),
        BackgroundTransparency = 1, TextColor3 = T.Sub,
        Font = Enum.Font.GothamBold, TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Right, Parent = b,
    })
    b.MouseButton1Click:Connect(function()
        S[key] = not S[key]
        stt.Text = S[key] and "ON" or "OFF"
        stt.TextColor3 = S[key] and T.On or T.Sub
        TweenService:Create(b, TweenInfo.new(0.2), {
            BackgroundColor3 = S[key] and Color3.fromRGB(30, 60, 55) or T.Card
        }):Play()
        if cb then
            local ok, err = pcall(cb, S[key])
            if not ok then warn("[Fireworks]", err) end
        end
    end)
end

local function AB(y, lbl, cb)
    local b = C("TextButton", {
        Text = lbl, Size = UDim2.new(1, -16, 0, 26),
        Position = UDim2.new(0, 8, 0, y),
        BackgroundColor3 = T.Card, BackgroundTransparency = 0.1,
        BorderSizePixel = 0, AutoButtonColor = false,
        TextColor3 = T.Text, Font = Enum.Font.GothamBold,
        TextSize = 10, Parent = M,
    })
    C("UICorner", { CornerRadius = UDim.new(0, 8), Parent = b })
    C("UIStroke", { Color = T.A1, Thickness = 1, Transparency = 0.3, Parent = b })
    b.MouseButton1Click:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(60, 100, 120)
        }):Play()
        task.delay(0.15, function()
            TweenService:Create(b, TweenInfo.new(0.2), {
                BackgroundColor3 = T.Card
            }):Play()
        end)
        if cb then
            local ok, err = pcall(cb)
            if not ok then warn("[Fireworks]", err) end
        end
    end)
end

local function MS(y, lbl, mn, mx, df, key)
    local c = C("Frame", {
        Size = UDim2.new(1, -16, 0, 32),
        Position = UDim2.new(0, 8, 0, y),
        BackgroundColor3 = T.Card, BackgroundTransparency = 0.1,
        BorderSizePixel = 0, Parent = M,
    })
    C("UICorner", { CornerRadius = UDim.new(0, 8), Parent = c })
    C("UIStroke", { Color = T.Off, Thickness = 1.2, Transparency = 0.4, Parent = c })
    local l = C("TextLabel", {
        Text = lbl .. ": " .. df, Size = UDim2.new(1, -16, 0, 12),
        Position = UDim2.new(0, 10, 0, 2), BackgroundTransparency = 1,
        TextColor3 = T.Text, Font = Enum.Font.GothamMedium,
        TextSize = 9, TextXAlignment = Enum.TextXAlignment.Left, Parent = c,
    })
    local tr = C("Frame", {
        Size = UDim2.new(1, -20, 0, 4),
        Position = UDim2.new(0, 10, 0, 22),
        BackgroundColor3 = Color3.fromRGB(20, 20, 32),
        BorderSizePixel = 0, Parent = c,
    })
    C("UICorner", { CornerRadius = UDim.new(1, 0), Parent = tr })
    local fl = C("Frame", {
        Size = UDim2.new((df - mn) / (mx - mn), 0, 1, 0),
        BackgroundColor3 = T.A1, BorderSizePixel = 0, Parent = tr,
    })
    C("UICorner", { CornerRadius = UDim.new(1, 0), Parent = fl })
    C("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, T.A1),
            ColorSequenceKeypoint.new(0.5, T.A2),
            ColorSequenceKeypoint.new(1, T.A3),
        }), Parent = fl,
    })
    local kb = C("Frame", {
        Size = UDim2.new(0, 10, 0, 10),
        Position = UDim2.new((df - mn) / (mx - mn), -5, 0.5, -5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0, Parent = tr,
    })
    C("UICorner", { CornerRadius = UDim.new(1, 0), Parent = kb })
    local dr = false
    local function up(inp)
        local r = math.clamp(
            (inp.Position.X - tr.AbsolutePosition.X) / math.max(tr.AbsoluteSize.X, 1), 0, 1)
        local v = math.floor(mn + (mx - mn) * r)
        fl.Size = UDim2.new(r, 0, 1, 0)
        kb.Position = UDim2.new(r, -5, 0.5, -5)
        l.Text = lbl .. ": " .. v
        S[key] = v
    end
    tr.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dr = true up(i)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dr and (i.UserInputType == Enum.UserInputType.MouseMovement
        or i.UserInputType == Enum.UserInputType.Touch) then up(i) end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then dr = false end
    end)
end

local EO = {}

local function CE(p)
    if p == LP then return end
    if EO[p] then return end
    local sg = C("ScreenGui", {
        Name = "FW_E_" .. p.Name, ResetOnSpawn = false,
        IgnoreGuiInset = true, Parent = hui,
    })
    local bx = C("Frame", {
        BackgroundTransparency = 1, BorderSizePixel = 0,
        Visible = false, Parent = sg,
    })
    local st = C("UIStroke", { Color = RC(1.5), Thickness = 2, Parent = bx })
    local nt = C("TextLabel", {
        BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold, TextSize = 10,
        TextStrokeTransparency = 0, Visible = false, Parent = sg,
    })
    local dt = C("TextLabel", {
        BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(200, 200, 255),
        Font = Enum.Font.Gotham, TextSize = 9,
        TextStrokeTransparency = 0, Visible = false, Parent = sg,
    })
    EO[p] = { g = sg, b = bx, s = st, n = nt, d = dt }
end

local function RE(p)
    local o = EO[p]
    if o and o.g then o.g:Destroy() end
    EO[p] = nil
end

RunService.RenderStepped:Connect(function()
    if not S.ESP then
        for _, o in pairs(EO) do
            o.b.Visible = false o.n.Visible = false o.d.Visible = false
        end
        return
    end
    local cam = workspace.CurrentCamera
    if not cam then return end
    for p, o in pairs(EO) do
        local c = p.Character
        local h = c and c:FindFirstChild("HumanoidRootPart")
        local hd = c and c:FindFirstChild("Head")
        local hu = c and c:FindFirstChildOfClass("Humanoid")
        if h and hd and hu and hu.Health > 0 then
            local hp, os = cam:WorldToViewportPoint(h.Position)
            local he = cam:WorldToViewportPoint(hd.Position + Vector3.new(0, 1, 0))
            if os then
                local hh = math.abs(he.Y - hp.Y) * 2.2
                local ww = hh * 0.6
                local x = hp.X - ww / 2
                local y = hp.Y - hh / 2
                o.b.Visible = true
                o.b.Position = UDim2.new(0, x, 0, y)
                o.b.Size = UDim2.new(0, ww, 0, hh)
                o.s.Color = RC(1.5)
                local d = (cam.CFrame.Position - h.Position).Magnitude
                o.n.Visible = true o.n.Text = p.Name
                o.n.Position = UDim2.new(0, x, 0, y - 16)
                o.n.Size = UDim2.new(0, ww, 0, 12)
                o.d.Visible = true o.d.Text = string.format("[%dm]", math.floor(d))
                o.d.Position = UDim2.new(0, x, 0, y + hh + 2)
                o.d.Size = UDim2.new(0, ww, 0, 10)
            else
                o.b.Visible = false o.n.Visible = false o.d.Visible = false
            end
        else
            o.b.Visible = false o.n.Visible = false o.d.Visible = false
        end
    end
end)

Players.PlayerAdded:Connect(function(p)
    if S.ESP then task.wait(1) CE(p) end
end)
Players.PlayerRemoving:Connect(RE)

-- テレポート（保存/移動）
local function SavePos()
    local hrp = HRP()
    if hrp then
        SavedPos = hrp.CFrame
        print("[Fireworks] 位置を保存しました")
    end
end

local function TeleportToSaved()
    if not SavedPos then
        warn("[Fireworks] 保存された位置がありません")
        return
    end
    local hrp = HRP()
    if hrp then
        hrp.CFrame = SavedPos + Vector3.new(0, 3, 0)
    end
end

-- ★ ビルド（パーツを置く）当たり判定あり
local function BuildPart()
    local hrp = HRP()
    if not hrp then return end
    local cam = workspace.CurrentCamera
    local pos = hrp.Position + cam.CFrame.LookVector * 10
    local part = Instance.new("Part")
    part.Size = Vector3.new(S.BuildSize, S.BuildSize, S.BuildSize)
    part.Position = pos
    part.Anchored = true
    part.CanCollide = true
    part.CanTouch = true
    part.CanQuery = true
    part.Color = RC(1)
    part.Material = Enum.Material.Neon
    part.Parent = Workspace
end

task.spawn(function()
    while task.wait(0.5) do
        if S.GodMode then
            local h = HUM()
            if h then h.Health = h.MaxHealth end
        end
    end
end)

local NC
task.spawn(function()
    while task.wait(0.2) do
        if S.Noclip then
            if not NC then
                NC = RunService.Stepped:Connect(function()
                    local c = LP.Character
                    if not c then return end
                    for _, p in pairs(c:GetDescendants()) do
                        if p:IsA("BasePart") then p.CanCollide = false end
                    end
                end)
            end
        else
            if NC then NC:Disconnect() NC = nil end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if S.FullBright then
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
        local h = HUM()
        if h then
            if h.WalkSpeed ~= S.WalkSpeed then h.WalkSpeed = S.WalkSpeed end
            if h.JumpPower ~= S.JumpPower then h.JumpPower = S.JumpPower end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if S.InfiniteJump then
        local h = HUM()
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

MK(36, "Infinite Jump", "InfiniteJump")
MK(66, "ESP", "ESP", function(v)
    if v then
        for _, p in pairs(Players:GetPlayers()) do CE(p) end
    else
        for p, _ in pairs(EO) do RE(p) end
    end
end)
MK(96, "God Mode", "GodMode")
MK(126, "Noclip", "Noclip")
MK(156, "Full Bright", "FullBright")
MK(186, "Rainbow UI", "RainbowUI")

C("TextLabel", {
    Text = "Teleport", Size = UDim2.new(1, -16, 0, 16),
    Position = UDim2.new(0, 8, 0, 216),
    BackgroundTransparency = 1, TextColor3 = T.Sub,
    Font = Enum.Font.GothamBold, TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left, Parent = M,
})
AB(234, "Save Position", SavePos)
AB(264, "Teleport to Saved", TeleportToSaved)

C("TextLabel", {
    Text = "Build", Size = UDim2.new(1, -16, 0, 16),
    Position = UDim2.new(0, 8, 0, 294),
    BackgroundTransparency = 1, TextColor3 = T.Sub,
    Font = Enum.Font.GothamBold, TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left, Parent = M,
})
AB(312, "Place Part", BuildPart)
MS(342, "PartSize", 1, 20, S.BuildSize, "BuildSize")

MS(384, "WalkSpeed", 1, 300, S.WalkSpeed, "WalkSpeed")
MS(420, "JumpPower", 1, 300, S.JumpPower, "JumpPower")

print("[Fireworks v6.6] Loaded")
