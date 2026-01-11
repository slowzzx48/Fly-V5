local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

local localPlayer = Players.LocalPlayer


local main = Instance.new("ScreenGui")
main.Name = "main"
main.Parent = localPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
main.ResetOnSpawn = false


local Frame = Instance.new("Frame")
Frame.Name = "Frame"
Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.10, 0, 0.36, 0)
Frame.Size = UDim2.new(0, 240, 0, 110)
Frame.Active = true
Frame.Draggable = true
Frame.ClipsDescendants = false

-- Visual: rounded corners for main frame
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = Frame


local TitleBar = Instance.new("Frame")
TitleBar.Parent = Frame
TitleBar.Size = UDim2.new(1, 0, 0, 34)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundTransparency = 0
TitleBar.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
TitleBar.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = TitleBar


local TextLabel = Instance.new("TextLabel")
TextLabel.Parent = TitleBar
TextLabel.BackgroundTransparency = 1
TextLabel.Size = UDim2.new(1, 100, 1, 0)
TextLabel.Position = UDim2.new(0, 10, 0, 0)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = " Fly v5"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left


local closebutton = Instance.new("TextButton")
closebutton.Name = "Close"
closebutton.Parent = TitleBar
closebutton.Size = UDim2.new(0, 30, 0, 24)
closebutton.Position = UDim2.new(1, -38, 0, 5)
closebutton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closebutton.Text = "X"
closebutton.Font = Enum.Font.GothamBold
closebutton.TextScaled = true
closebutton.TextColor3 = Color3.fromRGB(20,20,20)

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closebutton

local closeGrad = Instance.new("UIGradient")
closeGrad.Color = ColorSequence.new(Color3.fromRGB(255,120,120), Color3.fromRGB(220,60,60))
closeGrad.Rotation = 90
closeGrad.Parent = closebutton


local mini = Instance.new("TextButton")
mini.Name = "minimize"
mini.Parent = TitleBar
mini.Size = UDim2.new(0, 30, 0, 24)
mini.Position = UDim2.new(1, -76, 0, 5)
mini.BackgroundColor3 = Color3.fromRGB(110, 110, 110)
mini.Text = "-"
mini.Font = Enum.Font.GothamBold
mini.TextScaled = true
mini.TextColor3 = Color3.fromRGB(255,255,255)

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 6)
miniCorner.Parent = mini

local mini2 = Instance.new("TextButton")
mini2.Name = "minimize2"
mini2.Parent = TitleBar
mini2.Size = UDim2.new(0, 30, 0, 24)
mini2.Position = UDim2.new(1, -76, 0, 5)
mini2.BackgroundColor3 = Color3.fromRGB(110, 110, 110)
mini2.Text = "+"
mini2.Font = Enum.Font.GothamBold
mini2.TextScaled = true
mini2.TextColor3 = Color3.fromRGB(255,255,255)
mini2.Visible = false

local mini2Corner = Instance.new("UICorner")
mini2Corner.CornerRadius = UDim.new(0, 6)
mini2Corner.Parent = mini2


local Content = Instance.new("Frame")
Content.Parent = Frame
Content.Size = UDim2.new(1, -12, 1, -46)
Content.Position = UDim2.new(0, 6, 0, 40)
Content.BackgroundTransparency = 1


local function makeBtn(name, text, pos)
    local b = Instance.new("TextButton")
    b.Name = name
    b.Parent = Content
    b.Size = UDim2.new(0, 68, 0, 28)
    b.Position = pos
    b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    b.Font = Enum.Font.Gotham
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.TextScaled = true

    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,6); c.Parent = b
    local g = Instance.new("UIGradient"); g.Rotation = 90
    g.Color = ColorSequence.new(Color3.fromRGB(85,85,85), Color3.fromRGB(60,60,60))
    g.Parent = b

    return b
end

local up = makeBtn("up", "UP", UDim2.new(0, 0, 0, 0))
local down = makeBtn("down", "DOWN", UDim2.new(0, 0, 0, 34))
local plus = makeBtn("plus", "+", UDim2.new(0, 74, 0, 0))
local mine = makeBtn("mine", "-", UDim2.new(0, 74, 0, 34))
local onof = makeBtn("onof", "FLY", UDim2.new(0, 148, 0, 34))


