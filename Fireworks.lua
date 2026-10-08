local p=game.Players.LocalPlayer
local pg=p:WaitForChild("PlayerGui")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
if pg:FindFirstChild("VoidUI")then pg.VoidUI:Destroy()end
local sg=Instance.new("ScreenGui",pg)sg.Name="VoidUI"sg.ResetOnSpawn=false
local f=Instance.new("Frame",sg)f.Size=UDim2.new(0,320,0,480)f.Position=UDim2.new(.5,-160,.5,-240)f.BackgroundColor3=Color3.fromRGB(20,20,25)f.BackgroundTransparency=.3 f.Active=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,12)
local st=Instance.new("UIStroke",f)st.Color=Color3.fromRGB(0,255,150)st.Thickness=1.5 st.Transparency=.5
local gd=Instance.new("UIGradient",f)gd.Color=ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(100,100,100))gd.Rotation=45
local floatBtn=Instance.new("TextButton",sg)floatBtn.Size=UDim2.new(0,45,0,45)floatBtn.Position=UDim2.new(0,15,.5,-22.5)floatBtn.BackgroundColor3=Color3.fromRGB(20,20,25)floatBtn.BackgroundTransparency=.3 floatBtn.Text="V"floatBtn.TextColor3=Color3.fromRGB(0,255,150)floatBtn.Font=Enum.Font.GothamBold floatBtn.TextSize=22 floatBtn.Visible=false
Instance.new("UICorner",floatBtn).CornerRadius=UDim.new(0,12)
Instance.new("UIStroke",floatBtn).Color=Color3.fromRGB(0,255,150)
local fbd=false local fbm=false local fbs local fbp
floatBtn.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fbd=true fbm=false fbs=i.Position fbp=floatBtn.Position end end)
UIS.InputChanged:Connect(function(i)if fbd and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-fbs if math.abs(d.X)>5 or math.abs(d.Y)>5 then fbm=true end floatBtn.Position=UDim2.new(fbp.X.Scale,fbp.X.Offset+d.X,fbp.Y.Scale,fbp.Y.Offset+d.Y)end end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fbd=false end end)
floatBtn.MouseButton1Click:Connect(function()if fbm then return end f.Visible=true floatBtn.Visible=false end)
local function showConfirm(callback)
local cf=Instance.new("Frame",sg)cf.Size=UDim2.new(0,220,0,110)cf.Position=UDim2.new(.5,-110,.5,-55)cf.BackgroundColor3=Color3.fromRGB(20,20,25)cf.BackgroundTransparency=.2
Instance.new("UICorner",cf).CornerRadius=UDim.new(0,12)
local cst=Instance.new("UIStroke",cf)cst.Color=Color3.fromRGB(0,255,150)cst.Transparency=.4
local lbl=Instance.new("TextLabel",cf)lbl.Size=UDim2.new(1,0,0,50)lbl.BackgroundTransparency=1 lbl.Text="この画面を閉じますか？"lbl.TextColor3=Color3.fromRGB(200,200,200)lbl.Font=Enum.Font.GothamBold lbl.TextSize=14
local yes=Instance.new("TextButton",cf)yes.Size=UDim2.new(.4,0,0,30)yes.Position=UDim2.new(.05,0,.6,0)yes.Text="はい"yes.BackgroundColor3=Color3.fromRGB(0,255,150)yes.TextColor3=Color3.fromRGB(0,0,0)yes.Font=Enum.Font.GothamBold
Instance.new("UICorner",yes).CornerRadius=UDim.new(0,6)
local no=Instance.new("TextButton",cf)no.Size=UDim2.new(.4,0,0,30)no.Position=UDim2.new(.55,0,.6,0)no.Text="いいえ"no.BackgroundColor3=Color3.fromRGB(40,40,45)no.TextColor3=Color3.fromRGB(200,200,200)no.Font=Enum.Font.GothamBold
Instance.new("UICorner",no).CornerRadius=UDim.new(0,6)
yes.MouseButton1Click:Connect(function()cf:Destroy()callback()end)
no.MouseButton1Click:Connect(function()cf:Destroy()end)
end
local top=Instance.new("Frame",f)top.Size=UDim2.new(1,0,0,60)top.BackgroundTransparency=1
local title=Instance.new("TextLabel",top)title.Size=UDim2.new(.5,0,0,30)title.Position=UDim2.new(0,10,0,0)title.Text="Void"title.TextColor3=Color3.fromRGB(0,255,150)title.Font=Enum.Font.GothamBold title.TextSize=20 title.BackgroundTransparency=1 title.TextXAlignment=Enum.TextXAlignment.Left
local discord=Instance.new("TextButton",top)discord.Size=UDim2.new(1,-20,0,20)discord.Position=UDim2.new(0,10,0,28)discord.BackgroundTransparency=1 discord.Text="discord.gg/Znj8eBfa9"discord.TextColor3=Color3.fromRGB(150,150,150)discord.Font=Enum.Font.Gotham discord.TextSize=11 discord.TextXAlignment=Enum.TextXAlignment.Left
discord.MouseButton1Click:Connect(function()if setclipboard then setclipboard("https://discord.gg/Znj8eBfa9")end end)
local close=Instance.new("TextButton",top)close.Size=UDim2.new(0,25,0,25)close.Position=UDim2.new(1,-30,0,5)close.Text="X"close.BackgroundColor3=Color3.fromRGB(40,40,45)close.BackgroundTransparency=.4 close.TextColor3=Color3.fromRGB(255,100,100)close.Font=Enum.Font.GothamBold
Instance.new("UICorner",close).CornerRadius=UDim.new(0,6)
close.MouseButton1Click:Connect(function()showConfirm(function()f.Visible=false floatBtn.Visible=true end)end)
local lb=Instance.new("TextButton",top)lb.Size=UDim2.new(0,85,0,25)lb.Position=UDim2.new(1,-120,0,5)lb.Text="日本語🇯🇵"lb.BackgroundColor3=Color3.fromRGB(40,40,45)lb.BackgroundTransparency=.4 lb.TextColor3=Color3.fromRGB(255,255,255)lb.Font=Enum.Font.Gotham lb.TextSize=11
Instance.new("UICorner",lb).CornerRadius=UDim.new(0,6)
local tabFrame=Instance.new("Frame",f)tabFrame.Size=UDim2.new(1,-20,0,30)tabFrame.Position=UDim2.new(0,10,0,65)tabFrame.BackgroundTransparency=1
local tabL=Instance.new("UIListLayout",tabFrame)tabL.FillDirection=Enum.FillDirection.Horizontal tabL.Padding=UDim.new(.01,0)
local pages={} local btns={}
local tabNames={"プレイヤー","テレポート","コード","建築"}
local enNames={"Player","Teleport","Code","Build"}
for i,n in ipairs(tabNames)do
local b=Instance.new("TextButton",tabFrame)b.Size=UDim2.new(.24,0,1,0)b.Text=n b.BackgroundColor3=Color3.fromRGB(40,40,45)b.BackgroundTransparency=.4 b.TextColor3=Color3.fromRGB(200,200,200)b.Font=Enum.Font.GothamBold b.TextSize=11
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
btns[i]=b
end
local content=Instance.new("Frame",f)content.Size=UDim2.new(1,-20,1,-110)content.Position=UDim2.new(0,10,0,100)content.BackgroundTransparency=1
for i=1,4 do
local pp=Instance.new("Frame",content)pp.Size=UDim2.new(1,0,1,0)pp.BackgroundTransparency=1 pp.Visible=(i==1)
local lay=Instance.new("UIListLayout",pp)lay.Padding=UDim.new(0,6)
pages[i]=pp
end
for i,b in ipairs(btns)do
b.MouseButton1Click:Connect(function()
for j=1,4 do pages[j].Visible=(j==i) btns[j].BackgroundColor3=Color3.fromRGB(40,40,45) btns[j].TextColor3=Color3.fromRGB(200,200,200) end
b.BackgroundColor3=Color3.fromRGB(0,255,150)b.TextColor3=Color3.fromRGB(0,0,0)
end)
end
btns[1].BackgroundColor3=Color3.fromRGB(0,255,150)btns[1].TextColor3=Color3.fromRGB(0,0,0)
local function createToggle(parent,txt,default,cb)
local b=Instance.new("TextButton",parent)b.Size=UDim2.new(1,0,0,35)b.BackgroundColor3=Color3.fromRGB(40,40,45)b.BackgroundTransparency=.4 b.Text=txt..": "..(default and "ON" or "OFF")b.TextColor3=default and Color3.fromRGB(0,255,150)or Color3.fromRGB(200,200,200)b.Font=Enum.Font.GothamBold b.TextSize=13
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
local state=default
b.MouseButton1Click:Connect(function()
state=not state
b.Text=txt..": "..(state and "ON" or "OFF")
b.TextColor3=state and Color3.fromRGB(0,255,150)or Color3.fromRGB(200,200,200)
cb(state)
end)
return b
end
local pPage=pages[1]
local fl=false local bv,bg,cn
local flyToggle=createToggle(pPage,"飛行",false,function(state)
fl=state
if fl then
local c=p.Character if not c then fl=false return end
local h=c:FindFirstChild("HumanoidRootPart")local hum=c:FindFirstChildOfClass("Humanoid")
if not h or not hum then fl=false return end
hum.PlatformStand=true
bv=Instance.new("BodyVelocity",h)bv.MaxForce=Vector3.new(9e9,9e9,9e9)bv.Velocity=Vector3.zero
bg=Instance.new("BodyGyro",h)bg.MaxTorque=Vector3.new(9e9,9e9,9e9)bg.P=10000 bg.D=100
cn=RS.RenderStepped:Connect(function()
if not fl or not bv or not bg then return end
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
local spinFrame=Instance.new("Frame",pPage)spinFrame.Size=UDim2.new(1,0,0,35)spinFrame.BackgroundColor3=Color3.fromRGB(40,40,45)spinFrame.BackgroundTransparency=.4
Instance.new("UICorner",spinFrame).CornerRadius=UDim.new(0,6)
local spinLbl=Instance.new("TextLabel",spinFrame)spinLbl.Size=UDim2.new(.35,0,1,0)spinLbl.Position=UDim2.new(0,10,0,0)spinLbl.BackgroundTransparency=1 spinLbl.Text="スピン"spinLbl.TextColor3=Color3.fromRGB(200,200,200)spinLbl.Font=Enum.Font.Gotham spinLbl.TextSize=12 spinLbl.TextXAlignment=Enum.TextXAlignment.Left
local spinBox=Instance.new("TextBox",spinFrame)spinBox.Size=UDim2.new(.3,0,0,25)spinBox.Position=UDim2.new(.4,0,.5,-12.5)spinBox.Text="5"spinBox.BackgroundColor3=Color3.fromRGB(50,50,55)spinBox.BackgroundTransparency=.3 spinBox.TextColor3=Color3.fromRGB(0,255,150)spinBox.Font=Enum.Font.GothamBold spinBox.TextSize=12 spinBox.ClearTextOnFocus=false
Instance.new("UICorner",spinBox).CornerRadius=UDim.new(0,4)
local spinBtn=Instance.new("TextButton",spinFrame)spinBtn.Size=UDim2.new(.22,0,0,25)spinBtn.Position=UDim2.new(.75,0,.5,-12.5)spinBtn.Text="実行"spinBtn.BackgroundColor3=Color3.fromRGB(0,255,150)spinBtn.TextColor3=Color3.fromRGB(0,0,0)spinBtn.Font=Enum.Font.GothamBold spinBtn.TextSize=12
Instance.new("UICorner",spinBtn).CornerRadius=UDim.new(0,4)
local spinConn
spinBtn.MouseButton1Click:Connect(function()
local spd=tonumber(spinBox.Text) or 5
if spinConn then spinConn:Disconnect() spinConn=nil end
spinConn=RS.Heartbeat:Connect(function(dt)
local c=p.Character if not c then return end
local h=c:FindFirstChild("HumanoidRootPart") if not h then return end
h.CFrame=h.CFrame*CFrame.Angles(0,math.rad(spd*dt*60),0)
end)
end)
local tpBtn=Instance.new("TextButton",pPage)tpBtn.Size=UDim2.new(1,0,0,35)tpBtn.Text="TP"tpBtn.BackgroundColor3=Color3.fromRGB(40,40,45)tpBtn.BackgroundTransparency=.4 tpBtn.TextColor3=Color3.fromRGB(200,200,200)tpBtn.Font=Enum.Font.GothamBold tpBtn.TextSize=13
Instance.new("UICorner",tpBtn).CornerRadius=UDim.new(0,6)
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
local invConn
createToggle(pPage,"透明",false,function(state)
if state then
invConn=RS.RenderStepped:Connect(function()
local c=p.Character if not c then return end
for _,part in ipairs(c:GetDescendants())do
if part:IsA("BasePart")then part.LocalTransparencyModifier=1 end
if part:IsA("Decal")then part.Transparency=1 end
end
end)
else
if invConn then invConn:Disconnect() invConn=nil end
local c=p.Character if c then
for _,part in ipairs(c:GetDescendants())do
if part:IsA("BasePart")then part.LocalTransparencyModifier=0 end
if part:IsA("Decal")then part.Transparency=0 end
end
end
end
end)
local ncConn
createToggle(pPage,"貫通",false,function(state)
if state then
ncConn=RS.Stepped:Connect(function()
local c=p.Character if not c then return end
for _,part in ipairs(c:GetDescendants())do
if part:IsA("BasePart")then part.CanCollide=false end
end
end)
else
if ncConn then ncConn:Disconnect() ncConn=nil end
local c=p.Character if c then
for _,part in ipairs(c:GetDescendants())do
if part:IsA("BasePart")then part.CanCollide=true end
end
end
end
end)
local godConn
createToggle(pPage,"無敵",false,function(state)
if state then
godConn=RS.Heartbeat:Connect(function()
local c=p.Character if not c then return end
local h=c:FindFirstChildOfClass("Humanoid")
if h then h.Health=h.MaxHealth end
end)
else
if godConn then godConn:Disconnect() godConn=nil end
end
end)
local ijConn
createToggle(pPage,"無限ジャンプ",false,function(state)
if state then
ijConn=UIS.JumpRequest:Connect(function()
local c=p.Character if not c then return end
local h=c:FindFirstChildOfClass("Humanoid")
if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
end)
else
if ijConn then ijConn:Disconnect() ijConn=nil end
end
end)
local tPage=pages[2]
local rf=Instance.new("TextButton",tPage)rf.Size=UDim2.new(1,0,0,30)rf.Text="更新"rf.BackgroundColor3=Color3.fromRGB(0,255,150)rf.TextColor3=Color3.fromRGB(0,0,0)rf.Font=Enum.Font.GothamBold rf.TextSize=12
Instance.new("UICorner",rf).CornerRadius=UDim.new(0,6)
local sf=Instance.new("ScrollingFrame",tPage)sf.Size=UDim2.new(1,0,1,-40)sf.Position=UDim2.new(0,0,0,35)sf.BackgroundTransparency=1 sf.ScrollBarThickness=4
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
local cPage=pages[3]
local cInfo=Instance.new("TextLabel",cPage)cInfo.Size=UDim2.new(1,0,0,25)cInfo.BackgroundTransparency=1 cInfo.Text="コードを入力してください"cInfo.TextColor3=Color3.fromRGB(200,200,200)cInfo.Font=Enum.Font.Gotham cInfo.TextSize=12
local cBox=Instance.new("TextBox",cPage)cBox.Size=UDim2.new(1,0,0,35)cBox.Text=""cBox.PlaceholderText="ここに入力..."cBox.BackgroundColor3=Color3.fromRGB(50,50,55)cBox.BackgroundTransparency=.3 cBox.TextColor3=Color3.fromRGB(0,255,150)cBox.Font=Enum.Font.GothamBold cBox.TextSize=13 cBox.ClearTextOnFocus=false
Instance.new("UICorner",cBox).CornerRadius=UDim.new(0,6)
local cBtn=Instance.new("TextButton",cPage)cBtn.Size=UDim2.new(1,0,0,35)cBtn.Text="送信"cBtn.BackgroundColor3=Color3.fromRGB(0,255,150)cBtn.TextColor3=Color3.fromRGB(0,0,0)cBtn.Font=Enum.Font.GothamBold cBtn.TextSize=13
Instance.new("UICorner",cBtn).CornerRadius=UDim.new(0,6)
local cRes=Instance.new("TextLabel",cPage)cRes.Size=UDim2.new(1,0,0,80)cRes.BackgroundColor3=Color3.fromRGB(50,50,55)cRes.BackgroundTransparency=.3 cRes.Text=""cRes.TextColor3=Color3.fromRGB(0,255,150)cRes.Font=Enum.Font.GothamBold cRes.TextSize=12 cRes.TextWrapped=true
Instance.new("UICorner",cRes).CornerRadius=UDim.new(0,6)
cBtn.MouseButton1Click:Connect(function()
local code=cBox.Text
if code=="void2024" or code=="admin" then cRes.Text="✅ 管理者コード: ADMIN-VOID-2024"
else cRes.Text="❌ コードが違います" end
end)
local bPage=pages[4]
local buildPanel=Instance.new("Frame",sg)buildPanel.Size=UDim2.new(0,150,0,280)buildPanel.Position=UDim2.new(1,-160,.5,-140)buildPanel.BackgroundColor3=Color3.fromRGB(20,20,25)buildPanel.BackgroundTransparency=.3 buildPanel.Visible=false
Instance.new("UICorner",buildPanel).CornerRadius=UDim.new(0,12)
Instance.new("UIStroke",buildPanel).Color=Color3.fromRGB(0,255,150)
local bpLay=Instance.new("UIListLayout",buildPanel)bpLay.Padding=UDim.new(0,6)bpLay.HorizontalAlignment=Enum.HorizontalAlignment.Center
local bpTitle=Instance.new("TextLabel",buildPanel)bpTitle.Size=UDim2.new(1,0,0,25)bpTitle.BackgroundTransparency=1 bpTitle.Text="建築メニュー"bpTitle.TextColor3=Color3.fromRGB(0,255,150)bpTitle.Font=Enum.Font.GothamBold bpTitle.TextSize=14
local bpClose=Instance.new("TextButton",buildPanel)bpClose.Size=UDim2.new(0,25,0,25)bpClose.Position=UDim2.new(1,-30,0,5)bpClose.Text="X"bpClose.BackgroundColor3=Color3.fromRGB(40,40,45)bpClose.BackgroundTransparency=.4 bpClose.TextColor3=Color3.fromRGB(255,100,100)bpClose.Font=Enum.Font.GothamBold
Instance.new("UICorner",bpClose).CornerRadius=UDim.new(0,6)
bpClose.MouseButton1Click:Connect(function()showConfirm(function()buildPanel.Visible=false end)end)
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
local function buildBlock(pos)
local part=Instance.new("Part",folder)part.Size=Vector3.new(4,4,4)part.Position=pos part.Anchored=true part.BrickColor=BrickColor.new("Medium stone grey")
end
local function buildHouse(pos)
for x=-2,2,4 do for y=0,4,4 do for z=-2,2,4 do
if y==0 or x==-2 or x==2 or z==-2 or z==2 then buildBlock(pos+Vector3.new(x,y,z)) end
end end end
end
local function buildCastle(pos)
for x=-4,4,4 do for y=0,8,4 do for z=-4,4,4 do
if y==0 or x==-4 or x==4 or z==-4 or z==4 then buildBlock(pos+Vector3.new(x,y,z)) end
end end end
for x=-2,2,4 do for z=-2,2,4 do buildBlock(pos+Vector3.new(x,12,z)) end end
end
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
local openBuildBtn=Instance.new("TextButton",bPage)openBuildBtn.Size=UDim2.new(1,0,0,35)openBuildBtn.Text="建築メニューを開く"openBuildBtn.BackgroundColor3=Color3.fromRGB(0,255,150)openBuildBtn.TextColor3=Color3.fromRGB(0,0,0)openBuildBtn.Font=Enum.Font.GothamBold openBuildBtn.TextSize=13
Instance.new("UICorner",openBuildBtn).CornerRadius=UDim.new(0,6)
openBuildBtn.MouseButton1Click:Connect(function()buildPanel.Visible=true end)
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
lb.MouseButton1Click:Connect(function()
if lb.Text=="日本語🇯🇵"then
lb.Text="English🇺🇸"
for i,b in ipairs(btns)do b.Text=enNames[i] end
rf.Text="Refresh"
spinLbl.Text="Spin" spinBtn.Text="Run"
cInfo.Text="Enter the code" cBtn.Text="Submit"
bpTitle.Text="Build Menu" bpClose.Text="X" bpLbl.Text="Select object"
placeToggle.Text="Place: "..(placeMode and "ON" or "OFF")
openBuildBtn.Text="Open Build Menu"
else
lb.Text="日本語🇯🇵"
for i,b in ipairs(btns)do b.Text=tabNames[i] end
rf.Text="更新"
spinLbl.Text="スピン" spinBtn.Text="実行"
cInfo.Text="コードを入力してください" cBtn.Text="送信"
bpTitle.Text="建築メニュー" bpLbl.Text="設置するものを選択"
placeToggle.Text="設置モード: "..(placeMode and "ON" or "OFF")
openBuildBtn.Text="建築メニューを開く"
end
end)
p.CharacterAdded:Connect(function(ch)
task.wait(1)
local h=ch:FindFirstChildOfClass("Humanoid")
if h then h.WalkSpeed=16 h.UseJumpPower=true h.JumpPower=50 end
end)
