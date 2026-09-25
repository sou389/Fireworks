--// Fireworks v9.3
local hui=gethui and gethui()or game:GetService("CoreGui")
local P=game:GetService("Players")
local RS=game:GetService("RunService")
local TW=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local LT=game:GetService("Lighting")
local WS=game:GetService("Workspace")
local TS=game:GetService("TeleportService")
local HS=game:GetService("HttpService")
local LP=P.LocalPlayer

local Lg="JP"
local L={}
L.JP={p="プレイヤー",t="テレポート",b="建築",v="見た目",m="その他",
ij="無限ジャンプ",esp="ESP",gm="ゴッドモード",nc="ノークリップ",
rb="虹色UI",sp="移動速度",ww="壁歩き",li="ライト",
sv="位置を保存",tp="保存位置に移動",tpP="プレイヤーに移動",sel="プレイヤー選択",
one="パーツ",wl="壁",bx="箱",cs="城",tw="タワー",st="階段",ps="サイズ",
rj="再入場",sh="サーバー移動",lang="言語",saved="保存",none="なし",ok="OK",
title="Fireworks v9.3",loading="読み込み中",
shop="ショップ",buy="購入",shopTitle="プレミアムショップ",
adminCode="管理者コード",adminNG="コード違います",
addMoney="コイン追加",makeBig="巨大化",makeSmall="縮小化",
freeze="凍結",kick="キック",reset="リセット",
tax="税率",adminPanel="管理者パネル",target="選択中",noMoney="お金不足",
item1="無敵モード",item1d="永遠の無敵",
item2="キルチート",item2d="近くの敵を倒す",
item3="VIP",item3d="特別な能力",
item4="管理者",item4d="管理者権限",
owned="購入済み",fov="視野角",fullbright="明るく",
tpRandom="ランダムTP",heal="回復",maxHealth="最大HP"}
L.EN={p="Player",t="Teleport",b="Build",v="Visual",m="Misc",
ij="Infinite Jump",esp="ESP",gm="God Mode",nc="Noclip",
rb="Rainbow UI",sp="WalkSpeed",ww="Wall Walk",li="Light",
sv="Save Position",tp="TP to Saved",tpP="TP to Player",sel="Select Player",
one="Part",wl="Wall",bx="Box",cs="Castle",tw="Tower",st="Stairs",ps="Size",
rj="Rejoin",sh="Server Hop",lang="Language",saved="Saved",none="None",ok="OK",
title="Fireworks v9.3",loading="Loading",
shop="Shop",buy="Buy",shopTitle="Premium Shop",
adminCode="Admin Code",adminNG="Wrong code",
addMoney="Add Coins",makeBig="Make Big",makeSmall="Make Small",
freeze="Freeze",kick="Kick",reset="Reset",
tax="Tax",adminPanel="Admin Panel",target="Target",noMoney="No money",
item1="God Mode",item1d="Eternal Invincibility",
item2="Kill Cheat",item2d="Kill nearby enemies",
item3="VIP",item3d="Special abilities",
item4="Admin",item4d="Admin powers",
owned="Owned",fov="FOV",fullbright="Full Bright",
tpRandom="Random TP",heal="Heal",maxHealth="Max HP"}
local function T(k)return L[Lg][k]or k end

local S={WalkSpeed=16,InfiniteJump=false,ESP=false,GodMode=false,
Noclip=false,RainbowUI=true,BuildSize=5,WallWalk=false,Light=false,FOV=70}

local Data={Money=0,TaxRate=0,VIP=false,HasAdmin=false,BoughtGod=false,BoughtKill=false}
local SaveFile="fireworks_v93.json"
local function LoadData()
    if isfile and isfile(SaveFile) then
        pcall(function()
            local d=HS:JSONDecode(readfile(SaveFile))
            Data.Money=d.Money or 0
            Data.TaxRate=d.TaxRate or 0
            Data.VIP=d.VIP or false
            Data.HasAdmin=d.HasAdmin or false
            Data.BoughtGod=d.BoughtGod or false
            Data.BoughtKill=d.BoughtKill or false
        end)
    end
end
local function SaveData()
    if writefile then
        pcall(function() writefile(SaveFile,HS:JSONEncode(Data)) end)
    end
end
LoadData()

local Money=Data.Money
local TaxRate=Data.TaxRate
local VIP=Data.VIP
local HasAdmin=Data.HasAdmin
local BoughtGod=Data.BoughtGod
local BoughtKill=Data.BoughtKill

