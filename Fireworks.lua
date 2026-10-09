local p=game.Players.LocalPlayer
local pg=p:WaitForChild("PlayerGui")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
if pg:FindFirstChild("VoidUI")then pg.VoidUI:Destroy()end

local sg=Instance.new("ScreenGui")
sg.Name="VoidUI"
sg.ResetOnSpawn=false
sg.Parent=pg

local f=Instance.new("Frame")
f.Size=UDim2.new(0,560,0,400)
f.Position=UDim2.new(0.5,-280,0.5,-200)
f.BackgroundColor3=Color3.fromRGB(30,30,35)
f.BackgroundTransparency=0.05
f.BorderSizePixel=0
f.Active=true
f.Parent=sg
Instance.new("UICorner",f).CornerRadius=UDim.new(0,12)
local fStroke=Instance.new("UIStroke",f)
fStroke.Color=Color3.fromRGB(0,255,150)
fStroke.Thickness=1.5

-- Vボタン（閉じた後）
local floatBtn=Instance.new("TextButton")
floatBtn.Size=UDim2.new(0,45,0,45)
floatBtn.Position=UDim2.new(0,15,0.5,-22.5)
floatBtn.BackgroundColor3=Color3.fromRGB(30,30,35)
floatBtn.Text="V"
floatBtn.TextColor3=Color3.fromRGB(0,255,150)
floatBtn.Font=Enum.Font.GothamBold
floatBtn.TextSize=22
floatBtn.Visible=false
floatBtn.BorderSizePixel=0
floatBtn.Parent=sg
Instance.new("UICorner",floatBtn).CornerRadius=UDim.new(0,12)
local fs=Instance.new("UIStroke",floatBtn)
fs.Color=Color3.fromRGB(0,255,150)

local vDrag=false
local vMoved=false
local vStart=nil
local vPos=nil
floatBtn.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
vDrag=true
vMoved=false
vStart=i.Position
vPos=floatBtn.Position
end
end)
UIS.InputChanged:Connect(function(i)
if vDrag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then
local d=i.Position-vStart
if math.abs(d.X)>5 or math.abs(d.Y)>5 then vMoved=true end
floatBtn.Position=UDim2.new(vPos.X.Scale,vPos.X.Offset+d.X,vPos.Y.Scale,vPos.Y.Offset+d.Y)
end
end)
UIS.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
vDrag=false
end
end)
floatBtn.MouseButton1Click:Connect(function()
if vMoved then return end
f.Visible=true
floatBtn.Visible=false
end)

-- トップバー
local topBar=Instance.new("Frame")
topBar.Size=UDim2.new(1,0,0,45)
topBar.BackgroundColor3=Color3.fromRGB(15,15,20)
topBar.BackgroundTransparency=0.2
topBar.BorderSizePixel=0
topBar.Active=true
topBar.Parent=f
Instance.new("UICorner",topBar).CornerRadius=UDim.new(0,12)

-- ドラッグ
local dragging=false
local dragInput=nil
local dragStart=nil
local startPos=nil
topBar.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
dragging=true
dragStart=input.Position
startPos=f.Position
end
end)
topBar.InputChanged:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
dragInput=input
end
end)
UIS.InputChanged:Connect(function(input)
if input==dragInput and dragging then
local delta=input.Position-dragStart
f.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
end
end)
UIS.InputEnded:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
dragging=false
end
end)

-- ロゴ
local logo=Instance.new("TextLabel")
logo.Size=UDim2.new(0,35,0,35)
logo.Position=UDim2.new(0,10,0,5)
logo.BackgroundColor3=Color3.fromRGB(0,255,150)
logo.Text="V"
logo.TextColor3=Color3.fromRGB(0,0,0)
logo.Font=Enum.Font.GothamBold
logo.TextSize=20
logo.BorderSizePixel=0
logo.Parent=topBar
Instance.new("UICorner",logo).CornerRadius=UDim.new(0,8)

local title=Instance.new("TextLabel")
title.Size=UDim2.new(0,200,0,20)
title.Position=UDim2.new(0,55,0,5)
title.BackgroundTransparency=1
title.Text="Void"
title.TextColor3=Color3.fromRGB(0,255,150)
title.Font=Enum.Font.GothamBold
title.TextSize=16
title.TextXAlignment=Enum.TextXAlignment.Left
title.Parent=topBar

