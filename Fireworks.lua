--// Fireworks v8.2
local hui = gethui and gethui() or game:GetService("CoreGui")
local P=game:GetService("Players") local RS=game:GetService("RunService")
local TW=game:GetService("TweenService") local UIS=game:GetService("UserInputService")
local LT=game:GetService("Lighting") local WS=game:GetService("Workspace")
local TS=game:GetService("TeleportService") local LP=P.LocalPlayer

local Lg="JP"
local L={
JP={p="プレイヤー",t="テレポート",b="建築",v="見た目",m="その他",
ij="無限ジャンプ",esp="ESP",gm="ゴッドモード",nc="ノークリップ",
fb="フルブライト",rb="虹色UI",sp="移動速度",jp="ジャンプ力",
sv="位置を保存",tp="保存位置に移動",tpP="プレイヤーに移動",sel="プレイヤー選択",
one="パーツ1個",wl="壁",bx="箱",cs="城",tw="タワー",st="階段",ps="パーツサイズ",
rj="再入場",sh="サーバー移動",lang="言語",saved="保存",none="なし",ok="OK",
title="Fireworks v8.2"},
EN={p="Player",t="Teleport",b="Build",v="Visual",m="Misc",
ij="Infinite Jump",esp="ESP",gm="God Mode",nc="Noclip",
fb="Full Bright",rb="Rainbow UI",sp="WalkSpeed",jp="JumpPower",
sv="Save Position",tp="TP to Saved",tpP="TP to Player",sel="Select Player",
one="Place Part",wl="Wall",bx="Box",cs="Castle",tw="Tower",st="Stairs",ps="Part Size",
rj="Rejoin",sh="Server Hop",lang="Language",saved="Saved",none="None",ok="OK",
title="Fireworks v8.2"}}
local function T(k) return L[Lg][k] or k end

local S={WalkSpeed=16,JumpPower=50,InfiniteJump=false,ESP=false,GodMode=false,
Noclip=false,FullBright=false,RainbowUI=true,BuildSize=5}
local Sp=nil SelP=nil EO={} CS={} TR={}
local C1=Color3.fromRGB
local Th={Bg=C1(15,15,25),Cd=C1(24,24,38),Sl=C1(40,40,60),
Tx=C1(245,245,255),Sb=C1(140,140,180),A1=C1(140,90,255),A2=C1(80,200,255),
A3=C1(255,90,180),On=C1(80,220,140),Of=C1(60,60,90)}

local function C(c,p) local i=Instance.new(c) for k,v in pairs(p or {}) do i[k]=v end return i end
local function RC(s)
    local t=tick()*(s or 1)
    return Color3.new(math.sin(t)*0.5+0.5,math.sin(t+2.094)*0.5+0.5,math.sin(t+4.188)*0.5+0.5)
end
local function HM() local c=LP.Character if not c then return nil end return c:FindFirstChildOfClass("Humanoid") end
local function HR() local c=LP.Character if not c then return nil end return c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart end
local function Reg(o,tk) table.insert(TR,{o=o,k=tk}) end

task.spawn(function()
    while task.wait(0.05) do
        if S.RainbowUI then
            for i=#CS,1,-1 do
                local it=CS[i]
                if it.s and it.s.Parent then it.s.Color=RC(it.sp)
                else table.remove(CS,i) end
            end
        end
    end
end)

local SG=C("ScreenGui",{Name="FireworksUI",ResetOnSpawn=false,IgnoreGuiInset=true,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=hui})
local TB=C("TextButton",{Text="FW",Size=UDim2.new(0,60,0,26),Position=UDim2.new(0.5,-30,0,5),BackgroundColor3=Th.Cd,BorderSizePixel=0,AutoButtonColor=false,TextColor3=Th.Tx,Font=Enum.Font.GothamBold,TextSize=12,Parent=SG})
C("UICorner",{CornerRadius=UDim.new(0,13),Parent=TB})
C("UIStroke",{Color=Th.A1,Thickness=1.5,Parent=TB})

local M=C("Frame",{Size=UDim2.new(0,240,0,340),Position=UDim2.new(0.5,-120,0.5,-170),BackgroundColor3=Th.Bg,BackgroundTransparency=0.05,BorderSizePixel=0,Visible=false,Parent=SG})
C("UICorner",{CornerRadius=UDim.new(0,12),Parent=M})
C("UIStroke",{Color=Th.A1,Thickness=1.5,Parent=M})
TB.MouseButton1Click:Connect(function() M.Visible=not M.Visible end)

