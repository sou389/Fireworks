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
f.Size=UDim2.new(0,650,0,400)
f.Position=UDim2.new(0.5,-325,0.5,-200)
f.BackgroundColor3=Color3.fromRGB(30,30,35)
f.BackgroundTransparency=0.2
f.Active=true
f.Parent=sg
Instance.new("UICorner",f).CornerRadius=UDim.new(0,12)
local st=Instance.new("UIStroke",f)
st.Color=Color3.fromRGB(0,255,150)
st.Thickness=1
st.Transparency=0.6

local floatBtn=Instance.new("TextButton")
floatBtn.Size=UDim2.new(0,45,0,45)
floatBtn.Position=UDim2.new(0,15,0.5,-22.5)
floatBtn.BackgroundColor3=Color3.fromRGB(30,30,35)
floatBtn.Text="V"
floatBtn.TextColor3=Color3.fromRGB(0,255,150)
floatBtn.Font=Enum.Font.GothamBold
floatBtn.TextSize=22
floatBtn.Visible=false
floatBtn.Parent=sg
Instance.new("UICorner",floatBtn).CornerRadius=UDim.new(0,12)
local fs=Instance.new("UIStroke",floatBtn)
fs.Color=Color3.fromRGB(0,255,150)

local fbd,fbm,fbs,fbp=false,false,nil,nil
floatBtn.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
fbd=true fbm=false fbs=i.Position fbp=floatBtn.Position
end
end)
UIS.InputChanged:Connect(function(i)
if fbd and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then
local d=i.Position-fbs
if math.abs(d.X)>5 or math.abs(d.Y)>5 then fbm=true end
floatBtn.Position=UDim2.new(fbp.X.Scale,fbp.X.Offset+d.X,fbp.Y.Scale,fbp.Y.Offset+d.Y)
end
end)
UIS.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fbd=false end
end)
floatBtn.MouseButton1Click:Connect(function()
if fbm then return end
f.Visible=true floatBtn.Visible=false
end)

local top=Instance.new("Frame")
top.Size=UDim2.new(1,0,0,45)
top.BackgroundTransparency=1
top.Parent=f
local logo=Instance.new("TextLabel")
logo.Size=UDim2.new(0,35,0,35)
logo.Position=UDim2.new(0,10,0,5)
logo.BackgroundColor3=Color3.fromRGB(20,20,25)
logo.Text="V"
logo.TextColor3=Color3.fromRGB(0,255,150)
logo.Font=Enum.Font.GothamBold
logo.TextSize=20
logo.Parent=top
Instance.new("UICorner",logo).CornerRadius=UDim.new(0,8)
local ls=Instance.new("UIStroke",logo)
ls.Color=Color3.fromRGB(0,255,150)
local title=Instance.new("TextLabel")
title.Size=UDim2.new(0,200,0,20)
title.Position=UDim2.new(0,55,0,5)
title.BackgroundTransparency=1
title.Text="Void"
title.TextColor3=Color3.fromRGB(0,255,150)
title.Font=Enum.Font.GothamBold
title.TextSize=16
title.TextXAlignment=Enum.TextXAlignment.Left
title.Parent=top
local discord=Instance.new("TextButton")
discord.Size=UDim2.new(0,200,0,15)
discord.Position=UDim2.new(0,55,0,25)
discord.BackgroundTransparency=1
discord.Text="discord.gg/Znj8eBfa9"
discord.TextColor3=Color3.fromRGB(150,150,150)
discord.Font=Enum.Font.Gotham
discord.TextSize=10
discord.TextXAlignment=Enum.TextXAlignment.Left
discord.Parent=top
discord.MouseButton1Click:Connect(function()
if setclipboard then setclipboard("https://discord.gg/Znj8eBfa9")end
end)
local lb=Instance.new("TextButton")
lb.Size=UDim2.new(0,90,0,25)
lb.Position=UDim2.new(1,-210,0,10)
lb.Text="🇯🇵 日本語"
lb.BackgroundColor3=Color3.fromRGB(40,40,45)
lb.BackgroundTransparency=0.4
lb.TextColor3=Color3.fromRGB(255,255,255)
lb.Font=Enum.Font.Gotham
lb.TextSize=11
lb.Parent=top
Instance.new("UICorner",lb).CornerRadius=UDim.new(0,6)
local minBtn=Instance.new("TextButton")
minBtn.Size=UDim2.new(0,25,0,25)
minBtn.Position=UDim2.new(1,-80,0,10)
minBtn.Text="-"
minBtn.BackgroundColor3=Color3.fromRGB(40,40,45)
minBtn.BackgroundTransparency=0.4
minBtn.TextColor3=Color3.fromRGB(255,255,255)
minBtn.Font=Enum.Font.GothamBold
minBtn.Parent=top
Instance.new("UICorner",minBtn).CornerRadius=UDim.new(0,6)
local close=Instance.new("TextButton")
close.Size=UDim2.new(0,25,0,25)
close.Position=UDim2.new(1,-45,0,10)
close.Text="X"
close.BackgroundColor3=Color3.fromRGB(40,40,45)
close.BackgroundTransparency=0.4
close.TextColor3=Color3.fromRGB(255,100,100)
close.Font=Enum.Font.GothamBold
close.Parent=top
Instance.new("UICorner",close).CornerRadius=UDim.new(0,6)
close.MouseButton1Click:Connect(function()
f.Visible=false floatBtn.Visible=true
end)
minBtn.MouseButton1Click:Connect(function()
f.Visible=false floatBtn.Visible=true
end)
local sidebar=Instance.new("Frame")
sidebar.Size=UDim2.new(0,150,1,-55)
sidebar.Position=UDim2.new(0,5,0,50)
sidebar.BackgroundColor3=Color3.fromRGB(25,25,30)
sidebar.BackgroundTransparency=0.3
sidebar.Parent=f
Instance.new("UICorner",sidebar).CornerRadius=UDim.new(0,10)

