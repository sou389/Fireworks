--// Fireworks v6.0 - Modern Design
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

local FlyDir = { Forward = false, Back = false, Left = false, Right = false, Up = false, Down = false }

local Theme = {
    Bg = Color3.fromRGB(15, 15, 25),
    Card = Color3.fromRGB(24, 24, 38),
    Card2 = Color3.fromRGB(32, 32, 52),
    Text = Color3.fromRGB(245, 245, 255),
    Sub = Color3.fromRGB(140, 140, 180),
    Accent1 = Color3.fromRGB(140, 90, 255),
    Accent2 = Color3.fromRGB(80, 200, 255),
    Accent3 = Color3.fromRGB(255, 90, 180),
    On = Color3.fromRGB(80, 220, 140),
    Off = Color3.fromRGB(60, 60, 90),
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

local TopBtn = Create("TextButton", {
    Text = "",
    Size = UDim2.new(0, 120, 0, 32),
    Position = UDim2.new(0.5, -60, 0, 8),
    BackgroundColor3 = Theme.Card,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Parent = ScreenGui,
})
Create("UICorner", { CornerRadius = UDim.new(0, 16), Parent = TopBtn })
local TopStroke = Create("UIStroke", {
    Color = Theme.Accent1, Thickness = 2, Parent = TopBtn
})
Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.Accent1),
        ColorSequenceKeypoint.new(0.5, Theme.Accent2),
        ColorSequenceKeypoint.new(1, Theme.Accent3),
    }),
    Rotation = 0,
    Parent = TopStroke,
})

local TopLabel = Create("TextLabel", {
    Text = "Fireworks",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    Parent = TopBtn,
})
Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.Accent2),
        ColorSequenceKeypoint.new(0.5, Theme.Text),
        ColorSequenceKeypoint.new(1, Theme.Accent3),
    }),
    Parent = TopLabel,
})

local Main = Create("Frame", {
    Size = UDim2.new(0, 200, 0, 480),
    Position = UDim2.new(0.5, -100, 0.5, -240),
    BackgroundColor3 = Theme.Bg,
    BackgroundTransparency = 0.05,
    BorderSizePixel = 0,
    Visible = false,
    Parent = ScreenGui,
})
Create("UICorner", { CornerRadius = UDim.new(0, 16), Parent = Main })
local MainStroke = Create("UIStroke", { Color = Theme.Accent1, Thickness = 2, Parent = Main })
Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.Accent1),
        ColorSequenceKeypoint.new(0.5, Theme.Accent2),
        ColorSequenceKeypoint.new(1, Theme.Accent3),
    }),
    Rotation = 45,
    Parent = MainStroke,
})

local BgGrad = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 60),
    BackgroundColor3 = Theme.Card,
    BackgroundTransparency = 0.3,
    BorderSizePixel = 0,
    Parent = Main,
})
Create("UICorner", { CornerRadius = UDim.new(0, 16), Parent = BgGrad })

TopBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

local Header = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Parent = Main,
})

local HeaderTitle = Create("TextLabel", {
    Text = "Fireworks",
    Size = UDim2.new(1, -60, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Header,
})
Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.Accent1),
        ColorSequenceKeypoint.new(0.5, Theme.Accent2),
        ColorSequenceKeypoint.new(1, Theme.Accent3),
    }),
    Parent = HeaderTitle,
})

local CloseBtn = Create("TextButton", {
    Text = "×",
    Size = UDim2.new(0, 28, 0, 28),
    Position = UDim2.new(1, -36, 0.5, -14),
    BackgroundColor3 = Color3.fromRGB(60, 30, 45),
    BorderSizePixel = 0,
    AutoButtonColor = false,
    TextColor3 = Color3.fromRGB(255, 180, 200),
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    Parent = Header,
})
Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = CloseBtn })

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)
CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(200, 50, 70),
    }):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(60, 30, 45),
    }):Play()
end)

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
        Text = "",
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, y),
        BackgroundColor3 = Theme.Card,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Parent = Main,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = btn })
    local st = Create("UIStroke", {
        Color = Theme.Off, Thickness = 1.5, Transparency = 0.4, Parent = btn
    })

    local bar = Create("Frame", {
        Size = UDim2.new(0, 3, 0.6, 0),
        Position = UDim2.new(0, 6, 0.2, 0),
        BackgroundColor3 = Theme.Accent1,
        BorderSizePixel = 0,
        Parent = btn,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = bar })
    Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent1),
            ColorSequenceKeypoint.new(1, Theme.Accent2),
        }),
        Rotation = 90,
        Parent = bar,
    })

    Create("TextLabel", {
        Text = label,
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = btn,
    })

    local status = Create("TextLabel", {
        Text = "OFF",
        Size = UDim2.new(0, 40, 1, 0),
        Position = UDim2.new(1, -46, 0, 0),
        BackgroundTransparency = 1,
        TextColor3 = Theme.Sub,
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = btn,
    })

    local dot = Create("Frame", {
        Size = UDim2.new(0, 8, 0, 8),
        Position = UDim2.new(1, -12, 0.5, -4),
        BackgroundColor3 = Theme.Off,
        BorderSizePixel = 0,
        Parent = btn,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = dot })

    btn.MouseButton1Click:Connect(function()
        State[key] = not State[key]
        if State[key] then
            status.Text = "ON"
            status.TextColor3 = Theme.On
            dot.BackgroundColor3 = Theme.On
            TweenService:Create(btn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(30, 60, 55)
            }):Play()
            TweenService:Create(st, TweenInfo.new(0.2), {
                Color = Theme.On, Transparency = 0
            }):Play()
        else
            status.Text = "OFF"
            status.TextColor3 = Theme.Sub
            dot.BackgroundColor3 = Theme.Off
            TweenService:Create(btn, TweenInfo.new(0.2), {
                BackgroundColor3 = Theme.Card
            }):Play()
            TweenService:Create(st, TweenInfo.new(0.2), {
                Color = Theme.Off, Transparency = 0.4
            }):Play()
        end
        if callback then
            local ok, err = pcall(callback, State[key])
            if not ok then warn("[Fireworks]", err) end
        end
    end)