local discord=Instance.new("TextButton")
discord.Size=UDim2.new(0,200,0,15)
discord.Position=UDim2.new(0,55,0,25)
discord.BackgroundTransparency=1
discord.Text="discord.gg/Znj8eBfa9"
discord.TextColor3=Color3.fromRGB(150,150,150)
discord.Font=Enum.Font.Gotham
discord.TextSize=10
discord.TextXAlignment=Enum.TextXAlignment.Left
discord.Parent=topBar
discord.MouseButton1Click:Connect(function()
if setclipboard then setclipboard("https://discord.gg/Znj8eBfa9")end
end)

local lb=Instance.new("TextButton")
lb.Size=UDim2.new(0,95,0,25)
lb.Position=UDim2.new(1,-210,0,10)
lb.Text="🇯🇵 日本語"
lb.BackgroundColor3=Color3.fromRGB(50,50,55)
lb.TextColor3=Color3.fromRGB(255,255,255)
lb.Font=Enum.Font.Gotham
lb.TextSize=11
lb.BorderSizePixel=0
lb.ZIndex=5
lb.Parent=topBar
Instance.new("UICorner",lb).CornerRadius=UDim.new(0,6)

local minBtn=Instance.new("TextButton")
minBtn.Size=UDim2.new(0,25,0,25)
minBtn.Position=UDim2.new(1,-80,0,10)
minBtn.Text="-"
minBtn.BackgroundColor3=Color3.fromRGB(50,50,55)
minBtn.TextColor3=Color3.fromRGB(255,255,255)
minBtn.Font=Enum.Font.GothamBold
minBtn.BorderSizePixel=0
minBtn.ZIndex=5
minBtn.Parent=topBar
Instance.new("UICorner",minBtn).CornerRadius=UDim.new(0,6)

local close=Instance.new("TextButton")
close.Size=UDim2.new(0,25,0,25)
close.Position=UDim2.new(1,-45,0,10)
close.Text="X"
close.BackgroundColor3=Color3.fromRGB(255,80,80)
close.TextColor3=Color3.fromRGB(255,255,255)
close.Font=Enum.Font.GothamBold
close.BorderSizePixel=0
close.ZIndex=5
close.Parent=topBar
Instance.new("UICorner",close).CornerRadius=UDim.new(0,6)

close.MouseButton1Click:Connect(function()
f.Visible=false
floatBtn.Visible=true
end)
minBtn.MouseButton1Click:Connect(function()
f.Visible=false
floatBtn.Visible=true
end)
-- 翻訳
local lang="ja"
local trans={
ja={player="プレイヤー",tools="ツール",target="ターゲット",other="その他",teleport="デレポート",
speed="スピード",jump="ジャンプ力",inf_jump="無限ジャンプ",wall_walk="壁歩き",noclip="貫通",respawn="リスポーン",
spin="スピン",god="無敵",tp_random="ランダムTP",transparency="透明化",dev="開発中",
save_loc="場所の名前",save_btn="保存",update="更新",spin_btn="実行",tp_btn="ランダムTP",respawn_btn="今すぐリスポーン",
btn_go="実行",btn_on="ON",btn_off="OFF"},
en={player="Player",tools="Tools",target="Target",other="Other",teleport="Teleport",
speed="Speed",jump="Jump Power",inf_jump="Infinite Jump",wall_walk="Wall Walk",noclip="No Clip",respawn="Respawn",
spin="Spin",god="Godmode",tp_random="Random TP",transparency="Transparency",dev="Under Development",
save_loc="Location Name",save_btn="Save",update="Update",spin_btn="Execute",tp_btn="Random TP",respawn_btn="Respawn Now",
btn_go="Execute",btn_on="ON",btn_off="OFF"}
}
local tabKeys={"player","tools","target","other","teleport"}

-- サイドバー
local sidebar=Instance.new("Frame")
sidebar.Size=UDim2.new(0,145,0,260)
sidebar.Position=UDim2.new(0,8,0,52)
sidebar.BackgroundColor3=Color3.fromRGB(18,18,22)
sidebar.BackgroundTransparency=0.15
sidebar.BorderSizePixel=0
sidebar.Parent=f
Instance.new("UICorner",sidebar).CornerRadius=UDim.new(0,10)

