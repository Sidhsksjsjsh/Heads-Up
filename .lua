local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4")
local T1 = wndw:Tab("Peek")
local T2 = wndw:Tab("Seek")
local T3 = wndw:Tab("ESP")

local plr = game:GetService("Players")
local self = plr.LocalPlayer

local lab = T1:Label("Seeker label is disabled\npress 'Show seeker' to enable this labels")

local function getNearPlayer(str)
  for i,v in pairs(plr:GetPlayers()) do
    if (self.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude < 25 then
      return str:gsub("${user.name}",v.Name):gsub("${user.id}",v.UserId):gsub("${user.dn}",v.DisplayName):gsub("${user.pos}",v.Character.HumanoidRootPart.Position):gsub("${user.cframe}",v.Character.HumanoidRootPart.CFrame)
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