local tabNames={"プレイヤー","ツール","ターゲット","その他","デレポート"}
local enNames={"Player","Tools","Target","Others","Teleport"}
local pages={}
local btns={}

local content=Instance.new("Frame")
content.Size=UDim2.new(1,-165,1,-65)
content.Position=UDim2.new(0,160,0,55)
content.BackgroundTransparency=1
content.Parent=f

for i=1,5 do
local pp=Instance.new("Frame")
pp.Size=UDim2.new(1,0,1,0)
pp.BackgroundTransparency=1
pp.Visible=(i==1)
pp.Parent=content
local lay=Instance.new("UIListLayout",pp)
lay.Padding=UDim.new(0,8)
pages[i]=pp
end

for i=1,5 do
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-10,0,35)
b.Position=UDim2.new(0,5,0,5+(i-1)*40)
b.Text="   "..tabNames[i]
b.BackgroundColor3=Color3.fromRGB(35,35,40)
b.BackgroundTransparency=0.5
b.TextColor3=Color3.fromRGB(150,150,150)
b.Font=Enum.Font.Gotham
b.TextSize=12
b.TextXAlignment=Enum.TextXAlignment.Left
b.AutoButtonColor=false
b.Parent=sidebar
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)

local ind=Instance.new("Frame")
ind.Size=UDim2.new(0,3,0.6,0)
ind.Position=UDim2.new(0,3,0.2,0)
ind.BackgroundColor3=Color3.fromRGB(0,255,150)
ind.Visible=(i==1)
ind.Parent=b
Instance.new("UICorner",ind).CornerRadius=UDim.new(0,2)

btns[i]={btn=b,ind=ind}

b.MouseButton1Click:Connect(function()
for j=1,5 do
pages[j].Visible=(j==i)
btns[j].btn.TextColor3=Color3.fromRGB(150,150,150)
btns[j].btn.BackgroundTransparency=0.5
btns[j].ind.Visible=false
end
pages[i].Visible=true
b.TextColor3=Color3.fromRGB(255,255,255)
b.BackgroundTransparency=0.2
ind.Visible=true
end)
end
btns[1].btn.TextColor3=Color3.fromRGB(255,255,255)
btns[1].btn.BackgroundTransparency=0.2

