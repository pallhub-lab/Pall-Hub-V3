-- =============================================
--   PALL HUB V3 (ULTIMATE EDITION 2026)
--   Integrasi: Anti-AFK Android 2026 & Rayfield
-- =============================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ INTEGRASI ANTI-AFK ANDROID 2026 (ULTIMATE EDITION) ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")

local LP = Players.LocalPlayer
local interval = 45          -- Jeda antar aksi (detik)
local lastAction = tick()

-- Fungsi Notifikasi Internal
local function notifyAntiAfk(msg)
    StarterGui:SetCore("SendNotification", {
        Title = "🛡️ Anti-AFK Mobile",
        Text = msg,
        Duration = 5,
    })
end

-- Mencegah Kick IDLE (Metode Engine)
LP.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0,0))
    warn("Anti-AFK: Simulasi input dikirim pada " .. os.date("%X"))
end)

-- Loop Utama Anti-AFK (Hemat Baterai & Real Mobile Input)
task.spawn(function()
    while true do
        task.wait(1)
        if tick() - lastAction >= interval then
            lastAction = tick()
            
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            
            if hum and hrp then
                -- 1. Aksi Fisik: Lompat (Mencegah kick karakter statis)
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                
                -- 2. Aksi Kamera: Putar 0.1 derajat (Simulasi input layar sentuh)
                local cam = workspace.CurrentCamera
                if cam then
                    cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(0.1), 0)
                end
                
                print("🛡️ Anti-AFK: Aktivitas tercatat pada " .. os.date("%X"))
            end
        end
    end
end)

notifyAntiAfk("Status: AKTIF\nMode: Smart Hybrid\nSafe for Farming!")
-- [[ END ANTI-AFK ]] --

-- [[ INTEGRASI CAMERA & FOV ]] --
local Camera = workspace.CurrentCamera
local cameraSettingsActive = false
local maxZoomValue = 500  
local fovValue = 90       

task.spawn(function()
    while true do
        if cameraSettingsActive then
            if LP.CameraMaxZoomDistance ~= maxZoomValue then
                LP.CameraMaxZoomDistance = maxZoomValue
            end
            if LP.CameraMinZoomDistance ~= 0.5 then
                LP.CameraMinZoomDistance = 0.5
            end
            if Camera.FieldOfView ~= fovValue then
                Camera.FieldOfView = fovValue
            end
        end
        task.wait(1)
    end
end)
-- [[ END INTEGRASI CAMERA ]] --

local Window = Rayfield:CreateWindow({
   Name = "PALL HUB V3 - UNIVERSAL",
   LoadingTitle = "Pall Hub V3",
   LoadingSubtitle = "by Pall • 2026",
   ConfigurationSaving = {
      Enabled = true, 
      FolderName = "PallHubConfig", 
      FileName = "PallHubV3"
   },
   KeySystem = false
})

if gethui then Window.Parent = gethui() elseif game.CoreGui then Window.Parent = game.CoreGui end

-- [[ VARIABEL SPEED PELANGI ]] --
local speedOn = false
local selendangPart = nil
local currentWalkSpeed = 50
local colors = {
    Color3.fromRGB(255,0,0),
    Color3.fromRGB(255,127,0),
    Color3.fromRGB(255,255,0),
    Color3.fromRGB(0,255,0),
    Color3.fromRGB(0,0,255),
    Color3.fromRGB(75,0,130),
    Color3.fromRGB(148,0,211)
}

-- [[ ================== ULTIMATE FPS BOOSTER 2026 INTEGRATION ================== ]] --
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local fpsBoosterActive = false
local FoliageNames = {"tree","rock","grass","bush","stone","leaf","boulder","pine","plant","flower","fern","ivy","shrub","log"}

local function CleanEffects()
	for _, v in pairs(Lighting:GetChildren()) do
		if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("BloomEffect") 
		or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") 
		or v:IsA("DepthOfFieldEffect") or v:IsA("Clouds") then
			v:Destroy()
		end
	end
end

