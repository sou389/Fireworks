local p = game.Players.LocalPlayer
local pg = p:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

if pg:FindFirstChild("VoidUI") then pg.VoidUI:Destroy() end

local sg = Instance.new("ScreenGui")
sg.Name = "VoidUI"
sg.ResetOnSpawn = false
sg.Parent = pg

local accentColor = Color3.fromRGB(0, 170, 255) -- 画像の水色
local bgColor = Color3.fromRGB(25, 25, 30)

-- メインフレーム
local f = Instance.new("Frame")
f.Size = UDim2.new(0, 600, 0, 380)
f.Position = UDim2.new(0.5, -300, 0.5, -190)
f.BackgroundColor3 = bgColor
f.BackgroundTransparency = 0.15
f.BorderSizePixel = 0
f.Active = true
f.Parent = sg
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", f)
stroke.Color = accentColor
stroke.Thickness = 1
stroke.Transparency = 0.5

-- 最小化ボタン（V）
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 45, 0, 45)
floatBtn.Position = UDim2.new(0, 15, 0.5, -22.5)
floatBtn.BackgroundColor3 = bgColor
floatBtn.Text = "V"
floatBtn.TextColor3 = accentColor
floatBtn.Font = Enum.Font.GothamBold
floatBtn.TextSize = 22
floatBtn.Visible = false
floatBtn.BorderSizePixel = 0
floatBtn.Parent = sg
Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(0, 12)
local fs = Instance.new("UIStroke", floatBtn)
fs.Color = accentColor
floatBtn.MouseButton1Click:Connect(function()
    f.Visible = true
    floatBtn.Visible = false
end)

-- ドラッグ移動（トップバー全体で反応）
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    f.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
f.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = f.Position
    end
end)
f.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- トップバー
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.BackgroundTransparency = 1
topBar.Parent = f

-- ロゴとタイトル
local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(0, 30, 0, 30)
logo.Position = UDim2.new(0, 15, 0, 10)
logo.BackgroundColor3 = accentColor
logo.Text = "V"
logo.TextColor3 = Color3.fromRGB(0, 0, 0)
logo.Font = Enum.Font.GothamBold
logo.TextSize = 18
logo.BorderSizePixel = 0
logo.Parent = topBar
Instance.new("UICorner", logo).CornerRadius = UDim.new(0, 6)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 0, 20)
title.Position = UDim2.new(0, 55, 0, 8)
title.BackgroundTransparency = 1
title.Text = "Void"
title.TextColor3 = accentColor
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local discord = Instance.new("TextButton")
discord.Size = UDim2.new(0, 200, 0, 15)
discord.Position = UDim2.new(0, 55, 0, 28)
discord.BackgroundTransparency = 1
discord.Text = "discord.gg/Znj8eBfa9"
discord.TextColor3 = Color3.fromRGB(150, 150, 150)
discord.Font = Enum.Font.Gotham
discord.TextSize = 11
discord.TextXAlignment = Enum.TextXAlignment.Left
discord.Parent = topBar
discord.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard("https://discord.gg/Znj8eBfa9") end
end)

-- 右上のボタン群
local lb = Instance.new("TextButton")
lb.Size = UDim2.new(0, 85, 0, 25)
lb.Position = UDim2.new(1, -180, 0, 12)
lb.Text = "🇯🇵 日本語"
lb.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
lb.TextColor3 = Color3.fromRGB(255, 255, 255)
lb.Font = Enum.Font.Gotham
lb.TextSize = 11
lb.BorderSizePixel = 0
lb.Parent = topBar
Instance.new("UICorner", lb).CornerRadius = UDim.new(0, 6)

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 25, 0, 25)
minBtn.Position = UDim2.new(1, -85, 0, 12)
minBtn.Text = "-"
minBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
minBtn.Parent = topBar
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -45, 0, 12)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
close.TextColor3 = Color3.fromRGB(255, 80, 80)
close.Font = Enum.Font.GothamBold
close.BorderSizePixel = 0
close.Parent = topBar
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)

