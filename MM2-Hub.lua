--// MM2 PRO HUB v7.1 COMPLETO | Murder Mystery 2 | PC + Mobile (Delta/Fluxus)
--// ESP Pro + Aimbot + Silent + FOV + Kill/Throw Aura + Mobile + Farm + AutoPlay/Hop + Sniper

if getgenv().MM2_PRO_LOADED then
    pcall(function() getgenv().MM2_PRO_GUI:Destroy() end)
    pcall(function() getgenv().MM2_BOOT_GUI:Destroy() end)
    task.wait(0.2)
end
getgenv().MM2_PRO_LOADED = true
-- config antiga de outra versão = reseta (evita nil em chave nova no Delta)
if getgenv().MM2_CVER ~= 7.1 then getgenv().MM2_Config = nil getgenv().MM2_CVER = 7.1 end

-- espera jogo/carregar (essencial no Delta mobile)
pcall(function()
    if not game:IsLoaded() then game.Loaded:Wait() end
end)
pcall(function()
    task.wait(0.5)
    local lp = game:GetService("Players").LocalPlayer
    if lp then pcall(function() lp:WaitForChild("PlayerGui", 10) end) end
end)

--// Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local PathfindingService = nil pcall(function() PathfindingService = game:GetService("PathfindingService") end)
local VIM = nil pcall(function() VIM = game:GetService("VirtualInputManager") end)
local ReplicatedStorage = nil pcall(function() ReplicatedStorage = game:GetService("ReplicatedStorage") end)
if not ReplicatedStorage then ReplicatedStorage = game end

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera or nil
task.spawn(function()
    while not Camera do task.wait(0.5) pcall(function() Camera = Workspace.CurrentCamera end) end
    Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() Camera = Workspace.CurrentCamera end)
end)

--// Config
getgenv().MM2_Config = getgenv().MM2_Config or {
    ESP_Enabled = true, ESP_Names = true, ESP_Distance = true, ESP_Role = true,
    ESP_Gun = true, Chams = true,
    Aimbot_Sheriff = false, AimKey = Enum.KeyCode.Q, AimFOV = 180,
    SilentAim = false, SilentFOV = 220, SilentPred = 0.15,
    ShowFOV = true, ThrowFOV = 220, FOV_Color = {255,80,255},
    MobileButtons = true,
    AutoPlay = false, AutoHop = false, AutoHop_MinPlayers = 6, AutoHop_Delay = 90,
    ESP_TextSize = 13, ESP_ChamTrans = 55,
    ESP_Colors = nil,
    AutoGrabGun = false,
    CoinFarm = false, CoinFarm_Delay = 0.35,
    WalkFarm = false, WalkFarm_Range = 150,
    MurderAura = false, MurderAura_Range = 14, MurderAura_Delay = 0.35, MurderAura_TP = false,
    ThrowAura = false, ThrowAura_Range = 90, ThrowAura_Delay = 1.1, ThrowAura_Pred = 0.35,
    GunSniper = false, TradeHelper = false, TradeAutoAccept = false,
    Hitbox_Enabled = false, Hitbox_Size = 8,
    AutoVote = false,
    Speed_Enabled = false, Speed_Value = 32,
    Fly_Enabled = false, Fly_Speed = 50,
    Noclip = false, InfJump = false, Fullbright = false, Xray = false,
}
local C = getgenv().MM2_Config
-- garante chaves novas em config antiga
C.WalkFarm = C.WalkFarm or false; C.WalkFarm_Range = C.WalkFarm_Range or 150
C.MurderAura = C.MurderAura or false; C.MurderAura_Range = C.MurderAura_Range or 14
C.MurderAura_Delay = C.MurderAura_Delay or 0.35; C.MurderAura_TP = C.MurderAura_TP or false
C.ThrowAura = C.ThrowAura or false; C.ThrowAura_Range = C.ThrowAura_Range or 90
C.ThrowAura_Delay = C.ThrowAura_Delay or 1.1; C.ThrowAura_Pred = C.ThrowAura_Pred or 0.35
C.GunSniper = C.GunSniper or false; C.TradeHelper = C.TradeHelper or false; C.TradeAutoAccept = C.TradeAutoAccept or false
C.ShowFOV = (C.ShowFOV == nil) and true or C.ShowFOV; C.ThrowFOV = C.ThrowFOV or 220; C.MobileButtons = (C.MobileButtons == nil) and true or C.MobileButtons
C.SilentAim = C.SilentAim or false; C.SilentFOV = C.SilentFOV or 220; C.SilentPred = C.SilentPred or 0.15
C.AutoPlay = C.AutoPlay or false; C.AutoHop = C.AutoHop or false; C.AutoHop_MinPlayers = C.AutoHop_MinPlayers or 6; C.AutoHop_Delay = C.AutoHop_Delay or 90
C.ESP_TextSize = C.ESP_TextSize or 13; C.ESP_ChamTrans = C.ESP_ChamTrans or 55
C.ESP_Colors = C.ESP_Colors or {Murderer={255,35,55}, Sheriff={45,130,255}, Hero={255,180,0}, Innocent={60,255,120}, Gun={255,220,0}}
C.Hitbox_Enabled = C.Hitbox_Enabled or false; C.Hitbox_Size = C.Hitbox_Size or 8
C.AutoVote = C.AutoVote or false
-- blindagem extra: nenhuma chave pode ficar nil (sessão antiga do Delta reaproveita getgenv)
C.ESP_Enabled = (C.ESP_Enabled == nil) and true or C.ESP_Enabled
C.ESP_Names = (C.ESP_Names == nil) and true or C.ESP_Names
C.ESP_Distance = (C.ESP_Distance == nil) and true or C.ESP_Distance
C.ESP_Role = (C.ESP_Role == nil) and true or C.ESP_Role
C.ESP_Gun = (C.ESP_Gun == nil) and true or C.ESP_Gun
C.Chams = (C.Chams == nil) and true or C.Chams
C.AimKey = C.AimKey or Enum.KeyCode.Q; C.AimFOV = C.AimFOV or 180
C.FOV_Color = C.FOV_Color or {255,80,255}
C.CoinFarm_Delay = C.CoinFarm_Delay or 0.35
C.MurderAura_Range = C.MurderAura_Range or 14; C.ThrowAura_Range = C.ThrowAura_Range or 90
C.Speed_Value = C.Speed_Value or 32; C.Fly_Speed = C.Fly_Speed or 50

local function Notify(t) pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="MM2 PRO v7.1",Text=tostring(t),Duration=3}) end) end

--// BOOT STATUS (aparece em 1s mesmo se algum sistema falhar depois)
local BootGui, BootLabel = nil, nil
pcall(function()
    local pg = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 8)
    if pg then
        pcall(function() pg:FindFirstChild("MM2_BOOT"):Destroy() end)
        BootGui = Instance.new("ScreenGui") BootGui.Name = "MM2_BOOT" BootGui.ResetOnSpawn = false
        BootGui.DisplayOrder = 10001 BootGui.Parent = pg
        getgenv().MM2_BOOT_GUI = BootGui
        BootLabel = Instance.new("TextLabel") BootLabel.Size = UDim2.new(0,300,0,44)
        BootLabel.Position = UDim2.new(0.5,-150,0.08,0) BootLabel.BackgroundColor3 = Color3.fromRGB(15,15,25)
        BootLabel.TextColor3 = Color3.new(1,1,1) BootLabel.Font = Enum.Font.GothamBold BootLabel.TextSize = 13
        BootLabel.TextWrapped = true BootLabel.Text = "MM2 PRO boot..." BootLabel.Parent = BootGui
    end
end)
local function BootStage(t) pcall(function() if BootLabel then BootLabel.Text = "MM2 PRO: "..tostring(t) end end) end
BootStage("sistemas iniciando...")
local function GetChar(plr) plr = plr or LocalPlayer return plr.Character end
local function GetRoot(plr)
    local c = GetChar(plr)
    if c then return c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso") end
    return nil
end
local function GetHumanoid(plr) local c = GetChar(plr) if c then return c:FindFirstChildOfClass("Humanoid") end return nil end
local function IsAlive(plr) local h = GetHumanoid(plr) local r = GetRoot(plr) return h and r and h.Health > 0 end
local function HasTool(plr, names)
    if type(names)=="string" then names={names} end
    local bp = plr:FindFirstChild("Backpack") local ch = plr.Character
    for _,n in ipairs(names) do
        if bp and bp:FindFirstChild(n) then return true end
        if ch and ch:FindFirstChild(n) then return true end
    end
    return false
end
function GetRole(plr)
    if not IsAlive(plr) then return "Dead" end
    if HasTool(plr, {"Knife"}) then return "Murderer" end
    if HasTool(plr, {"Gun","Revolver"}) then return "Sheriff" end
    return "Innocent"
