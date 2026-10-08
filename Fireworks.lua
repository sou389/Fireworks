local p=game.Players.LocalPlayer
local pg=p:WaitForChild("PlayerGui")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
if pg:FindFirstChild("VoidUI")then pg.VoidUI:Destroy()end
local sg=Instance.new("ScreenGui",pg)sg.Name="VoidUI"sg.ResetOnSpawn=false

-- メインフレーム
local f=Instance.new("Frame",sg)f.Size=UDim2.new(0,650,0,400)f.Position=UDim2.new(.5,-325,.5,-200)f.BackgroundColor3=Color3.fromRGB(35,35,40)f.BackgroundTransparency=.2 f.Active=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,12)
local st=Instance.new("UIStroke",f)st.Color=Color3.fromRGB(0,255,150)st.Thickness=1 st.Transparency=.6
local gd=Instance.new("UIGradient",f)gd.Color=ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(80,80,80))gd.Rotation=45

-- 浮き出るVボタン（最小化用）
local floatBtn=Instance.new("TextButton",sg)floatBtn.Size=UDim2.new(0,45,0,45)floatBtn.Position=UDim2.new(0,15,.5,-22.5)floatBtn.BackgroundColor3=Color3.fromRGB(35,35,40)floatBtn.BackgroundTransparency=.2 floatBtn.Text="V"floatBtn.TextColor3=Color3.fromRGB(0,255,150)floatBtn.Font=Enum.Font.GothamBold floatBtn.TextSize=22 floatBtn.Visible=false
Instance.new("UICorner",floatBtn).CornerRadius=UDim.new(0,12)
Instance.new("UIStroke",floatBtn).Color=Color3.fromRGB(0,255,150)
local fbd=false local fbm=false local fbs local fbp
floatBtn.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fbd=true fbm=false fbs=i.Position fbp=floatBtn.Position end end)
UIS.InputChanged:Connect(function(i)if fbd and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-fbs if math.abs(d.X)>5 or math.abs(d.Y)>5 then fbm=true end floatBtn.Position=UDim2.new(fbp.X.Scale,fbp.X.Offset+d.X,fbp.Y.Scale,fbp.Y.Offset+d.Y)end end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fbd=false end end)
floatBtn.MouseButton1Click:Connect(function()if fbm then return end f.Visible=true floatBtn.Visible=false end)

