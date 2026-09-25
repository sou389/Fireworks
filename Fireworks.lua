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