local profile=Instance.new("Frame")
profile.Size=UDim2.new(1,-10,0,60)
profile.Position=UDim2.new(0,5,1,-70)
profile.BackgroundColor3=Color3.fromRGB(35,35,40)
profile.BackgroundTransparency=0.5
profile.Parent=sidebar
Instance.new("UICorner",profile).CornerRadius=UDim.new(0,8)

local pImg=Instance.new("ImageLabel")
pImg.Size=UDim2.new(0,40,0,40)
pImg.Position=UDim2.new(0,10,0,10)
pImg.BackgroundColor3=Color3.fromRGB(0,255,150)
pImg.Text=""
pImg.Parent=profile
Instance.new("UICorner",pImg).CornerRadius=UDim.new(0,20)

local ok,url=pcall(function()
return game:GetService("Players"):GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size150x150)
end)
if ok and url then pImg.Image=url end

local pName=Instance.new("TextLabel")
pName.Size=UDim2.new(1,-60,0,15)
pName.Position=UDim2.new(0,55,0,14)
pName.BackgroundTransparency=1
pName.Text=p.DisplayName
pName.TextColor3=Color3.fromRGB(255,255,255)
pName.Font=Enum.Font.GothamBold
pName.TextSize=12
pName.TextXAlignment=Enum.TextXAlignment.Left
pName.Parent=profile
local pHandle=Instance.new("TextLabel")
pHandle.Size=UDim2.new(1,-60,0,15)
pHandle.Position=UDim2.new(0,55,0,31)
pHandle.BackgroundTransparency=1
pHandle.Text="@"..p.Name
pHandle.TextColor3=Color3.fromRGB(150,150,150)
pHandle.Font=Enum.Font.Gotham
pHandle.TextSize=10
pHandle.TextXAlignment=Enum.TextXAlignment.Left
pHandle.Parent=profile
local function createToggle(parent,txt,default,cb)
local btn=Instance.new("TextButton")
btn.Size=UDim2.new(1,0,0,45)
btn.BackgroundColor3=Color3.fromRGB(40,40,45)
btn.BackgroundTransparency=0.4
btn.Text=""
btn.AutoButtonColor=false
btn.Parent=parent
Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)
local lbl=Instance.new("TextLabel")
lbl.Size=UDim2.new(0.7,0,1,0)
lbl.Position=UDim2.new(0,15,0,0)
lbl.BackgroundTransparency=1
lbl.Text=txt
lbl.TextColor3=Color3.fromRGB(200,200,200)
lbl.Font=Enum.Font.Gotham
lbl.TextSize=13
lbl.TextXAlignment=Enum.TextXAlignment.Left
lbl.Parent=btn
local sw=Instance.new("Frame")
sw.Size=UDim2.new(0,45,0,22)
sw.Position=UDim2.new(1,-55,0.5,-11)
sw.BackgroundColor3=default and Color3.fromRGB(0,255,150) or Color3.fromRGB(80,80,85)
sw.Parent=btn
Instance.new("UICorner",sw).CornerRadius=UDim.new(0,11)
local kn=Instance.new("Frame")
kn.Size=UDim2.new(0,18,0,18)
kn.Position=default and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9)
kn.BackgroundColor3=Color3.fromRGB(255,255,255)
kn.Parent=sw
Instance.new("UICorner",kn).CornerRadius=UDim.new(0,9)
local state=default
btn.MouseButton1Click:Connect(function()
state=not state
sw.BackgroundColor3=state and Color3.fromRGB(0,255,150) or Color3.fromRGB(80,80,85)
kn.Position=state and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9)
cb(state)
end)
return btn
end