-- タブ
local tabBtns={}
for i=1,5 do
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-10,0,40)
b.Position=UDim2.new(0,5,0,5+(i-1)*45)
b.Text="  "..trans[lang][tabKeys[i]]
b.BackgroundColor3=Color3.fromRGB(45,45,52)
b.TextColor3=Color3.fromRGB(200,200,200)
b.Font=Enum.Font.GothamBold
b.TextSize=12
b.TextXAlignment=Enum.TextXAlignment.Left
b.AutoButtonColor=false
b.BorderSizePixel=0
b.ZIndex=2
b.Parent=sidebar
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
tabBtns[i]=b
end
tabBtns[1].BackgroundColor3=Color3.fromRGB(0,255,150)
tabBtns[1].TextColor3=Color3.fromRGB(0,0,0)

-- プロフィール（左下）
local profile=Instance.new("Frame")
profile.Size=UDim2.new(0,145,0,60)
profile.Position=UDim2.new(0,8,1,-68)
profile.BackgroundColor3=Color3.fromRGB(18,18,22)
profile.BackgroundTransparency=0.15
profile.BorderSizePixel=0
profile.Parent=f
Instance.new("UICorner",profile).CornerRadius=UDim.new(0,10)

local pImg=Instance.new("ImageLabel")
pImg.Size=UDim2.new(0,40,0,40)
pImg.Position=UDim2.new(0,8,0,10)
pImg.BackgroundColor3=Color3.fromRGB(0,255,150)
pImg.Text=""
pImg.BorderSizePixel=0
pImg.Parent=profile
Instance.new("UICorner",pImg).CornerRadius=UDim.new(0,20)
pcall(function()
pImg.Image=game:GetService("Players"):GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size150x150)
end)

local pName=Instance.new("TextLabel")
pName.Size=UDim2.new(1,-55,0,15)
pName.Position=UDim2.new(0,52,0,14)
pName.BackgroundTransparency=1
pName.Text=p.DisplayName
pName.TextColor3=Color3.fromRGB(255,255,255)
pName.Font=Enum.Font.GothamBold
pName.TextSize=11
pName.TextXAlignment=Enum.TextXAlignment.Left
pName.Parent=profile

local pHandle=Instance.new("TextLabel")
pHandle.Size=UDim2.new(1,-55,0,15)
pHandle.Position=UDim2.new(0,52,0,31)
pHandle.BackgroundTransparency=1
pHandle.Text="@"..p.Name
pHandle.TextColor3=Color3.fromRGB(140,140,140)
pHandle.Font=Enum.Font.Gotham
pHandle.TextSize=9
pHandle.TextXAlignment=Enum.TextXAlignment.Left
pHandle.Parent=profile

-- コンテンツエリア
local content=Instance.new("Frame")
content.Size=UDim2.new(0,390,0,340)
content.Position=UDim2.new(0,160,0,52)
content.BackgroundColor3=Color3.fromRGB(18,18,22)
content.BackgroundTransparency=0.15
content.BorderSizePixel=0
content.Parent=f
Instance.new("UICorner",content).CornerRadius=UDim.new(0,10)

-- ページ（スクロール対応）
local pages={}
for i=1,5 do
local pp=Instance.new("ScrollingFrame")
pp.Size=UDim2.new(1,-10,1,-10)
pp.Position=UDim2.new(0,5,0,5)
pp.BackgroundTransparency=1
pp.BorderSizePixel=0
pp.ScrollBarThickness=4
pp.ScrollBarImageColor3=Color3.fromRGB(0,255,150)
pp.CanvasSize=UDim2.new(0,0,0,0)
pp.AutomaticCanvasSize=Enum.AutomaticSize.Y
pp.Visible=(i==1)
pp.Parent=content
local lay=Instance.new("UIListLayout",pp)
lay.Padding=UDim.new(0,8)
pages[i]=pp
end