end
local function ESPColor(role)
    local t = C.ESP_Colors and C.ESP_Colors[role]
    if t then return Color3.fromRGB(t[1], t[2], t[3]) end
    local fb = {Murderer=Color3.fromRGB(255,35,55), Sheriff=Color3.fromRGB(45,130,255), Hero=Color3.fromRGB(255,180,0), Innocent=Color3.fromRGB(60,255,120), Dead=Color3.fromRGB(120,120,120), Gun=Color3.fromRGB(255,220,0)}
    return fb[role] or Color3.new(1,1,1)
end
local RoleColors = {
    Murderer = Color3.fromRGB(255,35,55), Sheriff = Color3.fromRGB(45,130,255),
    Hero = Color3.fromRGB(255,180,0), Innocent = Color3.fromRGB(60,255,120),
    Dead = Color3.fromRGB(120,120,120),
}
local function TweenTo(pos, speed)
    speed = speed or 90
    local root = GetRoot() if not root then return end
    local d = (root.Position - pos).Magnitude
    local t = math.clamp(d/speed, 0.05, 3)
    pcall(function()
        local tw = TweenService:Create(root, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame=CFrame.new(pos)})
        tw:Play() tw.Completed:Wait()
    end)
end

pcall(function()
    LocalPlayer.Idled:Connect(function() VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new()) end)
end)

--// ===== ESP =====
local ESPFolder = Instance.new("Folder") ESPFolder.Name="MM2_PRO_ESP"
pcall(function()
    local pg = LocalPlayer:WaitForChild("PlayerGui", 5)
    if pg then ESPFolder.Parent = pg else ESPFolder.Parent = CoreGui end
end)
if not ESPFolder.Parent then pcall(function() ESPFolder.Parent = LocalPlayer:FindFirstChild("PlayerGui") or CoreGui end) end

local function ClearESP(plr)
    for _,v in ipairs(ESPFolder:GetChildren()) do if v.Name=="ESP_"..plr.UserId then v:Destroy() end end
    local c = plr.Character
    if c then for _,v in ipairs(c:GetChildren()) do
        if v.Name=="MM2_CHAM" and v:IsA("Highlight") then v:Destroy() end
        if v.Name=="MM2_TAG" and v:IsA("BillboardGui") then v:Destroy() end
    end end
end
local function ApplyESP(plr)
    if plr==LocalPlayer then return end
    ClearESP(plr)
    if not C.ESP_Enabled then return end
    local char = plr.Character if not char then return end
    local head = char:FindFirstChild("Head") local root = char:FindFirstChild("HumanoidRootPart")
    if not head or not root then return end
    local role = GetRole(plr) local color = ESPColor(role)
    if C.Chams then
        local hl = Instance.new("Highlight") hl.Name="MM2_CHAM"
        hl.FillColor=color hl.OutlineColor=Color3.new(0,0,0)
        hl.FillTransparency=(C.ESP_ChamTrans or 55)/100 hl.OutlineTransparency=0
        hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop hl.Adornee=char hl.Parent=char
    end
    local bb = Instance.new("BillboardGui") bb.Name="MM2_TAG" bb.Adornee=head
    bb.Size=UDim2.new(0,200,0,50) bb.StudsOffset=Vector3.new(0,2.2,0) bb.AlwaysOnTop=true bb.Parent=char
    local tl = Instance.new("TextLabel") tl.Size=UDim2.new(1,0,1,0) tl.BackgroundTransparency=1
    tl.Font=Enum.Font.GothamBold tl.TextSize=(C.ESP_TextSize or 13) tl.TextStrokeTransparency=0.2
    tl.TextStrokeColor3=Color3.new(0,0,0) tl.RichText=true tl.Parent=bb
    task.spawn(function()
        while bb.Parent and plr.Parent do
            if not C.ESP_Enabled then bb.Enabled=false task.wait(0.5) continue end
            bb.Enabled=true
            local r = GetRole(plr) local col = ESPColor(r)
            pcall(function() tl.TextSize = (C.ESP_TextSize or 13) end)
            local hex = string.format("#%02X%02X%02X",math.floor(col.R*255),math.floor(col.G*255),math.floor(col.B*255))
            local txt=""
            if C.ESP_Names then txt=txt..string.format('<font color="%s">%s</font>',hex,plr.DisplayName) end
            if C.ESP_Role then txt=txt..string.format('\n<font color="%s">[%s]</font>',hex,r) end
            if C.ESP_Distance and GetRoot() then
                local pr=GetRoot(plr) if pr then local d=math.floor((GetRoot().Position-pr.Position).Magnitude) txt=txt..string.format('\n<font color="#FFFFFF">[%dm]</font>',d) end
            end
            tl.Text=txt
            local hl=char:FindFirstChild("MM2_CHAM") if hl and hl:IsA("Highlight") then hl.FillColor=col pcall(function() hl.FillTransparency=(C.ESP_ChamTrans or 55)/100 end) end
            task.wait(0.3)
        end
    end)
end
local function RefreshAllESP() for _,p in ipairs(Players:GetPlayers()) do pcall(ApplyESP,p) end end
Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function() task.wait(1.2) pcall(ApplyESP,p) end) end)
for _,p in ipairs(Players:GetPlayers()) do if p~=LocalPlayer then p.CharacterAdded:Connect(function() task.wait(1.2) pcall(ApplyESP,p) end) end end
task.spawn(function() while true do if C.ESP_Enabled then RefreshAllESP() end task.wait(3) end end)
task.spawn(function()
    while true do pcall(function()
        for _,v in ipairs(Workspace:GetChildren()) do
            if v.Name=="GunDrop" or v.Name:lower():find("gundrop") then
                local h = v:IsA("BasePart") and v or v:FindFirstChildWhichIsA("BasePart",true)
                if h and C.ESP_Gun and C.ESP_Enabled and not h:FindFirstChild("MM2_GUNESP") then
                    local bb=Instance.new("BillboardGui") bb.Name="MM2_GUNESP" bb.Size=UDim2.new(0,200,0,40) bb.AlwaysOnTop=true bb.Adornee=h
                    local l=Instance.new("TextLabel",bb) l.Size=UDim2.new(1,0,1,0) l.BackgroundTransparency=1 l.Text="🔫 GUN DROP"
                    l.Font=Enum.Font.GothamBlack l.TextSize=15 l.TextColor3=Color3.fromRGB(255,220,0) l.TextStrokeTransparency=0
                    bb.Parent=h
                end
            end
        end
        if not C.ESP_Gun or not C.ESP_Enabled then for _,d in ipairs(Workspace:GetDescendants()) do if d.Name=="MM2_GUNESP" then d:Destroy() end end end
    end) task.wait(1.5) end
end)

--// ===== AIMBOT SHERIFF (segura Q) =====
local Aiming=false
UserInputService.InputBegan:Connect(function(i,g) if not g and i.KeyCode==C.AimKey then Aiming=true end end)
UserInputService.InputEnded:Connect(function(i) if i.KeyCode==C.AimKey then Aiming=false end end)
RunService.RenderStepped:Connect(function()
    pcall(function()
        if not C.Aimbot_Sheriff or not Aiming then return end
        if not HasTool(LocalPlayer,{"Gun","Revolver"}) then return end
        local best,bd=nil,C.AimFOV
        local mp=UserInputService:GetMouseLocation()
        for _,p in ipairs(Players:GetPlayers()) do
            if p==LocalPlayer then continue end
            if GetRole(p)~="Murderer" then continue end
            if not IsAlive(p) then continue end
            local hd=p.Character and p.Character:FindFirstChild("Head") if not hd then continue end
            local sp,os=Camera:WorldToViewportPoint(hd.Position) if not os then continue end
            local d=(Vector2.new(sp.X,sp.Y)-mp).Magnitude
            if d<bd then best,bd=p,d end
        end
        if best and best.Character:FindFirstChild("Head") then Camera.CFrame=CFrame.new(Camera.CFrame.Position,best.Character.Head.Position) end
    end)
end)