local Sp=nil SelP=nil EO={} CS={} TR={}
local LightObj=nil
local C1=Color3.fromRGB
local Th={Bg=C1(15,15,25),Cd=C1(24,24,38),Sl=C1(40,40,60),
Tx=C1(245,245,255),Sb=C1(140,140,180),A1=C1(140,90,255),A2=C1(80,200,255),
A3=C1(255,90,180),On=C1(80,220,140),Of=C1(60,60,90),
Gold=C1(255,200,60),Green=C1(60,180,90),Red=C1(200,60,70)}

local function C(c,p) local i=Instance.new(c) for k,v in pairs(p or {}) do i[k]=v end return i end
local function RC(s)
    local t=tick()*(s or 1)
    return Color3.new(math.sin(t)*0.5+0.5,math.sin(t+2.094)*0.5+0.5,math.sin(t+4.188)*0.5+0.5)
end
local function HM() local c=LP.Character if not c then return nil end return c:FindFirstChildOfClass("Humanoid") end
local function HR() local c=LP.Character if not c then return nil end return c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart end
local function Reg(o,tk,sl,cur) table.insert(TR,{o=o,k=tk,sl=sl,cur=cur}) end
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

local MoneyLbl=C("TextLabel",{Text="",Size=UDim2.new(0,0,0,0),Visible=false,Parent=SG})

