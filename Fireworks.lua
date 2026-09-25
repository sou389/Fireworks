--// Fireworks v7.0
local hui = gethui and gethui() or game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TeleportService = game:GetService("TeleportService")
local LP = Players.LocalPlayer

-- 言語
local Lang = "JP"
local L = {
    JP = {
        title = "Fireworks", tabPlayer = "プレイヤー", tabTP = "テレポート",
        tabBuild = "建築", tabVisual = "見た目", tabMisc = "その他",
        infJump = "無限ジャンプ", esp = "ESP", god = "ゴッドモード",
        noclip = "ノークリップ", bright = "フルブライト", rainbow = "虹色UI",
        speed = "移動速度", jump = "ジャンプ力",
        savePos = "位置を保存", tpSaved = "保存位置に移動",
        tpPlayer = "プレイヤーに移動", selectPlayer = "プレイヤー選択",
        buildOne = "パーツ1個", wall = "壁", box = "箱", castle = "城",
        tower = "タワー", stairs = "階段", partSize = "パーツサイズ",
        openBuild = "建築パネルを開く", rejoin = "再入場", serverHop = "サーバー移動",
        autoClick = "自動クリック", fly = "フライ", flySpeed = "フライ速度",
        saveMsg = "位置を保存しました", noSaved = "保存位置なし",
        lang = "言語", saved = "保存済み",
    },
    EN = {
        title = "Fireworks", tabPlayer = "Player", tabTP = "Teleport",
        tabBuild = "Build", tabVisual = "Visual", tabMisc = "Misc",
        infJump = "Infinite Jump", esp = "ESP", god = "God Mode",
        noclip = "Noclip", bright = "Full Bright", rainbow = "Rainbow UI",
        speed = "WalkSpeed", jump = "JumpPower",
        savePos = "Save Position", tpSaved = "TP to Saved",
        tpPlayer = "TP to Player", selectPlayer = "Select Player",
        buildOne = "Place Part", wall = "Wall", box = "Box", castle = "Castle",
        tower = "Tower", stairs = "Stairs", partSize = "Part Size",
        openBuild = "Open Build Panel", rejoin = "Rejoin", serverHop = "Server Hop",
        autoClick = "Auto Click", fly = "Fly", flySpeed = "Fly Speed",
        saveMsg = "Position saved", noSaved = "No saved position",
        lang = "Language", saved = "Saved",
    }
}
local function T(k) return L[Lang][k] or k end

local S = {
    WalkSpeed = 16, JumpPower = 50, InfiniteJump = false,
    ESP = false, GodMode = false, Noclip = false,
    FullBright = false, RainbowUI = true,
    BuildSize = 5, Fly = false, FlySpeed = 60,
    AutoClick = false,
}

local SavedPos = nil
local SelectedPlayer = nil
local FlyDir = {F=false, B=false, L=false, R=false, U=false, D=false}

-- カラー
local Th = {
    Bg = Color3.fromRGB(15, 15, 25),
    Card = Color3.fromRGB(24, 24, 38),
    CardSel = Color3.fromRGB(40, 40, 60),
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
    BackgroundColor3 = Th.Card, BorderSizePixel = 0,
    AutoButtonColor = false, TextColor3 = Th.Text,
    Font = Enum.Font.GothamBold, TextSize = 12, Parent = SG,
})
C("UICorner", { CornerRadius = UDim.new(0, 13), Parent = TB })
C("UIStroke", { Color = Th.A1, Thickness = 1.5, Parent = TB })

-- メインウィンドウ（横240）
local M = C("Frame", {
    Size = UDim2.new(0, 240, 0, 360),
    Position = UDim2.new(0.5, -120, 0.5, -180),
    BackgroundColor3 = Th.Bg, BackgroundTransparency = 0.05,
    BorderSizePixel = 0, Visible = false, Parent = SG,
})
C("UICorner", { CornerRadius = UDim.new(0, 12), Parent = M })
C("UIStroke", { Color = Th.A1, Thickness = 1.5, Parent = M })

TB.MouseButton1Click:Connect(function()
    M.Visible = not M.Visible
end)