close.MouseButton1Click:Connect(function()
    f.Visible = false
    floatBtn.Visible = true
end)
minBtn.MouseButton1Click:Connect(function()
    f.Visible = false
    floatBtn.Visible = true
end)
-- 翻訳データ
local lang = "ja"
local trans = {
    ja = {player="プレイヤー", tools="ツール", target="ターゲット", other="その他", teleport="デレポート", speed="歩行速度", jump="ジャンプ力", noclip="壁抜け", inf_jump="無限ジャンプ", god="無敵", respawn="リスタート（死亡）", spin="スピン", tp="テレポート", dev="開発中", save="場所を保存", update="更新"},
    en = {player="Player", tools="Tools", target="Target", other="Other", teleport="Teleport", speed="Walk Speed", jump="Jump Power", noclip="Noclip", inf_jump="Infinite Jump", god="Godmode", respawn="Respawn", spin="Spin", tp="Teleport", dev="Development", save="Save Location", update="Update"}
}
local tabKeys = {"player", "tools", "target", "other", "teleport"}

-- サイドバー
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 160, 1, -70)
sidebar.Position = UDim2.new(0, 5, 0, 55)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
sidebar.BackgroundTransparency = 0.3
sidebar.BorderSizePixel = 0
sidebar.Parent = f
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

-- プロフィール（左下）
local profile = Instance.new("Frame")
profile.Size = UDim2.new(0, 160, 0, 55)
profile.Position = UDim2.new(0, 5, 1, -65)
profile.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
profile.BackgroundTransparency = 0.3
profile.BorderSizePixel = 0
profile.Parent = f
Instance.new("UICorner", profile).CornerRadius = UDim.new(0, 10)

local pImg = Instance.new("ImageLabel")
pImg.Size = UDim2.new(0, 35, 0, 35)
pImg.Position = UDim2.new(0, 10, 0, 10)
pImg.BackgroundColor3 = accentColor
pImg.Text = ""
pImg.BorderSizePixel = 0
pImg.Parent = profile
Instance.new("UICorner", pImg).CornerRadius = UDim.new(0, 17)
pcall(function()
    pImg.Image = game:GetService("Players"):GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
end)

local pName = Instance.new("TextLabel")
pName.Size = UDim2.new(1, -55, 0, 15)
pName.Position = UDim2.new(0, 50, 0, 14)
pName.BackgroundTransparency = 1
pName.Text = p.DisplayName
pName.TextColor3 = Color3.fromRGB(255, 255, 255)
pName.Font = Enum.Font.GothamBold
pName.TextSize = 11
pName.TextXAlignment = Enum.TextXAlignment.Left
pName.Parent = profile

local pHandle = Instance.new("TextLabel")
pHandle.Size = UDim2.new(1, -55, 0, 15)
pHandle.Position = UDim2.new(0, 50, 0, 29)
pHandle.BackgroundTransparency = 1
pHandle.Text = "@" .. p.Name
pHandle.TextColor3 = Color3.fromRGB(140, 140, 140)
pHandle.Font = Enum.Font.Gotham
pHandle.TextSize = 9
pHandle.TextXAlignment = Enum.TextXAlignment.Left
pHandle.Parent = profile

-- コンテンツエリア
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -180, 1, -70)
content.Position = UDim2.new(0, 170, 0, 55)
content.BackgroundTransparency = 1
content.Parent = f

local pages = {}
local tabBtns = {}

for i = 1, 5 do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 40)
    b.Position = UDim2.new(0, 5, 0, 5 + (i - 1) * 45)
    b.Text = "  " .. trans[lang][tabKeys[i]]
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    b.TextColor3 = Color3.fromRGB(180, 180, 180)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.AutoButtonColor = false
    b.BorderSizePixel = 0
    b.Parent = sidebar
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    
    local ind = Instance.new("Frame")
    ind.Size = UDim2.new(0, 3, 0.6, 0)
    ind.Position = UDim2.new(0, 4, 0.2, 0)
    ind.BackgroundColor3 = accentColor
    ind.Visible = (i == 1)
    ind.BorderSizePixel = 0
    ind.Parent = b
    Instance.new("UICorner", ind).CornerRadius = UDim.new(0, 2)
    
    tabBtns[i] = {btn = b, ind = ind}

    local pp = Instance.new("ScrollingFrame")
    pp.Size = UDim2.new(1, 0, 1, 0)
    pp.BackgroundTransparency = 1
    pp.BorderSizePixel = 0
    pp.ScrollBarThickness = 4
    pp.ScrollBarImageColor3 = accentColor
    pp.CanvasSize = UDim2.new(0, 0, 0, 0)
    pp.AutomaticCanvasSize = Enum.AutomaticSize.Y
    pp.Visible = (i == 1)
    pp.Parent = content
    local lay = Instance.new("UIListLayout", pp)
    lay.Padding = UDim.new(0, 8)
    pages[i] = pp

    b.MouseButton1Click:Connect(function()
        for j = 1, 5 do
            pages[j].Visible = (j == i)
            tabBtns[j].btn.TextColor3 = Color3.fromRGB(180, 180, 180)
            tabBtns[j].btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
            tabBtns[j].ind.Visible = false
        end
        pages[i].Visible = true
        b.TextColor3 = accentColor
        b.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
        ind.Visible = true
    end)