end

local function MakeSlider(y, label, min, max, default, key)
    local c = Create("Frame", {
        Size = UDim2.new(1, -20, 0, 38),
        Position = UDim2.new(0, 10, 0, y),
        BackgroundColor3 = Theme.Card,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        Parent = Main,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = c })
    Create("UIStroke", { Color = Theme.Off, Thickness = 1.5, Transparency = 0.4, Parent = c })

    local lbl = Create("TextLabel", {
        Text = label .. ": " .. default,
        Size = UDim2.new(1, -20, 0, 14),
        Position = UDim2.new(0, 12, 0, 3),
        BackgroundTransparency = 1,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = c,
    })

    local track = Create("Frame", {
        Size = UDim2.new(1, -24, 0, 4),
        Position = UDim2.new(0, 12, 0, 26),
        BackgroundColor3 = Color3.fromRGB(20, 20, 32),
        BorderSizePixel = 0,
        Parent = c,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = track })

    local fill = Create("Frame", {
        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = Theme.Accent1,
        BorderSizePixel = 0,
        Parent = track,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = fill })
    Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent1),
            ColorSequenceKeypoint.new(0.5, Theme.Accent2),
            ColorSequenceKeypoint.new(1, Theme.Accent3),
        }),
        Parent = fill,
    })

    local knob = Create("Frame", {
        Size = UDim2.new(0, 12, 0, 12),
        Position = UDim2.new((default - min) / (max - min), -6, 0.5, -6),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Parent = track,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = knob })
    Create("UIStroke", { Color = Theme.Accent1, Thickness = 2, Parent = knob })

    local drag = false
    local function update(input)
        local rel = math.clamp(
            (input.Position.X - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
        local v = math.floor(min + (max - min) * rel)
        fill.Size = UDim2.new(rel, 0, 1, 0)
        knob.Position = UDim2.new(rel, -6, 0.5, -6)
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

local FlyPad = Create("Frame", {
    Size = UDim2.new(0, 200, 0, 200),
    Position = UDim2.new(1, -210, 0.5, -100),
    BackgroundColor3 = Theme.Bg,
    BackgroundTransparency = 0.15,
    BorderSizePixel = 0,
    Visible = false,
    Parent = ScreenGui,
})
Create("UICorner", { CornerRadius = UDim.new(0, 16), Parent = FlyPad })
local FlyStroke = Create("UIStroke", { Color = Theme.Accent1, Thickness = 2, Parent = FlyPad })
Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.Accent1),
        ColorSequenceKeypoint.new(0.5, Theme.Accent2),
        ColorSequenceKeypoint.new(1, Theme.Accent3),
    }),
    Rotation = 45,
    Parent = FlyStroke,
})

local function MakeFlyBtn(text, pos, dir)
    local b = Create("TextButton", {
        Text = text, Size = UDim2.new(0, 55, 0, 55),
        Position = pos,
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold, TextSize = 22,
        Parent = FlyPad,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 12), Parent = b })
    Create("UIStroke", { Color = Theme.Accent1, Thickness = 1.5, Transparency = 0.3, Parent = b })

    b.MouseButton1Down:Connect(function()
        FlyDir[dir] = true
        b.BackgroundColor3 = Color3.fromRGB(60, 120, 100)
        TweenService:Create(b, TweenInfo.new(0.1), {
            TextColor3 = Color3.fromRGB(150, 255, 200),
        }):Play()
    end)
    b.MouseButton1Up:Connect(function()
        FlyDir[dir] = false
        b.BackgroundColor3 = Theme.Card
        TweenService:Create(b, TweenInfo.new(0.1), {
            TextColor3 = Theme.Text,
        }):Play()
    end)
    b.MouseLeave:Connect(function()
        FlyDir[dir] = false
        b.BackgroundColor3 = Theme.Card
        b.TextColor3 = Theme.Text
    end)
end

MakeFlyBtn("↑", UDim2.new(0.5, -27, 0, 10), "Forward")
MakeFlyBtn("↓", UDim2.new(0.5, -27, 1, -65), "Back")
MakeFlyBtn("←", UDim2.new(0, 10, 0.5, -27), "Left")
MakeFlyBtn("→", UDim2.new(1, -65, 0.5, -27), "Right")
MakeFlyBtn("U", UDim2.new(1, -65, 0, 10), "Up")
MakeFlyBtn("D", UDim2.new(0, 10, 1, -65), "Down")

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
    local st = Create("UIStroke", { Color = RainbowColor(1.5), Thickness = 2, Parent = box })

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

task.spawn(function()
    while task.wait(0.02) do
        if State.Fly then
            local hrp = GetHRP()
            local cam = workspace.CurrentCamera
            if hrp and cam then
                local move = Vector3.zero
                local speed = State.FlySpeed / 30

                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.Ri