-- ヘッダー
local H = C("Frame", {
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundColor3 = Th.Card, BackgroundTransparency = 0.3,
    BorderSizePixel = 0, Parent = M,
})
C("UICorner", { CornerRadius = UDim.new(0, 12), Parent = H })
local HTitle = C("TextLabel", {
    Text = T("title"), Size = UDim2.new(1, -40, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1, TextColor3 = Th.Text,
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

-- ドラッグ
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

-- タブバー
local TabBar = C("Frame", {
    Size = UDim2.new(1, 0, 0, 26),
    Position = UDim2.new(0, 0, 0, 32),
    BackgroundTransparency = 1, Parent = M,
})

local Tabs = {}
local TabBtns = {}
local ContentArea = C("Frame", {
    Size = UDim2.new(1, -12, 1, -70),
    Position = UDim2.new(0, 6, 0, 62),
    BackgroundTransparency = 1, Parent = M,
})

local function SelectTab(name)
    for n, f in pairs(Tabs) do
        f.Visible = (n == name)
    end
    for n, b in pairs(TabBtns) do
        if n == name then
            b.BackgroundColor3 = Th.CardSel
            b.TextColor3 = Th.Text
        else
            b.BackgroundColor3 = Th.Card
            b.TextColor3 = Th.Sub
        end
    end
end

local TabNames = {"Player", "Teleport", "Build", "Visual", "Misc"}
local TabKeys = {"tabPlayer", "tabTP", "tabBuild", "tabVisual", "tabMisc"}
local TabWidth = 0.2

for i, key in ipairs(TabNames) do
    local b = C("TextButton", {
        Text = T(TabKeys[i]),
        Size = UDim2.new(TabWidth, -2, 1, 0),
        Position = UDim2.new((i - 1) * TabWidth, 2, 0, 0),
        BackgroundColor3 = Th.Card,
        BorderSizePixel = 0, AutoButtonColor = false,
        TextColor3 = Th.Sub, Font = Enum.Font.GothamBold,
        TextSize = 9, Parent = TabBar,
    })
    C("UICorner", { CornerRadius = UDim.new(0, 6), Parent = b })
    b.MouseButton1Click:Connect(function()
        SelectTab(key)
    end)
    TabBtns[key] = b

    local f = C("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 500),
        ScrollBarThickness = 3,
        Visible = false, Parent = ContentArea,
    })
    Tabs[key] = f
end

-- UI部品
local function MK(parent, y, lbl, key, cb)
    local b = C("TextButton", {
        Text = "", Size = UDim2.new(1, -16, 0, 26),
        Position = UDim2.new(0, 8, 0, y),
        BackgroundColor3 = Th.Card, BackgroundTransparency = 0.1,
        BorderSizePixel = 0, AutoButtonColor = false, Parent = parent,
    })
    C("UICorner", { CornerRadius = UDim.new(0, 8), Parent = b })
    local st = C("UIStroke", {
        Color = Th.Off, Thickness = 1.2, Transparency = 0.4, Parent = b
    })
    C("TextLabel", {
        Text = lbl, Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        BackgroundTransparency = 1, TextColor3 = Th.Text,
        Font = Enum.Font.GothamMedium, TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = b,
    })
    local stt = C("TextLabel", {
        Text = "OFF", Size = UDim2.new(0, 35, 1, 0),
        Position = UDim2.new(1, -40, 0, 0),
        BackgroundTransparency = 1, TextColor3 = Th.Sub,
        Font = Enum.Font.GothamBold, TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Right, Parent = b,
    })
    b.MouseButton1Click:Connect(function()
        S[key] = not S[key]
        stt.Text = S[key] and "ON" or "OFF"
        stt.TextColor3 = S[key] and Th.On or Th.Sub
        TweenService:Create(b, TweenInfo.new(0.2), {
            BackgroundColor3 = S[key] and Color3.fromRGB(30, 60, 55) or Th.Card
        }):Play()
        if cb then
            local ok, err = pcall(cb, S[key])
            if not ok then warn("[Fireworks]", err) end
        end
    end)
end

local function AB(parent, y, lbl, cb)
    local b = C("TextButton", {
        Text = lbl, Size = UDim2.new(1, -16, 0, 26),
        Position = UDim2.new(0, 8, 0, y),
        BackgroundColor3 = Th.Card, BackgroundTransparency = 0.1,
        BorderSizePixel = 0, AutoButtonColor = false,
        TextColor3 = Th.Text, Font = Enum.Font.GothamBold,
        TextSize = 10, Parent = parent,
    })
    C("UICorner", { CornerRadius = UDim.new(0, 8), Parent = b })
    C("UIStroke", { Color = Th.A1, Thickness = 1, Transparency = 0.3, Parent = b })
    b.MouseButton1Click:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(60, 100, 120)
        }):Play()
        task.delay(0.15, function()
            TweenService:Create(b, TweenInfo.new(0.2), {
                BackgroundColor3 = Th.Card
            }):Play()
        end)
        if cb then
            local ok, err = pcall(cb)
            if not ok then warn("[Fireworks]", err) end
        end
    end)