end
tabBtns[1].btn.TextColor3 = accentColor
tabBtns[1].btn.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
-- トグルスイッチ生成関数（画像のデザインを完全再現）
local function createToggle(parent, txtKey, default, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 15, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = trans[lang][txtKey]
    lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = btn
    lbl:SetAttribute("TKey", txtKey)

    local sw = Instance.new("Frame")
    sw.Size = UDim2.new(0, 45, 0, 22)
    sw.Position = UDim2.new(1, -60, 0.5, -11)
    sw.BackgroundColor3 = default and accentColor or Color3.fromRGB(70, 70, 78)
    sw.BorderSizePixel = 0
    sw.Parent = btn
    Instance.new("UICorner", sw).CornerRadius = UDim.new(0, 11)
    
    local kn = Instance.new("Frame")
    kn.Size = UDim2.new(0, 18, 0, 18)
    kn.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    kn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    kn.BorderSizePixel = 0
    kn.Parent = sw
    Instance.new("UICorner", kn).CornerRadius = UDim.new(0, 9)
    
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        sw.BackgroundColor3 = state and accentColor or Color3.fromRGB(70, 70, 78)
        kn.Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        cb(state)
    end)
end

-- プレイヤータブ
local pPage = pages[1]

-- 歩行速度
local speedFrame = Instance.new("Frame")
speedFrame.Size = UDim2.new(1, 0, 0, 55)
speedFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
speedFrame.BorderSizePixel = 0
speedFrame.Parent = pPage
Instance.new("UICorner", speedFrame).CornerRadius = UDim.new(0, 8)
local sLbl = Instance.new("TextLabel", speedFrame)
sLbl.Size = UDim2.new(0.5, 0, 0, 20)
sLbl.Position = UDim2.new(0, 15, 0, 5)
sLbl.BackgroundTransparency = 1
sLbl.Text = trans[lang]["speed"]
sLbl.TextColor3 = Color3.fromRGB(230, 230, 230)
sLbl.Font = Enum.Font.GothamBold
sLbl.TextSize = 13
sLbl.TextXAlignment = Enum.TextXAlignment.Left
sLbl:SetAttribute("TKey", "speed")
local sVal = Instance.new("TextLabel", speedFrame)
sVal.Size = UDim2.new(0, 50, 0, 20)
sVal.Position = UDim2.new(1, -60, 0, 5)
sVal.BackgroundTransparency = 1
sVal.Text = "16"
sVal.TextColor3 = accentColor
sVal.Font = Enum.Font.GothamBold
sVal.TextSize = 13
sVal.Parent = speedFrame

local sBarBg = Instance.new("Frame", speedFrame)
sBarBg.Size = UDim2.new(1, -30, 0, 8)
sBarBg.Position = UDim2.new(0, 15, 1, -18)
sBarBg.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
sBarBg.BorderSizePixel = 0
Instance.new("UICorner", sBarBg).CornerRadius = UDim.new(0, 4)
local sFill = Instance.new("Frame", sBarBg)
sFill.Size = UDim2.new(16/200, 0, 1, 0)
sFill.BackgroundColor3 = accentColor
sFill.BorderSizePixel = 0
Instance.new("UICorner", sFill).CornerRadius = UDim.new(0, 4)
local sKnob = Instance.new("TextButton", sBarBg)
sKnob.Size = UDim2.new(0, 18, 0, 18)
sKnob.Position = UDim2.new(16/200, -9, 0.5, -9)
sKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sKnob.Text = ""
sKnob.BorderSizePixel = 0
Instance.new("UICorner", sKnob).CornerRadius = UDim.new(0, 9)