-- トップバー
local top=Instance.new("Frame",f)top.Size=UDim2.new(1,0,0,45)top.BackgroundTransparency=1
local logo=Instance.new("TextLabel",top)logo.Size=UDim2.new(0,35,0,35)logo.Position=UDim2.new(0,10,0,5)logo.BackgroundColor3=Color3.fromRGB(20,20,25)logo.Text="C"logo.TextColor3=Color3.fromRGB(0,255,150)logo.Font=Enum.Font.GothamBold logo.TextSize=20
Instance.new("UICorner",logo).CornerRadius=UDim.new(0,8)
Instance.new("UIStroke",logo).Color=Color3.fromRGB(0,255,150)
local title=Instance.new("TextLabel",top)title.Size=UDim2.new(0,200,0,20)title.Position=UDim2.new(0,55,0,5)title.BackgroundTransparency=1 title.Text="Cryptic Hub"title.TextColor3=Color3.fromRGB(0,255,150)title.Font=Enum.Font.GothamBold title.TextSize=16 title.TextXAlignment=Enum.TextXAlignment.Left
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
local profile=Instance.new("Frame",sidebar)profile.Size=UDim2.new(1,0,0,60)profile.BackgroundColor3=Color3.fromRGB(35,35,40)profile.BackgroundTransparency=.5 profile.LayoutOrder=6
Instance.new("UICorner",profile).CornerRadius=UDim.new(0,8)
local pImg=Instance.new("ImageLabel",profile)pImg.Size=UDim2.new(0,35,0,35)pImg.Position=UDim2.new(0,10,0,12)pImg.BackgroundColor3=Color3.fromRGB(50,50,55)pImg.Image="rbxassetid://0"
Instance.new("UICorner",pImg).CornerRadius=UDim.new(0,17)
local pName=Instance.new("TextLabel",profile)pName.Size=UDim2.new(1,-55,0,15)pName.Position=UDim2.new(0,50,0,15)pName.BackgroundTransparency=1 pName.Text=p.Name pName.TextColor3=Color3.fromRGB(255,255,255)pName.Font=Enum.Font.GothamBold pName.TextSize=12 pName.TextXAlignment=Enum.TextXAlignment.Left
local pHandle=Instance.new("TextLabel",profile)pHandle.Size=UDim2.new(1,-55,0,15)pHandle.Position=UDim2.new(0,50,0,30)pHandle.BackgroundTransparency=1 pHandle.Text="@"..p.Name pHandle.TextColor3=Color3.fromRGB(150,150,150)pHandle.Font=Enum.Font.Gotham pHandle.TextSize=10 pHandle.TextXAlignment=Enum.TextXAlignment.Left
-- トグルスイッチ生成関数
local function createToggle(parent,txt,default,cb)
local c=Instance.new("Frame",parent)c.Size=UDim2.new(1,0,0,40)c.BackgroundColor3=Color3.fromRGB(40,40,45)c.BackgroundTransparency=.4
Instance.new("UICorner",c).CornerRadius=UDim.new(0,8)
local lbl=Instance.new("TextLabel",c)lbl.Size=UDim2.new(.7,0,1,0)lbl.Position=UDim2.new(0,15,0,0)lbl.BackgroundTransparency=1 lbl.Text=txt lbl.TextColor3=Color3.fromRGB(200,200,200)lbl.Font=Enum.Font.Gotham lbl.TextSize=13 lbl.TextXAlignment=Enum.TextXAlignment.Left
local val=Instance.new("TextLabel",c)val.Size=UDim2.new(0,40,1,0)val.Position=UDim2.new(1,-100,0,0)val.BackgroundTransparency=1 val.Text=default and "ON" or "OFF"val.TextColor3=default and Color3.fromRGB(0,255,150)or Color3.fromRGB(150,150,150)val.Font=Enum.Font.GothamBold val.TextSize=13
local switch=Instance.new("Frame",c)switch.Size=UDim2.new(0,40,0,20)switch.Position=UDim2.new(1,-50,.5,-10)switch.BackgroundColor3=default and Color3.fromRGB(0,255,150)or Color3.fromRGB(80,80,85)
Instance.new("UICorner",switch).CornerRadius=UDim.new(0,10)
local knob=Instance.new("TextButton",switch)knob.Size=UDim2.new(0,16,0,16)knob.Position=default and UDim2.new(1,-18,.5,-8)or UDim2.new(0,2,.5,-8)knob.BackgroundColor3=Color3.fromRGB(255,255,255)knob.Text=""
Instance.new("UICorner",knob).CornerRadius=UDim.new(0,8)
local state=default
knob.MouseButton1Click:Connect(function()
state=not state
switch.BackgroundColor3=state and Color3.fromRGB(0,255,150)or Color3.fromRGB(80,80,85)
knob.Position=state and UDim2.new(1,-18,.5,-8)or UDim2.new(0,2,.5,-8)
val.Text=state and "ON" or "OFF"
val.TextColor3=state and Color3.fromRGB(0,255,150)or Color3.fromRGB(150,150,150)
cb(state)
end)
return c
end