-- タブ切り替え
for i=1,5 do
tabBtns[i].MouseButton1Click:Connect(function()
for j=1,5 do
pages[j].Visible=(j==i)
tabBtns[j].BackgroundColor3=Color3.fromRGB(45,45,52)
tabBtns[j].TextColor3=Color3.fromRGB(200,200,200)
end
tabBtns[i].BackgroundColor3=Color3.fromRGB(0,255,150)
tabBtns[i].TextColor3=Color3.fromRGB(0,0,0)
end)
end
-- トグル
local function createToggle(parent,txtKey,default,cb)
local btn=Instance.new("TextButton")
btn.Size=UDim2.new(1,0,0,45)
btn.BackgroundColor3=Color3.fromRGB(45,45,52)
btn.Text=""
btn.AutoButtonColor=false
btn.BorderSizePixel=0
btn.Parent=parent
Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)
local lbl=Instance.new("TextLabel")
lbl.Size=UDim2.new(0.7,0,1,0)
lbl.Position=UDim2.new(0,15,0,0)
lbl.BackgroundTransparency=1
lbl.Text=trans[lang][txtKey]
lbl.TextColor3=Color3.fromRGB(230,230,230)
lbl.Font=Enum.Font.GothamBold
lbl.TextSize=13
lbl.TextXAlignment=Enum.TextXAlignment.Left
lbl.Parent=btn
lbl:SetAttribute("TKey",txtKey)
local sw=Instance.new("Frame")
sw.Size=UDim2.new(0,45,0,22)
sw.Position=UDim2.new(1,-55,0.5,-11)
sw.BackgroundColor3=default and Color3.fromRGB(0,255,150)or Color3.fromRGB(70,70,78)
sw.BorderSizePixel=0
sw.Parent=btn
Instance.new("UICorner",sw).CornerRadius=UDim.new(0,11)
local kn=Instance.new("Frame")
kn.Size=UDim2.new(0,18,0,18)
kn.Position=default and UDim2.new(1,-20,0.5,-9)or UDim2.new(0,2,0.5,-9)
kn.BackgroundColor3=Color3.fromRGB(255,255,255)
kn.BorderSizePixel=0
kn.Parent=sw
Instance.new("UICorner",kn).CornerRadius=UDim.new(0,9)
local state=default
btn.MouseButton1Click:Connect(function()
state=not state
sw.BackgroundColor3=state and Color3.fromRGB(0,255,150)or Color3.fromRGB(70,70,78)
kn.Position=state and UDim2.new(1,-20,0.5,-9)or UDim2.new(0,2,0.5,-9)
cb(state)
end)
end

-- スライダー
local function createSlider(parent,txtKey,min,max,default,cb)
local c=Instance.new("Frame")
c.Size=UDim2.new(1,0,0,55)
c.BackgroundColor3=Color3.fromRGB(45,45,52)
c.BorderSizePixel=0
c.Parent=parent
Instance.new("UICorner",c).CornerRadius=UDim.new(0,8)
local lbl=Instance.new("TextLabel")
lbl.Size=UDim2.new(0.6,0,0,20)
lbl.Position=UDim2.new(0,15,0,5)
lbl.BackgroundTransparency=1
lbl.Text=trans[lang][txtKey]
lbl.TextColor3=Color3.fromRGB(230,230,230)
lbl.Font=Enum.Font.GothamBold
lbl.TextSize=13
lbl.TextXAlignment=Enum.TextXAlignment.Left
lbl.Parent=c
lbl:SetAttribute("TKey",txtKey)
local val=Instance.new("TextLabel")
val.Size=UDim2.new(0,50,0,20)
val.Position=UDim2.new(1,-60,0,5)
val.BackgroundTransparency=1
val.Text=tostring(default)
val.TextColor3=Color3.fromRGB(0,255,150)
val.Font=Enum.Font.GothamBold
val.TextSize=13
val.Parent=c
local barBg=Instance.new("Frame")
barBg.Size=UDim2.new(1,-30,0,8)
barBg.Position=UDim2.new(0,15,1,-18)
barBg.BackgroundColor3=Color3.fromRGB(30,30,35)
barBg.BorderSizePixel=0
barBg.Parent=c
Instance.new("UICorner",barBg).CornerRadius=UDim.new(0,4)
local barFill=Instance.new("Frame")
barFill.Size=UDim2.new((default-min)/(max-min),0,1,0)
barFill.BackgroundColor3=Color3.fromRGB(0,255,150)
barFill.BorderSizePixel=0
barFill.Parent=barBg
Instance.new("UICorner",barFill).CornerRadius=UDim.new(0,4)
local knob=Instance.new("TextButton")
knob.Size=UDim2.new(0,18,0,18)
knob.Position=UDim2.new(barFill.Size.X.Scale,-9,0.5,-9)
knob.BackgroundColor3=Color3.fromRGB(255,255,255)
knob.Text=""
knob.BorderSizePixel=0
knob.Parent=barBg
Instance.new("UICorner",knob).CornerRadius=UDim.new(0,9)
local drag=false
local function upd(i)
local rx=math.clamp((i.Position.X-barBg.AbsolutePosition.X)/barBg.AbsoluteSize.X,0,1)
local v=math.floor(min+(max-min)*rx)
val.Text=tostring(v)
barFill.Size=UDim2.new(rx,0,1,0)
knob.Position=UDim2.new(rx,-9,0.5,-9)
cb(v)
end
knob.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=true upd(i)end
end)
barBg.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=true upd(i)end
end)
UIS.InputChanged:Connect(function(i)
if drag and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then upd(i)end
end)
UIS.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
end)
end