--// ===== FOV CIRCLE (Aim + Throw, PC Drawing + Mobile GUI fallback) =====
local FOVGuiCircle = nil
local FOVDrawAim, FOVDrawThrow = nil, nil
pcall(function()
    if Drawing then
        FOVDrawAim = Drawing.new("Circle")
        FOVDrawAim.Thickness = 1.5 FOVDrawAim.Filled = false FOVDrawAim.Transparency = 1
        FOVDrawThrow = Drawing.new("Circle")
        FOVDrawThrow.Thickness = 1.5 FOVDrawThrow.Filled = false FOVDrawThrow.Transparency = 0.7
    end
end)
-- fallback GUI (funciona no Delta mobile onde não tem Drawing)
local function GetFOVGui()
    if FOVGuiCircle and FOVGuiCircle.Parent then return FOVGuiCircle end
    local pg = LocalPlayer:FindFirstChild("PlayerGui") if not pg then return nil end
    local s = Instance.new("ScreenGui") s.Name="MM2_FOV" s.ResetOnSpawn=false s.IgnoreGuiInset=true
    pcall(function() s.Parent = pg end)
    local aim = Instance.new("Frame") aim.Name="Aim" aim.AnchorPoint=Vector2.new(0.5,0.5)
    aim.BackgroundTransparency=1 aim.Parent=s
    local st = Instance.new("UIStroke", aim) st.Thickness=1.5 st.Transparency=0.1
    st.Color=Color3.fromRGB(255,255,255)
    local c = Instance.new("UICorner", aim) c.CornerRadius=UDim.new(1,0)
    local thr = Instance.new("Frame") thr.Name="Throw" thr.AnchorPoint=Vector2.new(0.5,0.5)
    thr.BackgroundTransparency=1 thr.Parent=s
    local st2 = Instance.new("UIStroke", thr) st2.Thickness=1.5 st2.Transparency=0.4
    st2.Color=Color3.fromRGB(255,80,255)
    local c2 = Instance.new("UICorner", thr) c2.CornerRadius=UDim.new(1,0)
    FOVGuiCircle = s
    return s
end

local function FOVColor3()
    local t = C.FOV_Color or {255,80,255}
    return Color3.fromRGB(t[1],t[2],t[3])
end

RunService.RenderStepped:Connect(function()
    pcall(function()
        local show = C.ShowFOV and (C.Aimbot_Sheriff or C.ThrowAura)
        local mp
        if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
            local vs = Camera.ViewportSize
            mp = Vector2.new(vs.X/2, vs.Y/2)
        else
            mp = UserInputService:GetMouseLocation()
        end
        if FOVDrawAim and FOVDrawThrow then
            FOVDrawAim.Visible = show and C.Aimbot_Sheriff and C.ShowFOV
            FOVDrawThrow.Visible = show and C.ThrowAura and C.ShowFOV
            FOVDrawAim.Position = mp; FOVDrawAim.Radius = C.AimFOV
            FOVDrawAim.Color = Color3.new(1,1,1)
            FOVDrawThrow.Position = mp; FOVDrawThrow.Radius = C.ThrowFOV or 220
            pcall(function() FOVDrawThrow.Color = FOVColor3() end)
            local fg = FOVGuiCircle
            if fg and fg.Parent then fg.Enabled = false end
        else
            if FOVDrawAim then FOVDrawAim.Visible=false end
            if FOVDrawThrow then FOVDrawThrow.Visible=false end
            local s = GetFOVGui()
            if s then
                s.Enabled = show and true or false
                if show then
                    local aim = s:FindFirstChild("Aim") local thr = s:FindFirstChild("Throw")
                    if aim then
                        aim.Visible = C.Aimbot_Sheriff
                        aim.Size = UDim2.fromOffset(C.AimFOV*2, C.AimFOV*2)
                        aim.Position = UDim2.fromOffset(mp.X, mp.Y)
                    end
                    if thr then
                        thr.Visible = C.ThrowAura
                        thr.Size = UDim2.fromOffset((C.ThrowFOV or 220)*2, (C.ThrowFOV or 220)*2)
                        thr.Position = UDim2.fromOffset(mp.X, mp.Y)
                    end
                end
            end
        end
    end)
end)

--// ===== SILENT AIM SHERIFF (atira sem travar a câmera) =====
local SilentTarget = nil
local function SilentBest()
    if not HasTool(LocalPlayer, {"Gun","Revolver"}) then return nil end
    local my = GetRoot() if not my then return nil end
    local mp
    if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
        local vs = Camera.ViewportSize mp = Vector2.new(vs.X/2, vs.Y/2)
    else
        mp = UserInputService:GetMouseLocation()
    end
    local best, bd = nil, (C.SilentFOV or 220)
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LocalPlayer then continue end
        if GetRole(p)~="Murderer" then continue end
        if not IsAlive(p) then continue end
        local hd = p.Character and (p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("HumanoidRootPart"))
        if not hd then continue end
        local sp, os = Camera:WorldToViewportPoint(hd.Position) if not os then continue end
        local d = (Vector2.new(sp.X,sp.Y)-mp).Magnitude
        if d < bd then best, bd = p, d end
    end
    return best
end
local function SilentAimPos(target)
    local tr = GetRoot(target) if not tr then return nil end
    local p = tr.Position
    pcall(function()
        local v = tr.Velocity or tr.AssemblyLinearVelocity
        if v and v.Magnitude < 200 then p = p + (v * (C.SilentPred or 0.15)) end
    end)
    local hd = target.Character and target.Character:FindFirstChild("Head")
    if hd then p = (hd.Position + p)/2 + Vector3.new(0,0.3,0) end
    return p
end
-- snap-restore: no clique ele mira 1 frame e volta, parece legit na tela
UserInputService.InputBegan:Connect(function(inp, gpe)
    if gpe then return end
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        if not C.SilentAim then return end
        if not HasTool(LocalPlayer, {"Gun","Revolver"}) then return end
        pcall(function()
            local t = SilentBest()
            if t then
                local pos = SilentAimPos(t)
                if pos then
                    local old = Camera.CFrame
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, pos)
                    SilentTarget = t
                    task.delay(0.12, function() pcall(function() Camera.CFrame = old end) SilentTarget = nil end)
                end
            end
        end)
    end
end)
-- hook real no remote de tiro (se o executor suportar): redireciona o hit pro murderer sem mexer a câmera
pcall(function()
    if hookmetamethod and getnamecallmethod then
        local oldNC
        oldNC = hookmetamethod(game, "__namecall", function(self, ...)
            local m = getnamecallmethod()
            if C.SilentAim and (m=="FireServer" or m=="InvokeServer") then
                local n = tostring(self.Name):lower() .. "/" .. tostring(self:GetFullName()):lower()
                if n:find("shoot") or n:find("fire") or n:find("gun") or n:find("revolver") or n:find("damage") or n:find("hit") or n:find("knife") then
                    local t = SilentBest()
                    if t then
                        local pos = SilentAimPos(t)
                        if pos then
                            local args = {...}
                            -- tenta trocar qualquer Vector3/CFrame de mira pelo alvo
                            for i,v in ipairs(args) do
                                if typeof(v)=="Vector3" then args[i]=pos end
                                if typeof(v)=="CFrame" then args[i]=CFrame.new(v.Position, pos) end
                                if typeof(v)=="Instance" and v:IsA("BasePart") then
                                    local hd = t.Character and t.Character:FindFirstChild("Head")
                                    if hd then args[i]=hd end
                                end
                            end
                            return oldNC(self, (table.unpack or unpack)(args))
                        end
                    end
                end
            end
            return oldNC(self, ...)
        end)
    end
end)

--// ===== AUTO GRAB GUN =====
task.spawn(function()
    while true do pcall(function()
        if C.AutoGrabGun and IsAlive(LocalPlayer) and GetRole(LocalPlayer)=="Innocent" then
            local gd=Workspace:FindFirstChild("GunDrop")
            if not gd then for _,v in ipairs(Workspace:GetChildren()) do
                if v.Name:lower():find("gun") and v:IsA("BasePart") then gd=v break end
                if v.Name:lower():find("gun") and v:FindFirstChildWhichIsA("BasePart") then gd=v:FindFirstChildWhichIsA("BasePart") break end
            end end
            if gd then
                local pos=gd:IsA("BasePart") and gd.Position or gd:GetPivot().Position
                local my=GetRoot() if my and (my.Position-pos).Magnitude<120 then my.CFrame=CFrame.new(pos+Vector3.new(0,2,0)) task.wait(0.25) end
            end
        end
    end) task.wait(0.5) end
end)

--// ===== COIN UTILS =====
local function GetCoins()
    local out={}
    for _,v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name:lower():find("coin") then
            if v.Transparency<1 and v.Size.Magnitude>0.5 and v.Size.Magnitude<20 then table.insert(out,v) end
        end
        if #out>60 then break end
    end
    return out
end

