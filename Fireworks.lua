local p=game.Players.LocalPlayer
local pg=p:WaitForChild("PlayerGui")
local UIS=game:GetService("UserInputService")
if pg:FindFirstChild("VoidUI")then pg.VoidUI:Destroy()end
local sg=Instance.new("ScreenGui",pg)sg.Name="VoidUI"sg.ResetOnSpawn=false
local f=Instance.new("Frame",sg)f.Size=UDim2.new(0,280,0,490)f.Position=UDim2.new(.5,-140,.5,-245)f.BackgroundColor3=Color3.fromRGB(30,30,35)f.Active=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)
local floatBtn=Instance.new("TextButton",sg)floatBtn.Size=UDim2.new(0,45,0,45)floatBtn.Position=UDim2.new(0,15,.5,-22.5)floatBtn.BackgroundColor3=Color3.fromRGB(30,30,35)floatBtn.Text="V"floatBtn.TextColor3=Color3.fromRGB(0,255,150)floatBtn.Font=Enum.Font.GothamBold floatBtn.TextSize=22 floatBtn.Visible=false
Instance.new("UICorner",floatBtn).CornerRadius=UDim.new(0,8)
local fbd=false local fbm=false local fbs local fbp
floatBtn.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fbd=true fbm=false fbs=i.Position fbp=floatBtn.Position end end)
UIS.InputChanged:Connect(function(i)if fbd and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-fbs if math.abs(d.X)>5 or math.abs(d.Y)>5 then fbm=true end floatBtn.Position=UDim2.new(fbp.X.Scale,fbp.X.Offset+d.X,fbp.Y.Scale,fbp.Y.Offset+d.Y)end end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fbd=false end end)
floatBtn.MouseButton1Click:Connect(function()if fbm then return end f.Visible=true floatBtn.Visible=false end)
local top=Instance.new("Frame",f)top.Size=UDim2.new(1,0,0,60)top.BackgroundTransparency=1
local title=Instance.new("TextLabel",top)title.Size=UDim2.new(.5,0,0,30)title.Position=UDim2.new(0,10,0,0)title.Text="Void"title.TextColor3=Color3.fromRGB(0,255,150)title.Font=Enum.Font.GothamBold title.TextSize=20 title.BackgroundTransparency=1 title.TextXAlignment=Enum.TextXAlignment.Left
local discord=Instance.new("TextButton",top)discord.Size=UDim2.new(1,-20,0,20)discord.Position=UDim2.new(0,10,0,28)discord.BackgroundTransparency=1 discord.Text="discord.gg/Znj8eBfa9"discord.TextColor3=Color3.fromRGB(150,150,150)discord.Font=Enum.Font.Gotham discord.TextSize=11 discord.TextXAlignment=Enum.TextXAlignment.Left
discord.MouseButton1Click:Connect(function()if setclipboard then setclipboard("https://discord.gg/Znj8eBfa9")end end)
local close=Instance.new("TextButton",top)close.Size=UDim2.new(0,25,0,25)close.Position=UDim2.new(1,-30,0,5)close.Text="X"close.BackgroundColor3=Color3.fromRGB(40,40,45)close.TextColor3=Color3.fromRGB(255,100,100)close.Font=Enum.Font.GothamBold
Instance.new("UICorner",close).CornerRadius=UDim.new(0,6)
close.MouseButton1Click:Connect(function()f.Visible=false floatBtn.Visible=true end)
local lb=Instance.new("TextButton",top)lb.Size=UDim2.new(0,85,0,25)lb.Position=UDim2.new(1,-120,0,5)lb.Text="日本語🇯🇵"lb.BackgroundColor3=Color3.fromRGB(40,40,45)lb.TextColor3=Color3.fromRGB(255,255,255)lb.Font=Enum.Font.Gotham lb.TextSize=11
Instance.new("UICorner",lb).CornerRadius=UDim.new(0,6)
local tabBar=Instance.new("Frame",f)tabBar.Size=UDim2.new(1,-20,0,25)tabBar.Position=UDim2.new(0,10,0,65)tabBar.BackgroundTransparency=1
local btnP=Instance.new("TextButton",tabBar)btnP.Size=UDim2.new(.5,-5,1,0)btnP.Text="プレイヤー"btnP.BackgroundColor3=Color3.fromRGB(0,255,150)btnP.TextColor3=Color3.fromRGB(0,0,0)btnP.Font=Enum.Font.GothamBold btnP.TextSize=12
Instance.new("UICorner",btnP).CornerRadius=UDim.new(0,6)
local btnT=Instance.new("TextButton",tabBar)btnT.Size=UDim2.new(.5,-5,1,0)btnT.Position=UDim2.new(.5,5,0,0)btnT.Text="テレポート"btnT.BackgroundColor3=Color3.fromRGB(40,40,45)btnT.TextColor3=Color3.fromRGB(200,200,200)btnT.Font=Enum.Font.Gotham btnT.TextSize=12
Instance.new("UICorner",btnT).CornerRadius=UDim.new(0,6)
local content=Instance.new("Frame",f)content.Size=UDim2.new(1,-20,1,-110)content.Position=UDim2.new(0,10,0,100)content.BackgroundTransparency=1
local pPage=Instance.new("Frame",content)pPage.Size=UDim2.new(1,0,1,0)pPage.BackgroundTransparency=1 pPage.Visible=true
local pL=Instance.new("UIListLayout",pPage)pL.Padding=UDim.new(0,6)
local tPage=Instance.new("Frame",content)tPage.Size=UDim2.new(1,0,1,0)tPage.BackgroundTransparency=1 tPage.Visible=false
local tL=Instance.new("UIListLayout",tPage)tL.Padding=UDim.new(0,4)
btnP.MouseButton1Click:Connect(function()pPage.Visible=true tPage.Visible=false btnP.BackgroundColor3=Color3.fromRGB(0,255,150)btnP.TextColor3=Color3.fromRGB(0,0,0)btnT.BackgroundColor3=Color3.fromRGB(40,40,45)btnT.TextColor3=Color3.fromRGB(200,200,200)end)
btnT.MouseButton1Click:Connect(function()pPage.Visible=false tPage.Visible=true btnT.BackgroundColor3=Color3.fromRGB(0,255,150)btnT.TextColor3=Color3.fromRGB(0,0,0)btnP.BackgroundColor3=Color3.fromRGB(40,40,45)btnP.TextColor3=Color3.fromRGB(200,200,200)end)
local fl=false local bv,bg,cn local flySpeed=50
local fb=Instance.new("TextButton",pPage)fb.Size=UDim2.new(1,0,0,35)fb.Text="飛行: OFF"fb.BackgroundColor3=Color3.fromRGB(40,40,45)fb.TextColor3=Color3.fromRGB(200,200,200)fb.Font=Enum.Font.Gotham fb.LayoutOrder=3
Instance.new("UICorner",fb).CornerRadius=UDim.new(0,6)
fb.MouseButton1Click:Connect(function()
fl=not fl
if fl then
local c=p.Character
if not c then fl=false return end
local h=c:FindFirstChild("HumanoidRootPart")
local hum=c:FindFirstChildOfClass("Humanoid")
if not h or not hum then fl=false return end
hum.PlatformStand=true
bv=Instance.new("BodyVelocity",h)bv.MaxForce=Vector3.new(9e9,9e9,9e9)bv.Velocity=Vector3.zero
bg=Instance.new("BodyGyro",h)bg.MaxTorque=Vector3.new(9e9,9e9,9e9)bg.P=10000 bg.D=100
cn=game:GetService("RunService").RenderStepped:Connect(function()
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
bv.Velocity=d*flySpeed bg.CFrame=cam.CFrame
end)
fb.Text="飛行: ON"fb.TextColor3=Color3.fromRGB(0,255,150)
else
if bv then bv:Destroy()bv=nil end
if bg then bg:Destroy()bg=nil end
if cn then cn:Disconnect()cn=nil end
local c=p.Character if c then local hum=c:FindFirstChildOfClass("Humanoid") if hum then hum.PlatformStand=false end end
fb.Text="飛行: OFF"fb.TextColor3=Color3.fromRGB(200,200,200)
end
end)
local function sl(n,mi,ma,de,o,cb)
local b=Instance.new("Frame",pPage)b.Size=UDim2.new(1,0,0,50)b.BackgroundColor3=Color3.fromRGB(35,35,40)b.LayoutOrder=o
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
local lbl=Instance.new("TextLabel",b)lbl.Name="NameLabel"lbl.Size=UDim2.new(.5,0,0,20)lbl.Position=UDim2.new(0,10,0,5)lbl.Text=n lbl.TextColor3=Color3.fromRGB(200,200,200)lbl.TextSize=12 lbl.Font=Enum.Font.Gotham lbl.BackgroundTransparency=1 lbl.TextXAlignment=Enum.TextXAlignment.Left
local v=Instance.new("TextBox",b)v.Name="ValueLabel"v.Size=UDim2.new(0,55,0,22)v.Position=UDim2.new(1,-65,0,5)v.Text=tostring(de)v.TextColor3=Color3.fromRGB(0,255,150)v.TextSize=12 v.Font=Enum.Font.GothamBold v.BackgroundColor3=Color3.fromRGB(50,50,55)v.BackgroundTransparency=.3 v.ClearTextOnFocus=false
Instance.new("UICorner",v).CornerRadius=UDim.new(0,4)
local bar=Instance.new("Frame",b)bar.Size=UDim2.new(1,-20,0,6)bar.Position=UDim2.new(0,10,1,-12)bar.BackgroundColor3=Color3.fromRGB(60,60,65)
Instance.new("UICorner",bar).CornerRadius=UDim.new(0,3)
local fill=Instance.new("Frame",bar)fill.Size=UDim2.new((de-mi)/(ma-mi),0,1,0)fill.BackgroundColor3=Color3.fromRGB(0,255,150)
Instance.new("UICorner",fill).CornerRadius=UDim.new(0,3)
local knob=Instance.new("TextButton",bar)knob.Size=UDim2.new(0,16,0,16)knob.Position=UDim2.new(fill.Size.X.Scale,-8,.5,-8)knob.BackgroundColor3=Color3.fromRGB(200,200,200)knob.Text=""
Instance.new("UICorner",knob).CornerRadius=UDim.new(0,8)
local dr=false
knob.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true end end)
bar.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true end end)
UIS.InputChanged:Connect(function(i)
if dr and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then
local rx=math.clamp((i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
local vv=math.floor(mi+(ma-mi)*rx)
v.Text=tostring(vv)fill.Size=UDim2.new(rx,0,1,0)knob.Position=UDim2.new(rx,-8,.5,-8)cb(vv)
end
end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
v.FocusLost:Connect(function()
local num=tonumber(v.Text)
if num then
num=math.clamp(num,mi,ma)
v.Text=tostring(num)
local rx=(num-mi)/(ma-mi)
fill.Size=UDim2.new(rx,0,1,0)knob.Position=UDim2.new(rx,-8,.5,-8)cb(num)
else v.Text=tostring(de)end
end)
return b
end
local ws=sl("歩行速度",0,500,16,4,function(v)if p.Character and p.Character:FindFirstChild("Humanoid")then p.Character.Humanoid.WalkSpeed=v end end)
local jp=sl("ジャンプ力",0,500,50,5,function(v)if p.Character and p.Character:FindFirstChild("Humanoid")then p.Character.Humanoid.UseJumpPower=true p.Character.Humanoid.JumpPower=v end end)
local fs=sl("飛行速度",0,300,50,6,function(v)flySpeed=v end)
local rf=Instance.new("TextButton",tPage)rf.Size=UDim2.new(1,0,0,30)rf.Text="更新"rf.BackgroundColor3=Color3.fromRGB(0,255,150)rf.TextColor3=Color3.fromRGB(0,0,0)rf.Font=Enum.Font.GothamBold rf.TextSize=12
Instance.new("UICorner",rf).CornerRadius=UDim.new(0,6)
local sf=Instance.new("ScrollingFrame",tPage)sf.Size=UDim2.new(1,0,1,-40)sf.Position=UDim2.new(0,0,0,35)sf.BackgroundTransparency=1 sf.ScrollBarThickness=4
local sl2=Instance.new("UIListLayout",sf)sl2.Padding=UDim.new(0,4)
local function upd()
for _,ch in ipairs(sf:GetChildren())do if ch:IsA("TextButton")then ch:Destroy()end end
for _,pl in ipairs(game.Players:GetPlayers())do
if pl~=p then
local b=Instance.new("TextButton",sf)b.Size=UDim2.new(1,-5,0,30)b.Text=pl.Name b.BackgroundColor3=Color3.fromRGB(35,35,40)b.TextColor3=Color3.fromRGB(200,200,200)b.Font=Enum.Font.Gotham b.TextSize=12
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
lb.Text="English🇺🇸"fb.Text=fl and "Fly: ON" or "Fly: OFF"btnP.Text="Players"btnT.Text="Teleport"rf.Text="Refresh"
ws.NameLabel.Text="Walk Speed"jp.NameLabel.Text="Jump Power"fs.NameLabel.Text="Fly Speed"
else
lb.Text="日本語🇯🇵"fb.Text=fl and "飛行: ON" or "飛行: OFF"btnP.Text="プレイヤー"btnT.Text="テレポート"rf.Text="更新"
ws.NameLabel.Text="歩行速度"jp.NameLabel.Text="ジャンプ力"fs.NameLabel.Text="飛行速度"
end
end)
p.CharacterAdded:Connect(function(ch)
task.wait(1)
local h=ch:FindFirstChildOfClass("Humanoid")
if h then h.WalkSpeed=16 h.UseJumpPower=true h.JumpPower=50 end
end)