-- アコーディオン
local function createAccordion(parent,txtKey,build)
local wrap=Instance.new("Frame")
wrap.Size=UDim2.new(1,0,0,45)
wrap.AutomaticSize=Enum.AutomaticSize.Y
wrap.BackgroundColor3=Color3.fromRGB(45,45,52)
wrap.BorderSizePixel=0
wrap.Parent=parent
Instance.new("UICorner",wrap).CornerRadius=UDim.new(0,8)
local wL=Instance.new("UIListLayout",wrap)
wL.SortOrder=Enum.SortOrder.LayoutOrder
local hd=Instance.new("TextButton")
hd.Size=UDim2.new(1,0,0,45)
hd.BackgroundTransparency=1
hd.Text="  "..trans[lang][txtKey].."  ▼"
hd.TextColor3=Color3.fromRGB(230,230,230)
hd.Font=Enum.Font.GothamBold
hd.TextSize=13
hd.TextXAlignment=Enum.TextXAlignment.Left
hd.LayoutOrder=1
hd.AutoButtonColor=false
hd.Parent=wrap
hd:SetAttribute("TKey",txtKey)
local cf=Instance.new("Frame")
cf.Size=UDim2.new(1,-20,0,0)
cf.AutomaticSize=Enum.AutomaticSize.Y
cf.BackgroundTransparency=1
cf.LayoutOrder=2
cf.Visible=false
cf.Parent=wrap
local cL=Instance.new("UIListLayout",cf)
cL.Padding=UDim.new(0,6)
local cP=Instance.new("UIPadding",cf)
cP.PaddingBottom=UDim.new(0,12)
build(cf)
hd.MouseButton1Click:Connect(function()
cf.Visible=not cf.Visible
if cf.Visible then
hd.Text="  "..trans[lang][txtKey].."  ▲"
else
hd.Text="  "..trans[lang][txtKey].."  ▼"
end
end)
return wrap
end
-- プレイヤータブ
local pPage=pages[1]

createSlider(pPage,"speed",0,200,16,function(v)
if p.Character and p.Character:FindFirstChild("Humanoid")then
p.Character.Humanoid.WalkSpeed=v
end
end)

createSlider(pPage,"jump",0,500,50,function(v)
if p.Character and p.Character:FindFirstChild("Humanoid")then
p.Character.Humanoid.UseJumpPower=true
p.Character.Humanoid.JumpPower=v
end
end)

createToggle(pPage,"inf_jump",false,function(s)
if s then
local cn
cn=UIS.JumpRequest:Connect(function()
local c=p.Character
if not c then return end
local h=c:FindFirstChildOfClass("Humanoid")
if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end
end)
p.CharacterAdded:Connect(function()cn:Disconnect()end)
end
end)

createToggle(pPage,"wall_walk",false,function(s)
if s then
local wallConn
wallConn=RS.RenderStepped:Connect(function()
local c=p.Character
if not c then wallConn:Disconnect() return end
local hrp=c:FindFirstChild("HumanoidRootPart")
local hum=c:FindFirstChildOfClass("Humanoid")
if not hrp or not hum then return end
local rp=RaycastParams.new()
rp.FilterDescendantsInstances={c}
rp.FilterType=Enum.RaycastFilterType.Exclude
local ray=workspace:Raycast(hrp.Position,hum.MoveDirection*5,rp)
if ray and hum.MoveDirection.Magnitude>0 then
local bv=hrp:FindFirstChild("WWBV")or Instance.new("BodyVelocity",hrp)
bv.Name="WWBV"
bv.MaxForce=Vector3.new(9e9,9e9,9e9)
bv.Velocity=hum.MoveDirection*10
local bf=hrp:FindFirstChild("WWBF")or Instance.new("BodyForce",hrp)
bf.Name="WWBF"
bf.Force=Vector3.new(0,workspace.Gravity*hrp:GetMass(),0)
else
local bv=hrp:FindFirstChild("WWBV")
if bv then bv:Destroy()end
local bf=hrp:FindFirstChild("WWBF")
if bf then bf:Destroy()end
end
end)
else
local c=p.Character
if c then
local hrp=c:FindFirstChild("HumanoidRootPart")
if hrp then
local bv=hrp:FindFirstChild("WWBV")
if bv then bv:Destroy()end
local bf=hrp:FindFirstChild("WWBF")
if bf then bf:Destroy()end
end
end
end
end)