local LS=C("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=C1(10,10,20),BorderSizePixel=0,ZIndex=100,Parent=SG})
C("TextLabel",{Text="Fireworks v9.3",Size=UDim2.new(1,0,0,40),Position=UDim2.new(0,0,0.4,-40),BackgroundTransparency=1,TextColor3=Th.Tx,Font=Enum.Font.GothamBold,TextSize=22,Parent=LS})
local LBBg=C("Frame",{Size=UDim2.new(0.6,0,0,20),Position=UDim2.new(0.2,0,0.5,10),BackgroundColor3=C1(30,30,50),BorderSizePixel=0,Parent=LS})
C("UICorner",{CornerRadius=UDim.new(1,0),Parent=LBBg})
local LBFill=C("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Th.A1,BorderSizePixel=0,Parent=LBBg})
C("UICorner",{CornerRadius=UDim.new(1,0),Parent=LBFill})
C("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Th.A1),ColorSequenceKeypoint.new(0.5,Th.A2),ColorSequenceKeypoint.new(1,Th.A3)}),Parent=LBFill})
local LBP=C("TextLabel",{Text="0%",Size=UDim2.new(1,0,0,20),Position=UDim2.new(0,0,0.5,35),BackgroundTransparency=1,TextColor3=Th.Tx,Font=Enum.Font.GothamBold,TextSize=14,Parent=LS})
task.spawn(function()
    for i=0,100 do LBFill.Size=UDim2.new(i/100,0,1,0) LBP.Text=i.."%" task.wait(0.02) end
    task.wait(0.3) LS:Destroy()
end)

local lastTick=tick()
task.spawn(function()
    while true do
        task.wait(1)
        local now=tick()
        if now-lastTick>=60 then
            lastTick=now
            local earn=10
            local tax=math.floor(earn*(TaxRate/100))
            local net=earn-tax
            Money=Money+net
            Data.Money=Money
            SaveData()
            if ShopBal and ShopBal.Parent then ShopBal.Text="¥ "..Money end
        end
    end
end)

local TB=C("TextButton",{Text="FW",Size=UDim2.new(0,60,0,26),Position=UDim2.new(0.5,-30,0,5),BackgroundColor3=Th.Cd,BorderSizePixel=0,AutoButtonColor=false,TextColor3=Th.Tx,Font=Enum.Font.GothamBold,TextSize=12,Parent=SG})
C("UICorner",{CornerRadius=UDim.new(0,13),Parent=TB})
C("UIStroke",{Color=Th.A1,Thickness=1.5,Parent=TB})

local M=C("Frame",{Size=UDim2.new(0,240,0,340),Position=UDim2.new(0.5,-120,0.5,-170),BackgroundColor3=Th.Bg,BackgroundTransparency=0.05,BorderSizePixel=0,Visible=false,Parent=SG})
C("UICorner",{CornerRadius=UDim.new(0,12),Parent=M})
C("UIStroke",{Color=Th.A1,Thickness=1.5,Parent=M})
TB.MouseButton1Click:Connect(function() M.Visible=not M.Visible end)

local H=C("Frame",{Size=UDim2.new(1,0,0,30),BackgroundColor3=Th.Cd,BackgroundTransparency=0.3,BorderSizePixel=0,Parent=M})
C("UICorner",{CornerRadius=UDim.new(0,12),Parent=H})
local HT=C("TextLabel",{Text=T("title"),Size=UDim2.new(1,-40,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,TextColor3=Th.Tx,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=H})
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
    local b=C("TextButton",{Text=T(k),Size=UDim2.new(0.2,-2,1,0),Position=UDim2.new((i-1)*0.2,2,0,0),BackgroundColor3=Th.Cd,BorderSizePixel=0,AutoButtonColor=false,TextColor3=Th.Sb,Font=Enum.Font.GothamBold,TextSize=9,Parent=TBa})
    C("UICorner",{CornerRadius=UDim.new(0,6),Parent=b})
    b.MouseButton1Click:Connect(function() Sel(k) end)
    TbB[k]=b Reg(b,k)
    Tb[k]=C("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ClipsDescendants=true,Visible=false,Parent=CA})
end
local function MK(par,y,tk,key,cb)
    local b=C("TextButton",{Text="",Size=UDim2.new(1,-16,0,26),Position=UDim2.new(0,8,0,y),BackgroundColor3=Th.Cd,BackgroundTransparency=0.1,BorderSizePixel=0,AutoButtonColor=false,Parent=par})
    C("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
    C("UIStroke",{Color=Th.Of,Thickness=1.2,Transparency=0.4,Parent=b})
    local lb=C("TextLabel",{Text=T(tk),Size=UDim2.new(1,-50,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,TextColor3=Th.Tx,Font=Enum.Font.GothamMedium,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,Parent=b})
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
    local b=C("TextButton",{Text=T(tk),Size=UDim2.new(1,-16,0,26),Position=UDim2.new(0,8,0,y),BackgroundColor3=Th.Cd,BackgroundTransparency=0.1,BorderSizePixel=0,AutoButtonColor=false,TextColor3=Th.Tx,Font=Enum.Font.GothamBold,TextSize=10,Parent=par})
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
    local l=C("TextLabel",{Text=T(tk)..": "..df,Size=UDim2.new(1,-16,0,12),Position=UDim2.new(0,10,0,2),BackgroundTransparency=1,TextColor3=Th.Tx,Font=Enum.Font.GothamMedium,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,Parent=c})
    Reg(l,tk,true,df)
    local tr=C("Frame",{Size=UDim2.new(1,-20,0,4),Position=UDim2.new(0,10,0,22),BackgroundColor3=C1(20,20,32),BorderSizePixel=0,Parent=c})
    C("UICorner",{CornerRadius=UDim.new(1,0),Parent=tr})
    local fl=C("Frame",{Size=UDim2.new((df-mn)/(mx-mn),0,1,0),BackgroundColor3=Th.A1,BorderSizePixel=0,Parent=tr})
    C("UICorner",{CornerRadius=UDim.new(1,0),Parent=fl})
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
-- Player タブ
local pt=Tb["p"]
MK(pt,4,"ij","InfiniteJump")
MK(pt,34,"esp","ESP",function(v)
    if v then for _,p in pairs(P:GetPlayers()) do CE(p) end
    else for p,_ in pairs(EO) do RE(p) end end
end)
MK(pt,64,"gm","GodMode")
MK(pt,94,"nc","Noclip")
MK(pt,124,"ww","WallWalk")
MK(pt,154,"li","Light",function(v)
    if v then
        local c=LP.Character
        if c then
            if not LightObj then
                LightObj=Instance.new("PointLight")
                LightObj.Brightness=5
                LightObj.Range=60
                LightObj.Color=C1(255,255,255)
            end
            LightObj.Parent=c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
        end
    else if LightObj then LightObj.Parent=nil end end
end)
MS(pt,190,"sp",1,300,S.WalkSpeed,"WalkSpeed")

-- Teleport タブ
local tt=Tb["t"]
local tpI=C("TextLabel",{Text=T("saved")..": "..T("none"),Size=UDim2.new(1,-16,0,14),Position=UDim2.new(0,8,0,4),BackgroundTransparency=1,TextColor3=Th.Sb,Font=Enum.Font.Gotham,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,Parent=tt})
AB(tt,24,"sv",function()
    local h=HR()
    if h then Sp=h.CFrame
        tpI.Text=T("saved")..": "..string.format("%.0f,%.0f,%.0f",h.Position.X,h.Position.Y,h.Position.Z)
    end
end)
AB(tt,56,"tp",function()
    if not Sp then return end
    local h=HR() if h then h.CFrame=Sp+Vector3.new(0,3,0) end
end)
local slL=C("TextLabel",{Text=T("sel"),Size=UDim2.new(1,-16,0,14),Position=UDim2.new(0,8,0,92),BackgroundTransparency=1,TextColor3=Th.Sb,Font=Enum.Font.GothamBold,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,Parent=tt})
Reg(slL,"sel")
local PL=C("Frame",{Size=UDim2.new(1,-16,0,130),Position=UDim2.new(0,8,0,110),BackgroundColor3=Th.Cd,BackgroundTransparency=0.3,BorderSizePixel=0,ClipsDescendants=true,Parent=tt})
C("UICorner",{CornerRadius=UDim.new(0,8),Parent=PL})
local plScrollY=0
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
end
AB(tt,248,"tpP",function()
    if not SelP then return end
    local h=HR()
    local ch=SelP.Character
    local th=ch and ch:FindFirstChild("HumanoidRootPart")
    if h and th then h.CFrame=th.CFrame+Vector3.new(0,3,0) end
end)
task.spawn(function()
    Rf()
    P.PlayerAdded:Connect(function() task.wait(1) Rf() end)
    P.PlayerRemoving:Connect(function() task.wait(0.5) Rf() end)
end)

-- Build タブ
local bt=Tb["b"]
local function MP(pos,size,col,mat)
    local p=Instance.new("Part")
    p.Size=size p.Position=pos p.Anchored=true
    p.CanCollide=true p.CanTouch=true p.CanQuery=true
    p.Color=col or RC(1) p.Material=mat or Enum.Material.Neon
    p.Parent=WS return p
end
AB(bt,4,"one",function()
    local h=HR() if not h then return end
    local c=workspace.CurrentCamera
    MP(h.Position+c.CFrame.LookVector*10,Vector3.new(S.BuildSize,S.BuildSize,S.BuildSize))
end)
AB(bt,36,"wl",function()
    local h=HR() if not h then return end
    local c=workspace.CurrentCamera
    local pos=h.Position+c.CFrame.LookVector*10+Vector3.new(0,S.BuildSize*1.5,0)
    local p=MP(pos,Vector3.new(S.BuildSize*4,S.BuildSize*3,1),C1(120,120,140),Enum.Material.Concrete)
    p.CFrame=CFrame.new(pos,pos+c.CFrame.LookVector)
end)
AB(bt,68,"bx",function()
    local h=HR() if not h then return end
    local c=workspace.CurrentCamera
    local base=h.Position+c.CFrame.LookVector*15
    local sz=S.BuildSize
    for i=1,4 do
        local a=math.rad((i-1)*90)
        local off=Vector3.new(math.cos(a),0,math.sin(a))*sz*2
        local pos=base+off+Vector3.new(0,sz,0)
        local w=MP(pos,Vector3.new(sz*4,sz*2,1),C1(100,150,200))
        w.CFrame=CFrame.new(pos,pos+Vector3.new(-off.X,0,-off.Z))
    end
end)
AB(bt,100,"cs",function()
    local h=HR() if not h then return end
    local c=workspace.CurrentCamera
    local base=h.Position+c.CFrame.LookVector*20
    local sz=S.BuildSize
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
    local h=HR() if not h then return end
    local c=workspace.CurrentCamera
    local base=h.Position+c.CFrame.LookVector*10
    for i=0,9 do
        MP(base+Vector3.new(0,i*S.BuildSize+S.BuildSize/2,0),Vector3.new(S.BuildSize,S.BuildSize,S.BuildSize))
    end
end)
AB(bt,164,"st",function()
    local h=HR() if not h then return end
    local c=workspace.CurrentCamera
    local base=h.Position+c.CFrame.LookVector*10
    local sz=S.BuildSize
    for i=0,9 do
        MP(base+c.CFrame.LookVector*(i*sz)+Vector3.new(0,i*(sz/2),0),Vector3.new(sz*2,sz/2,sz))
    end
end)
MS(bt,200,"ps",1,20,S.BuildSize,"BuildSize")