--// ===== TWEEN FARM (rápido) =====
task.spawn(function()
    while true do pcall(function()
        if C.CoinFarm and not C.WalkFarm and IsAlive(LocalPlayer) then
            local coins=GetCoins() local my=GetRoot()
            if #coins>0 and my then
                table.sort(coins,function(a,b) return (my.Position-a.Position).Magnitude<(my.Position-b.Position).Magnitude end)
                for i=1,math.min(3,#coins) do
                    if not C.CoinFarm or C.WalkFarm then break end
                    local c=coins[i] if c and c.Parent then TweenTo(c.Position+Vector3.new(0,2.5,0),70) task.wait(C.CoinFarm_Delay) end
                end
            else task.wait(0.5) end
        else task.wait(0.5) end
    end) task.wait(0.1) end
end)

--// ===== WALK FARM (humano, Pathfinding, sem teleporte) =====
local function WalkToPosition(targetPos, timeout)
    timeout = timeout or 7
    local root=GetRoot() local hum=GetHumanoid()
    if not root or not hum then return false end
    local ok, path = pcall(function()
        return PathfindingService:CreatePath({AgentRadius=2,AgentHeight=5,AgentCanJump=true,AgentJumpHeight=7,AgentMaxSlope=45})
    end)
    if not ok or not path then hum:MoveTo(targetPos) task.wait(1) return true end
    local s,e = pcall(function() path:ComputeAsync(root.Position, targetPos) end)
    if not s or path.Status~=Enum.PathStatus.Success then
        hum:MoveTo(targetPos)
        local t0=tick()
        while tick()-t0<2.5 do
            if (root.Position-targetPos).Magnitude<6 then return true end
            if not C.WalkFarm then return false end
            task.wait(0.2)
        end
        return false
    end
    local wps = path:GetWaypoints()
    for _,wp in ipairs(wps) do
        if not C.WalkFarm then return false end
        if not IsAlive(LocalPlayer) then return false end
        hum:MoveTo(wp.Position)
        if wp.Action==Enum.PathWaypointAction.Jump then pcall(function() hum.Jump=true end) end
        local t0=tick()
        local done=false
        local conn; conn=hum.MoveToFinished:Connect(function() done=true end)
        while not done and tick()-t0<3 do
            if (root.Position-targetPos).Magnitude<6 then if conn then conn:Disconnect() end return true end
            -- destravanca: se parado, pula
            task.wait(0.2)
        end
        if conn then conn:Disconnect() end
        if (root.Position-targetPos).Magnitude<7 then return true end
    end
    return (root.Position-targetPos).Magnitude<8
end

task.spawn(function()
    while true do pcall(function()
        if C.WalkFarm and IsAlive(LocalPlayer) then
            local my=GetRoot()
            if my then
                local coins=GetCoins()
                -- filtra por alcance
                local f={}
                for _,c in ipairs(coins) do if c.Parent and (my.Position-c.Position).Magnitude<=C.WalkFarm_Range then table.insert(f,c) end end
                if #f>0 then
                    table.sort(f,function(a,b) return (my.Position-a.Position).Magnitude<(my.Position-b.Position).Magnitude end)
                    local c=f[1]
                    if c and c.Parent then
                        WalkToPosition(c.Position+Vector3.new(0,1,0), 8)
                    else task.wait(0.4) end
                else task.wait(0.8) end
            else task.wait(0.5) end
        else task.wait(0.6) end
    end) task.wait(0.15) end
end)

--// ===== KILL AURA MURDERER =====
local function GetKnifeTool()
    local ch=LocalPlayer.Character
    if ch then local t=ch:FindFirstChild("Knife") if t and t:IsA("Tool") then return t end end
    local bp=LocalPlayer:FindFirstChild("Backpack")
    if bp then local t=bp:FindFirstChild("Knife") if t then return t end end
    return nil
end
local function EquipKnife()
    local hum=GetHumanoid() local bp=LocalPlayer:FindFirstChild("Backpack")
    if not hum or not bp then return end
    local k=bp:FindFirstChild("Knife")
    if k then pcall(function() hum:EquipTool(k) end) end
end
local function NearestVictim(maxDist)
    local my=GetRoot() if not my then return nil,nil end
    local best,bd=nil,maxDist
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LocalPlayer then continue end
        if not IsAlive(p) then continue end
        if GetRole(LocalPlayer)=="Murderer" and GetRole(p)=="Murderer" then continue end
        local tr=GetRoot(p) if not tr then continue end
        local d=(my.Position-tr.Position).Magnitude
        if d<bd then best,bd=p,d end
    end
    return best,bd
end

task.spawn(function()
    while true do pcall(function()
        if C.MurderAura and IsAlive(LocalPlayer) and GetRole(LocalPlayer)=="Murderer" then
            local victim,dist=NearestVictim(C.MurderAura_Range)
            if victim then
                EquipKnife()
                task.wait(0.05)
                local tool=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Knife")
                local my=GetRoot() local tr=GetRoot(victim)
                if tool and my and tr then
                    if C.MurderAura_TP then
                        -- TP kill arriscado: vai, bate, volta
                        local old=my.CFrame
                        my.CFrame=tr.CFrame+CFrame.new(0,0,1.2)
                        my.CFrame=CFrame.new(my.Position,tr.Position)
                        task.wait(0.08)
                        pcall(function() tool:Activate() end)
                        task.wait(0.12)
                        -- tenta toque direto no servidor
                        pcall(function()
                            for _,part in ipairs(victim.Character:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    firetouchinterest(tool:FindFirstChildWhichIsA("BasePart",true) or my, part, 0)
                                    firetouchinterest(tool:FindFirstChildWhichIsA("BasePart",true) or my, part, 1)
                                    break
                                end
                            end
                        end)
                        task.wait(C.MurderAura_Delay)
                        if IsAlive(LocalPlayer) then my.CFrame=old end
                    else
                        -- legit: olha e bate, sem teleporte
                        my.CFrame=CFrame.new(my.Position,Vector3.new(tr.Position.X,my.Position.Y,tr.Position.Z))
                        pcall(function() tool:Activate() end)
                        task.wait(C.MurderAura_Delay)
                    end
                else task.wait(0.2) end
            else task.wait(0.25) end
        else task.wait(0.5) end
    end) task.wait(0.05) end
end)

--// ===== HITBOX EXPANDER =====
local OrigSizes={}
task.spawn(function()
    while true do pcall(function()
        if C.Hitbox_Enabled and IsAlive(LocalPlayer) then
            local amMurder = GetRole(LocalPlayer)=="Murderer"
            for _,p in ipairs(Players:GetPlayers()) do
                if p==LocalPlayer then continue end
                if not IsAlive(p) then continue end
                -- murderer expande inocentes/xerife | xerife expande murderer
                local pr=GetRole(p)
                local want=false
                if amMurder and pr~="Murderer" then want=true end
                if not amMurder and pr=="Murderer" then want=true end
                if want then
                    local hrp=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and hrp:IsA("BasePart") then
                        if not OrigSizes[p.UserId] then OrigSizes[p.UserId]=hrp.Size end
                        hrp.Size=Vector3.new(C.Hitbox_Size,C.Hitbox_Size,C.Hitbox_Size)
                        hrp.Transparency=0.7
                        hrp.CanCollide=false
                    end
                end
            end
        else
            -- restaura
            for _,p in ipairs(Players:GetPlayers()) do
                if OrigSizes[p.UserId] and p.Character then
                    local hrp=p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then pcall(function() hrp.Size=OrigSizes[p.UserId] hrp.Transparency=1 end) end
                    OrigSizes[p.UserId]=nil
                end
            end
        end
    end) task.wait(1) end
end)

--// ===== AUTO VOTE MAPA =====
local function FindVotePads()
    local pads={}
    for _,v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local n=v.Name:lower() local pn=v.Parent and v.Parent.Name:lower() or ""
            if n:find("vote") or pn:find("vote") or n:find("votar") then
                table.insert(pads,v)
            end
        end
    end
    return pads
end
local function VotePadName(pad)
    if pad.Parent then
        for _,d in ipairs(pad.Parent:GetDescendants()) do
            if d:IsA("TextLabel") and #d.Text>1 and #d.Text<30 then return d.Text end
        end
        return pad.Parent.Name
    end
    return pad.Name
end
task.spawn(function()
    local lastVote=0
    while true do pcall(function()
        if C.AutoVote and IsAlive(LocalPlayer) and tick()-lastVote>6 then
            local pads=FindVotePads()
            if #pads>0 then
                -- escolhe aleatório pra parecer humano, evita concentrar voto
                local pad=pads[math.random(1,#pads)]
                local hum=GetHumanoid() local my=GetRoot()
                if hum and my and pad then
                    local dist=(my.Position-pad.Position).Magnitude
                    if dist<400 then
                        -- anda até o pad (sem tween seco) + firetouch pra garantir
                        hum:MoveTo(pad.Position+Vector3.new(0,2,0))
                        task.wait(1.2)
                        pcall(function()
                            if firetouchinterest then
                                firetouchinterest(my,pad,0) task.wait(0.15) firetouchinterest(my,pad,1)
                            end
                        end)
                        task.wait(1.2)
                        lastVote=tick()
                        Notify("Votou: "..tostring(VotePadName(pad)))
                    end
                end
            end
        end
    end) task.wait(2) end
end)

--// ===== THROW AURA (faca arremessada longa distância) =====
local ThrowRemoteCache = nil
local function FindThrowRemote()
    if ThrowRemoteCache and ThrowRemoteCache.Parent then return ThrowRemoteCache end
    local best = nil
    pcall(function()
        for _,v in ipairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                local n = v.Name:lower()
                if n:find("throw") or n:find("knife") or (n:find("slash") and n:find("remote")) then
                    -- prefere o que tem throw no nome
                    if n:find("throw") then best = v break end
                    best = best or v
                end
            end
        end
        -- fallback MM2 conhecido: Remotes dentro de ReplicatedStorage com "Knife" / "Throw"
        if not best then
            for _,v in ipairs(game:GetDescendants()) do
                if (v:IsA("RemoteEvent")) and v.Name:lower()=="throwknife" then best=v break end
            end
        end
    end)
    ThrowRemoteCache = best
    return best
end

local function PredictPos(tRoot)
    local p = tRoot.Position
    pcall(function()
        local vel = tRoot.Velocity or tRoot.AssemblyLinearVelocity
        if vel and vel.Magnitude < 200 then
            p = p + (vel * C.ThrowAura_Pred)
        end
    end)
    return p + Vector3.new(0, 0.5, 0)
end

local function HasLOS(fromPos, toPos, ignoreChar, targetChar)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {ignoreChar, targetChar}
    params.IgnoreWater = true
    local dir = toPos - fromPos
    local dist = dir.Magnitude
    if dist < 1 then return true end
    local res = Workspace:Raycast(fromPos, dir.Unit * dist, params)
    return res == nil
end

local function DoThrowAt(victim)
    local my = GetRoot() local tr = GetRoot(victim)
    local hum = GetHumanoid()
    if not my or not tr or not hum then return false end
    EquipKnife()
    task.wait(0.06)
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Knife")
    if not tool then return false end
    local aimPos = PredictPos(tr)
    -- mira + encara (necessário pro throw do MM2 ir na direção certa)
    pcall(function()
        my.CFrame = CFrame.new(my.Position, Vector3.new(aimPos.X, my.Position.Y, aimPos.Z))
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, aimPos)
    end)
    task.wait(0.09)
    -- 1) slash/throw normal
    pcall(function() tool:Activate() end)
    -- 2) MM2 joga a faca no E -> simula E (só se VIM existir - Delta tem, mas com guard)
    pcall(function()
        if VIM then
            VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.05)
            VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        end
    end)
    -- 3) tenta remote direto (se o jogo expuser)
    pcall(function()
        local r = FindThrowRemote()
        if r and r:IsA("RemoteEvent") then
            -- tenta assinaturas comuns sem quebrar
            pcall(function() r:FireServer(aimPos) end)
            pcall(function() r:FireServer(victim.Character, aimPos) end)
            pcall(function() r:FireServer("Throw", aimPos) end)
        end
    end)
    return true