local sDrag = false
local function sUpdate(i)
    local rx = math.clamp((i.Position.X - sBarBg.AbsolutePosition.X) / sBarBg.AbsoluteSize.X, 0, 1)
    local v = math.floor(0 + 200 * rx)
    sVal.Text = tostring(v)
    sFill.Size = UDim2.new(rx, 0, 1, 0)
    sKnob.Position = UDim2.new(rx, -9, 0.5, -9)
    if p.Character and p.Character:FindFirstChild("Humanoid") then
        p.Character.Humanoid.WalkSpeed = v
    end
end
sKnob.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then sDrag = true sUpdate(i) end end)
sBarBg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then sDrag = true sUpdate(i) end end)
UIS.InputChanged:Connect(function(i) if sDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then sUpdate(i) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then sDrag = false end end)

-- ジャンプ力
local jumpFrame = Instance.new("Frame")
jumpFrame.Size = UDim2.new(1, 0, 0, 55)
jumpFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
jumpFrame.BorderSizePixel = 0
jumpFrame.Parent = pPage
Instance.new("UICorner", jumpFrame).CornerRadius = UDim.new(0, 8)
local jLbl = Instance.new("TextLabel", jumpFrame)
jLbl.Size = UDim2.new(0.5, 0, 0, 20)
jLbl.Position = UDim2.new(0, 15, 0, 5)
jLbl.BackgroundTransparency = 1
jLbl.Text = trans[lang]["jump"]
jLbl.TextColor3 = Color3.fromRGB(230, 230, 230)
jLbl.Font = Enum.Font.GothamBold
jLbl.TextSize = 13
jLbl.TextXAlignment = Enum.TextXAlignment.Left
jLbl:SetAttribute("TKey", "jump")
local jVal = Instance.new("TextLabel", jumpFrame)
jVal.Size = UDim2.new(0, 50, 0, 20)
jVal.Position = UDim2.new(1, -60, 0, 5)
jVal.BackgroundTransparency = 1
jVal.Text = "50"
jVal.TextColor3 = accentColor
jVal.Font = Enum.Font.GothamBold
jVal.TextSize = 13
jVal.Parent = jumpFrame

local jBarBg = Instance.new("Frame", jumpFrame)
jBarBg.Size = UDim2.new(1, -30, 0, 8)
jBarBg.Position = UDim2.new(0, 15, 1, -18)
jBarBg.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
jBarBg.BorderSizePixel = 0
Instance.new("UICorner", jBarBg).CornerRadius = UDim.new(0, 4)
local jFill = Instance.new("Frame", jBarBg)
jFill.Size = UDim2.new(50/500, 0, 1, 0)
jFill.BackgroundColor3 = accentColor
jFill.BorderSizePixel = 0
Instance.new("UICorner", jFill).CornerRadius = UDim.new(0, 4)
local jKnob = Instance.new("TextButton", jBarBg)
jKnob.Size = UDim2.new(0, 18, 0, 18)
jKnob.Position = UDim2.new(50/500, -9, 0.5, -9)
jKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
jKnob.Text = ""
jKnob.BorderSizePixel = 0
Instance.new("UICorner", jKnob).CornerRadius = UDim.new(0, 9)

local jDrag = false
local function jUpdate(i)
    local rx = math.clamp((i.Position.X - jBarBg.AbsolutePosition.X) / jBarBg.AbsoluteSize.X, 0, 1)
    local v = math.floor(0 + 500 * rx)
    jVal.Text = tostring(v)
    jFill.Size = UDim2.new(rx, 0, 1, 0)
    jKnob.Position = UDim2.new(rx, -9, 0.5, -9)
    if p.Character and p.Character:FindFirstChild("Humanoid") then
        p.Character.Humanoid.UseJumpPower = true
        p.Character.Humanoid.JumpPower = v
    end
end
jKnob.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then jDrag = true jUpdate(i) end end)
jBarBg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then jDrag = true jUpdate(i) end end)
UIS.InputChanged:Connect(function(i) if jDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then jUpdate(i) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then jDrag = false end end)