end

local function MS(parent, y, lbl, mn, mx, df, key)
    local c = C("Frame", {
        Size = UDim2.new(1, -16, 0, 32),
        Position = UDim2.new(0, 8, 0, y),
        BackgroundColor3 = Th.Card, BackgroundTransparency = 0.1,
        BorderSizePixel = 0, Parent = parent,
    })
    C("UICorner", { CornerRadius = UDim.new(0, 8), Parent = c })
    C("UIStroke", { Color = Th.Off, Thickness = 1.2, Transparency = 0.4, Parent = c })
    local l = C("TextLabel", {
        Text = lbl .. ": " .. df, Size = UDim2.new(1, -16, 0, 12),
        Position = UDim2.new(0, 10, 0, 2), BackgroundTransparency = 1,
        TextColor3 = Th.Text, Font = Enum.Font.GothamMedium,
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
        BackgroundColor3 = Th.A1, BorderSizePixel = 0, Parent = tr,
    })
    C("UICorner", { CornerRadius = UDim.new(1, 0), Parent = fl })
    C("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Th.A1),
            ColorSequenceKeypoint.new(0.5, Th.A2),
            ColorSequenceKeypoint.new(1, Th.A3),
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

-- ============ Player タブ ============
local pTab = Tabs["tabPlayer"]
MK(pTab, 4, T("infJump"), "InfiniteJump")
MK(pTab, 34, T("esp"), "ESP", function(v)
    if v then
        for _, p in pairs(Players:GetPlayers()) do CE(p) end
    else
        for p, _ in pairs(EO) do RE(p) end
    end
end)
MK(pTab, 64, T("god"), "GodMode")
MK(pTab, 94, T("noclip"), "Noclip")
MK(pTab, 124, T("fly"), "Fly", function(v)
    local h = HUM()
    if h then h.PlatformStand = v end
    if not v then for k,_ in pairs(FlyDir) do FlyDir[k]=false end end
end)

C("TextLabel", {
    Text = T("speed"), Size = UDim2.new(1, -16, 0, 14),
    Position = UDim2.new(0, 8, 0, 158),
    BackgroundTransparency = 1, TextColor3 = Th.Sub,
    Font = Enum.Font.GothamBold, TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Left, Parent = pTab,
})
MS(pTab, 174, T("speed"), 1, 300, S.WalkSpeed, "WalkSpeed")
MS(pTab, 210, T("jump"), 1, 300, S.JumpPower, "JumpPower")
MS(pTab, 246, T("flySpeed"), 10, 300, S.FlySpeed, "FlySpeed")

-- ============ Teleport タブ ============
local tTab = Tabs["tabTP"]

local tpInfo = C("TextLabel", {
    Text = T("saved") .. ": " .. T("noSaved"),
    Size = UDim2.new(1, -16, 0, 14),
    Position = UDim2.new(0, 8, 0, 4),
    BackgroundTransparency = 1, TextColor3 = Th.Sub,
    Font = Enum.Font.Gotham, TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Left, Parent = tTab,
})

AB(tTab, 24, T("savePos"), function()
    local hrp = HRP()
    if hrp then
        SavedPos = hrp.CFrame
        tpInfo.Text = T("saved") .. ": " .. string.format("%.0f, %.0f, %.0f",
            hrp.Position.X, hrp.Position.Y, hrp.Position.Z)
        print("[Fireworks] " .. T("saveMsg"))
    end
end)
AB(tTab, 56, T("tpSaved"), function()
    if not SavedPos then warn(T("noSaved")) return end
    local hrp = HRP()
    if hrp then hrp.CFrame = SavedPos + Vector3.new(0, 3, 0) end
end)

C("TextLabel", {
    Text = T("selectPlayer"), Size = UDim2.new(1, -16, 0, 14),
    Position = UDim2.new(0, 8, 0, 92),
    BackgroundTransparency = 1, TextColor3 = Th.Sub,
    Font = Enum.Font.GothamBold, TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Left, Parent = tTab,
})

local PlayerList = C("ScrollingFrame", {
    Size = UDim2.new(1, -16, 0, 140),
    Position = UDim2.new(0, 8, 0, 110),
    BackgroundColor3 = Th.Card, BackgroundTransparency = 0.3,
    BorderSizePixel = 0, CanvasSize = UDim2.new(0,0,0,0),
    ScrollBarThickness = 3, Parent = tTab,
})
C("UICorner", { CornerRadius = UDim.new(0, 8), Parent = PlayerList })

local function RefreshPlayerList()
    for _, c in pairs(PlayerList:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    local list = Players:GetPlayers()
    local y = 0
    for _, p in ipairs(list) do
        if p ~= LP then
            local b = C("TextButton", {
                Text = p.Name, Size = UDim2.new(1, -4, 0, 22),
                Position = UDim2.new(0, 2, 0, y),
                BackgroundColor3 = Th.Card, BorderSizePixel = 0,
                AutoButtonColor = false, TextColor3 = Th.Text,
                Font = Enum.Font.Gotham, TextSize = 9,
                TextXAlignment = Enum.TextXAlignment.Left, Parent = PlayerList,
            })
            C("UICorner", { CornerRadius = UDim.new(0, 4), Parent = b })
            b.MouseButton1Click:Connect(function()
                SelectedPlayer = p
                for _, x in pairs(PlayerList:GetChildren()) do
                    if x:IsA("TextButton") then
                        x.BackgroundColor3 = Th.Card
                    end
                end
                b.BackgroundColor3 = Th.CardSel
            end)
            y = y + 24
        end
    end
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, y)
end

AB(tTab, 256, T("tpPlayer"), function()
    if not SelectedPlayer then return end
    local hrp = HRP()
    local target = SelectedPlayer.Character
    local thrp = target and target:FindFirstChild("HumanoidRootPart")
    if hrp and thrp then
        hrp.CFrame = thrp.CFrame + Vector3.new(0, 3, 0)
    end
end)

task.spawn(function()
    RefreshPlayerList()
    Players.PlayerAdded:Connect(function() task.wait(1) RefreshPlayerList() end)
    Players.PlayerRemoving:Connect(function() task.wait(0.5) RefreshPlayerList() end)
end)

-- ============ Build タブ ============
local bTab = Tabs["tabBuild"]

local function MakePart(pos, size, color, mat)
    local part = Instance.new("Part")
    part.Size = size
    part.Position = pos
    part.Anchored = true
    part.CanCollide = true
    part.CanTouch = true
    part.CanQuery = true
    part.Color = color or RC(1)
    part.Material = mat or Enum.Material.Neon
    part.Parent = Workspace
    return part
end

local function PlaceOne()
    local hrp = HRP()
    if not hrp then return end
    local cam = workspace.CurrentCamera
    MakePart(hrp.Position + cam.CFrame.LookVector * 10,
        Vector3.new(S.BuildSize, S.BuildSize, S.BuildSize))
end

local function BuildWall()
    local hrp = HRP()
    if not hrp then return end
    local cam = workspace.CurrentCamera
    local pos = hrp.Position + cam.CFrame.LookVector * 10 + Vector3.new(0, S.BuildSize * 1.5, 0)
    local part = MakePart(pos, Vector3.new(S.BuildSize * 4, S.BuildSize * 3, 1),
        Color3.fromRGB(120,120,140), Enum.Material.Concrete)
    part.CFrame = CFrame.new(pos, pos + cam.CFrame.LookVector)
end

local function BuildBox()
    local hrp = HRP()
    if not hrp then return end
    local cam = workspace.CurrentCamera
    local base = hrp.Position + cam.CFrame.LookVector * 15
    local size = S.BuildSize
    for i = 1, 4 do
        local angle = math.rad((i-1) * 90)
        local offset = Vector3.new(math.cos(angle), 0, math.sin(angle)) * size * 2
        local pos = base + offset + Vector3.new(0, size, 0)
        local wall = MakePart(pos, Vector3.new(size*4, size*2, 1),
            Color3.fromRGB(100,150,200))
        wall.CFrame = CFrame.new(pos, pos + Vector3.new(-offset.X, 0, -offset.Z))
    end
end

local function BuildCastle()
