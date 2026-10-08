local p=game.Players.LocalPlayer
local pg=p:WaitForChild("PlayerGui")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
if pg:FindFirstChild("VoidUI")then pg.VoidUI:Destroy()end
local sg=Instance.new("ScreenGui",pg)sg.Name="VoidUI"sg.ResetOnSpawn=false

local f=Instance.new("Frame",sg)f.Size=UDim2.new(0,650,0,400)f.Position=UDim2.new(.5,-325,.5,-200)f.BackgroundColor3=Color3.fromRGB(30,30,35)f.BackgroundTransparency=.2 f.Active=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,12)
local st=Instance.new("UIStroke",f)st.Color=Color3.fromRGB(0,255,150)st.Thickness=1 st.Transparency=.6
local gd=Instance.new("UIGradient",f)gd.Color=ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(80,80,80))gd.Rotation=45

local floatBtn=Instance.new("TextButton",sg)floatBtn.Size=UDim2.new(0,45,0,45)floatBtn.Position=UDim2.new(0,15,.5,-22.5)floatBtn.BackgroundColor3=Color3.fromRGB(30,30,35)floatBtn.BackgroundTransparency=.2 floatBtn.Text="V"floatBtn.TextColor3=Color3.fromRGB(0,255,150)floatBtn.Font=Enum.Font.GothamBold floatBtn.TextSize=22 floatBtn.Visible=false
Instance.new("UICorner",floatBtn).CornerRadius=UDim.new(0,12)
Instance.new("UIStroke",floatBtn).Color=Color3.fromRGB(0,255,150)
local fbd=false local fbm=false local fbs local fbp
floatBtn.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fbd=true fbm=false fbs=i.Position fbp=floatBtn.Position end end)
UIS.InputChanged:Connect(function(i)if fbd and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-fbs if math.abs(d.X)>5 or math.abs(d.Y)>5 then fbm=true end floatBtn.Position=UDim2.new(fbp.X.Scale,fbp.X.Offset+d.X,fbp.Y.Scale,fbp.Y.Offset+d.Y)end end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fbd=false end end)
floatBtn.MouseButton1Click:Connect(function()if fbm then return end f.Visible=true floatBtn.Visible=false end)