local function createAccordion(parent,txt,build)
local wrap=Instance.new("Frame")
wrap.Size=UDim2.new(1,0,0,40)
wrap.AutomaticSize=Enum.AutomaticSize.Y
wrap.BackgroundColor3=Color3.fromRGB(40,40,45)
wrap.BackgroundTransparency=0.4
wrap.Parent=parent
Instance.new("UICorner",wrap).CornerRadius=UDim.new(0,8)
local wL=Instance.new("UIListLayout",wrap)
wL.SortOrder=Enum.SortOrder.LayoutOrder
wL.Padding=UDim.new(0,0)
local hd=Instance.new("TextButton")
hd.Size=UDim2.new(1,0,0,40)
hd.BackgroundTransparency=1
hd.Text="   "..txt
hd.TextColor3=Color3.fromRGB(200,200,200)
hd.Font=Enum.Font.GothamBold
hd.TextSize=13
hd.TextXAlignment=Enum.TextXAlignment.Left
hd.LayoutOrder=1
hd.AutoButtonColor=false
hd.Parent=wrap
local ar=Instance.new("TextLabel")
ar.Size=UDim2.new(0,20,0,20)
ar.Position=UDim2.new(1,-30,0.5,-10)
ar.BackgroundTransparency=1
ar.Text="▼"
ar.TextColor3=Color3.fromRGB(150,150,150)
ar.Font=Enum.Font.GothamBold
ar.TextSize=10
ar.Parent=hd
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
ar.Text=cf.Visible and "▲" or "▼"
end)
return wrap
end

-- プレイヤータブ
local pPage=pages[1]
local flightState=false
local fBV,fBG,fHum,fConn

local function stopFlight()
flightState=false
if fBV then fBV:Destroy() fBV=nil end
if fBG then fBG:Destroy() fBG=nil end
if fConn then fConn:Disconnect() fConn=nil end
if fHum then fHum.PlatformStand=false fHum=nil end
end

local function startFlight()
local c=p.Character
if not c then return end
local hrp=c:FindFirstChild("HumanoidRootPart")
local hum=c:FindFirstChildOfClass("Humanoid")
if not hrp or not hum then return end
flightState=true
fHum=hum
hum.PlatformStand=true
fBV=Instance.new("BodyVelocity",hrp)
fBV.MaxForce=Vector3.new(9e9,9e9,9e9)
fBV.Velocity=Vector3.zero
fBG=Instance.new("BodyGyro",hrp)
fBG.MaxTorque=Vector3.new(9e9,9e9,9e9)
fBG.P=10000
fBG.D=100
fConn=RS.RenderStepped:Connect(function()
if not flightState then return end
local c=p.Character
if not c then return end
local h=c:FindFirstChild("HumanoidRootPart")
if not h then return end
local cam=workspace.CurrentCamera
local d=Vector3.zero
if UIS:IsKeyDown(Enum.KeyCode.W)then d=d+cam.CFrame.LookVector end
if UIS:IsKeyDown(Enum.KeyCode.S)then d=d-cam.CFrame.LookVector end
if UIS:IsKeyDown(Enum.KeyCode.A)then d=d-cam.CFrame.RightVector end
if UIS:IsKeyDown(Enum.KeyCode.D)then d=d+cam.CFrame.RightVector end
if UIS:IsKeyDown(Enum.KeyCode.Space)then d=d+Vector3.new(0,1,0)end
if UIS:IsKeyDown(Enum.KeyCode.LeftControl)then d=d-Vector3.new(0,1,0)end
fBV.Velocity=d*50
fBG.CFrame=cam.CFrame
end)
end

createToggle(pPage,"飛行",false,function(s)
if s then startFlight() else stopFlight() end
end)

createToggle(pPage,"無限ジャンプ",false,function(s)
if s then
local cn
cn=UIS.JumpRequest:Connect(function()
local c=p.Character
if not c then return end
local h=c:FindFirstChildOfClass("Humanoid")
if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end
end)
end
end)

