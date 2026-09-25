--// Fireworks v6.1
local hui = gethui and gethui() or game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer

local S = {
    WalkSpeed = 16, JumpPower = 50, InfiniteJump = false,
    Invisible = false, ESP = false, Kill = false,
    GodMode = false, Noclip = false, FullBright = false, RainbowUI = true,
}

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

local function HRP()
    local c = LP.Character
    if not c then return nil end
    return c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
end

local function HUM()
    local c = LP.Character
    if not c then return nil end
    return c:FindFirstChildOfClass("Humanoid")
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
    Text = "Fireworks", Size = UDim2.new(0, 120, 0, 32),
    Position = UDim2.new(0.5, -60, 0, 8),
    BackgroundColor3 = T.Card, BorderSizePixel = 0,
    AutoButtonColor = false, TextColor3 = T.Text,
    Font = Enum.Font.GothamBold, TextSize = 14, Parent = SG,
})
C("UICorner", { CornerRadius = UDim.new(0, 16), Parent = TB })
local TBs = C("UIStroke", { Color = T.A1, Thickness = 2, Parent = TB })
C("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, T.A1),
        ColorSequenceKeypoint.new(0.5, T.A2),
        ColorSequenceKeypoint.new(1, T.A3),
    }),
    Parent = TBs,
})

local M = C("Frame", {
    Size = UDim2.new(0, 200, 0, 480),
    Position = UDim2.new(0.5, -100, 0.5, -240),
    BackgroundColor3 = T.Bg, BackgroundTransparency = 0.05,
    BorderSizePixel = 0, Visible = false, Parent = SG,
})
C("UICorner", { CornerRadius = UDim.new(0, 16), Parent = M })
local Ms = C("UIStroke", { Color = T.A1, Thickness = 2, Parent = M })
C("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, T.A1),
        ColorSequenceKeypoint.new(0.5, T.A2),
        ColorSequenceKeypoint.new(1, T.A3),
    }),
    Rotation = 45, Parent = Ms,
})

TB.MouseButton1Click:Connect(function()
    M.Visible = not M.Visible
end)

local H = C("Frame", {
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundTransparency = 1, Parent = M,
})

C("TextLabel", {
    Text = "Fireworks", Size = UDim2.new(1, -60, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1, TextColor3 = T.Text,
    Font = Enum.Font.GothamBold, TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left, Parent = H,
})

local CB = C("TextButton", {
    Text = "×", Size = UDim2.new(0, 28, 0, 28),
    Position = UDim2.new(1, -36, 0.5, -14),
    BackgroundColor3 = Color3.fromRGB(60, 30, 45),
    BorderSizePixel = 0, AutoButtonColor = false,
    TextColor3 = Color3.fromRGB(255, 180, 200),
    Font = Enum.Font.GothamBold, TextSize = 18, Parent = H,
})
C("UICorner", { CornerRadius = UDim.new(0, 8), Parent = CB })
CB.MouseButton1Click:Connect(function()
    M.Visible = false
end)

local dg, dS, dP
H.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dg = true dS = input.Position dP = M.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dg and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dS
        M.Position = UDim2.new(
            dP.X.Scale, dP.X.Offset + d.X,
            dP.Y.Scale, dP.Y.Offset + d.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then dg = false end
end)

local function MK(y, lbl, key, cb)
    local b = C("TextButton", {
        Text = "", Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, y),
        BackgroundColor3 = T.Card, BackgroundTransparency = 0.1,
        BorderSizePixel = 0, AutoButtonColor = false, Parent = M,
    })
    C("UICorner", { CornerRadius = UDim.new(0, 10), Parent = b })
    local st = C("UIStroke", {
        Color = T.Off, Thickness = 1.5, Transparency = 0.4, Parent = b
    })
    local bar = C("Frame", {
        Size = UDim2.new(0, 3, 0.6, 0),
        Position = UDim2.new(0, 6, 0.2, 0),
        BackgroundColor3 = T.A1, BorderSizePixel = 0, Parent = b,
    })
    C("UICorner", { CornerRadius = UDim.new(1, 0), Parent = bar })
    C("TextLabel", {
        Text = lbl, Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1, TextColor3 = T.Text,
        Font = Enum.Font.GothamMedium, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = b,
    })
    local stt = C("TextLabel", {
        Text = "OFF", Size = UDim2.new(0, 40, 1, 0),
        Position = UDim2.new(1, -46, 0, 0),
        BackgroundTransparency = 1, TextColor3 = T.Sub,
        Font = Enum.Font.GothamBold, TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Right, Parent = b,
    })
    b.MouseButton1Click:Connect(function()
        S[key] = not S[key]
        stt.Text = S[key] and "ON" or "OFF"
        stt.TextColor3 = S[key] and T.On or T.Sub
        TweenService:Create(b, TweenInfo.new(0.2), {
            BackgroundColor3 = S[key] and Color3.fromRGB(30, 60, 55) or T.Card
        }):Play()
        TweenService:Create(st, TweenInfo.new(0.2), {
            Color = S[key] and T.On or T.Off,
            Transparency = S[key] and 0 or 0.4,
        }):Play()
        if cb then
            local ok, err = pcall(cb, S[key])
            if not ok then warn("[Fireworks]", err) end
        end
    end)