createToggle(pPage,"noclip",false,function(s)
if s then
local cn
cn=RS.Stepped:Connect(function()
local c=p.Character
if not c then cn:Disconnect() return end
for _,v in ipairs(c:GetDescendants())do
if v:IsA("BasePart")then v.CanCollide=false end
end
end)
else
local c=p.Character
if c then
for _,v in ipairs(c:GetDescendants())do
if v:IsA("BasePart")then v.CanCollide=true end
end
end
end
end)

local respawnBtn=Instance.new("TextButton")
respawnBtn.Size=UDim2.new(1,0,0,45)
respawnBtn.Text=trans[lang]["respawn_btn"]
respawnBtn.BackgroundColor3=Color3.fromRGB(255,80,80)
respawnBtn.TextColor3=Color3.fromRGB(255,255,255)
respawnBtn.Font=Enum.Font.GothamBold
respawnBtn.TextSize=13
respawnBtn.AutoButtonColor=false
respawnBtn.BorderSizePixel=0
respawnBtn.Parent=pPage
respawnBtn:SetAttribute("TKey","respawn_btn")
Instance.new("UICorner",respawnBtn).CornerRadius=UDim.new(0,8)
respawnBtn.MouseButton1Click:Connect(function()
if p.Character then
local h=p.Character:FindFirstChildOfClass("Humanoid")
if h then h.Health=0 end
end
end)

-- ツールタブ
local tPage=pages[2]

createAccordion(tPage,"spin",function(cf)
local box=Instance.new("TextBox")
box.Size=UDim2.new(1,0,0,35)
box.Text="5"
box.BackgroundColor3=Color3.fromRGB(30,30,35)
box.TextColor3=Color3.fromRGB(0,255,150)
box.Font=Enum.Font.GothamBold
box.TextSize=13
box.ClearTextOnFocus=false
box.BorderSizePixel=0
box.Parent=cf
Instance.new("UICorner",box).CornerRadius=UDim.new(0,6)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,0,0,35)
b.Text=trans[lang]["spin_btn"]
b.BackgroundColor3=Color3.fromRGB(0,255,150)
b.TextColor3=Color3.fromRGB(0,0,0)
b.Font=Enum.Font.GothamBold
b.TextSize=13
b.AutoButtonColor=false
b.BorderSizePixel=0
b.Parent=cf
b:SetAttribute("TKey","spin_btn")
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
local spd=tonumber(box.Text)or 5
local conn
conn=RS.Heartbeat:Connect(function(dt)
local c=p.Character
if not c then conn:Disconnect() return end
local h=c:FindFirstChild("HumanoidRootPart")
if not h then return end
h.CFrame=h.CFrame*CFrame.Angles(0,math.rad(spd*dt*60),0)
end)
end)
end)

createAccordion(tPage,"god",function(cf)
createToggle(cf,"god",false,function(s)
if s then
local cn
cn=RS.Heartbeat:Connect(function()
local c=p.Character
if not c then cn:Disconnect() return end
local h=c:FindFirstChildOfClass("Humanoid")
if h then h.Health=h.MaxHealth end
end)
end
end)
end)

createAccordion(tPage,"tp_random",function(cf)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,0,0,35)
b.Text=trans[lang]["tp_btn"]
b.BackgroundColor3=Color3.fromRGB(0,255,150)
b.TextColor3=Color3.fromRGB(0,0,0)
b.Font=Enum.Font.GothamBold
b.TextSize=13
b.AutoButtonColor=false
b.BorderSizePixel=0
b.Parent=cf
b:SetAttribute("TKey","tp_btn")
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
local o={}
for _,pl in ipairs(game.Players:GetPlayers())do
if pl~=p then table.insert(o,pl)end
end
if #o>0 then
local t=o[math.random(1,#o)]
if t.Character and t.Character:FindFirstChild("HumanoidRootPart") and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
p.Character.HumanoidRootPart.CFrame=t.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
end
end
end)
end)