local top=Instance.new("Frame",f)top.Size=UDim2.new(1,0,0,45)top.BackgroundTransparency=1
local logo=Instance.new("TextLabel",top)logo.Size=UDim2.new(0,35,0,35)logo.Position=UDim2.new(0,10,0,5)logo.BackgroundColor3=Color3.fromRGB(20,20,25)logo.Text="V"logo.TextColor3=Color3.fromRGB(0,255,150)logo.Font=Enum.Font.GothamBold logo.TextSize=20
Instance.new("UICorner",logo).CornerRadius=UDim.new(0,8)
Instance.new("UIStroke",logo).Color=Color3.fromRGB(0,255,150)
local title=Instance.new("TextLabel",top)title.Size=UDim2.new(0,200,0,20)title.Position=UDim2.new(0,55,0,5)title.BackgroundTransparency=1 title.Text="Void"title.TextColor3=Color3.fromRGB(0,255,150)title.Font=Enum.Font.GothamBold title.TextSize=16 title.TextXAlignment=Enum.TextXAlignment.Left
local discord=Instance.new("TextButton",top)discord.Size=UDim2.new(0,200,0,15)discord.Position=UDim2.new(0,55,0,25)discord.BackgroundTransparency=1 discord.Text="discord.gg/Znj8eBfa9"discord.TextColor3=Color3.fromRGB(150,150,150)discord.Font=Enum.Font.Gotham discord.TextSize=10 discord.TextXAlignment=Enum.TextXAlignment.Left
discord.MouseButton1Click:Connect(function()if setclipboard then setclipboard("https://discord.gg/Znj8eBfa9")end end)
local lb=Instance.new("TextButton",top)lb.Size=UDim2.new(0,90,0,25)lb.Position=UDim2.new(1,-210,0,10)lb.Text="🇯🇵 日本語"lb.BackgroundColor3=Color3.fromRGB(40,40,45)lb.BackgroundTransparency=.4 lb.TextColor3=Color3.fromRGB(255,255,255)lb.Font=Enum.Font.Gotham lb.TextSize=11
Instance.new("UICorner",lb).CornerRadius=UDim.new(0,6)
local minBtn=Instance.new("TextButton",top)minBtn.Size=UDim2.new(0,25,0,25)minBtn.Position=UDim2.new(1,-80,0,10)minBtn.Text="-"minBtn.BackgroundColor3=Color3.fromRGB(40,40,45)minBtn.BackgroundTransparency=.4 minBtn.TextColor3=Color3.fromRGB(255,255,255)minBtn.Font=Enum.Font.GothamBold
Instance.new("UICorner",minBtn).CornerRadius=UDim.new(0,6)
local close=Instance.new("TextButton",top)close.Size=UDim2.new(0,25,0,25)close.Position=UDim2.new(1,-45,0,10)close.Text="X"close.BackgroundColor3=Color3.fromRGB(40,40,45)close.BackgroundTransparency=.4 close.TextColor3=Color3.fromRGB(255,100,100)close.Font=Enum.Font.GothamBold
Instance.new("UICorner",close).CornerRadius=UDim.new(0,6)
close.MouseButton1Click:Connect(function()f.Visible=false floatBtn.Visible=true end)
minBtn.MouseButton1Click:Connect(function()f.Visible=false floatBtn.Visible=true end)
local sidebar=Instance.new("Frame",f)sidebar.Size=UDim2.new(0,150,1,-55)sidebar.Position=UDim2.new(0,5,0,50)sidebar.BackgroundColor3=Color3.fromRGB(25,25,30)sidebar.BackgroundTransparency=.3
Instance.new("UICorner",sidebar).CornerRadius=UDim.new(0,10)
local sbLay=Instance.new("UIListLayout",sidebar)sbLay.Padding=UDim.new(0,5)sbLay.SortOrder=Enum.SortOrder.LayoutOrder
local tabNames={"プレイヤー","ツール","ターゲット","その他","デレポート"}
local enNames={"Player","Tools","Target","Others","Teleport"}
local pages={} local btns={}
local content=Instance.new("Frame",f)content.Size=UDim2.new(1,-165,1,-65)content.Position=UDim2.new(0,160,0,55)content.BackgroundTransparency=1
for i=1,5 do
local pp=Instance.new("Frame",content)pp.Size=UDim2.new(1,0,1,0)pp.BackgroundTransparency=1 pp.Visible=(i==1)
local lay=Instance.new("UIListLayout",pp)lay.Padding=UDim.new(0,8)
pages[i]=pp
end
for i,n in ipairs(tabNames)do
local b=Instance.new("TextButton",sidebar)b.Size=UDim2.new(1,0,0,35)b.Text="  "..n b.BackgroundColor3=Color3.fromRGB(35,35,40)b.BackgroundTransparency=.5 b.TextColor3=Color3.fromRGB(150,150,150)b.Font=Enum.Font.Gotham b.TextSize=12 b.TextXAlignment=Enum.TextXAlignment.Left b.LayoutOrder=i
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
local ind=Instance.new("Frame",b)ind.Size=UDim2.new(0,3,.6,0)ind.Position=UDim2.new(0,3,.2,0)ind.BackgroundColor3=Color3.fromRGB(0,255,150)ind.Visible=(i==1)
Instance.new("UICorner",ind).CornerRadius=UDim.new(0,2)
btns[i]=b
b.MouseButton1Click:Connect(function()
for j=1,5 do pages[j].Visible=(j==i) btns[j].TextColor3=Color3.fromRGB(150,150,150) btns[j].BackgroundTransparency=.5 btns[j].ind.Visible=false end
pages[i].Visible=true b.TextColor3=Color3.fromRGB(255,255,255)b.BackgroundTransparency=.2 ind.Visible=true
end)
end
btns[1].TextColor3=Color3.fromRGB(255,255,255)btns[1].BackgroundTransparency=.2
-- プロフィール（左下）
local profile=Instance.new("Frame",sidebar)profile.Size=UDim2.new(1,0,0,65)profile.BackgroundColor3=Color3.fromRGB(35,35,40)profile.BackgroundTransparency=.5 profile.LayoutOrder=6
Instance.new("UICorner",profile).CornerRadius=UDim.new(0,8)
local pImg=Instance.new("ImageLabel",profile)pImg.Size=UDim2.new(0,40,0,40)pImg.Position=UDim2.new(0,10,0,12)pImg.BackgroundColor3=Color3.fromRGB(50,50,55)pImg.Image="rbxassetid://"..p.UserId
Instance.new("UICorner",pImg).CornerRadius=UDim.new(0,20)
local pName=Instance.new("TextLabel",profile)pName.Size=UDim2.new(1,-60,0,15)pName.Position=UDim2.new(0,55,0,15)pName.BackgroundTransparency=1 pName.Text=p.DisplayName pName.TextColor3=Color3.fromRGB(255,255,255)pName.Font=Enum.Font.GothamBold pName.TextSize=12 pName.TextXAlignment=Enum.TextXAlignment.Left
local pHandle=Instance.new("TextLabel",profile)pHandle.Size=UDim2.new(1,-60,0,15)pHandle.Position=UDim2.new(0,55,0,32)pHandle.BackgroundTransparency=1 pHandle.Text="@"..p.Name pHandle.TextColor3=Color3.fromRGB(150,150,150)pHandle.Font=Enum.Font.Gotham pHandle.TextSize=10 pHandle.TextXAlignment=Enum.TextXAlignment.Left
-- トグルスイッチ
local function createToggle(parent,txt,default,cb)
local c=Instance.new("Frame",parent)c.Size=UDim2.new(1,0,0,45)c.BackgroundColor3=Color3.fromRGB(40,40,45)c.BackgroundTransparency=.4
Instance.new("UICorner",c).CornerRadius=UDim.new(0,8)
local lbl=Instance.new("TextLabel",c)lbl.Size=UDim2.new(.7,0,1,0)lbl.Position=UDim2.new(0,15,0,0)lbl.BackgroundTransparency=1 lbl.Text=txt lbl.TextColor3=Color3.fromRGB(200,200,200)lbl.Font=Enum.Font.Gotham lbl.TextSize=13 lbl.TextXAlignment=Enum.TextXAlignment.Left
local switch=Instance.new("Frame",c)switch.Size=UDim2.new(0,45,0,22)switch.Position=UDim2.new(1,-55,.5,-11)switch.BackgroundColor3=default and Color3.fromRGB(0,255,150)or Color3.fromRGB(80,80,85)
Instance.new("UICorner",switch).CornerRadius=UDim.new(0,11)
local knob=Instance.new("TextButton",switch)knob.Size=UDim2.new(0,18,0,18)knob.Position=default and UDim2.new(1,-20,.5,-9)or UDim2.new(0,2,.5,-9)knob.BackgroundColor3=Color3.fromRGB(255,255,255)knob.Text=""
Instance.new("UICorner",knob).CornerRadius=UDim.new(0,9)
local state=default
knob.MouseButton1Click:Connect(function()
state=not state
switch.BackgroundColor3=state and Color3.fromRGB(0,255,150)or Color3.fromRGB(80,80,85)
knob.Position=state and UDim2.new(1,-20,.5,-9)or UDim2.new(0,2,.5,-9)
cb(state)
end)
return c,function()return state end,function()state=not state switch.BackgroundColor3=state and Color3.fromRGB(0,255,150)or Color3.fromRGB(80,80,85) knob.Position=state and UDim2.new(1,-20,.5,-9)or UDim2.new(0,2,.5,-9) cb(state)end
end