end

task.spawn(function()
    while true do pcall(function()
        if C.ThrowAura and IsAlive(LocalPlayer) and GetRole(LocalPlayer)=="Murderer" then
            local my = GetRoot()
            if my then
                local best, bestD = nil, C.ThrowAura_Range
                for _,p in ipairs(Players:GetPlayers()) do
                    if p==LocalPlayer then continue end
                    if not IsAlive(p) then continue end
                    if GetRole(p)=="Murderer" then continue end
                    local tr = GetRoot(p) if not tr then continue end
                    local d = (my.Position - tr.Position).Magnitude
                    -- evita roubar o trabalho da kill aura de perto
                    if d < (C.MurderAura_Range - 1) and C.MurderAura then continue end
                    if d < bestD then
                        -- checa parede: só joga se tem visão
                        local head = p.Character and (p.Character:FindFirstChild("Head") or tr)
                        local tp = head and head.Position or tr.Position
                        if HasLOS(Camera.CFrame.Position, tp, LocalPlayer.Character, p.Character) then
                            best, bestD = p, d
                        end
                    end
                end
                if best then
                    DoThrowAt(best)
                    task.wait(C.ThrowAura_Delay)
                else task.wait(0.3) end
            else task.wait(0.4) end
        else task.wait(0.6) end
    end) task.wait(0.08) end
end)

--// ===== GUN SNIPER (pega arma do herói/xerife instantâneo + volta) =====
task.spawn(function()
    while true do pcall(function()
        local want = C.GunSniper or C.AutoGrabGun
        if want and IsAlive(LocalPlayer) and GetRole(LocalPlayer)=="Innocent" then
            local gd = Workspace:FindFirstChild("GunDrop")
            if gd then
                local gPart = gd:IsA("BasePart") and gd or gd:FindFirstChildWhichIsA("BasePart", true)
                if gPart then
                    local my = GetRoot()
                    if my and (my.Position - gPart.Position).Magnitude < 500 then
                        if HasTool(LocalPlayer, {"Gun","Revolver"}) then task.wait(1) return end
                        local old = my.CFrame
                        if C.GunSniper then
                            -- sniper: pega e volta pra posição antiga
                            for _=1,3 do
                                if HasTool(LocalPlayer, {"Gun","Revolver"}) then break end
                                my.CFrame = CFrame.new(gPart.Position + Vector3.new(0,2,0))
                                task.wait(0.12)
                                pcall(function()
                                    if firetouchinterest then firetouchinterest(my, gPart, 0) task.wait(0.05) firetouchinterest(my, gPart, 1) end
                                end)
                                task.wait(0.15)
                            end
                            task.wait(0.2)
                            if IsAlive(LocalPlayer) and HasTool(LocalPlayer, {"Gun","Revolver"}) then
                                Notify("🔫 Gun snipada! Voltando")
                            end
                            task.wait(0.3)
                            if IsAlive(LocalPlayer) then my.CFrame = old + Vector3.new(0,2,0) end
                        else
                            my.CFrame = CFrame.new(gPart.Position + Vector3.new(0,2,0))
                            task.wait(0.3)
                        end
                    end
                end
            end
        end
    end) task.wait(0.35) end
end)

--// ===== TRADE HELPER / SNIPER =====
local GODLY_KEYS = {"godly","ancient","chroma","vintage","swirly","corrupt","shiny","holy","demonic","icewing","ginger","candy","flowerwood","harvester","grabber","logchopper","batwing","ghostblade","lightbringer","darkbringer","niks","seer","tides","eternal","gemstone","handsaw","blue seer","red seer"}
local function FindTradeGui()
    local pg = LocalPlayer:FindFirstChild("PlayerGui") if not pg then return nil end
    for _,v in ipairs(pg:GetDescendants()) do
        if v:IsA("ScreenGui") or v:IsA("Frame") then
            local n = v.Name:lower()
            if n:find("trade") then
                -- precisa estar visível
                local vis = true
                pcall(function()
                    if v:IsA("GuiObject") and not v.Visible then vis = false end
                end)
                if vis then return v:IsA("ScreenGui") and v or v:FindFirstAncestorOfClass("ScreenGui") or v end
            end
        end
    end
    return nil
end
local function GetTradeTexts(gui)
    local out = {}
    for _,d in ipairs(gui:GetDescendants()) do
        if d:IsA("TextLabel") or d:IsA("TextButton") then
            local t = d.Text and tostring(d.Text) or ""
            if #t > 1 and #t < 40 then table.insert(out, t) end
        end
    end
    return out
end
local function ScoreOffer(texts)
    local score = 0 local hits = {}
    for _,t in ipairs(texts) do
        local tl = t:lower()
        for _,k in ipairs(GODLY_KEYS) do
            if tl:find(k) then score = score + 3 table.insert(hits, t.." ("..k..)") break end
        end
        if tl:find("legendary") or tl:find("legend") then score = score + 1 end
    end
    return score, hits
end
local function ClickAccept(gui)
    for _,d in ipairs(gui:GetDescendants()) do
        if d:IsA("TextButton") or d:IsA("ImageButton") then
            local t = ""
            pcall(function()
                if d:IsA("TextButton") then t = d.Text:lower()
                elseif d:FindFirstChildWhichIsA("TextLabel", true) then t = d:FindFirstChildWhichIsA("TextLabel", true).Text:lower() end
            end)
            if t:find("accept") or t:find("confirm") or t:find("trade!") or t:find("aceitar") then
                if not VIM then return false end
                pcall(function()
                    if d:IsA("TextButton") then
                        for _,c in ipairs(getconnections and getconnections(d.MouseButton1Click) or {}) do end
                    end
                    -- clique legítimo via input
                    local pos = d.AbsolutePosition + d.AbsoluteSize/2
                    VIM:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 1)
                    task.wait(0.05)
                    VIM:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 1)
                end)
                return true
            end
        end
    end
    return false