createAccordion(tPage,"transparency",function(cf)
createToggle(cf,"transparency",false,function(s)
if s then
local cn
cn=RS.RenderStepped:Connect(function()
local c=p.Character
if not c then cn:Disconnect() return end
for _,v in ipairs(c:GetDescendants())do
if v:IsA("BasePart")then v.LocalTransparencyModifier=1 end
if v:IsA("Decal")then v.Transparency=1 end
end
end)
else
local c=p.Character
if c then
for _,v in ipairs(c:GetDescendants())do
if v:IsA("BasePart")then v.LocalTransparencyModifier=0 end
if v:IsA("Decal")then v.Transparency=0 end
end
end
end
end)
end)

-- その他タブ
local oPage=pages[4]
local dev=Instance.new("TextLabel")
dev.Size=UDim2.new(1,0,0,100)
dev.BackgroundTransparency=1
dev.Text=trans[lang]["dev"]
dev.TextColor3=Color3.fromRGB(150,150,150)
dev.Font=Enum.Font.GothamBold
dev.TextSize=24
dev.Parent=oPage
dev:SetAttribute("TKey","dev")
-- ターゲットタブ
local tgtPage=pages[3]
local tgtList=Instance.new("Frame")
tgtList.Size=UDim2.new(1,0,0,150)
tgtList.BackgroundColor3=Color3.fromRGB(30,30,35)
tgtList.BorderSizePixel=0
tgtList.Parent=tgtPage
Instance.new("UICorner",tgtList).CornerRadius=UDim.new(0,8)
local tgtLay=Instance.new("UIListLayout",tgtList)
tgtLay.Padding=UDim.new(0,4)
local tgtPad=Instance.new("UIPadding",tgtList)
tgtPad.PaddingLeft=UDim.new(0,5)
tgtPad.PaddingTop=UDim.new(0,5)

local function updT()
for _,v in ipairs(tgtList:GetChildren())do
if v:IsA("TextButton")then v:Destroy()end
end
for _,pl in ipairs(game.Players:GetPlayers())do
if pl~=p then
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-10,0,30)
b.Text=pl.Name
b.BackgroundColor3=Color3.fromRGB(45,45,52)
b.TextColor3=Color3.fromRGB(230,230,230)
b.Font=Enum.Font.GothamBold
b.TextSize=12
b.AutoButtonColor=false
b.BorderSizePixel=0
b.Parent=tgtList
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
if pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
p.Character.HumanoidRootPart.CFrame=pl.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
end
end)
end
end
end
updT()
game.Players.PlayerAdded:Connect(updT)
game.Players.PlayerRemoving:Connect(updT)

local saveRow=Instance.new("Frame")
saveRow.Size=UDim2.new(1,0,0,40)
saveRow.BackgroundTransparency=1
saveRow.Parent=tgtPage
local saveBox=Instance.new("TextBox")
saveBox.Size=UDim2.new(0.6,0,1,0)
saveBox.Position=UDim2.new(0,0,0,0)
saveBox.Text=""
saveBox.PlaceholderText=trans[lang]["save_loc"]
saveBox.BackgroundColor3=Color3.fromRGB(30,30,35)
saveBox.TextColor3=Color3.fromRGB(0,255,150)
saveBox.Font=Enum.Font.GothamBold
saveBox.TextSize=12
saveBox.ClearTextOnFocus=false
saveBox.BorderSizePixel=0
saveBox.Parent=saveRow
saveBox:SetAttribute("PKey","save_loc")
Instance.new("UICorner",saveBox).CornerRadius=UDim.new(0,6)
local saveBtn=Instance.new("TextButton")
saveBtn.Size=UDim2.new(0.35,0,1,0)
saveBtn.Position=UDim2.new(0.65,0,0,0)
saveBtn.Text=trans[lang]["save_btn"]
saveBtn.BackgroundColor3=Color3.fromRGB(0,255,150)
saveBtn.TextColor3=Color3.fromRGB(0,0,0)
saveBtn.Font=Enum.Font.GothamBold
saveBtn.TextSize=12
saveBtn.AutoButtonColor=false
saveBtn.BorderSizePixel=0
saveBtn.Parent=saveRow
saveBtn:SetAttribute("TKey","save_btn")
Instance.new("UICorner",saveBtn).CornerRadius=UDim.new(0,6)