-- ツール用アコーディオン（押すと下にアイテムが出る）
local function createToolAccordion(parent,txt,createContent)
local container=Instance.new("Frame",parent)container.Size=UDim2.new(1,0,0,40)container.BackgroundColor3=Color3.fromRGB(40,40,45)container.BackgroundTransparency=.4
Instance.new("UICorner",container).CornerRadius=UDim.new(0,8)
local btn=Instance.new("TextButton",container)btn.Size=UDim2.new(1,0,0,40)btn.Text=txt btn.BackgroundTransparency=1 btn.TextColor3=Color3.fromRGB(200,200,200)btn.Font=Enum.Font.GothamBold btn.TextSize=13
local arrow=Instance.new("TextLabel",container)arrow.Size=UDim2.new(0,20,0,20)arrow.Position=UDim2.new(1,-30,0,10)arrow.BackgroundTransparency=1 arrow.Text="▼"arrow.TextColor3=Color3.fromRGB(150,150,150)arrow.Font=Enum.Font.GothamBold arrow.TextSize=10
local contentFrame=Instance.new("Frame",container)contentFrame.Size=UDim2.new(1,-10,0,0)contentFrame.Position=UDim2.new(0,5,0,45)contentFrame.BackgroundTransparency=1 contentFrame.Visible=false
local cLay=Instance.new("UIListLayout",contentFrame)cLay.Padding=UDim.new(0,5)
createContent(contentFrame)
btn.MouseButton1Click:Connect(function()
contentFrame.Visible=not contentFrame.Visible
arrow.Text=contentFrame.Visible and "▲" or "▼"
local h=contentFrame.Visible and (#contentFrame:GetChildren()*50) or 0
container.Size=UDim2.new(1,0,0,40+h)
end)
return container,contentFrame
end
local pPage=pages[1]
createToggle(pPage,"飛行",false,function(state)
if state then
local c=p.Character if not c then return end
local h=c:FindFirstChild("HumanoidRootPart")local hum=c:FindFirstChildOfClass("Humanoid")
if not h or not hum then return end
hum.PlatformStand=true
local bv=Instance.new("BodyVelocity",h)bv.MaxForce=Vector3.new(9e9,9e9,9e9)bv.Velocity=Vector3.zero
local bg=Instance.new("BodyGyro",h)bg.MaxTorque=Vector3.new(9e9,9e9,9e9)bg.P=10000 bg.D=100
local cn=RS.RenderStepped:Connect(function()
if not state then cn:Disconnect() bv:Destroy() bg:Destroy() hum.PlatformStand=false return end
local c=p.Character if not c then return end
local h=c:FindFirstChild("HumanoidRootPart") if not h then return end
local cam=workspace.CurrentCamera local d=Vector3.zero
if UIS:IsKeyDown(Enum.KeyCode.W)then d=d+cam.CFrame.LookVector end
if UIS:IsKeyDown(Enum.KeyCode.S)then d=d-cam.CFrame.LookVector end
if UIS:IsKeyDown(Enum.KeyCode.A)then d=d-cam.CFrame.RightVector end
if UIS:IsKeyDown(Enum.KeyCode.D)then d=d+cam.CFrame.RightVector end
if UIS:IsKeyDown(Enum.KeyCode.Space)then d=d+Vector3.new(0,1,0)end
if UIS:IsKeyDown(Enum.KeyCode.LeftControl)then d=d-Vector3.new(0,1,0)end
bv.Velocity=d*50 bg.CFrame=cam.CFrame
end)
end
end)
createToggle(pPage,"無限ジャンプ",false,function(state)
if state then
local cn=UIS.JumpRequest:Connect(function()
local c=p.Character if not c then return end
local h=c:FindFirstChildOfClass("Humanoid")
if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
end)
p.Character.AncestryChanged:Connect(function()if not p.Character then cn:Disconnect()end end)
end
end)
local tpBtn=Instance.new("TextButton",pPage)tpBtn.Size=UDim2.new(1,0,0,40)tpBtn.Text="ランダムTP"tpBtn.BackgroundColor3=Color3.fromRGB(40,40,45)tpBtn.BackgroundTransparency=.4 tpBtn.TextColor3=Color3.fromRGB(200,200,200)tpBtn.Font=Enum.Font.GothamBold tpBtn.TextSize=13
Instance.new("UICorner",tpBtn).CornerRadius=UDim.new(0,8)
tpBtn.MouseButton1Click:Connect(function()
local ps=game.Players:GetPlayers() local others={}
for _,pl in ipairs(ps)do if pl~=p then table.insert(others,pl) end end
if #others>0 then
local t=others[math.random(1,#others)]
if t.Character and t.Character:FindFirstChild("HumanoidRootPart")and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
p.Character.HumanoidRootPart.CFrame=t.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
end
end
end)
-- デレポートタブ
local dPage=pages[5]
local rf=Instance.new("TextButton",dPage)rf.Size=UDim2.new(1,0,0,30)rf.Text="更新"rf.BackgroundColor3=Color3.fromRGB(0,255,150)rf.TextColor3=Color3.fromRGB(0,0,0)rf.Font=Enum.Font.GothamBold rf.TextSize=12
Instance.new("UICorner",rf).CornerRadius=UDim.new(0,6)
local sf=Instance.new("ScrollingFrame",dPage)sf.Size=UDim2.new(1,0,1,-40)sf.Position=UDim2.new(0,0,0,35)sf.BackgroundTransparency=1 sf.ScrollBarThickness=4
local sl2=Instance.new("UIListLayout",sf)sl2.Padding=UDim.new(0,4)
local function upd()
for _,ch in ipairs(sf:GetChildren())do if ch:IsA("TextButton")then ch:Destroy()end end
for _,pl in ipairs(game.Players:GetPlayers())do
if pl~=p then
local b=Instance.new("TextButton",sf)b.Size=UDim2.new(1,-5,0,30)b.Text=pl.Name b.BackgroundColor3=Color3.fromRGB(35,35,40)b.BackgroundTransparency=.4 b.TextColor3=Color3.fromRGB(200,200,200)b.Font=Enum.Font.Gotham b.TextSize=12
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
local ch=pl.Character
if ch and ch:FindFirstChild("HumanoidRootPart")and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
p.Character.HumanoidRootPart.CFrame=ch.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
end
end)
end
end
end
rf.MouseButton1Click:Connect(upd)upd()
local tPage=pages[2]
-- スピン
createToolAccordion(tPage,"スピン",function(parent)
local c=Instance.new("Frame",parent)c.Size=UDim2.new(1,0,0,35)c.BackgroundColor3=Color3.fromRGB(50,50,55)c.BackgroundTransparency=.3
Instance.new("UICorner",c).CornerRadius=UDim.new(0,6)
local box=Instance.new("TextBox",c)box.Size=UDim2.new(.6,0,1,0)box.Position=UDim2.new(0,5,0,0)box.BackgroundTransparency=1 box.Text="5"box.TextColor3=Color3.fromRGB(0,255,150)box.Font=Enum.Font.GothamBold box.TextSize=12 box.ClearTextOnFocus=false
local btn=Instance.new("TextButton",c)btn.Size=UDim2.new(.35,0,1,0)btn.Position=UDim2.new(.65,0,0,0)btn.Text="実行"btn.BackgroundColor3=Color3.fromRGB(0,255,150)btn.TextColor3=Color3.fromRGB(0,0,0)btn.Font=Enum.Font.GothamBold btn.TextSize=12
Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6)
local conn
btn.MouseButton1Click:Connect(function()
local spd=tonumber(box.Text) or 5
if conn then conn:Disconnect() end
conn=RS.Heartbeat:Connect(function(dt)
local c=p.Character if not c then return end
local h=c:FindFirstChild("HumanoidRootPart") if not h then return end
h.CFrame=h.CFrame*CFrame.Angles(0,math.rad(spd*dt*60),0)
end)
end)
end)
-- 貫通
createToolAccordion(tPage,"貫通",function(parent)
createToggle(parent,"貫通有効",false,function(state)
if state then
local ncConn=RS.Stepped:Connect(function()
local c=p.Character if not c then return end
for _,part in ipairs(c:GetDescendants())do if part:IsA("BasePart")then part.CanCollide=false end end
end)
p.Character.AncestryChanged:Connect(function()if not p.Character then ncConn:Disconnect()end end)
else
local c=p.Character if c then for _,part in ipairs(c:GetDescendants())do if part:IsA("BasePart")then part.CanCollide=true end end end
end
end)
end)
-- 無敵
createToolAccordion(tPage,"無敵",function(parent)
createToggle(parent,"無敵有効",false,function(state)
if state then
local godConn=RS.Heartbeat:Connect(function()
local c=p.Character if not c then return end
local h=c:FindFirstChildOfClass("Humanoid")
if h then h.Health=h.MaxHealth end
end)
p.Character.AncestryChanged:Connect(function()if not p.Character then godConn:Disconnect()end end)
end
end)
end)
-- リスポーン
createToolAccordion(tPage,"リスポーン",function(parent)
local b=Instance.new("TextButton",parent)b.Size=UDim2.new(1,0,0,35)b.Text="今すぐリスポーン"b.BackgroundColor3=Color3.fromRGB(255,100,100)b.TextColor3=Color3.fromRGB(255,255,255)b.Font=Enum.Font.GothamBold b.TextSize=12
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
if p.Character then local h=p.Character:FindFirstChildOfClass("Humanoid") if h then h.Health=0 end end
end)
end)
-- TP
createToolAccordion(tPage,"TP",function(parent)
local b=Instance.new("TextButton",parent)b.Size=UDim2.new(1,0,0,35)b.Text="ランダムTP"b.BackgroundColor3=Color3.fromRGB(0,255,150)b.TextColor3=Color3.fromRGB(0,0,0)b.Font=Enum.Font.GothamBold b.TextSize=12
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
local ps=game.Players:GetPlayers() local others={}
for _,pl in ipairs(ps)do if pl~=p then table.insert(others,pl) end end
if #others>0 then
local t=others[math.random(1,#others)]
if t.Character and t.Character:FindFirstChild("HumanoidRootPart")and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
p.Character.HumanoidRootPart.CFrame=t.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
end
end
end)
end)
-- 透明化
createToolAccordion(tPage,"透明化",function(parent)
createToggle(parent,"透明有効",false,function(state)
if state then
local invConn=RS.RenderStepped:Connect(function()
local c=p.Character if not c then return end
for _,part in ipairs(c:GetDescendants())do
if part:IsA("BasePart")then part.LocalTransparencyModifier=1 end
if part:IsA("Decal")then part.Transparency=1 end
end
end)
p.Character.AncestryChanged:Connect(function()if not p.Character then invConn:Disconnect()end end)
else
local c=p.Character if c then for _,part in ipairs(c:GetDescendants())do if part:IsA("BasePart")then part.LocalTransparencyModifier=0 end if part:IsA("Decal")then part.Transparency=0 end end end
end
end)
end)
-- その他
local oPage=pages[4]
local devLbl=Instance.new("TextLabel",oPage)devLbl.Size=UDim2.new(1,0,0,100)devLbl.BackgroundTransparency=1 devLbl.Text="開発中"devLbl.TextColor3=Color3.fromRGB(150,150,150)devLbl.Font=Enum.Font.GothamBold devLbl.TextSize=24
local tgtPage=pages[3]
local savedLocations={}
-- プレイヤーへのTP
local targetList=Instance.new("ScrollingFrame",tgtPage)targetList.Size=UDim2.new(1,0,0,120)targetList.BackgroundColor3=Color3.fromRGB(30,30,35)targetList.BackgroundTransparency=.4 targetList.ScrollBarThickness=4
Instance.new("UICorner",targetList).CornerRadius=UDim.new(0,8)
local tlLay=Instance.new("UIListLayout",targetList)tlLay.Padding=UDim.new(0,4)
local function updTargets()
for _,ch in ipairs(targetList:GetChildren())do if ch:IsA("TextButton")then ch:Destroy()end end
for _,pl in ipairs(game.Players:GetPlayers())do
if pl~=p then
local b=Instance.new("TextButton",targetList)b.Size=UDim2.new(1,-5,0,30)b.Text=pl.Name b.BackgroundColor3=Color3.fromRGB(35,35,40)b.TextColor3=Color3.fromRGB(200,200,200)b.Font=Enum.Font.Gotham b.TextSize=12
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
local ch=pl.Character
if ch and ch:FindFirstChild("HumanoidRootPart")and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
p.Character.HumanoidRootPart.CFrame=ch.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
end
end)
end
end
end
updTargets()
game.Players.PlayerAdded:Connect(updTargets)
game.Players.PlayerRemoving:Connect(updTargets)
-- 場所の保存
local saveFrame=Instance.new("Frame",tgtPage)saveFrame.Size=UDim2.new(1,0,0,40)saveFrame.BackgroundColor3=Color3.fromRGB(40,40,45)saveFrame.BackgroundTransparency=.4
Instance.new("UICorner",saveFrame).CornerRadius=UDim.new(0,8)
local saveBox=Instance.new("TextBox",saveFrame)saveBox.Size=UDim2.new(.6,0,1,0)saveBox.Position=UDim2.new(0,5,0,0)saveBox.BackgroundTransparency=1 saveBox.Text=""saveBox.PlaceholderText="場所の名前"saveBox.TextColor3=Color3.fromRGB(0,255,150)saveBox.Font=Enum.Font.GothamBold saveBox.TextSize=12
local saveBtn=Instance.new("TextButton",saveFrame)saveBtn.Size=UDim2.new(.35,0,1,0)saveBtn.Position=UDim2.new(.65,0,0,0)saveBtn.Text="保存"saveBtn.BackgroundColor3=Color3.fromRGB(0,255,150)saveBtn.TextColor3=Color3.fromRGB(0,0,0)saveBtn.Font=Enum.Font.GothamBold saveBtn.TextSize=12
Instance.new("UICorner",saveBtn).CornerRadius=UDim.new(0,6)
saveBtn.MouseButton1Click:Connect(function()
if p.Character and p.Character:FindFirstChild("HumanoidRootPart")and saveBox.Text~=""then
table.insert(savedLocations,{name=saveBox.Text,cframe=p.Character.HumanoidRootPart.CFrame})
saveBox.Text=""
-- リスト更新
for _,ch in ipairs(tgtPage:GetChildren())do if ch:IsA("ScrollingFrame")and ch~=targetList then ch:Destroy()end end
local locList=Instance.new("ScrollingFrame",tgtPage)locList.Size=UDim2.new(1,0,0,100)locList.BackgroundColor3=Color3.fromRGB(30,30,35)locList.BackgroundTransparency=.4 locList.ScrollBarThickness=4
Instance.new("UICorner",locList).CornerRadius=UDim.new(0,8)
local llLay=Instance.new("UIListLayout",locList)llLay.Padding=UDim.new(0,4)
for _,loc in ipairs(savedLocations)do
local b=Instance.new("TextButton",locList)b.Size=UDim2.new(1,-5,0,30)b.Text=loc.name b.BackgroundColor3=Color3.fromRGB(35,35,40)b.TextColor3=Color3.fromRGB(200,200,200)b.Font=Enum.Font.Gotham b.TextSize=12
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
if p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
p.Character.HumanoidRootPart.CFrame=loc.cframe
end
end)
end
end
end)

-- ドラッグ移動
local dragging,dragInput,dragStart,startPos
top.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
dragging=true dragStart=input.Position startPos=f.Position
input.Changed:Connect(function()if input.UserInputState==Enum.UserInputState.End then dragging=false end end)
end
end)
top.InputChanged:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then dragInput=input end
end)
UIS.InputChanged:Connect(function(input)
if input==dragInput and dragging then
local delta=input.Position-dragStart
f.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
end
end)

-- 言語切り替え
lb.MouseButton1Click:Connect(function()
if lb.Text=="🇯🇵 日本語"then
lb.Text="🇺🇸 English"
for i,b in ipairs(btns)do b.Text="  "..enNames[i] end
else
lb.Text="🇯🇵 日本語"
for i,b in ipairs(btns)do b.Text="  "..tabNames[i] end
end
end)

-- キャラクター再スポーン時の処理
p.CharacterAdded:Connect(function(ch)
task.wait(1)
local h=ch:FindFirstChildOfClass("Humanoid")
if h then h.WalkSpeed=16 h.UseJumpPower=true h.JumpPower=50 end
end)