-- スライダー生成関数（画像のデザイン）
local function createSlider(parent,txt,min,max,default,cb)
local c=Instance.new("Frame",parent)c.Size=UDim2.new(1,0,0,50)c.BackgroundColor3=Color3.fromRGB(40,40,45)c.BackgroundTransparency=.4
Instance.new("UICorner",c).CornerRadius=UDim.new(0,8)
local lbl=Instance.new("TextLabel",c)lbl.Size=UDim2.new(.5,0,0,20)lbl.Position=UDim2.new(0,15,0,5)lbl.BackgroundTransparency=1 lbl.Text=txt lbl.TextColor3=Color3.fromRGB(200,200,200)lbl.Font=Enum.Font.Gotham lbl.TextSize=13 lbl.TextXAlignment=Enum.TextXAlignment.Left
local val=Instance.new("TextLabel",c)val.Size=UDim2.new(0,50,0,20)val.Position=UDim2.new(1,-80,0,5)val.BackgroundTransparency=1 val.Text=tostring(default)val.TextColor3=Color3.fromRGB(0,255,150)val.Font=Enum.Font.GothamBold val.TextSize=13
local barBg=Instance.new("Frame",c)barBg.Size=UDim2.new(1,-30,0,6)barBg.Position=UDim2.new(0,15,1,-15)barBg.BackgroundColor3=Color3.fromRGB(60,60,65)
Instance.new("UICorner",barBg).CornerRadius=UDim.new(0,3)
local barFill=Instance.new("Frame",barBg)barFill.Size=UDim2.new((default-min)/(max-min),0,1,0)barFill.BackgroundColor3=Color3.fromRGB(0,255,150)
Instance.new("UICorner",barFill).CornerRadius=UDim.new(0,3)
local knob=Instance.new("TextButton",barBg)knob.Size=UDim2.new(0,16,0,16)knob.Position=UDim2.new(barFill.Size.X.Scale,-8,.5,-8)knob.BackgroundColor3=Color3.fromRGB(200,200,200)knob.Text=""
Instance.new("UICorner",knob).CornerRadius=UDim.new(0,8)
local dragging=false
knob.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true end end)
barBg.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true end end)
UIS.InputChanged:Connect(function(i)
if dragging and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then
local rx=math.clamp((i.Position.X-barBg.AbsolutePosition.X)/barBg.AbsoluteSize.X,0,1)
local v=math.floor(min+(max-min)*rx)
val.Text=tostring(v)barFill.Size=UDim2.new(rx,0,1,0)knob.Position=UDim2.new(rx,-8,.5,-8)cb(v)
end
end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
return c
end
local pPage=pages[1]
-- 歩行速度スライダー
createSlider(pPage,"歩行速度",0,200,16,function(v)
if p.Character and p.Character:FindFirstChild("Humanoid")then p.Character.Humanoid.WalkSpeed=v end
end)
-- 飛行トグル
local flying=false local bv,bg,cn
local flyToggle=createToggle(pPage,"飛行",false,function(state)
flying=state
if flying then
local c=p.Character if not c then flying=false return end
local h=c:FindFirstChild("HumanoidRootPart")local hum=c:FindFirstChildOfClass("Humanoid")
if not h or not hum then flying=false return end
hum.PlatformStand=true
bv=Instance.new("BodyVelocity",h)bv.MaxForce=Vector3.new(9e9,9e9,9e9)bv.Velocity=Vector3.zero
bg=Instance.new("BodyGyro",h)bg.MaxTorque=Vector3.new(9e9,9e9,9e9)bg.P=10000 bg.D=100
cn=RS.RenderStepped:Connect(function()
if not flying or not bv or not bg then return end
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
else
if bv then bv:Destroy()bv=nil end
if bg then bg:Destroy()bg=nil end
if cn then cn:Disconnect()cn=nil end
local c=p.Character if c then local hum=c:FindFirstChildOfClass("Humanoid") if hum then hum.PlatformStand=false end end
end
end)
-- ジャンプ力スライダー
createSlider(pPage,"ジャンプ力",0,500,50,function(v)
if p.Character and p.Character:FindFirstChild("Humanoid")then p.Character.Humanoid.UseJumpPower=true p.Character.Humanoid.JumpPower=v end
end)
-- ツールタブ
local tPage=pages[2]
createToggle(tPage,"スピン",false,function(state)
if state then
if p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
local spinConn=RS.Heartbeat:Connect(function(dt)
local c=p.Character if not c then return end
local h=c:FindFirstChild("HumanoidRootPart") if not h then return end
h.CFrame=h.CFrame*CFrame.Angles(0,math.rad(5*dt*60),0)
end)
p.Character.AncestryChanged:Connect(function()spinConn:Disconnect()end)
end
end
end)
-- ターゲットタブ
local tgtPage=pages[3]
local tpBtn=Instance.new("TextButton",tgtPage)tpBtn.Size=UDim2.new(1,0,0,40)tpBtn.Text="TP (ランダム)"tpBtn.BackgroundColor3=Color3.fromRGB(40,40,45)tpBtn.BackgroundTransparency=.4 tpBtn.TextColor3=Color3.fromRGB(200,200,200)tpBtn.Font=Enum.Font.GothamBold tpBtn.TextSize=13
Instance.new("UICorner",tpBtn).CornerRadius=UDim.new(0,8)
tpBtn.MouseButton1Click:Connect(function()
local ps=game.Players:GetPlayers()
local others={}
for _,pl in ipairs(ps)do if pl~=p then table.insert(others,pl) end end
if #others>0 then
local t=others[math.random(1,#others)]
if t.Character and t.Character:FindFirstChild("HumanoidRootPart")and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
p.Character.HumanoidRootPart.CFrame=t.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
end
end
end)
-- その他タブ
local oPage=pages[4]
createToggle(oPage,"透明",false,function(state)
if state then
local invConn=RS.RenderStepped:Connect(function()
local c=p.Character if not c then return end
for _,part in ipairs(c:GetDescendants())do
if part:IsA("BasePart")then part.LocalTransparencyModifier=1 end
if part:IsA("Decal")then part.Transparency=1 end
end
end)
p.Character.AncestryChanged:Connect(function()invConn:Disconnect()end)
else
local c=p.Character if c then
for _,part in ipairs(c:GetDescendants())do
if part:IsA("BasePart")then part.LocalTransparencyModifier=0 end
if part:IsA("Decal")then part.Transparency=0 end
end
end
end
end)
createToggle(oPage,"貫通",false,function(state)
if state then
local ncConn=RS.Stepped:Connect(function()
local c=p.Character if not c then return end
for _,part in ipairs(c:GetDescendants())do
if part:IsA("BasePart")then part.CanCollide=false end
end
end)
p.Character.AncestryChanged:Connect(function()ncConn:Disconnect()end)
else
local c=p.Character if c then
for _,part in ipairs(c:GetDescendants())do
if part:IsA("BasePart")then part.CanCollide=true end
end
end
end
end)
createToggle(oPage,"無敵",false,function(state)
if state then
local godConn=RS.Heartbeat:Connect(function()
local c=p.Character if not c then return end
local h=c:FindFirstChildOfClass("Humanoid")
if h then h.Health=h.MaxHealth end
end)
p.Character.AncestryChanged:Connect(function()godConn:Disconnect()end)
end
end)
createToggle(oPage,"無限ジャンプ",false,function(state)
if state then
local ijConn=UIS.JumpRequest:Connect(function()
local c=p.Character if not c then return end
local h=c:FindFirstChildOfClass("Humanoid")
if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
end)
p.Character.AncestryChanged:Connect(function()ijConn:Disconnect()end)
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

-- 建築パネル（右側に独立）
local buildPanel=Instance.new("Frame",sg)buildPanel.Size=UDim2.new(0,150,0,280)buildPanel.Position=UDim2.new(1,-160,.5,-140)buildPanel.BackgroundColor3=Color3.fromRGB(20,20,25)buildPanel.BackgroundTransparency=.2 buildPanel.Visible=false
Instance.new("UICorner",buildPanel).CornerRadius=UDim.new(0,12)
Instance.new("UIStroke",buildPanel).Color=Color3.fromRGB(0,255,150)
local bpLay=Instance.new("UIListLayout",buildPanel)bpLay.Padding=UDim.new(0,6)bpLay.HorizontalAlignment=Enum.HorizontalAlignment.Center
local bpTitle=Instance.new("TextLabel",buildPanel)bpTitle.Size=UDim2.new(1,0,0,25)bpTitle.BackgroundTransparency=1 bpTitle.Text="建築メニュー"bpTitle.TextColor3=Color3.fromRGB(0,255,150)bpTitle.Font=Enum.Font.GothamBold bpTitle.TextSize=14
local bpClose=Instance.new("TextButton",buildPanel)bpClose.Size=UDim2.new(0,25,0,25)bpClose.Position=UDim2.new(1,-30,0,5)bpClose.Text="X"bpClose.BackgroundColor3=Color3.fromRGB(40,40,45)bpClose.BackgroundTransparency=.4 bpClose.TextColor3=Color3.fromRGB(255,100,100)bpClose.Font=Enum.Font.GothamBold
Instance.new("UICorner",bpClose).CornerRadius=UDim.new(0,6)
bpClose.MouseButton1Click:Connect(function()buildPanel.Visible=false end)
local bpLbl=Instance.new("TextLabel",buildPanel)bpLbl.Size=UDim2.new(1,0,0,20)bpLbl.BackgroundTransparency=1 bpLbl.Text="設置するものを選択"bpLbl.TextColor3=Color3.fromRGB(200,200,200)bpLbl.Font=Enum.Font.Gotham bpLbl.TextSize=11
local selType="Block"
local function bpBtn(txt,typ)
local b=Instance.new("TextButton",buildPanel)b.Size=UDim2.new(.8,0,0,30)b.Text=txt b.BackgroundColor3=Color3.fromRGB(40,40,45)b.BackgroundTransparency=.4 b.TextColor3=Color3.fromRGB(200,200,200)b.Font=Enum.Font.GothamBold b.TextSize=12
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(function()
selType=typ
for _,c in ipairs(buildPanel:GetChildren())do if c:IsA("TextButton")and c~=bpClose then c.BackgroundColor3=Color3.fromRGB(40,40,45) end end
b.BackgroundColor3=Color3.fromRGB(0,255,150)b.TextColor3=Color3.fromRGB(0,0,0)
end)
end
bpBtn("ブロック","Block")
bpBtn("家","House")
bpBtn("お城","Castle")
local placeMode=false
local placeToggle=Instance.new("TextButton",buildPanel)placeToggle.Size=UDim2.new(.8,0,0,35)placeToggle.Text="設置モード: OFF"placeToggle.BackgroundColor3=Color3.fromRGB(40,40,45)placeToggle.BackgroundTransparency=.4 placeToggle.TextColor3=Color3.fromRGB(200,200,200)placeToggle.Font=Enum.Font.GothamBold placeToggle.TextSize=13
Instance.new("UICorner",placeToggle).CornerRadius=UDim.new(0,6)
placeToggle.MouseButton1Click:Connect(function()
placeMode=not placeMode
placeToggle.Text="設置モード: "..(placeMode and "ON" or "OFF")
placeToggle.TextColor3=placeMode and Color3.fromRGB(0,255,150)or Color3.fromRGB(200,200,200)
end)
local folder=Instance.new("Folder",workspace)folder.Name="VoidBuild"
local function buildBlock(pos)local part=Instance.new("Part",folder)part.Size=Vector3.new(4,4,4)part.Position=pos part.Anchored=true part.BrickColor=BrickColor.new("Medium stone grey")end
local function buildHouse(pos)for x=-2,2,4 do for y=0,4,4 do for z=-2,2,4 do if y==0 or x==-2 or x==2 or z==-2 or z==2 then buildBlock(pos+Vector3.new(x,y,z)) end end end end end
local function buildCastle(pos)for x=-4,4,4 do for y=0,8,4 do for z=-4,4,4 do if y==0 or x==-4 or x==4 or z==-4 or z==4 then buildBlock(pos+Vector3.new(x,y,z)) end end end end for x=-2,2,4 do for z=-2,2,4 do buildBlock(pos+Vector3.new(x,12,z)) end end end
UIS.InputBegan:Connect(function(i,gp)
if gp then return end
if not buildPanel.Visible or not placeMode then return end
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
local cam=workspace.CurrentCamera
local ray=cam:ViewportPointToRay(i.Position.X,i.Position.Y)
local params=RaycastParams.new()
params.FilterType=Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances={p.Character,folder}
local result=workspace:Raycast(ray.Origin,ray.Direction*1000,params)
if result then
local hitPos=result.Position+result.Normal*2
if selType=="Block" then buildBlock(hitPos)
elseif selType=="House" then buildHouse(hitPos)
elseif selType=="Castle" then buildCastle(hitPos) end
end
end
end)
-- 建築タブのボタン
local openBuildBtn=Instance.new("TextButton",tPage)openBuildBtn.Size=UDim2.new(1,0,0,35)openBuildBtn.Text="建築メニューを開く"openBuildBtn.BackgroundColor3=Color3.fromRGB(0,255,150)openBuildBtn.TextColor3=Color3.fromRGB(0,0,0)openBuildBtn.Font=Enum.Font.GothamBold openBuildBtn.TextSize=13
Instance.new("UICorner",openBuildBtn).CornerRadius=UDim.new(0,6)
openBuildBtn.MouseButton1Click:Connect(function()buildPanel.Visible=true end)

-- コード入力（その他タブに追加）
local cBox=Instance.new("TextBox",oPage)cBox.Size=UDim2.new(1,0,0,35)cBox.Text=""cBox.PlaceholderText="管理者コードを入力..."cBox.BackgroundColor3=Color3.fromRGB(50,50,55)cBox.BackgroundTransparency=.3 cBox.TextColor3=Color3.fromRGB(0,255,150)cBox.Font=Enum.Font.GothamBold cBox.TextSize=13 cBox.ClearTextOnFocus=false
Instance.new("UICorner",cBox).CornerRadius=UDim.new(0,6)
local cBtn=Instance.new("TextButton",oPage)cBtn.Size=UDim2.new(1,0,0,35)cBtn.Text="送信"cBtn.BackgroundColor3=Color3.fromRGB(0,255,150)cBtn.TextColor3=Color3.fromRGB(0,0,0)cBtn.Font=Enum.Font.GothamBold cBtn.TextSize=13
Instance.new("UICorner",cBtn).CornerRadius=UDim.new(0,6)
local cRes=Instance.new("TextLabel",oPage)cRes.Size=UDim2.new(1,0,0,40)cRes.BackgroundColor3=Color3.fromRGB(50,50,55)cRes.BackgroundTransparency=.3 cRes.Text=""cRes.TextColor3=Color3.fromRGB(0,255,150)cRes.Font=Enum.Font.GothamBold cRes.TextSize=12 cRes.TextWrapped=true
Instance.new("UICorner",cRes).CornerRadius=UDim.new(0,6)
cBtn.MouseButton1Click:Connect(function()
if cBox.Text=="void2024" or cBox.Text=="admin" then cRes.Text="✅ 管理者コード: ADMIN-VOID-2024"
else cRes.Text="❌ コードが違います" end
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