local tpBtn=Instance.new("TextButton")
tpBtn.Size=UDim2.new(1,0,0,45)
tpBtn.Text="ランダムTP"
tpBtn.BackgroundColor3=Color3.fromRGB(40,40,45)
tpBtn.BackgroundTransparency=0.4
tpBtn.TextColor3=Color3.fromRGB(200,200,200)
tpBtn.Font=Enum.Font.GothamBold
tpBtn.TextSize=13
tpBtn.AutoButtonColor=false
tpBtn.Parent=pPage
Instance.new("UICorner",tpBtn).CornerRadius=UDim.new(0,8)
tpBtn.MouseButton1Click:Connect(function()
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
-- ツールタブ
local tPage=pages[2]

createAccordion(tPage,"スピン",function(cf)
local box=Instance.new("TextBox")
box.Size=UDim2.new(1,0,0,35)
box.Text="5"
box.BackgroundColor3=Color3.fromRGB(50,50,55)
box.BackgroundTransparency=0.3
box.TextColor3=Color3.fromRGB(0,255,150)
box.Font=Enum.Font.GothamBold
box.TextSize=13
box.ClearTextOnFocus=false
box.Parent=cf
Instance.new("UICorner",box).CornerRadius=UDim.new(0,6)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,0,0,35)
b.Text="実行"
b.BackgroundColor3=Color3.fromRGB(0,255,150)
b.TextColor3=Color3.fromRGB(0,0,0)
b.Font=Enum.Font.GothamBold
b.TextSize=13
b.AutoButtonColor=false
b.Parent=cf
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

createAccordion(tPage,"貫通",function(cf)
createToggle(cf,"貫通有効",false,function(s)
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
end)

createAccordion(tPage,"無敵",function(cf)
createToggle(cf,"無敵有効",false,function(s)
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

createAccordion(tPage,"リスポーン",function(cf)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,0,0,35)
b.Text="今すぐリスポーン"
b.BackgroundColor3=Color3.fromRGB(255,100,100)
b.TextColor3=Color3.fromRGB(255,255,255)
b.Font=Enum.Font.GothamBold
b.TextSize=13
b.AutoButtonColor=false
b.Parent=cf
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
if p.Character then
local h=p.Character:FindFirstChildOfClass("Humanoid")
if h then h.Health=0 end
end
end)
end)

createAccordion(tPage,"TP",function(cf)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,0,0,35)
b.Text="ランダムプレイヤーへ"
b.BackgroundColor3=Color3.fromRGB(0,255,150)
b.TextColor3=Color3.fromRGB(0,0,0)
b.Font=Enum.Font.GothamBold
b.TextSize=13
b.AutoButtonColor=false
b.Parent=cf
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

createAccordion(tPage,"透明化",function(cf)
createToggle(cf,"透明有効",false,function(s)
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
dev.Text="開発中"
dev.TextColor3=Color3.fromRGB(150,150,150)
dev.Font=Enum.Font.GothamBold
dev.TextSize=24
dev.Parent=oPage

-- ターゲットタブ
local tgtPage=pages[3]
local targetList=Instance.new("ScrollingFrame")
targetList.Size=UDim2.new(1,0,0,140)
targetList.BackgroundColor3=Color3.fromRGB(30,30,35)
targetList.BackgroundTransparency=0.4
targetList.ScrollBarThickness=4
targetList.BorderSizePixel=0
targetList.Parent=tgtPage
Instance.new("UICorner",targetList).CornerRadius=UDim.new(0,8)
local tlL=Instance.new("UIListLayout",targetList)
tlL.Padding=UDim.new(0,4)
local function updT()
for _,v in ipairs(targetList:GetChildren())do
if v:IsA("TextButton")then v:Destroy()end
end
for _,pl in ipairs(game.Players:GetPlayers())do
if pl~=p then
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-5,0,30)
b.Text=pl.Name
b.BackgroundColor3=Color3.fromRGB(35,35,40)
b.TextColor3=Color3.fromRGB(200,200,200)
b.Font=Enum.Font.Gotham
b.TextSize=12
b.AutoButtonColor=false
b.Parent=targetList
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
saveBox.PlaceholderText="場所の名前"
saveBox.BackgroundColor3=Color3.fromRGB(50,50,55)
saveBox.BackgroundTransparency=0.3
saveBox.TextColor3=Color3.fromRGB(0,255,150)
saveBox.Font=Enum.Font.GothamBold
saveBox.TextSize=12
saveBox.ClearTextOnFocus=false
saveBox.Parent=saveRow
Instance.new("UICorner",saveBox).CornerRadius=UDim.new(0,6)
local saveBtn=Instance.new("TextButton")
saveBtn.Size=UDim2.new(0.35,0,1,0)
saveBtn.Position=UDim2.new(0.65,0,0,0)
saveBtn.Text="保存"
saveBtn.BackgroundColor3=Color3.fromRGB(0,255,150)
saveBtn.TextColor3=Color3.fromRGB(0,0,0)
saveBtn.Font=Enum.Font.GothamBold
saveBtn.TextSize=12
saveBtn.AutoButtonColor=false
saveBtn.Parent=saveRow
Instance.new("UICorner",saveBtn).CornerRadius=UDim.new(0,6)

local locList=Instance.new("ScrollingFrame")
locList.Size=UDim2.new(1,0,0,100)
locList.BackgroundColor3=Color3.fromRGB(30,30,35)
locList.BackgroundTransparency=0.4
locList.ScrollBarThickness=4
locList.BorderSizePixel=0
locList.Parent=tgtPage
Instance.new("UICorner",locList).CornerRadius=UDim.new(0,8)
local llL=Instance.new("UIListLayout",locList)
llL.Padding=UDim.new(0,4)
local saved={}
local function refreshLocs()
for _,v in ipairs(locList:GetChildren())do
if v:IsA("TextButton")then v:Destroy()end
end
for _,loc in ipairs(saved)do
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-5,0,30)
b.Text=loc.name
b.BackgroundColor3=Color3.fromRGB(35,35,40)
b.TextColor3=Color3.fromRGB(200,200,200)
b.Font=Enum.Font.Gotham
b.TextSize=12
b.AutoButtonColor=false
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
rf.Size=UDim2.new(1,0,0,30)
rf.Text="更新"
rf.BackgroundColor3=Color3.fromRGB(0,255,150)
rf.TextColor3=Color3.fromRGB(0,0,0)
rf.Font=Enum.Font.GothamBold
rf.TextSize=12
rf.AutoButtonColor=false
rf.Parent=dPage
Instance.new("UICorner",rf).CornerRadius=UDim.new(0,6)
local sf=Instance.new("ScrollingFrame")
sf.Size=UDim2.new(1,0,1,-40)
sf.Position=UDim2.new(0,0,0,35)
sf.BackgroundTransparency=1
sf.ScrollBarThickness=4
sf.BorderSizePixel=0
sf.Parent=dPage
local sl2=Instance.new("UIListLayout",sf)
sl2.Padding=UDim.new(0,4)
local function upd()
for _,v in ipairs(sf:GetChildren())do
if v:IsA("TextButton")then v:Destroy()end
end
for _,pl in ipairs(game.Players:GetPlayers())do
if pl~=p then
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-5,0,30)
b.Text=pl.Name
b.BackgroundColor3=Color3.fromRGB(35,35,40)
b.BackgroundTransparency=0.4
b.TextColor3=Color3.fromRGB(200,200,200)
b.Font=Enum.Font.Gotham
b.TextSize=12
b.AutoButtonColor=false
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

-- ドラッグ移動
local dragging,dragInput,dragStart,startPos
top.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
dragging=true
dragStart=input.Position
startPos=f.Position
input.Changed:Connect(function()
if input.UserInputState==Enum.UserInputState.End then dragging=false end
end)
end
end)
top.InputChanged:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
dragInput=input
end
end)
UIS.InputChanged:Connect(function(input)
if input==dragInput and dragging then
local d=input.Position-dragStart
f.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
end
end)

-- 言語切り替え
lb.MouseButton1Click:Connect(function()
if lb.Text=="🇯🇵 日本語"then
lb.Text="🇺🇸 English"
for i=1,5 do btns[i].btn.Text="   "..enNames[i]end
else
lb.Text="🇯🇵 日本語"
for i=1,5 do btns[i].btn.Text="   "..tabNames[i]end
end
end)

-- リスポーン時の処理
p.CharacterAdded:Connect(function(ch)
stopFlight()
task.wait(1)
local h=ch:FindFirstChildOfClass("Humanoid")
if h then
h.WalkSpeed=16
h.UseJumpPower=true
h.JumpPower=50
end
end)