end
local LastTradeSig = ""
task.spawn(function()
    while true do pcall(function()
        if C.TradeHelper or C.TradeAutoAccept then
            local tg = FindTradeGui()
            if tg then
                local texts = GetTradeTexts(tg)
                if #texts > 0 then
                    local sig = table.concat(texts, "|")
                    if sig ~= LastTradeSig then
                        LastTradeSig = sig
                        local score, hits = ScoreOffer(texts)
                        if C.TradeHelper and score >= 3 then
                            Notify("💎 Trade bom: "..table.concat(hits, ", "):sub(1,120))
                        end
                        if C.TradeAutoAccept then
                            if score >= 3 then
                                task.wait(0.6)
                                if ClickAccept(tg) then Notify("✅ Auto-accept: trade godly") end
                            end
                        end
                    end
                end
            else LastTradeSig = "" end
        end
    end) task.wait(1) end
end)

--// ===== AUTOPLAY + SERVER HOP =====
local TeleportService = game:GetService("TeleportService")
local HopStart = tick()
local function ServerHop(reason)
    pcall(function()
        Notify("🔀 Hop: "..tostring(reason or "trocando"))
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
end
task.spawn(function()
    while true do pcall(function()
        if C.AutoPlay then
            -- liga o kit de farm/voto/sniper junto
            if not C.WalkFarm and not C.CoinFarm then C.WalkFarm = true end
            if not C.AutoVote then C.AutoVote = true end
            if not C.GunSniper then C.GunSniper = true end
            -- se for murderer, garante auras; se xerife, garante silent
            local r = GetRole(LocalPlayer)
            if r == "Murderer" then
                if not C.MurderAura then C.MurderAura = true end
                if not C.ThrowAura then C.ThrowAura = true end
            elseif r == "Sheriff" then
                if not C.SilentAim and not C.Aimbot_Sheriff then C.SilentAim = true end
            end
        end
        if C.AutoHop then
            local n = #Players:GetPlayers()
            if n < (C.AutoHop_MinPlayers or 6) and tick()-HopStart > 15 then
                HopStart = tick()
                ServerHop("server vazio ("..n.." players)")
            elseif tick()-HopStart > (C.AutoHop_Delay or 90)*60 then
                HopStart = tick()
                ServerHop("tempo limite")
            end
        else
            HopStart = tick()
        end
    end) task.wait(5) end
end)

--// ===== MOBILE BUTTONS (Throw manual + Aim hold) =====
local MobileUI = nil
local function BuildMobileButtons()
    if MobileUI and MobileUI.Parent then return MobileUI end
    local pg = LocalPlayer:WaitForChild("PlayerGui", 8) if not pg then return nil end
    local s = Instance.new("ScreenGui") s.Name="MM2_MOBILE" s.ResetOnSpawn=false s.IgnoreGuiInset=true
    pcall(function() s.Parent = pg end)
    if not s.Parent then return nil end
    local function mkBtn(txt, pos, color)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0,84,0,84) b.Position = pos
        b.BackgroundColor3 = color b.BackgroundTransparency = 0.15
        b.Text = txt b.Font = Enum.Font.GothamBlack b.TextSize = 15 b.TextColor3 = Color3.new(1,1,1)
        b.Active = true b.Draggable = true
        local c = Instance.new("UICorner", b) c.CornerRadius = UDim.new(1,0)
        local st = Instance.new("UIStroke", b) st.Thickness=2 st.Transparency=0.3 st.Color=Color3.new(1,1,1)
        b.Parent = s
        return b
    end
    local throwB = mkBtn("🔪\nTHROW", UDim2.new(1,-200,1,-220), Color3.fromRGB(180,40,60))
    local aimB = mkBtn("🎯\nAIM", UDim2.new(1,-105,1,-220), Color3.fromRGB(40,110,200))
    -- throw manual: joga no melhor alvo visível dentro do ThrowFOV/Range
    throwB.MouseButton1Click:Connect(function()
        pcall(function()
            if GetRole(LocalPlayer) ~= "Murderer" then Notify("Só murderer joga faca") return end
            local my = GetRoot() if not my then return end
            local mp
            if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
                local vs = Camera.ViewportSize mp = Vector2.new(vs.X/2, vs.Y/2)
            else
                mp = UserInputService:GetMouseLocation()
            end
            local best, bestD = nil, (C.ThrowFOV or 220)
            local bestDist3D = C.ThrowAura_Range or 90
            local bestP = nil
            for _,p in ipairs(Players:GetPlayers()) do
                if p==LocalPlayer then continue end
                if not IsAlive(p) then continue end
                if GetRole(p)=="Murderer" then continue end
                local tr = GetRoot(p) if not tr then continue end
                if (my.Position - tr.Position).Magnitude > bestDist3D then continue end
                local hd = p.Character and p.Character:FindFirstChild("Head") if not hd then continue end
                local sp, os = Camera:WorldToViewportPoint(hd.Position) if not os then continue end
                local d = (Vector2.new(sp.X,sp.Y) - mp).Magnitude
                if d < bestD then bestD = d bestP = p end
            end
            -- fallback: mais próximo em 3D se ninguém no FOV
            if not bestP then
                local bd = 1e9
                for _,p in ipairs(Players:GetPlayers()) do
                    if p==LocalPlayer then continue end
                    if not IsAlive(p) then continue end
                    if GetRole(p)=="Murderer" then continue end
                    local tr = GetRoot(p) if not tr then continue end
                    local d = (my.Position - tr.Position).Magnitude
                    if d < bd and d <= bestDist3D then bd = d bestP = p end
                end
            end
            if bestP then DoThrowAt(bestP) Notify("🔪 Throw: "..bestP.DisplayName) else Notify("Sem alvo no FOV") end
        end)
    end)
    -- aim hold mobile: segura pra mirar
    aimB.MouseButton1Down:Connect(function() Aiming = true end)
    aimB.MouseButton1Up:Connect(function()
        -- só solta se não estiver segurando Q no PC
        if not UserInputService:IsKeyDown(C.AimKey) then Aiming = false end
    end)
    -- esconde/mostra conforme toggle + mostra só função relevante
    task.spawn(function()
        while s.Parent do
            pcall(function()
                s.Enabled = C.MobileButtons
                if s.Enabled then
                    local role = GetRole(LocalPlayer)
                    throwB.Visible = (role == "Murderer")
                    aimB.Visible = HasTool(LocalPlayer, {"Gun","Revolver"}) or role ~= "Murderer"
                end
            end)
            task.wait(0.5)
        end
    end)
    MobileUI = s
    return s
end
pcall(BuildMobileButtons)
LocalPlayer.CharacterAdded:Connect(function() task.wait(1) pcall(BuildMobileButtons) end)

--// ===== PLAYER MODS =====
RunService.Heartbeat:Connect(function()
    pcall(function()
        if C.Speed_Enabled then local h=GetHumanoid() if h and h.WalkSpeed~=C.Speed_Value then h.WalkSpeed=C.Speed_Value end end
        if C.Noclip then local c=GetChar() if c then for _,v in ipairs(c:GetDescendants()) do if v:IsA("BasePart") and v.CanCollide then v.CanCollide=false end end end end
        if C.Fullbright then Lighting.Brightness=2 Lighting.ClockTime=14 Lighting.FogEnd=100000 Lighting.GlobalShadows=false end
    end)
end)
UserInputService.JumpRequest:Connect(function() if C.InfJump then pcall(function() local h=GetHumanoid() if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end) end end)
local FlyConn=nil
local function SetFly(on)
    if FlyConn then FlyConn:Disconnect() FlyConn=nil end
    if not on then return end
    FlyConn=RunService.Heartbeat:Connect(function() pcall(function()
        local root=GetRoot() local hum=GetHumanoid() if not root or not hum then return end
        hum:ChangeState(Enum.HumanoidStateType.Physics)
        local dir=Vector3.new() local cf=Camera.CFrame
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir+=cf.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir-=cf.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir+=cf.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir-=cf.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir+=Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir-=Vector3.new(0,1,0) end
        if dir.Magnitude>0 then root.CFrame=root.CFrame+(dir.Unit*(C.Fly_Speed/50)) root.Velocity=Vector3.new()
        else root.Velocity=Vector3.new(0,0.5,0) end
    end) end)