end

local function MS(y, lbl, mn, mx, df, key)
    local c = C("Frame", {
        Size = UDim2.new(1, -20, 0, 38),
        Position = UDim2.new(0, 10, 0, y),
        BackgroundColor3 = T.Card, BackgroundTransparency = 0.1,
        BorderSizePixel = 0, Parent = M,
    })
    C("UICorner", { CornerRadius = UDim.new(0, 10), Parent = c })
    C("UIStroke", {
        Color = T.Off, Thickness = 1.5, Transparency = 0.4, Parent = c
    })
    local l = C("TextLabel", {
        Text = lbl .. ": " .. df, Size = UDim2.new(1, -20, 0, 14),
        Position = UDim2.new(0, 12, 0, 3), BackgroundTransparency = 1,
        TextColor3 = T.Text, Font = Enum.Font.GothamMedium,
        TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left, Parent = c,
    })
    local tr = C("Frame", {
        Size = UDim2.new(1, -24, 0, 4),
        Position = UDim2.new(0, 12, 0, 26),
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
        Size = UDim2.new(0, 12, 0, 12),
        Position = UDim2.new((df - mn) / (mx - mn), -6, 0.5, -6),
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
        kb.Position = UDim2.new(r, -6, 0.5, -6)
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

-- ESP
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

-- ★ Kill Player 関数
local function KillAll()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            local char = p.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.Health = 0
                end
            end
        end
    end
end

-- Killループ
task.spawn(function()
    while task.wait(0.5) do
        if S.Kill then
            KillAll()
        end
    end
end)

-- その他
task.spawn(function()
    while task.wait(0.1) do
        if S.Invisible then
            local c = LP.Character
            if c then
                for _, p in pairs(c:GetDescendants()) do
                    if p:IsA("BasePart") then p.LocalTransparencyModifier = 0.9 end
                end
            end
        end
    end
end)

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

-- ボタン配置（Flyを削除、Killを追加）
MK(50, "Infinite Jump", "InfiniteJump")
MK(86, "Invisible", "Invisible")
MK(122, "ESP", "ESP", function(v)
    if v then
        for _, p in pairs(Players:GetPlayers()) do CE(p) end
    else
        for p, _ in pairs(EO) do RE(p) end
    end
end)
MK(158, "Kill Player", "Kill")
MK(194, "God Mode", "GodMode")
MK(230, "Noclip", "Noclip")
MK(266, "Full Bright", "FullBright")
MK(302, "Rainbow UI", "RainbowUI")

MS(342, "WalkSpeed", 1, 300, S.WalkSpeed, "WalkSpeed")
MS(386, "JumpPower", 1, 300, S.JumpPower, "JumpPower")

print("[Fireworks v6.1] Loaded")