-- 機能トグル（画像の通り、テキスト＋スイッチ）
createToggle(pPage, "noclip", false, function(s)
    if s then
        local cn
        cn = RS.Stepped:Connect(function()
            local c = p.Character
            if not c then cn:Disconnect() return end
            for _, v in ipairs(c:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end)
    else
        local c = p.Character
        if c then
            for _, v in ipairs(c:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = true end
            end
        end
    end
end)

createToggle(pPage, "inf_jump", false, function(s)
    if s then
        local cn
        cn = UIS.JumpRequest:Connect(function()
            local c = p.Character
            if not c then return end
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    end
end)

createToggle(pPage, "god", false, function(s)
    if s then
        local cn
        cn = RS.Heartbeat:Connect(function()
            local c = p.Character
            if not c then cn:Disconnect() return end
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.Health = h.MaxHealth end
        end)
    end
end)

createToggle(pPage, "respawn", false, function(s)
    if s and p.Character then
        local h = p.Character:FindFirstChildOfClass("Humanoid")
        if h then h.Health = 0 end
    end
end)

-- ツールタブ（アコーディオンやその他の機能）
local tPage = pages[2]
local spinRow = Instance.new("Frame", tPage)
spinRow.Size = UDim2.new(1, 0, 0, 50)
spinRow.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
spinRow.BorderSizePixel = 0
Instance.new("UICorner", spinRow).CornerRadius = UDim.new(0, 8)
local spinLbl = Instance.new("TextLabel", spinRow)
spinLbl.Size = UDim2.new(0.5, 0, 1, 0)
spinLbl.Position = UDim2.new(0, 15, 0, 0)
spinLbl.BackgroundTransparency = 1
spinLbl.Text = trans[lang]["spin"]
spinLbl.TextColor3 = Color3.fromRGB(230, 230, 230)
spinLbl.Font = Enum.Font.GothamBold
spinLbl.TextSize = 13
spinLbl.TextXAlignment = Enum.TextXAlignment.Left
spinLbl:SetAttribute("TKey", "spin")
local spinBox = Instance.new("TextBox", spinRow)
spinBox.Size = UDim2.new(0.25, 0, 0, 30)
spinBox.Position = UDim2.new(0.5, 0, 0.5, -15)
spinBox.Text = "5"
spinBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
spinBox.TextColor3 = accentColor
spinBox.Font = Enum.Font.GothamBold
spinBox.TextSize = 13
spinBox.ClearTextOnFocus = false
spinBox.BorderSizePixel = 0
Instance.new("UICorner", spinBox).CornerRadius = UDim.new(0, 6)
local spinBtn = Instance.new("TextButton", spinRow)
spinBtn.Size = UDim2.new(0.2, 0, 0, 30)
spinBtn.Position = UDim2.new(0.78, 0, 0.5, -15)
spinBtn.Text = "実行"
spinBtn.BackgroundColor3 = accentColor
spinBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
spinBtn.Font = Enum.Font.GothamBold
spinBtn.TextSize = 12
spinBtn.BorderSizePixel = 0
Instance.new("UICorner", spinBtn).CornerRadius = UDim.new(0, 6)
spinBtn.MouseButton1Click:Connect(function()
    local spd = tonumber(spinBox.Text) or 5
    local conn
    conn = RS.Heartbeat:Connect(function(dt)
        local c = p.Character
        if not c then conn:Disconnect() return end
        local h = c:FindFirstChild("HumanoidRootPart")
        if not h then return end
        h.CFrame = h.CFrame * CFrame.Angles(0, math.rad(spd * dt * 60), 0)
    end)
end)

-- 他のタブ（ターゲット、その他、デレポート）
local tgtPage = pages[3]
local tpFrame = Instance.new("Frame", tgtPage)
tpFrame.Size = UDim2.new(1, 0, 0, 150)
tpFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
tpFrame.BorderSizePixel = 0
Instance.new("UICorner", tpFrame).CornerRadius = UDim.new(0, 8)
local tpLay = Instance.new("UIListLayout", tpFrame)
tpLay.Padding = UDim.new(0, 4)
local tpPad = Instance.new("UIPadding", tpFrame)
tpPad.PaddingLeft = UDim.new(0, 5)
tpPad.PaddingTop = UDim.new(0, 5)

local function updateTargets()
    for _, v in ipairs(tpFrame:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    for _, pl in ipairs(game.Players:GetPlayers()) do
        if pl ~= p then
            local b = Instance.new("TextButton", tpFrame)
            b.Size = UDim2.new(1, -10, 0, 30)
            b.Text = pl.Name
            b.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
            b.TextColor3 = Color3.fromRGB(230, 230, 230)
            b.Font = Enum.Font.GothamBold
            b.TextSize = 12
            b.AutoButtonColor = false
            b.BorderSizePixel = 0
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
            b.MouseButton1Click:Connect(function()
                if pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character.HumanoidRootPart.CFrame = pl.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                end
            end)
        end
    end
end
updateTargets()
game.Players.PlayerAdded:Connect(updateTargets)
game.Players.PlayerRemoving:Connect(updateTargets)

local oPage = pages[4]
local devLbl = Instance.new("TextLabel", oPage)
devLbl.Size = UDim2.new(1, 0, 0, 100)
devLbl.BackgroundTransparency = 1
devLbl.Text = trans[lang]["dev"]
devLbl.TextColor3 = Color3.fromRGB(150, 150, 150)
devLbl.Font = Enum.Font.GothamBold
devLbl.TextSize = 24
devLbl:SetAttribute("TKey", "dev")

-- デレポートタブ
local dPage = pages[5]
local rf = Instance.new("TextButton", dPage)
rf.Size = UDim2.new(1, 0, 0, 35)
rf.Text = trans[lang]["update"]
rf.BackgroundColor3 = accentColor
rf.TextColor3 = Color3.fromRGB(0, 0, 0)
rf.Font = Enum.Font.GothamBold
rf.TextSize = 13
rf.AutoButtonColor = false
rf.BorderSizePixel = 0
rf:SetAttribute("TKey", "update")
Instance.new("UICorner", rf).CornerRadius = UDim.new(0, 6)
local df = Instance.new("Frame", dPage)
df.Size = UDim2.new(1, 0, 1, -45)
df.Position = UDim2.new(0, 0, 0, 45)
df.BackgroundTransparency = 1
local dfLay = Instance.new("UIListLayout", df)
dfLay.Padding = UDim.new(0, 4)
local function upd()
    for _, v in ipairs(df:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    for _, pl in ipairs(game.Players:GetPlayers()) do
        if pl ~= p then
            local b = Instance.new("TextButton", df)
            b.Size = UDim2.new(1, 0, 0, 35)
            b.Text = pl.Name
            b.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
            b.TextColor3 = Color3.fromRGB(230, 230, 230)
            b.Font = Enum.Font.GothamBold
            b.TextSize = 12
            b.AutoButtonColor = false
            b.BorderSizePixel = 0
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
            b.MouseButton1Click:Connect(function()
                if pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character.HumanoidRootPart.CFrame = pl.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                end
            end)
        end
    end
end
rf.MouseButton1Click:Connect(upd)
upd()

-- 言語切り替えロジック
local function updateLanguage()
    for _, obj in ipairs(f:GetDescendants()) do
        local tkey = obj:GetAttribute("TKey")
        if tkey and trans[lang][tkey] then
            obj.Text = trans[lang][tkey]
        end
        local pkey = obj:GetAttribute("PKey")
        if pkey and trans[lang][pkey] then
            obj.PlaceholderText = trans[lang][pkey]
        end
    end
    for i = 1, 5 do
        tabBtns[i].btn.Text = "  " .. trans[lang][tabKeys[i]]
    end
    lb.Text = lang == "ja" and "🇯🇵 日本語" or "🇺🇸 English"
    sLbl.Text = trans[lang]["speed"]
    jLbl.Text = trans[lang]["jump"]
    spinLbl.Text = trans[lang]["spin"]
    spinBtn.Text = lang == "ja" and "実行" or "Run"
    devLbl.Text = trans[lang]["dev"]
    rf.Text = trans[lang]["update"]
end

lb.MouseButton1Click:Connect(function()
    lang = lang == "ja" and "en" or "ja"
    updateLanguage()
end)

-- リスポーン時の処理
p.CharacterAdded:Connect(function(ch)
    task.wait(1)
    local h = ch:FindFirstChildOfClass("Humanoid")
    if h then
        h.WalkSpeed = 16
        h.UseJumpPower = true
        h.JumpPower = 50
    end
end)