-- Única mudança: TextLabel virou TextBox (input editável)
local speed = Instance.new("TextBox")
speed.Name = "speed"
speed.Parent = Content
speed.Size = UDim2.new(0, 68, 0, 28)
speed.Position = UDim2.new(0, 148, 0, 0)
speed.BackgroundColor3 = Color3.fromRGB(50,50,50)
speed.Font = Enum.Font.GothamBold
speed.TextColor3 = Color3.fromRGB(255,255,255)
speed.TextScaled = true
speed.Text = "1"
speed.ClearTextOnFocus = false
speed.PlaceholderText = "Digite..."
local speedCorner = Instance.new("UICorner"); speedCorner.CornerRadius = UDim.new(0,6); speedCorner.Parent = speed
local speedGrad = Instance.new("UIGradient"); speedGrad.Color = ColorSequence.new(Color3.fromRGB(90,60,200), Color3.fromRGB(50,50,120)); speedGrad.Rotation = 90; speedGrad.Parent = speed


local outline = Instance.new("Frame")
outline.Parent = Frame
outline.Size = UDim2.new(1, 6, 1, 6)
outline.Position = UDim2.new(0, -3, 0, -3)
outline.BackgroundTransparency = 1


StarterGui:SetCore("SendNotification", {
    Title = "by Slowzzx4";
    Text = "Fly GUI loaded";
    Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150";
    Duration = 4;
})


local speaker = Players.LocalPlayer

local chr = Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

local nowe = false

local speeds = 1


-- Atualiza speeds quando digitar e apertar Enter
speed.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newSpeed = tonumber(speed.Text)
        if newSpeed and newSpeed >= 1 then
            speeds = newSpeed
            speed.Text = tostring(speeds)
            
            -- Se fly estiver ligado, reinicia os spawns com o novo valor
            if nowe then
                tpwalking = false
                task.wait(0.1)
                tpwalking = true
                for i = 1, speeds do
                    task.spawn(function()
                        local hb = RunService.Heartbeat
                        local chr = Players.LocalPlayer.Character
                        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                        while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                            if hum.MoveDirection.Magnitude > 0 then
                                chr:TranslateBy(hum.MoveDirection)
                            end
                        end
                    end)
                end
            end
        else
            speed.Text = tostring(speeds)  -- Volta pro valor atual se inválido
        end
    end
end)


onof.MouseButton1Down:Connect(function()
    if nowe == true then
        nowe = false

        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    else 
        nowe = true

        for i = 1, speeds do
            spawn(function()
                local hb = RunService.Heartbeat    

                tpwalking = true
                local chr = Players.LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection)
                    end
                end
            end)
        end

        if Players.LocalPlayer.Character:FindFirstChild("Animate") then
            local animScript = Players.LocalPlayer.Character.Animate
            animScript.Disabled = true
        end

        local Char = Players.LocalPlayer.Character
        local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")
        if Hum then
            for i,v in next, Hum:GetPlayingAnimationTracks() do
                v:AdjustSpeed(0)
            end
        end

        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
    end

    if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
        local plr = game.Players.LocalPlayer
        local torso = plr.Character.Torso
        local flying = true
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 50
        local speedv = 0

        local bg = Instance.new("BodyGyro", torso)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = torso.CFrame
        local bv = Instance.new("BodyVelocity", torso)
        bv.velocity = Vector3.new(0,0.1,0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        if nowe == true then
            plr.Character.Humanoid.PlatformStand = true
        end
        while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
            RunService.RenderStepped:Wait()

            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speedv = speedv+.5+(speedv/maxspeed)
                if speedv > maxspeed then
                    speedv = maxspeed
                end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speedv ~= 0 then
                speedv = speedv-1
                if speedv < 0 then
                    speedv = 0
                end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speedv
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speedv ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speedv
            else
                bv.velocity = Vector3.new(0,0,0)
            end
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speedv/maxspeed),0,0)
        end
        ctrl = {f = 0, b = 0, l = 0, r = 0}
        lastctrl = {f = 0, b = 0, l = 0, r = 0}
        speedv = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
        if Players.LocalPlayer.Character:FindFirstChild("Animate") then
            Players.LocalPlayer.Character.Animate.Disabled = false
        end
        tpwalking = false

    else
        local plr = game.Players.LocalPlayer
        local UpperTorso = plr.Character:FindFirstChild("UpperTorso") or plr.Character:FindFirstChild("Torso")
        local flying = true
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 50
        local speedv = 0

        local bg = Instance.new("BodyGyro", UpperTorso)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = UpperTorso.CFrame
        local bv = Instance.new("BodyVelocity", UpperTorso)
        bv.velocity = Vector3.new(0,0.1,0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        if nowe == true then
            plr.Character.Humanoid.PlatformStand = true
        end
        while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
            wait()

            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speedv = speedv+.5+(speedv/maxspeed)
                if speedv > maxspeed then
                    speedv = maxspeed
                end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speedv ~= 0 then
                speedv = speedv-1
                if speedv < 0 then
                    speedv = 0
                end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speedv
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speedv ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speedv
            else
                bv.velocity = Vector3.new(0,0,0)
            end

            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speedv/maxspeed),0,0)
        end
        ctrl = {f = 0, b = 0, l = 0, r = 0}
        lastctrl = {f = 0, b = 0, l = 0, r = 0}
        speedv = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
        if Players.LocalPlayer.Character:FindFirstChild("Animate") then
            Players.LocalPlayer.Character.Animate.Disabled = false
        end
        tpwalking = false
    end