local H=C("Frame",{Size=UDim2.new(1,0,0,30),BackgroundColor3=Th.Cd,BackgroundTransparency=0.3,BorderSizePixel=0,Parent=M})
C("UICorner",{CornerRadius=UDim.new(0,12),Parent=H})
local HT=C("TextLabel",{Text="",Size=UDim2.new(1,-40,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,TextColor3=Th.Tx,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=H})
Reg(HT,"title")

local CB=C("TextButton",{Text="×",Size=UDim2.new(0,26,0,26),Position=UDim2.new(1,-30,0.5,-13),BackgroundColor3=C1(80,35,50),BorderSizePixel=0,AutoButtonColor=false,TextColor3=C1(255,200,220),Font=Enum.Font.GothamBold,TextSize=18,Parent=H})
C("UICorner",{CornerRadius=UDim.new(0,8),Parent=CB})
CB.MouseButton1Click:Connect(function() M.Visible=false end)

local dg,dS,dP
H.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=true dS=i.Position dP=M.Position end
end)
UIS.InputChanged:Connect(function(i)
    if dg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-dS
        M.Position=UDim2.new(dP.X.Scale,dP.X.Offset+d.X,dP.Y.Scale,dP.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=false end
end)

local TBa=C("Frame",{Size=UDim2.new(1,-12,0,26),Position=UDim2.new(0,6,0,32),BackgroundTransparency=1,Parent=M})
local CA=C("Frame",{Size=UDim2.new(1,-12,1,-70),Position=UDim2.new(0,6,0,62),BackgroundTransparency=1,Parent=M})
local Tb={} TbB={} TbO={"p","t","b","v","m"}
local function Sel(k)
    for n,f in pairs(Tb) do f.Visible=(n==k) end
    for n,b in pairs(TbB) do
        if n==k then b.BackgroundColor3=Th.Sl b.TextColor3=Th.Tx
        else b.BackgroundColor3=Th.Cd b.TextColor3=Th.Sb end
    end
end
for i,k in ipairs(TbO) do
    local b=C("TextButton",{Text="",Size=UDim2.new(0.2,-2,1,0),Position=UDim2.new((i-1)*0.2,2,0,0),BackgroundColor3=Th.Cd,BorderSizePixel=0,AutoButtonColor=false,TextColor3=Th.Sb,Font=Enum.Font.GothamBold,TextSize=9,Parent=TBa})
    C("UICorner",{CornerRadius=UDim.new(0,6),Parent=b})
    b.MouseButton1Click:Connect(function() Sel(k) end)
    TbB[k]=b Reg(b,k)
    Tb[k]=C("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,CanvasSize=UDim2.new(0,0,0,500),ScrollBarThickness=3,Visible=false,Parent=CA})
end
local function MK(par,y,tk,key,cb)
    local b=C("TextButton",{Text="",Size=UDim2.new(1,-16,0,26),Position=UDim2.new(0,8,0,y),BackgroundColor3=Th.Cd,BackgroundTransparency=0.1,BorderSizePixel=0,AutoButtonColor=false,Parent=par})
    C("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
    C("UIStroke",{Color=Th.Of,Thickness=1.2,Transparency=0.4,Parent=b})
    local lb=C("TextLabel",{Text="",Size=UDim2.new(1,-50,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,TextColor3=Th.Tx,Font=Enum.Font.GothamMedium,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,Parent=b})
    Reg(lb,tk)
    local stt=C("TextLabel",{Text="OFF",Size=UDim2.new(0,35,1,0),Position=UDim2.new(1,-40,0,0),BackgroundTransparency=1,TextColor3=Th.Sb,Font=Enum.Font.GothamBold,TextSize=9,TextXAlignment=Enum.TextXAlignment.Right,Parent=b})
    b.MouseButton1Click:Connect(function()
        S[key]=not S[key]
        stt.Text=S[key] and "ON" or "OFF"
        stt.TextColor3=S[key] and Th.On or Th.Sb
        TW:Create(b,TweenInfo.new(0.2),{BackgroundColor3=S[key] and C1(30,60,55) or Th.Cd}):Play()
        if cb then pcall(cb,S[key]) end
    end)
end
local function AB(par,y,tk,cb)
    local b=C("TextButton",{Text="",Size=UDim2.new(1,-16,0,26),Position=UDim2.new(0,8,0,y),BackgroundColor3=Th.Cd,BackgroundTransparency=0.1,BorderSizePixel=0,AutoButtonColor=false,TextColor3=Th.Tx,Font=Enum.Font.GothamBold,TextSize=10,Parent=par})
    C("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
    C("UIStroke",{Color=Th.A1,Thickness=1,Transparency=0.3,Parent=b})
    Reg(b,tk)
    b.MouseButton1Click:Connect(function()
        TW:Create(b,TweenInfo.new(0.1),{BackgroundColor3=C1(60,100,120)}):Play()
        task.delay(0.15,function() TW:Create(b,TweenInfo.new(0.2),{BackgroundColor3=Th.Cd}):Play() end)
        if cb then pcall(cb) end
    end)
end
local function MS(par,y,tk,mn,mx,df,key)
    local c=C("Frame",{Size=UDim2.new(1,-16,0,32),Position=UDim2.new(0,8,0,y),BackgroundColor3=Th.Cd,BackgroundTransparency=0.1,BorderSizePixel=0,Parent=par})
    C("UICorner",{CornerRadius=UDim.new(0,8),Parent=c})
    C("UIStroke",{Color=Th.Of,Thickness=1.2,Transparency=0.4,Parent=c})
    local l=C("TextLabel",{Text="",Size=UDim2.new(1,-16,0,12),Position=UDim2.new(0,10,0,2),BackgroundTransparency=1,TextColor3=Th.Tx,Font=Enum.Font.GothamMedium,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,Parent=c})
    table.insert(TR,{o=l,k=tk,sl=true,cur=df})
    local tr=C("Frame",{Size=UDim2.new(1,-20,0,4),Position=UDim2.new(0,10,0,22),BackgroundColor3=C1(20,20,32),BorderSizePixel=0,Parent=c})
    C("UICorner",{CornerRadius=UDim.new(1,0),Parent=tr})
    local fl=C("Frame",{Size=UDim2.new((df-mn)/(mx-mn),0,1,0),BackgroundColor3=Th.A1,BorderSizePixel=0,Parent=tr})
    C("UICorner",{CornerRadius=UDim.new(1,0),Parent=fl})
    C("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Th.A1),ColorSequenceKeypoint.new(0.5,Th.A2),ColorSequenceKeypoint.new(1,Th.A3)}),Parent=fl})
    local kb=C("Frame",{Size=UDim2.new(0,10,0,10),Position=UDim2.new((df-mn)/(mx-mn),-5,0.5,-5),BackgroundColor3=C1(255,255,255),BorderSizePixel=0,Parent=tr})
    C("UICorner",{CornerRadius=UDim.new(1,0),Parent=kb})
    local dr=false
    local function up(inp)
        local r=math.clamp((inp.Position.X-tr.AbsolutePosition.X)/math.max(tr.AbsoluteSize.X,1),0,1)
        local v=math.floor(mn+(mx-mn)*r)
        fl.Size=UDim2.new(r,0,1,0) kb.Position=UDim2.new(r,-5,0.5,-5)
        l.Text=T(tk)..": "..v S[key]=v
        for _,it in ipairs(TR) do if it.o==l then it.cur=v end end
    end
    tr.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true up(i) end end)
    UIS.InputChanged:Connect(function(i) if dr and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then up(i) end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
end

local function CE(p)
    if p==LP or EO[p] then return end
    local sg=C("ScreenGui",{Name="FW_E_"..p.Name,ResetOnSpawn=false,IgnoreGuiInset=true,Parent=hui})
    local bx=C("Frame",{BackgroundTransparency=1,BorderSizePixel=0,Visible=false,Parent=sg})
    local st=C("UIStroke",{Color=RC(1.5),Thickness=2,Parent=bx})
    local nt=C("TextLabel",{BackgroundTransparency=1,TextColor3=C1(255,255,255),Font=Enum.Font.GothamBold,TextSize=10,TextStrokeTransparency=0,Visible=false,Parent=sg})
    local dt=C("TextLabel",{BackgroundTransparency=1,TextColor3=C1(200,200,255),Font=Enum.Font.Gotham,TextSize=9,TextStrokeTransparency=0,Visible=false,Parent=sg})
    EO[p]={g=sg,b=bx,s=st,n=nt,d=dt}
end
local function RE(p) local o=EO[p] if o and o.g then o.g:Destroy() end EO[p]=nil end

RS.RenderStepped:Connect(function()
    if not S.ESP then for _,o in pairs(EO) do o.b.Visible=false o.n.Visible=false o.d.Visible=false end return end
    local cam=workspace.CurrentCamera if not cam then return end
    for p,o in pairs(EO) do
        local c=p.Character
        local h=c and c:FindFirstChild("HumanoidRootPart")
        local hd=c and c:FindFirstChild("Head")
        local hu=c and c:FindFirstChildOfClass("Humanoid")
        if h and hd and hu and hu.Health>0 then
            local hp,os=cam:WorldToViewportPoint(h.Position)
            local he=cam:WorldToViewportPoint(hd.Position+Vector3.new(0,1,0))
            if os then
                local hh=math.abs(he.Y-hp.Y)*2.2 local ww=hh*0.6
                local x=hp.X-ww/2 local y=hp.Y-hh/2
                o.b.Visible=true o.b.Position=UDim2.new(0,x,0,y) o.b.Size=UDim2.new(0,ww,0,hh)
                o.s.Color=RC(1.5)
                local d=(cam.CFrame.Position-h.Position).Magnitude
                o.n.Visible=true o.n.Text=p.Name o.n.Position=UDim2.new(0,x,0,y-16) o.n.Size=UDim2.new(0,ww,0,12)
                o.d.Visible=true o.d.Text=string.format("[%dm]",math.floor(d)) o.d.Position=UDim2.new(0,x,0,y+hh+2) o.d.Size=UDim2.new(0,ww,0,10)
            else o.b.Visible=false o.n.Visible=false o.d.Visible=false end
        else o.b.Visible=false o.n.Visible=false o.d.Visible=false end
    end
end)
P.PlayerAdded:Connect(function(p) if S.ESP then task.wait(1) CE(p) end end)
P.PlayerRemoving:Connect(RE)

local pt=Tb["p"]
MK(pt,4,"ij","InfiniteJump")
MK(pt,34,"esp","ESP",function(v) if v then for _,p in pairs(P:GetPlayers()) do CE(p) end else for p,_ in pairs(EO) do RE(p) end end end)
MK(pt,64,"gm","GodMode")
MK(pt,94,"nc","Noclip")
MK(pt,124,"fb","FullBright")
MS(pt,160,"sp",1,300,S.WalkSpeed,"WalkSpeed")
MS(pt,196,"jp",1,300,S.JumpPower,"JumpPower")

local tt=Tb["t"]
local tpI=C("TextLabel",{Text="",Size=UDim2.new(1,-16,0,14),Position=UDim2.new(0,8,0,4),BackgroundTransparency=1,TextColor3=Th.Sb,Font=Enum.Font.Gotham,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,Parent=tt})
AB(tt,24,"sv",function()
    local h=HR() if h then Sp=h.CFrame
        tpI.Text=T("saved")..": "..string.format("%.0f,%.0f,%.0f",h.Position.X,h.Position.Y,h.Position.Z)
    end
end)
AB(tt,56,"tp",function() if not Sp then return end local h=HR() if h then h.CFrame=Sp+Vector3.new(0,3,0) end end)
local slL=C("TextLabel",{Text="",Size=UDim2.new(1,-16,0,14),Position=UDim2.new(0,8,0,92),BackgroundTransparency=1,TextColor3=Th.Sb,Font=Enum.Font.GothamBold,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,Parent=tt})
Reg(slL,"sel")
local PL=C("ScrollingFrame",{Size=UDim2.new(1,-16,0,130),Position=UDim2.new(0,8,0,110),BackgroundColor3=Th.Cd,BackgroundTransparency=0.3,BorderSizePixel=0,CanvasSize=UDim2.new(0,0,0,0),ScrollBarThickness=3,Parent=tt})
C("UICorner",{CornerRadius=UDim.new(0,8),Parent=PL})
local function Rf()
    for _,c in pairs(PL:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    local y=0
    for _,p in ipairs(P:GetPlayers()) do
        if p~=LP then
            local b=C("TextButton",{Text=p.Name,Size=UDim2.new(1,-4,0,22),Position=UDim2.new(0,2,0,y),BackgroundColor3=Th.Cd,BorderSizePixel=0,AutoButtonColor=false,TextColor3=Th.Tx,Font=Enum.Font.Gotham,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,Parent=PL})
            C("UICorner",{CornerRadius=UDim.new(0,4),Parent=b})
            b.MouseButton1Click:Connect(function()
                SelP=p
                for _,x in pairs(PL:GetChildren()) do if x:IsA("TextButton") then x.BackgroundColor3=Th.Cd end end
                b.BackgroundColor3=Th.Sl
            end)
            y=y+24
        end
    end
    PL.CanvasSize=UDim2.new(0,0,0,y)
end
AB(tt,248,"tpP",function()
    if not SelP then return end
    local h=HR() local ch=SelP.Character local th=ch and ch:FindFirstChild("HumanoidRootPart")
    if h and th then h.CFrame=th.CFrame+Vector3.new(0,3,0) end
end)
task.spawn(function()
    Rf()
    P.PlayerAdded:Connect(function() task.wait(1) Rf() end)
    P.PlayerRemoving:Connect(function() task.wait(0.5) Rf() end)
end)
local bt=Tb["b"]
local function MP(pos,size,col,mat)
    local p=Instance.new("Part")
    p.Size=size p.Position=pos p.Anchored=true
    p.CanCollide=true p.CanTouch=true p.CanQuery=true
    p.Color=col or RC(1) p.Material=mat or Enum.Material.Neon
    p.Parent=WS return p
end
AB(bt,4,"one",function() local h=HR() if not h then return end local c=workspace.CurrentCamera MP(h.Position+c.CFrame.LookVector*10,Vector3.new(S.BuildSize,S.BuildSize,S.BuildSize)) end)
AB(bt,36,"wl",function()
    local h=HR() if not h then return end local c=workspace.CurrentCamera
    local pos=h.Position+c.CFrame.LookVector*10+Vector3.new(0,S.BuildSize*1.5,0)
    local p=MP(pos,Vector3.new(S.BuildSize*4,S.BuildSize*3,1),C1(120,120,140),Enum.Material.Concrete)
    p.CFrame=CFrame.new(pos,pos+c.CFrame.LookVector)
end)
AB(bt,68,"bx",function()
    local h=HR() if not h then return end local c=workspace.CurrentCamera
    local base=h.Position+c.CFrame.LookVector*15 local sz=S.BuildSize
    for i=1,4 do
        local a=math.rad((i-1)*90)
        local off=Vector3.new(math.cos(a),0,math.sin(a))*sz*2
        local pos=base+off+Vector3.new(0,sz,0)
        local w=MP(pos,Vector3.new(sz*4,sz*2,1),C1(100,150,200))
        w.CFrame=CFrame.new(pos,pos+Vector3.new(-off.X,0,-off.Z))
    end
end)
AB(bt,100,"cs",function()
    local h=HR() if not h then return end local c=workspace.CurrentCamera
    local base=h.Position+c.CFrame.LookVector*20 local sz=S.BuildSize
    for i=1,4 do
        local a=math.rad((i-1)*90)
        local off=Vector3.new(math.cos(a),0,math.sin(a))*sz*2
        local pos=base+off+Vector3.new(0,sz*1.5,0)
        local w=MP(pos,Vector3.new(sz*4,sz*3,1),C1(140,140,160),Enum.Material.Concrete)
        w.CFrame=CFrame.new(pos,pos+Vector3.new(-off.X,0,-off.Z))
    end
    MP(base+Vector3.new(0,sz*3,0),Vector3.new(sz*4,1,sz*4),C1(160,120,100),Enum.Material.Wood)
    MP(base+Vector3.new(0,sz*5,0),Vector3.new(sz*2,sz*4,sz*2),C1(180,180,200),Enum.Material.Slate)
end)
AB(bt,132,"tw",function()
    local h=HR() if not h then return end local c=workspace.CurrentCamera
    local base=h.Position+c.CFrame.LookVector*10
    for i=0,9 do MP(base+Vector3.new(0,i*S.BuildSize+S.BuildSize/2,0),Vector3.new(S.BuildSize,S.BuildSize,S.BuildSize)) end
end)
AB(bt,164,"st",function()
    local h=HR() if not h then return end local c=workspace.CurrentCamera
    local base=h.Position+c.CFrame.LookVector*10 local sz=S.BuildSize
    for i=0,9 do MP(base+c.CFrame.LookVector*(i*sz)+Vector3.new(0,i*(sz/2),0),Vector3.new(sz*2,sz/2,sz)) end
end)
MS(bt,200,"ps",1,20,S.BuildSize,"BuildSize")

local vt=Tb["v"]
MK(vt,4,"rb","RainbowUI")

local mt=Tb["m"]
AB(mt,4,"rj",function() TS:Teleport(game.PlaceId,LP) end)
AB(mt,36,"sh",function()
    local Ht=game:GetService("HttpService")
    local ok,res=pcall(function() return game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100") end)
    if ok and res then
        local data=Ht:JSONDecode(res) local sv={}
        for _,s in pairs(data.data or {}) do
            if s.playing<s.maxPlayers and s.id~=game.JobId then table.insert(sv,s.id) end
        end
        if #sv>0 then TS:TeleportToPlaceInstance(game.PlaceId,sv[math.random(1,#sv)],LP) end
    end
end)
local lgL=C("TextLabel",{Text="",Size=UDim2.new(1,-16,0,14),Position=UDim2.new(0,8,0,76),BackgroundTransparency=1,TextColor3=Th.Sb,Font=Enum.Font.GothamBold,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,Parent=mt})
Reg(lgL,"lang")
local BJP=C("TextButton",{Text="日本語",Size=UDim2.new(0.5,-12,0,26),Position=UDim2.new(0,8,0,94),BackgroundColor3=Th.Sl,BorderSizePixel=0,AutoButtonColor=false,TextColor3=Th.Tx,Font=Enum.Font.GothamBold,TextSize=10,Parent=mt})
C("UICorner",{CornerRadius=UDim.new(0,8),Parent=BJP})
local BEN=C("TextButton",{Text="English",Size=UDim2.new(0.5,-12,0,26),Position=UDim2.new(0.5,4,0,94),BackgroundColor3=Th.Cd,BorderSizePixel=0,AutoButtonColor=false,TextColor3=Th.Sb,Font=Enum.Font.GothamBold,TextSize=10,Parent=mt})
C("UICorner",{CornerRadius=UDim.new(0,8),Parent=BEN})

local function UA()
    for _,it in ipairs(TR) do
        if it.o and it.o.Parent then
            if it.sl then it.o.Text=L[Lg][it.k]..": "..it.cur
            else it.o.Text=L[Lg][it.k] end
        end
    end
    tpI.Text=L[Lg].saved..": "..(Sp and L[Lg].ok or L[Lg].none)
end
BJP.MouseButton1Click:Connect(function() Lg="JP" BJP.BackgroundColor3=Th.Sl BJP.TextColor3=Th.Tx BEN.BackgroundColor3=Th.Cd BEN.TextColor3=Th.Sb UA() end)
BEN.MouseButton1Click:Connect(function() Lg="EN" BEN.BackgroundColor3=Th.Sl BEN.TextColor3=Th.Tx BJP.BackgroundColor3=Th.Cd BJP.TextColor3=Th.Sb UA() end)
UA()

task.spawn(function() while task.wait(0.5) do if S.GodMode then local h=HM() if h then h.Health=h.MaxHealth end end end end)
local NC
task.spawn(function()
    while task.wait(0.2) do
        if S.Noclip then
            if not NC then
                NC=RS.Stepped:Connect(function()
                    local c=LP.Character if not c then return end
                    for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
                end)
            end
        else if NC then NC:Disconnect() NC=nil end end
    end
end)
task.spawn(function() while task.wait(0.5) do if S.FullBright then LT.Brightness=3 LT.ClockTime=12 LT.Ambient=C1(178,178,178) LT.OutdoorAmbient=C1(178,178,178) LT.FogEnd=100000 end end end)
task.spawn(function()
    while task.wait(0.1) do
        local h=HM()
        if h then
            if h.WalkSpeed~=S.WalkSpeed then h.WalkSpeed=S.WalkSpeed end
            if h.JumpPower~=S.JumpPower then h.JumpPower=S.JumpPower end
        end
    end
end)
UIS.JumpRequest:Connect(function() if S.InfiniteJump then local h=HM() if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end)

Sel("p")
print("[Fireworks v8.2] Loaded")