end
local function SetXray(on)
    for _,v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsDescendantOf(LocalPlayer.Character or Instance.new("Model")) then
            if v.Name:lower():find("coin") or v.Name=="GunDrop" then continue end
            pcall(function()
                if on then if v.Transparency<0.7 then v:SetAttribute("OLD_T",v.Transparency) v.Transparency=0.7 end
                else local o=v:GetAttribute("OLD_T") if o then v.Transparency=o end end
            end)
        end
    end
end
local function FPSBoost() pcall(function()
    for _,v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then v.Material=Enum.Material.SmoothPlastic v.CastShadow=false end
        if v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled=false end
    end
    Lighting.GlobalShadows=false Lighting.FogEnd=100000 Notify("FPS Boost aplicado")
end) end
local function TeleportToPlayer(plr) local t=GetRoot(plr) local m=GetRoot() if t and m then m.CFrame=t.CFrame+Vector3.new(0,0,3) end end
local function TeleportToGun()
    local gd=Workspace:FindFirstChild("GunDrop") local m=GetRoot()
    if gd and m then local pos=gd:IsA("BasePart") and gd.Position or gd:GetPivot().Position m.CFrame=CFrame.new(pos+Vector3.new(0,3,0)) else Notify("Gun não dropada") end
end
local function KillMurdererAsSheriff() pcall(function()
    if not HasTool(LocalPlayer,{"Gun","Revolver"}) then Notify("Você não é xerife") return end
    for _,p in ipairs(Players:GetPlayers()) do if GetRole(p)=="Murderer" and IsAlive(p) then
        local tool=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
        if tool then Camera.CFrame=CFrame.new(Camera.CFrame.Position,p.Character.Head.Position) task.wait(0.15) tool:Activate() Notify("Tiro no murderer: "..p.DisplayName) break end
    end end
end) end

--// ===== UI (Delta-safe: PlayerGui primeiro, gethui se existir) =====
local function GetUIParent()
    if gethui then local ok,h = pcall(gethui) if ok and h then return h end end
    if get_hidden_gui then local ok,h = pcall(get_hidden_gui) if ok and h then return h end end
    local pg = nil pcall(function() pg = LocalPlayer:WaitForChild("PlayerGui", 10) end)
    if pg then return pg end
    local ok,c = pcall(function() return CoreGui end)
    if ok and c then return c end
    return LocalPlayer:FindFirstChild("PlayerGui")
end
local gui=Instance.new("ScreenGui") gui.Name="MM2_PRO" gui.ResetOnSpawn=false gui.IgnoreGuiInset=false
gui.DisplayOrder = 999 gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() gui.Parent = GetUIParent() getgenv().MM2_PRO_GUI=gui end)
if not gui.Parent then pcall(function() gui.Parent = LocalPlayer:WaitForChild("PlayerGui", 8) getgenv().MM2_PRO_GUI=gui end) end
BootStage("menu criado, ligando ESP...")
local function mk(c,pr,pa) local o=Instance.new(c) for k,v in pairs(pr) do pcall(function() o[k]=v end) end o.Parent=pa return o end
local Main=mk("Frame",{Name="Main",Size=UDim2.new(0,370,0,460),Position=UDim2.new(0.5,-185,0.5,-230),BackgroundColor3=Color3.fromRGB(16,16,22),BorderSizePixel=0,Active=true,Draggable=true},gui)
mk("UICorner",{CornerRadius=UDim.new(0,10)},Main)
mk("UIStroke",{Color=Color3.fromRGB(120,60,255),Thickness=1.5,Transparency=0.3},Main)
local Title=mk("TextLabel",{Size=UDim2.new(1,0,0,42),BackgroundColor3=Color3.fromRGB(24,24,32),Text="  🔪 MM2 PRO v7.1 COMPLETO",Font=Enum.Font.GothamBlack,TextSize=15,TextColor3=Color3.new(1,1,1),TextXAlignment=Enum.TextXAlignment.Left},Main)
mk("UICorner",{CornerRadius=UDim.new(0,10)},Title)
local ToggleBtn=mk("TextButton",{Size=UDim2.new(0,120,0,32),Position=UDim2.new(0,10,0,10),BackgroundColor3=Color3.fromRGB(120,60,255),Text="ABRIR [RShift]",Font=Enum.Font.GothamBold,TextSize=11,TextColor3=Color3.new(1,1,1)},gui)
mk("UICorner",{CornerRadius=UDim.new(0,8)},ToggleBtn) ToggleBtn.Draggable=true ToggleBtn.Active=true
ToggleBtn.MouseButton1Click:Connect(function() Main.Visible=not Main.Visible end)
UserInputService.InputBegan:Connect(function(i,g) if not g and i.KeyCode==Enum.KeyCode.RightShift then Main.Visible=not Main.Visible end end)
local Scroll=mk("ScrollingFrame",{Size=UDim2.new(1,-16,1,-58),Position=UDim2.new(0,8,0,50),BackgroundTransparency=1,ScrollBarThickness=4,CanvasSize=UDim2.new(0,0,0,2300)},Main)
mk("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder},Scroll)
local function Section(t) return mk("TextLabel",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,Text="— "..t.." —",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=Color3.fromRGB(160,130,255)},Scroll) end
local function Toggle(text,get,set)
    local b=mk("TextButton",{Size=UDim2.new(1,0,0,32),BackgroundColor3=Color3.fromRGB(30,30,40),Text="",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=Color3.new(1,1,1)},Scroll)
    mk("UICorner",{CornerRadius=UDim.new(0,7)},b)
    local function upd() local v=get() b.Text=(v and "✅ " or "❌ ")..text b.BackgroundColor3=v and Color3.fromRGB(35,95,55) or Color3.fromRGB(30,30,40) end
    b.MouseButton1Click:Connect(function() set(not get()) upd() end) upd() return b
end
local function Button(text,cb) local b=mk("TextButton",{Size=UDim2.new(1,0,0,32),BackgroundColor3=Color3.fromRGB(45,45,60),Text=text,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=Color3.new(1,1,1)},Scroll) mk("UICorner",{CornerRadius=UDim.new(0,7)},b) b.MouseButton1Click:Connect(function() pcall(cb) end) return b end
local function Slider(text,min,max,get,set)
    local f=mk("Frame",{Size=UDim2.new(1,0,0,44),BackgroundColor3=Color3.fromRGB(30,30,40)},Scroll) mk("UICorner",{CornerRadius=UDim.new(0,7)},f)
    local l=mk("TextLabel",{Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,Text=text..": "..tostring(get()),Font=Enum.Font.GothamBold,TextSize=12,TextColor3=Color3.new(1,1,1)},f)
    local mi=mk("TextButton",{Size=UDim2.new(0.5,-2,0,20),Position=UDim2.new(0,0,0,22),BackgroundColor3=Color3.fromRGB(60,60,75),Text="-",TextSize=14,Font=Enum.Font.GothamBlack,TextColor3=Color3.new(1,1,1)},f)
    local pl=mk("TextButton",{Size=UDim2.new(0.5,-2,0,20),Position=UDim2.new(0.5,2,0,22),BackgroundColor3=Color3.fromRGB(60,60,75),Text="+",TextSize=14,Font=Enum.Font.GothamBlack,TextColor3=Color3.new(1,1,1)},f)
    mi.MouseButton1Click:Connect(function() set(math.clamp(get()-1,min,max)) l.Text=text..": "..tostring(get()) end)
    pl.MouseButton1Click:Connect(function() set(math.clamp(get()+1,min,max)) l.Text=text..": "..tostring(get()) end)
end

Section("VISUAL / ESP")
Toggle("ESP Geral",function() return C.ESP_Enabled end,function(v) C.ESP_Enabled=v if not v then for _,p in ipairs(Players:GetPlayers()) do ClearESP(p) end else RefreshAllESP() end end)
Toggle("Nomes",function() return C.ESP_Names end,function(v) C.ESP_Names=v end)
Toggle("Distância",function() return C.ESP_Distance end,function(v) C.ESP_Distance=v end)
Toggle("Cargo [Murder/Sheriff]",function() return C.ESP_Role end,function(v) C.ESP_Role=v end)
Toggle("Chams",function() return C.Chams end,function(v) C.Chams=v RefreshAllESP() end)
Toggle("ESP Gun Drop",function() return C.ESP_Gun end,function(v) C.ESP_Gun=v end)
Toggle("Fullbright",function() return C.Fullbright end,function(v) C.Fullbright=v if not v then Lighting.Brightness=1 Lighting.GlobalShadows=true end end)
Toggle("X-Ray",function() return C.Xray end,function(v) C.Xray=v SetXray(v) end)