local locList=Instance.new("Frame")
locList.Size=UDim2.new(1,0,0,100)
locList.BackgroundColor3=Color3.fromRGB(30,30,35)
locList.BorderSizePixel=0
locList.Parent=tgtPage
Instance.new("UICorner",locList).CornerRadius=UDim.new(0,8)
local locLay=Instance.new("UIListLayout",locList)
locLay.Padding=UDim.new(0,4)
local locPad=Instance.new("UIPadding",locList)
locPad.PaddingLeft=UDim.new(0,5)
locPad.PaddingTop=UDim.new(0,5)

local saved={}
local function refreshLocs()
for _,v in ipairs(locList:GetChildren())do
if v:IsA("TextButton")then v:Destroy()end
end
for _,loc in ipairs(saved)do
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-10,0,30)
b.Text=loc.name
b.BackgroundColor3=Color3.fromRGB(45,45,52)
b.TextColor3=Color3.fromRGB(230,230,230)
b.Font=Enum.Font.GothamBold
b.TextSize=12
b.AutoButtonColor=false
b.BorderSizePixel=0
b.Parent=locList
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
if p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
p.Character.HumanoidRootPart.CFrame=loc.cf
end
end)
end
end
saveBtn.MouseButton1Click:Connect(function()
if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and saveBox.Text~=""then
table.insert(saved,{name=saveBox.Text,cf=p.Character.HumanoidRootPart.CFrame})
saveBox.Text=""
refreshLocs()
end
end)

-- デレポートタブ
local dPage=pages[5]
local rf=Instance.new("TextButton")
rf.Size=UDim2.new(1,0,0,35)
rf.Text=trans[lang]["update"]
rf.BackgroundColor3=Color3.fromRGB(0,255,150)
rf.TextColor3=Color3.fromRGB(0,0,0)
rf.Font=Enum.Font.GothamBold
rf.TextSize=13
rf.AutoButtonColor=false
rf.BorderSizePixel=0
rf.Parent=dPage
rf:SetAttribute("TKey","update")
Instance.new("UICorner",rf).CornerRadius=UDim.new(0,6)
local sf=Instance.new("Frame")
sf.Size=UDim2.new(1,0,1,-40)
sf.Position=UDim2.new(0,0,0,40)
sf.BackgroundTransparency=1
sf.Parent=dPage
local sfLay=Instance.new("UIListLayout",sf)
sfLay.Padding=UDim.new(0,4)
local function upd()
for _,v in ipairs(sf:GetChildren())do
if v:IsA("TextButton")then v:Destroy()end
end
for _,pl in ipairs(game.Players:GetPlayers())do
if pl~=p then
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,0,0,35)
b.Text=pl.Name
b.BackgroundColor3=Color3.fromRGB(45,45,52)
b.TextColor3=Color3.fromRGB(230,230,230)
b.Font=Enum.Font.GothamBold
b.TextSize=12
b.AutoButtonColor=false
b.BorderSizePixel=0
b.Parent=sf
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
if pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
p.Character.HumanoidRootPart.CFrame=pl.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
end
end)
end
end
end
rf.MouseButton1Click:Connect(upd)
upd()

-- 言語切り替え
local function updateLanguage()
for _,obj in ipairs(f:GetDescendants())do
local tkey=obj:GetAttribute("TKey")
if tkey and trans[lang][tkey]then
obj.Text=trans[lang][tkey]
end
local pkey=obj:GetAttribute("PKey")
if pkey and trans[lang][pkey]then
obj.PlaceholderText=trans[lang][pkey]
end
end
for i=1,5 do
local active=tabBtns[i].BackgroundColor3==Color3.fromRGB(0,255,150)
tabBtns[i].Text="  "..trans[lang][tabKeys[i]]
end
lb.Text=lang=="ja" and "🇯🇵 日本語" or "🇺🇸 English"
end

lb.MouseButton1Click:Connect(function()
lang=lang=="ja" and "en" or "ja"
updateLanguage()
end)

-- リスポーン時
p.CharacterAdded:Connect(function(ch)
task.wait(1)
local h=ch:FindFirstChildOfClass("Humanoid")
if h then
h.WalkSpeed=16
h.UseJumpPower=true
h.JumpPower=50
end
end)