end)

local tis
up.MouseButton1Down:Connect(function()
    tis = up.MouseEnter:Connect(function()
        while tis do
            wait()
            if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)
            end
        end
    end)
end)

up.MouseLeave:Connect(function()
    if tis then
        tis:Disconnect()
        tis = nil
    end
end)

local dis
down.MouseButton1Down:Connect(function()
    dis = down.MouseEnter:Connect(function()
        while dis do
            wait()
            if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)
            end
        end
    end)
end)

down.MouseLeave:Connect(function()
    if dis then
        dis:Disconnect()
        dis = nil
    end
end)

Players.LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.7)
    if Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        Players.LocalPlayer.Character.Humanoid.PlatformStand = false
    end
    if Players.LocalPlayer.Character:FindFirstChild("Animate") then
        Players.LocalPlayer.Character.Animate.Disabled = false
    end
end)

plus.MouseButton1Down:Connect(function()
    speeds = speeds + 1
    speed.Text = tostring(speeds)
    if nowe == true then
        tpwalking = false
        for i = 1, speeds do
            spawn(function()
                local hb = RunService.Heartbeat    

                tpwalking = true
                local chr = Players.LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection)
                    end
                end
            end)
        end
    end
end)

mine.MouseButton1Down:Connect(function()
    if speeds == 1 then
        speed.Text = 'cannot be less than 1'
        wait(1)
        speed.Text = tostring(speeds)
    else
        speeds = speeds - 1
        speed.Text = tostring(speeds)
        if nowe == true then
            tpwalking = false
            for i = 1, speeds do
                spawn(function()
                    local hb = RunService.Heartbeat    

                    tpwalking = true
                    local chr = Players.LocalPlayer.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end)
            end
        end
    end
end)

closebutton.MouseButton1Click:Connect(function()
    main:Destroy()
end)

local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
mini.MouseButton1Click:Connect(function()

    mini.Visible = false
    mini2.Visible = true
    local t1 = TweenService:Create(Frame, tweenInfo, {Size = UDim2.new(Frame.Size.X.Scale, Frame.Size.X.Offset, 0, 34)})
    t1:Play()
    for _, child in pairs(Content:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextBox") then
            local t = TweenService:Create(child, tweenInfo, {TextTransparency = 1, BackgroundTransparency = 1})
            t:Play()
        end
    end
end)

mini2.MouseButton1Click:Connect(function()
    mini2.Visible = false
    mini.Visible = true
    local t1 = TweenService:Create(Frame, tweenInfo, {Size = UDim2.new(Frame.Size.X.Scale, Frame.Size.X.Offset, 0, 110)})
    t1:Play()
    for _, child in pairs(Content:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextBox") then
            local t = TweenService:Create(child, tweenInfo, {TextTransparency = 0, BackgroundTransparency = 0})
            t:Play()
        end
    end
end)