Section("ESP PRO (cor/tamanho)")
Slider("Texto ESP",8,24,function() return C.ESP_TextSize end,function(v) C.ESP_TextSize=v RefreshAllESP() end)
Slider("Cham Transp %",0,90,function() return C.ESP_ChamTrans end,function(v) C.ESP_ChamTrans=v end)
Button("🎨 Murder: vermelho",function() C.ESP_Colors.Murderer={255,35,55} RefreshAllESP() Notify("Murder = vermelho") end)
Button("🎨 Murder: rosa",function() C.ESP_Colors.Murderer={255,80,200} RefreshAllESP() Notify("Murder = rosa") end)
Button("🎨 Murder: laranja",function() C.ESP_Colors.Murderer={255,130,0} RefreshAllESP() Notify("Murder = laranja") end)
Button("🎨 Sheriff: azul",function() C.ESP_Colors.Sheriff={45,130,255} RefreshAllESP() Notify("Sheriff = azul") end)
Button("🎨 Sheriff: ciano",function() C.ESP_Colors.Sheriff={0,220,255} RefreshAllESP() Notify("Sheriff = ciano") end)
Button("🎨 Innocent: verde",function() C.ESP_Colors.Innocent={60,255,120} RefreshAllESP() Notify("Innocent = verde") end)
Button("🎨 Innocent: branco",function() C.ESP_Colors.Innocent={255,255,255} RefreshAllESP() Notify("Innocent = branco") end)
Button("🎨 Hero: dourado",function() C.ESP_Colors.Hero={255,180,0} RefreshAllESP() Notify("Hero = dourado") end)

Section("XERIFE / HERO")
Toggle("Aimbot [segura Q / botão AIM]",function() return C.Aimbot_Sheriff end,function(v) C.Aimbot_Sheriff=v Notify(v and "Aimbot ON: segure Q ou AIM" or "Aimbot OFF") end)
Toggle("Silent Aim (sem travar câmera)",function() return C.SilentAim end,function(v) C.SilentAim=v Notify(v and "Silent ON: só atirar" or "Silent OFF") end)
Slider("Silent FOV (px)",40,600,function() return C.SilentFOV end,function(v) C.SilentFOV=v end)
Toggle("Mostrar FOV",function() return C.ShowFOV end,function(v) C.ShowFOV=v end)
Slider("Aim FOV (px)",40,600,function() return C.AimFOV end,function(v) C.AimFOV=v end)
Button("🔫 Atirar no Murderer agora",KillMurdererAsSheriff)
Button("🔫 TP p/ Arma dropada",TeleportToGun)
Toggle("Auto pegar Gun",function() return C.AutoGrabGun end,function(v) C.AutoGrabGun=v end)
Toggle("Gun Sniper (pega e volta)",function() return C.GunSniper end,function(v) C.GunSniper=v Notify(v and "Gun Sniper ON" or "Gun Sniper OFF") end)
Toggle("Hitbox no Murderer (x8)",function() return C.Hitbox_Enabled end,function(v) C.Hitbox_Enabled=v end)

Section("MURDERER - KILL AURA")
Toggle("Kill Aura (bate sozinho)",function() return C.MurderAura end,function(v) C.MurderAura=v Notify(v and "Kill Aura ON" or "Kill Aura OFF") end)
Toggle("TP Kill (teleporta p/ matar - arriscado)",function() return C.MurderAura_TP end,function(v) C.MurderAura_TP=v end)
Slider("Aura Range",6,30,function() return C.MurderAura_Range end,function(v) C.MurderAura_Range=v end)
Toggle("Throw Aura (faca voadora)",function() return C.ThrowAura end,function(v) C.ThrowAura=v Notify(v and "Throw Aura ON" or "Throw Aura OFF") end)
Slider("Throw Range (studs)",20,200,function() return C.ThrowAura_Range end,function(v) C.ThrowAura_Range=v end)
Slider("Throw FOV (px)",40,600,function() return C.ThrowFOV end,function(v) C.ThrowFOV=v end)
Toggle("Botões Mobile THROW/AIM",function() return C.MobileButtons end,function(v) C.MobileButtons=v if v then pcall(BuildMobileButtons) end end)
Button("🔪 Throw manual agora",function()
    pcall(function()
        if GetRole(LocalPlayer)~="Murderer" then Notify("Só murderer") return end
        local my=GetRoot() if not my then return end
        local best,bd=nil,C.ThrowAura_Range
        for _,p in ipairs(Players:GetPlayers()) do
            if p==LocalPlayer then continue end
            if not IsAlive(p) then continue end
            if GetRole(p)=="Murderer" then continue end
            local tr=GetRoot(p) if tr then local d=(my.Position-tr.Position).Magnitude if d<bd then best,bd=p,d end end
        end
        if best then DoThrowAt(best) Notify("🔪 Throw: "..best.DisplayName) else Notify("Sem alvo") end
    end)
end)

Section("FARM MOEDAS")
Toggle("Tween Farm (rápido, visível)",function() return C.CoinFarm end,function(v) C.CoinFarm=v if v then C.WalkFarm=false end Notify(v and "Tween Farm ON" or "OFF") end)
Toggle("Walk Farm (andando, legit)",function() return C.WalkFarm end,function(v) C.WalkFarm=v if v then C.CoinFarm=false end Notify(v and "Walk Farm ON - andando" or "OFF") end)
Slider("Walk Range",50,500,function() return C.WalkFarm_Range end,function(v) C.WalkFarm_Range=v end)

Section("LOBBY / VOTO")
Toggle("Auto Votar Mapa",function() return C.AutoVote end,function(v) C.AutoVote=v Notify(v and "AutoVote ON" or "AutoVote OFF") end)
Button("🗳️ Votar agora",function()
    local pads=FindVotePads()
    if #pads==0 then Notify("Nenhum pad de voto achado (só no lobby)") return end
    local pad=pads[1] local hum=GetHumanoid()
    if hum then hum:MoveTo(pad.Position+Vector3.new(0,2,0)) Notify("Indo votar: "..VotePadName(pad)) end
end)

Section("AUTOPLAY + HOP")
Toggle("AutoPlay round (farm sozinho)",function() return C.AutoPlay end,function(v) C.AutoPlay=v Notify(v and "AutoPlay ON" or "AutoPlay OFF") end)
Toggle("Server Hop auto",function() return C.AutoHop end,function(v) C.AutoHop=v Notify(v and "AutoHop ON" or "AutoHop OFF") end)
Slider("Min players p/ hop",2,12,function() return C.AutoHop_MinPlayers end,function(v) C.AutoHop_MinPlayers=v end)
Button("🔀 Hop agora",function() pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) end) end)

Section("TRADE SNIPER")
Toggle("Alerta trade godly",function() return C.TradeHelper end,function(v) C.TradeHelper=v Notify(v and "Trade Helper ON" or "OFF") end)
Toggle("Auto-accept godly/ancient",function() return C.TradeAutoAccept end,function(v) C.TradeAutoAccept=v if v then C.TradeHelper=true end Notify(v and "Auto-Accept ON" or "OFF") end)

Section("PLAYER")
Toggle("Speed",function() return C.Speed_Enabled end,function(v) C.Speed_Enabled=v if not v then local h=GetHumanoid() if h then h.WalkSpeed=16 end end end)
Slider("WalkSpeed",16,120,function() return C.Speed_Value end,function(v) C.Speed_Value=v end)
Toggle("Fly",function() return C.Fly_Enabled end,function(v) C.Fly_Enabled=v SetFly(v) end)
Slider("Fly Speed",20,150,function() return C.Fly_Speed end,function(v) C.Fly_Speed=v if C.Fly_Enabled then SetFly(true) end end)
Toggle("Noclip",function() return C.Noclip end,function(v) C.Noclip=v end)
Toggle("Inf Jump",function() return C.InfJump end,function(v) C.InfJump=v end)

Section("MISC")
Button("⚡ FPS Boost",FPSBoost)
Button("🔄 Re-aplicar ESP",RefreshAllESP)
Button("👥 TP p/ Murderer",function() for _,p in ipairs(Players:GetPlayers()) do if GetRole(p)=="Murderer" then TeleportToPlayer(p) break end end end)
Button("👥 TP p/ Sheriff",function() for _,p in ipairs(Players:GetPlayers()) do if GetRole(p)=="Sheriff" then TeleportToPlayer(p) break end end end)
Button("❌ Fechar",function() for _,p in ipairs(Players:GetPlayers()) do pcall(ClearESP,p) end gui:Destroy() getgenv().MM2_PRO_LOADED=false end)

RefreshAllESP()
Notify("MM2 PRO v7.1 COMPLETO carregado!")
BootStage("carregado! Abrindo menu...")
task.delay(3, function() pcall(function() if BootGui then BootGui:Destroy() end end) end)