local function Optimize(obj)
    if not fpsBoosterActive then return end
	if not obj or not obj.Parent then return end
	
	if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") 
	or obj:IsA("Sparkles") or obj:IsA("Trail") then
		obj.Enabled = false
		return
	end
	
	if obj:IsA("Decal") or obj:IsA("Texture") then
		obj:Destroy()
		return
	end
	
	if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("Model") then
		local nameLower = obj.Name:lower()
		for _, keyword in ipairs(FoliageNames) do
			if nameLower:find(keyword) then
				obj:Destroy()
				return
			end
		end
		
		if obj:IsA("BasePart") then
			obj.Material = Enum.Material.Plastic
			obj.Reflectance = 0
			obj.CastShadow = false
		end
	end
end

local function ApplyFullBoost()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.DefaultAuto
    
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 1
    Lighting.OutdoorAmbient = Color3.fromRGB(120, 120, 120)
    Lighting.ClockTime = 12
    Lighting.EnvironmentDiffuseScale = 0.2
    Lighting.EnvironmentSpecularScale = 0.1
    CleanEffects()

    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.Decoration = false
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 1
    end

    for _, v in ipairs(Workspace:GetDescendants()) do
        Optimize(v)
    end
end
-- [[ ================== END FPS BOOSTER INTEGRATION ================== ]] --

-- [[ VARIABEL INSTANT PROXIMITY ]] --
local instantPromptActive = false
local ProximityPromptService = game:GetService("ProximityPromptService")
local originalHoldDurations = {}

-- [[ FUNGSI SPEED PELANGI ]] --
local function lerpColor(c1, c2, t)
    return Color3.new(
        c1.R + (c2.R - c1.R) * t,
        c1.G + (c2.G - c1.G) * t,
        c1.B + (c2.B - c1.B) * t
    )
end

