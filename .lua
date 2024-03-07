local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local ESPLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/ESP-THING/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4")
local T1 = wndw:Tab("Peek")
local T2 = wndw:Tab("Seek")
local T3 = wndw:Tab("ESP")

local plr = game:GetService("Players")
local self = plr.LocalPlayer
local workspace = game:GetService("Workspace")
local camera = workspace.CurrentCamera
local lab = T1:Label("Seeker label is disabled\npress 'Show seeker' to enable this labels")
--[[
camera.CameraType = "Fixed"
notify("Camera","Fixing Camera...")
wait(0.5)
camera.CameraSubject = self.Character:FindFirstChildWhichIsA('Humanoid')
camera.CameraType = "Custom"
]]

local function getNearPlayer(str)
  for i,v in pairs(plr:GetPlayers()) do
    if (self.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude < 25 then
      return str:gsub("${user.name}",v.Name):gsub("${user.id}",v.UserId):gsub("${user.dn}",v.DisplayName)
    end
  end
end

T1:Toggle("Peek",false,function(value)
    plr["#Network"]["RoundSystem"]["Peek"]:FireServer(value)
end)

T1:Toggle("Show seeker & Instant pick - AI Picker ( Seek & Peek )",false,function(value)
    _G.seek = value
    while wait() do
      if _G.seek == false then break end
      lab:EditLabel(getNearPlayer("user: ${user.name}\nDisplay name: ${user.dn}\nId: ${user.id}"))
      plr["#Network"]["RoundSystem"]["Pick"]:FireServer(getNearPlayer("${user.id}"))
    end
end)

T1:Toggle("Auto change camera state",false,function(value)
    _G.camstate = value
    camera.CameraType = "Fixed"
    while wait() do
      if _G.camstate == false then break end
      camera.CameraSubject = self.Character.Humanoid
      camera.CameraType = "Custom"
    end
end)

T2:Toggle("Auto catch peeker",false,function(value)
    _G.cpeek = value
    while wait() do
      if _G.cpeek == false then break end
      plr["#Network"]["RoundSystem"]["CatchRequest"]:FireServer(getNearPlayer("${user.id}"))
    end
end)

T2:Toggle("Auto pick peeker",false,function(value)
    _G.ppeek = value
    while wait() do
      if _G.ppeek == false then break end
      plr["#Network"]["RoundSystem"]["Pick"]:FireServer(getNearPlayer("${user.id}"))
    end
end)

T3:Button("ESP",function()
    for i,v in pairs(plr:GetPlayers()) do
      ESPLib:CreateESPTag({
          Text = "AI",
          Part = v.Character,
          TextSize = 7,
          TextColor = Color3.new(255, 255, 255),
          Highlight = true,
          Outline = Color3.new(255,0,0),
          EnableBoxESP = true,
          BoxColor = Color3.new(255,255,255),
          TracerColor = Color3.new(255,0,0)
      })
    end
end)