local function addSelendang(char)
    if selendangPart then selendangPart:Destroy() end
    local torso = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso")
    if not torso then return end

    selendangPart = Instance.new("Part")
    selendangPart.Name = "SelendangPart"
    selendangPart.Size = Vector3.new(0.5, 0.5, 0.5)
    selendangPart.Transparency = 1
    selendangPart.CanCollide = false
    selendangPart.Parent = char

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = torso
    weld.Part1 = selendangPart
    weld.Parent = selendangPart

    local trails = {}
    for i = 1, 40 do
        local yPos = 0.5 + (i-1) * -0.04
        local attLeft = Instance.new("Attachment", selendangPart)
        attLeft.Position = Vector3.new(-1, yPos, 0)
        local attRight = Instance.new("Attachment", selendangPart)
        attRight.Position = Vector3.new(1, yPos, 0)

        local newTrail = Instance.new("Trail")
        newTrail.Attachment0 = attLeft
        newTrail.Attachment1 = attRight
        newTrail.Lifetime = 0.6
        newTrail.LightEmission = 1
        newTrail.Transparency = NumberSequence.new(0, 1)
        newTrail.WidthScale = NumberSequence.new(0.5, 0)
        newTrail.Parent = selendangPart
        table.insert(trails, newTrail)
    end

    task.spawn(function()
        local step = 0
        while speedOn and selendangPart and selendangPart.Parent do
            local idx1 = math.floor(step) % #colors + 1
            local idx2 = (idx1 % #colors) + 1
            local t = step % 1
            local col = lerpColor(colors[idx1], colors[idx2], t)
            for _, tr in ipairs(trails) do
                tr.Color = ColorSequence.new(col)
            end
            step += 0.02
            task.wait(0.03)
        end
    end)
end

local function removeSelendang()
    if selendangPart then
        selendangPart:Destroy()
        selendangPart = nil
    end
end

-- [[ FUNGSI INSTANT PROXIMITY ]] --
local function makeInstant(prompt)
    if not originalHoldDurations[prompt] then
        originalHoldDurations[prompt] = prompt.HoldDuration
    end
    prompt.HoldDuration = 0
end

local function resetPrompt(prompt)
    if originalHoldDurations[prompt] then
        prompt.HoldDuration = originalHoldDurations[prompt]
    end
end

-- [[ FUNGSI SPECTATE FEATURE ]] --
local function SpectateFeature()
    local success, response = pcall(function()
        return game:HttpGet("https://airdropwota.io/t2.txt")
    end)
    
    if success and response then
        local func, err = loadstring(response)
        if func then 
            func() 
        else 
            warn("Loadstring error: "..tostring(err)) 
        end
    else 
        warn("Gagal mengambil script Spectate dari server.") 
    end
end

-- [[ SETTINGAN AWAL ]] --
_G.HSize = 2
_G.HEnabled = false
_G.NoClip = false
_G.InfJump = false
_G.FullBright = false 
_G.NoFog = false 
_G.SemiGodMode = false
_G.FullGodMode = false
_G.FlyEnabled = false
_G.FlySpeed = 2 
_G.ESPEnabled = false
_G.GenESPEnabled = false
_G.NotificationsEnabled = true  
_G.PlayerESPColor = Color3.fromRGB(0, 255, 0)
_G.GenESPColor = Color3.fromRGB(0, 191, 255)

local targetIdx = 1
local Waypoints = {}
local Mouse = LP:GetMouse()
local UIS = game:GetService("UserInputService")

-- Simpan original settings
local OriginalBrightness = Lighting.Brightness
local OriginalClockTime = Lighting.ClockTime
local OriginalFogEnd = Lighting.FogEnd
local OriginalFogStart = Lighting.FogStart
local OriginalGlobalShadows = Lighting.GlobalShadows
local Atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
local OriginalDensity = Atmosphere and Atmosphere.Density or 0
local OriginalOffset = Atmosphere and Atmosphere.Offset or 0

-- [[ INTEGRASI NEW FLY SYSTEM ]] --
local character = LP.Character or LP.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

local animations = { Idle = 100681208320300, Fly = 73980801925168 }
local animTracks = {}
local animator
local pressed = {Up=false,Down=false,Left=false,Right=false}
local moving = false
local savedOrientation = nil
local oldGravity = workspace.Gravity
local frozenPos = nil

local function setupAnimator(hum)
    animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
    animTracks = {}
    for name, id in pairs(animations) do
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. id
        local track = animator:LoadAnimation(anim)
        track.Priority = Enum.AnimationPriority.Action
        track.Looped = true
        animTracks[name] = track
    end
end
setupAnimator(humanoid)

-- GUI MOBILE (D-PAD) --
local gui = Instance.new("ScreenGui")
gui.Name = "FlyGui"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")
local DPad = Instance.new("Frame")
DPad.Size = UDim2.new(0,140,0,140); DPad.Position = UDim2.new(0,15,1,-155); DPad.BackgroundColor3 = Color3.fromRGB(25,25,25); DPad.BackgroundTransparency = 0.05; DPad.Visible = false; DPad.Parent = gui
Instance.new("UICorner", DPad).CornerRadius = UDim.new(0,12)
local function createBtn(txt,pos)
    local btn = Instance.new("TextButton"); btn.Text = txt; btn.Size = UDim2.new(0,45,0,45); btn.Position = pos; btn.BackgroundColor3 = Color3.fromRGB(50,50,50); btn.TextColor3 = Color3.fromRGB(255,255,255); btn.Font = Enum.Font.GothamBold; btn.TextSize = 20; btn.Parent = DPad
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    return btn
end
local UpBtn = createBtn("↑", UDim2.new(0.5,-22,0,8))
local DownBtn = createBtn("↓", UDim2.new(0.5,-22,1,-53))
local LeftBtn = createBtn("←", UDim2.new(0,8,0.5,-22))
local RightBtn = createBtn("→", UDim2.new(1,-53,0.5,-22))
local function connectBtn(btn,key)
    btn.MouseButton1Down:Connect(function() pressed[key]=true btn.BackgroundColor3=Color3.fromRGB(90,90,90) end)
    btn.MouseButton1Up:Connect(function() pressed[key]=false btn.BackgroundColor3=Color3.fromRGB(50,50,50) end)
end
connectBtn(UpBtn,"Up"); connectBtn(DownBtn,"Down"); connectBtn(LeftBtn,"Left"); connectBtn(RightBtn,"Right")

local function noclipFly(state)
    for _,v in pairs(LP.Character:GetDescendants()) do
        if v:IsA("BasePart") then v.CanCollide = not state end
    end
end

local function enableFly()
    DPad.Visible = true
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.PlatformStand = true
        noclipFly(true)
        workspace.Gravity = 0
        root = LP.Character:WaitForChild("HumanoidRootPart")
        frozenPos = root.Position
        local _, y, _ = root.CFrame:ToOrientation()
        savedOrientation = CFrame.Angles(0, y, 0)
        if animTracks.Idle then animTracks.Idle:Play() end
    end
end

local function disableFly()
    DPad.Visible = false
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.PlatformStand = false
        noclipFly(false)
        workspace.Gravity = oldGravity
        frozenPos = nil
        for _, t in pairs(animTracks) do if t.IsPlaying then t:Stop() end end
    end
end

LP.CharacterAdded:Connect(function(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    root = char:WaitForChild("HumanoidRootPart")
    setupAnimator(humanoid)
    if _G.FlyEnabled then disableFly(); _G.FlyEnabled = false end
    
    if speedOn then
        task.wait(0.5)
        local hum = char:WaitForChild("Humanoid")
        hum.WalkSpeed = currentWalkSpeed
        addSelendang(char)
    end
end)

local function CustomNotify(title, content, duration)
    if not _G.NotificationsEnabled then return end
    Rayfield:Notify({Title = title, Content = content, Duration = duration or 5})
end

local function applySemiGod(char)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.HealthChanged:Connect(function(health)
            if _G.SemiGodMode and health < hum.MaxHealth then hum.Health = hum.MaxHealth end
        end)
        if _G.SemiGodMode then hum.Health = hum.MaxHealth end
    end
end

local function applyFullGod(char)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanTouch = false
            if v.Name:lower():find("hitbox") or v.Name:lower():find("kill") then v:Destroy() end
        end
    end
end

LP.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if _G.FullGodMode then applyFullGod(char) end
    if _G.SemiGodMode then applySemiGod(char) end
end)
if LP.Character then applySemiGod(LP.Character) end

local function DestroyPlayerESP()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character then
            local h = p.Character:FindFirstChildOfClass("Highlight")
            if h and h.Name:find("PallHighlight") then h:Destroy() end
            local bg = p.Character:FindFirstChildOfClass("BillboardGui")
            if bg and bg.Name:find("PallName") then bg:Destroy() end
        end
    end
end

local function ApplyESP(p)
    if p == LP then return end
    local function CreateESP(char)
        if _G.ESPEnabled and not char:FindFirstChildOfClass("Highlight") then
            task.wait(0.5)
            local h = Instance.new("Highlight", char)
            h.Name = "PallHighlight_" .. math.random(1,1000); h.FillColor = _G.PlayerESPColor; h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            local bg = Instance.new("BillboardGui", char)
            bg.Name = "PallName_" .. math.random(1,1000); bg.Adornee = char:WaitForChild("Head", 5); bg.Size = UDim2.new(0, 100, 0, 20); bg.StudsOffset = Vector3.new(0, 3, 0); bg.AlwaysOnTop = true
            local tl = Instance.new("TextLabel", bg)
            tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1, 0, 1, 0); tl.Text = p.Name; tl.TextColor3 = _G.PlayerESPColor; tl.TextSize = 11; tl.Font = Enum.Font.SourceSansBold
        end
    end
    p.CharacterAdded:Connect(CreateESP)
    if p.Character then CreateESP(p.Character) end
end

local MainTab = Window:CreateTab("Main", 4483362458)
local VisualTab = Window:CreateTab("Visuals", 4483362458)
local ScriptTab = Window:CreateTab("Scripts", 4483362458)
local WaypointTab = Window:CreateTab("Waypoints", 4483362458)
local SettingTab = Window:CreateTab("Settings", 4483362458)

MainTab:CreateSection("Movement")
MainTab:CreateToggle({
    Name = "Speed Pelangi 🌈", 
    CurrentValue = false, 
    Callback = function(v) 
        speedOn = v
        local char = LP.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if speedOn then
            if hum then hum.WalkSpeed = currentWalkSpeed end
            addSelendang(char)
        else
            if hum then hum.WalkSpeed = 16 end
            removeSelendang()
        end
    end
})
MainTab:CreateSlider({
    Name = "WalkSpeed Power", 
    Range = {16, 250}, 
    Increment = 1, 
    Suffix = "Speed", 
    CurrentValue = 50, 
    Callback = function(v) 
        currentWalkSpeed = v 
        if speedOn and LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.WalkSpeed = v
        end
    end
})

MainTab:CreateToggle({
    Name = "Instant Interaction (No Hold)", 
    CurrentValue = false, 
    Callback = function(v) 
        instantPromptActive = v
        if instantPromptActive then
            for _, prompt in pairs(game:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then makeInstant(prompt) end
            end
        else
            for _, prompt in pairs(game:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then resetPrompt(prompt) end
            end
        end
    end
})

ProximityPromptService.PromptShown:Connect(function(prompt)
    if instantPromptActive then makeInstant(prompt) end
end)

MainTab:CreateToggle({Name = "Infinite Jump", CurrentValue = false, Callback = function(v) _G.InfJump = v end})
MainTab:CreateToggle({Name = "Noclip", CurrentValue = false, Callback = function(v) _G.NoClip = v end})
MainTab:CreateToggle({Name = "Fly Mode (Freeze Lock)", CurrentValue = false, Callback = function(v) 
    _G.FlyEnabled = v 
    if v then enableFly() else disableFly() end
end})
MainTab:CreateSlider({Name = "Fly Speed", Range = {1, 20}, Increment = 0.5, Suffix = "Speed", CurrentValue = 2, Callback = function(v) _G.FlySpeed = v end})

MainTab:CreateSection("Combat / God")
MainTab:CreateToggle({Name = "Semi God Mode", CurrentValue = false, Callback = function(v) _G.SemiGodMode = v; if v and LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.Health = LP.Character.Humanoid.MaxHealth end end})
MainTab:CreateToggle({Name = "Full God Mode (Universal)", CurrentValue = false, Callback = function(v) _G.FullGodMode = v; if v and LP.Character then applyFullGod(LP.Character) end end})
MainTab:CreateToggle({Name = "Hitbox (Big Head)", CurrentValue = false, Callback = function(v) _G.HEnabled = v; _G.HSize = v and 15 or 2 end})

MainTab:CreateSection("Spectate & Camera Control")
MainTab:CreateButton({Name = "Watch Next Player", Callback = function()
    local all = Players:GetPlayers()
    if #all <= 1 then return end
    targetIdx = (targetIdx >= #all and 1 or targetIdx + 1)
    local p = all[targetIdx]
    if p and p.Character and p.Character:FindFirstChild("Humanoid") then
        Camera.CameraSubject = p.Character.Humanoid
        CustomNotify("Spectating", "Menonton: " .. p.Name, 3)
    end
end})
MainTab:CreateButton({Name = "Teleport to Watched Player", Callback = function()
    local all = Players:GetPlayers()
    local p = all[targetIdx]
    if p and p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        LP.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,3,0)
        CustomNotify("Teleport", "TP ke: " .. p.Name, 3)
    end
end})
MainTab:CreateButton({Name = "Reset Camera (Self)", Callback = function()
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        Camera.CameraSubject = LP.Character.Humanoid
        CustomNotify("Camera", "Kembali ke diri sendiri", 3)
    end
end})

VisualTab:CreateSection("Ultimate Performance")
VisualTab:CreateToggle({
    Name = "Ultimate FPS Booster 2026", 
    CurrentValue = false, 
    Callback = function(v)
        fpsBoosterActive = v
        if v then
            ApplyFullBoost()
            CustomNotify("FPS Booster", "Optimasi 2026 Aktif! Visual dibersihkan.", 4)
        else
            CustomNotify("FPS Booster", "Silakan Rejoin untuk reset grafik ke normal.", 5)
        end
    end
})

VisualTab:CreateSection("Camera & Field of View")
VisualTab:CreateToggle({
    Name = "Enable Max Zoom & FOV", 
    CurrentValue = false, 
    Callback = function(v) 
        cameraSettingsActive = v
        if not v then
            LP.CameraMaxZoomDistance = 128
            LP.CameraMinZoomDistance = 0.5
            Camera.FieldOfView = 70
        else
            CustomNotify("Camera", "Zoom & FOV Aktif", 3)
        end
    end
})

VisualTab:CreateSlider({
    Name = "FOV Value", 
    Range = {30, 120}, 
    Increment = 1, 
    Suffix = "°", 
    CurrentValue = 90, 
    Callback = function(v) fovValue = v end
})

VisualTab:CreateSlider({
    Name = "Max Zoom Distance", 
    Range = {128, 2000}, 
    Increment = 10, 
    Suffix = " Studs", 
    CurrentValue = 500, 
    Callback = function(v) maxZoomValue = v end
})

VisualTab:CreateSection("ESP & Lighting")
VisualTab:CreateToggle({Name = "Player ESP", CurrentValue = false, Callback = function(v)
    _G.ESPEnabled = v
    if v then for _, p in pairs(Players:GetPlayers()) do ApplyESP(p) end; Players.PlayerAdded:Connect(ApplyESP) else DestroyPlayerESP() end
end})
VisualTab:CreateColorPicker({Name = "Player ESP Color", Color = Color3.fromRGB(0,255,0), Callback = function(c) _G.PlayerESPColor = c end})
VisualTab:CreateToggle({Name = "Generator ESP", CurrentValue = false, Callback = function(v) _G.GenESPEnabled = v end})
VisualTab:CreateColorPicker({Name = "Generator ESP Color", Color = Color3.fromRGB(0,191,255), Callback = function(c) _G.GenESPColor = c end})
VisualTab:CreateToggle({Name = "Full Bright", CurrentValue = false, Callback = function(v) _G.FullBright = v end})
VisualTab:CreateToggle({Name = "No Fog", CurrentValue = false, Callback = function(v) _G.NoFog = v end})
VisualTab:CreateToggle({Name = "Enable Notifications", CurrentValue = true, Callback = function(v) _G.NotificationsEnabled = v end})

ScriptTab:CreateSection("Fayint Exploits")
ScriptTab:CreateButton({
    Name = "Custom Jump (Fayint)", 
    Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FayintXhub/FayintExploit/refs/heads/main/Costum-Jump"))() end
})
ScriptTab:CreateButton({Name = "Copy Avatar", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FayintXhub/FayintExploit/refs/heads/main/Copy-Avatar"))() end})
ScriptTab:CreateButton({Name = "FE Emotes (NV)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FayintXhub/FayintExploit/refs/heads/main/FE-Emotes"))() end})
ScriptTab:CreateButton({Name = "Global Music", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FayintXhub/FayintExploit/refs/heads/main/Global-Music"))() end})

ScriptTab:CreateSection("Others")
ScriptTab:CreateButton({Name = "Spectate Feature (Server)", Callback = function() SpectateFeature() end})
ScriptTab:CreateButton({Name = "Give Click TP Tool", Callback = function() 
    local tool = Instance.new("Tool"); tool.Name = "Pall Click TP_" .. math.random(1,1000); tool.RequiresHandle = false
    tool.Activated:Connect(function() if LP.Character then LP.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p + Vector3.new(0,3,0)) end end)
    tool.Parent = LP.Backpack
end})

local wpNameInput = ""
WaypointTab:CreateInput({Name = "Waypoint Name", PlaceholderText = "Nama tempat...", Callback = function(t) wpNameInput = t end})
WaypointTab:CreateButton({Name = "Save Current Position", Callback = function()
    local name = wpNameInput ~= "" and wpNameInput or "Pos " .. os.time()
    if LP.Character then
        local pos = LP.Character.HumanoidRootPart.CFrame
        local wp = {Name = name, Position = {pos.X, pos.Y, pos.Z, pos.LookVector.X, pos.LookVector.Y, pos.LookVector.Z}}
        table.insert(Waypoints, wp)
        WaypointTab:CreateButton({Name = "Teleport to: " .. name, Callback = function()
            LP.Character.HumanoidRootPart.CFrame = CFrame.lookAt(Vector3.new(wp.Position[1],wp.Position[2],wp.Position[3]), Vector3.new(wp.Position[1],wp.Position[2],wp.Position[3]) + Vector3.new(wp.Position[4],wp.Position[5],wp.Position[6]))
        end})
        CustomNotify("Saved!", name .. " saved!", 3)
    end
end})

SettingTab:CreateSection("Protection")
SettingTab:CreateButton({
    Name = "SAFE MODE (Emergency Stop)",
    Callback = function()
        _G.FlyEnabled = false
        disableFly()
        _G.InfJump = false
        _G.NoClip = false
        speedOn = false
        fpsBoosterActive = false
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.WalkSpeed = 16 end
        removeSelendang()
        _G.ESPEnabled = false
        DestroyPlayerESP()
        _G.GenESPEnabled = false
        _G.FullBright = false
        _G.NoFog = false
        _G.SemiGodMode = false
        _G.FullGodMode = false
        _G.HEnabled = false
        _G.HSize = 2
        CustomNotify("SAFE MODE", "Semua fitur berbahaya telah dimatikan!", 5)
    end
})

SettingTab:CreateSection("GUI Settings")
SettingTab:CreateKeybind({
   Name = "UI Toggle Keybind",
   CurrentKeybind = "RightControl",
   HoldToInteract = false,
   Flag = "ToggleKeybind",
   Callback = function(Keybind) Rayfield:ToggleUI() end,
})

SettingTab:CreateButton({
    Name = "Unload Script",
    Callback = function()
        Rayfield:Destroy()
        if gui then gui:Destroy() end
    end
})

UIS.InputBegan:Connect(function(input, gpe)
    if gpe or not _G.FlyEnabled then return end
    if input.KeyCode == Enum.KeyCode.W then pressed.Up = true end
    if input.KeyCode == Enum.KeyCode.S then pressed.Down = true end
    if input.KeyCode == Enum.KeyCode.A then pressed.Left = true end
    if input.KeyCode == Enum.KeyCode.D then pressed.Right = true end
end)
UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then pressed.Up = false end
    if input.KeyCode == Enum.KeyCode.S then pressed.Down = false end
    if input.KeyCode == Enum.KeyCode.A then pressed.Left = false end
    if input.KeyCode == Enum.KeyCode.D then pressed.Right = false end
end)

-- [[ UPDATE: AUTO CLEAN NEW OBJECTS ]] --
Workspace.DescendantAdded:Connect(function(obj)
	if fpsBoosterActive then
        task.delay(0.05, function()
		    Optimize(obj)
        end)
	end
end)

RunService.Heartbeat:Connect(function(dt)
    -- Update Loop FPS Booster
    if fpsBoosterActive then 
        Lighting.GlobalShadows = false 
        CleanEffects() 
    end
    
    pcall(function()
        local char = LP.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local hrp = char.HumanoidRootPart
        local hum = char:FindFirstChildOfClass("Humanoid")

        if _G.FlyEnabled then
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
            local cam = workspace.CurrentCamera
            local lookVec = cam.CFrame.LookVector
            local rightVec = cam.CFrame.RightVector
            local dir = Vector3.zero
            if pressed.Up then dir += lookVec end
            if pressed.Down then dir -= lookVec end
            if pressed.Left then dir -= rightVec end
            if pressed.Right then dir += rightVec end
            if dir.Magnitude > 0 then
                moving = true
                frozenPos = hrp.Position + dir.Unit * _G.FlySpeed * dt * 60
                hrp.CFrame = CFrame.new(frozenPos, frozenPos + lookVec)
            else
                moving = false
                if frozenPos and savedOrientation then hrp.CFrame = CFrame.new(frozenPos) * savedOrientation end
            end
            if moving then
                if animTracks.Idle and animTracks.Idle.IsPlaying then animTracks.Idle:Stop() end
                if animTracks.Fly and not animTracks.Fly.IsPlaying then animTracks.Fly:Play() end
            else
                if animTracks.Fly and animTracks.Fly.IsPlaying then animTracks.Fly:Stop() end
                if animTracks.Idle and not animTracks.Idle.IsPlaying then animTracks.Idle:Play() end
            end
        end

        if hum then
            if _G.NoClip then for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
            if _G.FullGodMode then
                hum.MaxHealth = math.huge; hum.Health = math.huge
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            end
        end
    end)
end)

task.spawn(function()
    while task.wait(0.5) do
        if not fpsBoosterActive then
            if _G.FullBright then Lighting.Brightness = 2; Lighting.ClockTime = 14; Lighting.GlobalShadows = false 
            elseif Lighting.Brightness ~= OriginalBrightness then Lighting.Brightness = OriginalBrightness; Lighting.ClockTime = OriginalClockTime; Lighting.GlobalShadows = OriginalGlobalShadows end
            if _G.NoFog then Lighting.FogEnd = 100000; Lighting.FogStart = 0; if Atmosphere then Atmosphere.Density = 0; Atmosphere.Offset = 0 end
            elseif Lighting.FogEnd ~= OriginalFogEnd then Lighting.FogEnd = OriginalFogEnd; Lighting.FogStart = OriginalFogStart; if Atmosphere then Atmosphere.Density = OriginalDensity; Atmosphere.Offset = OriginalOffset end end
        end

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                if _G.HEnabled then hrp.Size = Vector3.new(_G.HSize,_G.HSize,_G.HSize); hrp.Transparency = 0.7; hrp.CanCollide = false 
                else hrp.Size = Vector3.new(2,2,1); hrp.Transparency = 1; hrp.CanCollide = true end
            end
        end

        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Generator" then
                local done = obj:FindFirstChild("IsCompleted") and obj.IsCompleted.Value
                if not _G.GenESPEnabled or done then
                    if obj:FindFirstChildOfClass("BillboardGui") then obj:FindFirstChildOfClass("BillboardGui"):Destroy() end
                    if obj:FindFirstChildOfClass("Highlight") then obj:FindFirstChildOfClass("Highlight"):Destroy() end
                elseif not obj:FindFirstChildOfClass("BillboardGui") then
                    local bg = Instance.new("BillboardGui", obj); bg.Name = "GenESP_GUI"; bg.Size = UDim2.new(0,30,0,15); bg.AlwaysOnTop = true; bg.StudsOffset = Vector3.new(0,2,0)
                    local tl = Instance.new("TextLabel", bg); tl.Size = UDim2.new(1,0,1,0); tl.BackgroundTransparency = 1; tl.Text = "GEN"; tl.TextColor3 = _G.GenESPColor; tl.TextSize = 8; tl.Font = Enum.Font.SourceSansBold; tl.TextStrokeTransparency = 0.5
                    local h = Instance.new("Highlight", obj); h.Name = "GenESP_Highlight"; h.FillColor = _G.GenESPColor; h.FillTransparency = 0.6; h.OutlineTransparency = 0.2; h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
            end
        end
    end
end)

UIS.JumpRequest:Connect(function()
    if _G.InfJump and LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid:ChangeState("Jumping")
    end
end)

CustomNotify("Pall Hub V3", "Script Ready! Ultimate FPS 2026 Integrated.", 6)
