--Changelog:
--[[
    {
        Added: kill, permavoid, serverhop, new dupe + dupe UI to match protons colors, added rejoin refresh (rjre), digitalities "leg rescale" which we all know he didn't make and source added so people can skid more from me, other stuff i cant remember
        Changed: changed the trash over done re to a more simple and useful one, changed "punish" command to perma void explaination in the command, improved void, improved fling and switched with mine, improved hat fling to work with any accessory, other stuff idk
        Removed or Commented Out: Most if not all commands relating to layered clothing crashes (obvious reasons), stupid jump command? lmao, removed stupid RGB UI it had that digiality promised hed fix, other stuff i forgot
        Future Ideas: Adding alleged digitalties "kill all/bring all" that we all know he didn't make with full source so more skidding for you guys yay
        DM me if you have a brain the size of a grain of sand and encounters a problem and can't fix it for some reason.
    }
]]

-- Originally skided by Digitality#0001

-- Edited by noketchupjustrice#3666 :scream:
-- Adding more stuff when I have time
-- All new commands are near botton so you can skid easier.

-- Disabilties comments are the (--//) ones lol if you see just regular comments they are most likley mines (--)

--// Skidton Admin
local Admin = {
    Name = "Skidton Admin",
    Prefix = "/",
    Invite = "",
    Info = {}
}

--// inserting info shit into Admin.Info table -- because i want the most ads possible for my shitty server thats full of newgen skids :nerd:
table.insert(Admin.Info,tostring(Admin.Name))
table.insert(Admin.Info,"Prefix is set to "..Admin.Prefix)
table.insert(Admin.Info,"Discord Invite: "..Admin.Invite)

--// custom chat function so i don't gotta use Players:Chatted or the chat event or any of that bullshit
-- ^^because disability is a skid
local function chat(text)
	StarterGui = game:GetService('StarterGui')
	A = false
	ChatBar = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Chat'):WaitForChild('Frame'):WaitForChild('ChatBarParentFrame'):WaitForChild('Frame'):WaitForChild('BoxFrame'):WaitForChild('Frame'):FindFirstChildOfClass('TextBox')
	A = StarterGui:GetCore('ChatActive')
	StarterGui:SetCore('ChatActive', true)
	ChatBar:CaptureFocus()
	ChatBar.Text = text
    ChatBar.TextEditable = false
	ChatBar:ReleaseFocus(true)
    ChatBar.TextEditable = true
	StarterGui:SetCore('ChatActive', A)
end

--// Printing out info on execution
-- Wtf ew
--[[for i,v in pairs(Admin.Info) do
    print(v)
end]]

--// Variables
local players = game:GetService("Players")
local p = players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")
local whitelisted = {p}
local Commands = {}
local connected = {}
local target
local speaker
local args
local regargs
local prefix = "/"
local guiprefix = ";"
local gui
local guicons = {}
local main
local cmdbar
local cmdbartextbox
local cmdlist
local cmdlisttext
local cmdlistsearchtextbox
local cmdlistclose
local main
--// getplayer function
local function getplayer(Name)
    Name = Name:lower():gsub(" ","")
    for _,x in next, players:GetPlayers() do
        if x ~= p then
            if x.Name:lower():match("^"..Name) then
                return x
            elseif x.DisplayName:lower():match("^"..Name) then
                return x
            end
        end
    end
end

-- Leaving this be because i am not touching any of this skided shit
-- Average admin command handler be like:
--// addcmd function with onchatted connecting
function addcmd(Name, callback)
    if Name:match(", ") then
        Commands[Name] = Name:split(", ")
    else
        Commands[Name] = {}
        Commands[Name].Name = Name
        Commands[Name].callback = callback
    end
    cmdlisttext.Text = cmdlisttext.Text.."\n"..Name
    table.insert(connected,game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(messagedata)
        local wl = players:FindFirstChild(messagedata.FromSpeaker)
        msg = messagedata.Message
        if wl and table.find(whitelisted, wl) then
            speaker = wl
            msg = msg:lower()
            args = msg:split(' ')
            if args[1] == prefix..Name then
                if args[2] then
                    if args[2] == "all" then
                        target = players:GetPlayers()
                    elseif args[2] == "others" then
                        local plrtable = {}
                        for i,v in pairs(players:GetPlayers()) do
                               if v ~= p then
                                table.insert(plrtable,v)
                            end
                        end
                        target = plrtable
                    elseif args[2] == "me" then
                        target = speaker
                    else
                        target = getplayer(args[2])
                    end
                else
                    target = speaker
                end
                local success, err = pcall(function()
                    coroutine.wrap(function()
                        callback()
                    end)()
                end)
            end
        end
    end))
end

--// UI stuff
local function loadui(id)
    if gui then
        gui:Destroy()
        for i,v in pairs(guicons) do
            v:Disconnect()
        end
    end
    gui = game:GetObjects("rbxassetid://"..id)[1]
    if gui:IsA("ScreenGui") then
        -- Removing the settings because they are shit oml 
        shitasssettings = gui:FindFirstChild("ProtonSettings")
        main = gui:FindFirstChild("ProtonMain", true)
        cmdbar = gui:FindFirstChild("ProtonCommandBar", true)
        cmdbartextbox = gui:FindFirstChild("ProtonCommandBarTextbox", true)
        cmdlist = gui:FindFirstChild("ProtonCommandList", true)
        cmdlisttext = gui:FindFirstChild("ProtonCommandListText", true)
        cmdlistsearchtextbox = gui:FindFirstChild("ProtonCommandListSearchTextbox", true)
        cmdlistclose = gui:FindFirstChild("ProtonCommandListClose", true)
        main = gui:FindFirstChild("ProtonMain", true) or cmdbar
        local belowpos = UDim2.new(0.5,main.AbsoluteSize.X/2,1,main.AbsoluteSize.Y/2)
        shitasssettings:Destroy()
        gui.Parent = game:GetService("CoreGui")
        gui.ResetOnSpawn = false
        main.Visible = false
        cmdlist.Visible = false
        cmdlist.Draggable = true
        cmdlist.Active = true
        cmdlist.Selectable = true
        cmdlistclose.MouseButton1Click:Connect(function()
            cmdlist.Visible = false
        end)
        for i,v in pairs(main:GetDescendants()) do
            if (pcall(function() return v.BackgroundTransparency; end)) then
                pcall(function()
                    local val = Instance.new("NumberValue", v)
                    val.Name = "backtrans"
                    val.Value = v.BackgroundTransparency
                    v.BackgroundTransparency = 1
                end)
            end
        end
        for i,v in pairs(main:GetDescendants()) do
            pcall(function()
                if (pcall(function() return v.TextTransparency; end)) then
                    pcall(function()
                        local val = Instance.new("NumberValue", v)
                        val.Name = "texttrans"
                        val.Value = v.TextTransparency
                        v.TextTransparency = 1
                    end)
                end
            end)
        end
        for i,v in pairs(main:GetDescendants()) do
            if (pcall(function() return v.ImageTransparency; end)) then
                pcall(function()
                    local val = Instance.new("NumberValue", v)
                    val.Name = "imagetrans"
                    val.Value = v.ImageTransparency
                    v.ImageTransparency = 1
                end)
            end
        end
        table.insert(guicons,p:GetMouse().KeyDown:Connect(function(key)
            if key == guiprefix then
                main.Visible = true
                local tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(0.25, Enum.EasingStyle.Linear)
                for i,v in pairs(main:GetDescendants()) do
                    if (pcall(function() return v.BackgroundTransparency; end)) then
                        pcall(function()
                            tweenService:Create(v, tweenInfo, {BackgroundTransparency = v.backtrans.Value}):Play()
                        end)
                    end
                end
                for i,v in pairs(main:GetDescendants()) do
                    if (pcall(function() return v.TextTransparency; end)) then
                        pcall(function()
                            tweenService:Create(v, tweenInfo, {TextTransparency = v.texttrans.Value}):Play()
                        end)
                    end
                end
                for i,v in pairs(main:GetDescendants()) do
                    if (pcall(function() return v.ImageTransparency; end)) then
                        pcall(function()
                            tweenService:Create(v, tweenInfo, {ImageTransparency = v.imagetrans.Value}):Play()
                        end)
                    end
                end
                task.wait()
                cmdbartextbox:CaptureFocus()
                --[[local currentmessage
                local focused = true
                coroutine.wrap(function()
                    while focused do
                        currentmessage = cmdbartextbox.Text
                        task.wait()
                    end
                end)()]]
                cmdbartextbox.FocusLost:Wait()
                local wl = p
                --msg = currentmessage
                msg = cmdbartextbox.Text
                if wl and table.find(whitelisted, wl) then
                    speaker = wl
                    msg = msg:lower()
                    args = msg:split(' ')
                    if Commands[args[1]] or Commands[args[1]:split(prefix)[1]] then
                        local commandname = Commands[args[1]] or Commands[args[1]:split(prefix)[1]]
                        if args[2] then
                            if args[2] == "all" then
                                target = players:GetPlayers()
                            elseif args[2] == "others" then
                                local plrtable = {}
                                for i,v in pairs(players:GetPlayers()) do
                                    if v ~= p then
                                        table.insert(plrtable,v)
                                    end
                                end
                                target = plrtable
                            elseif args[2] == "me" and speaker then
                                target = speaker
                            elseif (pcall(function() return(getplayer(args[2])) end)) then
                                target = getplayer(args[2])
                            end
                        else
                            target = speaker
                        end
                        local success, err = pcall(function()
                            coroutine.wrap(function()
                                commandname.callback()
                            end)()
                        end)
                    end
                end
                for i,v in pairs(main:GetDescendants()) do
                    if (pcall(function() return v.BackgroundTransparency; end)) then
                        pcall(function()
                            tweenService:Create(v, tweenInfo, {BackgroundTransparency = 1}):Play()
                        end)
                    end
                end
                for i,v in pairs(main:GetDescendants()) do
                    if (pcall(function() return v.TextTransparency; end)) then
                        pcall(function()
                            tweenService:Create(v, tweenInfo, {TextTransparency = 1}):Play()
                        end)
                    end
                end
                for i,v in pairs(main:GetDescendants()) do
                    if (pcall(function() return v.ImageTransparency; end)) then
                        pcall(function()
                            tweenService:Create(v, tweenInfo, {ImageTransparency = 1}):Play()
                        end)
                    end
                end
                task.wait(0.25)
                main.Visible = false
            end
        end))
    end
end

--// Load UI
if not _G.UI_Id or _G.UI_Id and _G.UI_Id == "default" then
    loadui(10981707755)
else
    loadui(_G.UI_Id)
end

--// Functions
local function breakvel(part)
    local stay = Instance.new("BodyVelocity")
    stay.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    stay.P = math.huge
    stay.Velocity = Vector3.new(0, 0, 0)
    stay.Parent = part
    local brv = true
    coroutine.wrap(function()
        while brv do
            for i,v in pairs(p.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Velocity = Vector3.new()
                    v.RotVelocity = Vector3.new()
                end
            end
            game:GetService("RunService").Heartbeat:Wait()
        end
    end)()
    task.wait()
    brv = false
    stay:Destroy()
end
-- ^^ :skull:
local function fakechar()
    local clone = game:GetObjects("rbxassetid://8370047840")[1]
    clone.Parent = game:GetService("Workspace")
    clone:MoveTo(p.Character.PrimaryPart.Position)
    clone:FindFirstChild("HumanoidRootPart").Anchored = false
    for i,v in pairs(clone:GetDescendants()) do
        if (pcall(function() return v.Transparency; end)) then
		    pcall(function()
			    v.Transparency = 1
		    end)
        end
    end
    for i,v in pairs(clone:GetDescendants()) do
        if v:IsA("Accessory") then
            v:Destroy()
        end
    end
    p.Character = clone
    game:GetService("Workspace").CurrentCamera.CameraSubject = clone:FindFirstChild("Humanoid")
end
local function replacechar()
    local c = p.Character
    p.Character = nil
    p.Character = c
end
local function replacehum()
    local h = p.Character:FindFirstChild("Humanoid"):Clone()
    p.Character:FindFirstChild("Humanoid"):Destroy()
    h.Parent = p.Character
end
local function massless(model)
    for i,v in pairs(model:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Massless = true
        end
    end
end
local function anchorchar()
    for i,v in pairs(p.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Anchored = true
        end
    end
end
local function unanchorchar()
    for i,v in pairs(p.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Anchored = false
        end
    end
end
local function breakjoints(model)
    for i,v in pairs(model:GetDescendants()) do
        if v:IsA("BasePart") then
            v:BreakJoints()
        end
    end
end
local function getnetlessvelocity(realPartVelocity)
    if (realPartVelocity.Y > 1) or (realPartVelocity.Y < -1) then
        return realPartVelocity * (25.1 / realPartVelocity.Y)
    end
    realPartVelocity = realPartVelocity * Vector3.new(1, 0, 1)
    local mag = realPartVelocity.Magnitude
    if mag > 1 then
        realPartVelocity = realPartVelocity * 100 / mag
    end
    return realPartVelocity + Vector3.new(0, 26, 0)
end
local function align(Part1,Part0,CFrameOffset)
	local AlignPos = Instance.new('AlignPosition', Part1)
    AlignPos.Name = "alignpos"
	AlignPos.Parent.CanCollide = false
	AlignPos.ApplyAtCenterOfMass = true
	AlignPos.MaxForce = 67752
	AlignPos.MaxVelocity = math.huge/9e110
	AlignPos.ReactionForceEnabled = false
	AlignPos.Responsiveness = 200
	AlignPos.RigidityEnabled = false
	local AlignOri = Instance.new('AlignOrientation', Part1)
    AlignOri.Name = "alignori"
	AlignOri.MaxAngularVelocity = math.huge/9e110
	AlignOri.MaxTorque = 67752
	AlignOri.PrimaryAxisOnly = false
	AlignOri.ReactionTorqueEnabled = false
	AlignOri.Responsiveness = 200
	AlignOri.RigidityEnabled = false
	local AttachmentA=Instance.new('Attachment',Part1)
    AttachmentA.Name = "aa"
	local AttachmentB=Instance.new('Attachment',Part0)
    AttachmentB.Name = "ab"
	AttachmentB.CFrame = AttachmentB.CFrame * CFrameOffset
	AlignPos.Attachment0 = AttachmentA
	AlignPos.Attachment1 = AttachmentB
	AlignOri.Attachment0 = AttachmentA
	AlignOri.Attachment1 = AttachmentB
    local realVelocity = Vector3.new(0,30,0)
    local steppedcon = game:GetService("RunService").Stepped:Connect(function()
        Part1.Velocity = realVelocity
    end)
    local heartbeatcon = game:GetService("RunService").Heartbeat:Connect(function()
        realVelocity = Part1.Velocity
        Part1.Velocity = getnetlessvelocity(realVelocity)
    end)
    Part1.Destroying:Connect(function()
        Part1 = nil
        steppedcon:Disconnect()
        heartbeatcon:Disconnect()
    end)
end

local x = Instance.new("BindableEvent")
for _, v in ipairs({game:GetService("RunService").RenderStepped, game:GetService("RunService").Heartbeat, game:GetService("RunService").Stepped}) do
    v.Connect(v, function()
        return x.Fire(x, tick())
    end)
end
local superstepped = x.Event
local function superwait()
    x.Event:Wait()
end
local function unalign(Part1,Part0)
    Part1:FindFirstChild("alignpos"):Destroy()
    Part1:FindFirstChild("alignori"):Destroy()
    Part1:FindFirstChild("aa"):Destroy()
    Part0:FindFirstChild("ab"):Destroy()
end
-- oh nah wtf is this fly
local mouse = p:GetMouse()
local FLYING = false
local QEfly = true
local flyspeed = 1
local vehicleflyspeed = 1
local function sFLY(vfly)
	repeat task.wait() until p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildOfClass("Humanoid")
	repeat task.wait() until mouse
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = p.Character:FindFirstChild("HumanoidRootPart")
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0
	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 10e5
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(10e11, 10e11, 10e11)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new()
		BV.maxForce = Vector3.new(10e11, 10e11, 10e11)
		task.spawn(function()
			repeat wait()
				if not vfly and p.Character:FindFirstChildOfClass('Humanoid') then
					p.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = ws.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if p.Character:FindFirstChildOfClass('Humanoid') then
				p.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	local flyKeyDown = mouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and vehicleflyspeed or flyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and vehicleflyspeed or flyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and vehicleflyspeed or flyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and vehicleflyspeed or flyspeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and vehicleflyspeed or flyspeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and vehicleflyspeed or flyspeed)*2
		end
		pcall(function() ws.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	local flyKeyUp = mouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

local function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if p.Character:FindFirstChildOfClass('Humanoid') then
		p.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

-- Removed the rhs commands because nobody plays rhs stupid newgens

--// Commands
addcmd("cmds", function()
    if target == p then
        cmdlist.Visible = true
    end
end)

addcmd("stopadmin", function()
    if gui then
        gui:Destroy()
        for i,v in pairs(guicons) do
            v:Disconnect()
        end
    end
    for i,v in pairs(connected) do
        v:Disconnect()
    end
end)

addcmd("info", function()
    task.wait(0.1)
    for i,v in pairs(Admin.Info) do
        chat(v)
        task.wait(0.1)
    end
end)

addcmd("prefix", function()
    prefix = args[2]
end)
addcmd("cmdbarprefix", function()
    guiprefix = args[2]
end)
addcmd("admin", function()
    if speaker == p then
        if type(target) == "table" then
            for i,v in pairs(target) do
                if not table.find(whitelisted,v) then
                    table.insert(whitelisted,v)
                end
            end
        else
            if not table.find(whitelisted,target) then
                table.insert(whitelisted,target)
            end
        end
    end
end)
addcmd("unadmin", function()
    if speaker == p then
        if type(target) == "table" then
            for i,v in pairs(target) do
                if v ~= p then
                    if table.find(whitelisted,v) then
                        table.remove(whitelisted,table.find(whitelisted,v))
                    end
                end
            end
        else
            if target ~= p then
                if table.find(whitelisted,target) then
                    table.remove(whitelisted,table.find(whitelisted,target))
                end
            end
        end
    end
end)

addcmd("rj", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, p)
end)

addcmd("rjre", function()
	if not syn.queue_on_teleport then
		return print("noob")
	end
	local Saved = tostring(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame)
	syn.queue_on_teleport(string.format([[
	repeat task.wait() until game:GetService("Players") and game:GetService("Players").LocalPlayer
	game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen()
	local p = game:GetService("Players").LocalPlayer
    repeat task.wait() until p.Character
	for i = 1,5 do
		p.Character:SetPrimaryPartCFrame(CFrame.new(%s))
        p.Character:WaitForChild('ForceField'):Destroy()
	end
    ]],Saved))
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, p)
    if game:GetService("CoreGui"):FindFirstChild("TeeleportGui") then
        game:GetService("CoreGui"):FindFirstChild("TeeleportGui"):Destroy()
    end
end)

-- Added serverhop since apparntly disability can't make one
addcmd("hop",function()
    function FindServer()
		pcall(function()
			local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100") or game:HttpGet("https://games.roblox.com/v1/games/" ..game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
			while task.wait() do
				v = Servers.data[math.random(#Servers.data)]
				if v.playing < v.maxPlayers and v.id ~= game.JobId then
					game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id)
					break
				end
			end			
		end)
	end
	  local function ServerHop()
		FindServer()
		while task.wait() do
			pcall(FindServer)
		end
	  end
	  ServerHop()
end)

addcmd("to", function()
    if type(target) == "table" then
        for i,target in pairs(target) do
            --breakvel(p.Character:FindFirstChild("HumanoidRootPart")) nah
            for i,v in pairs(p.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    breakvel(v)
                end
            end
            p.Character:SetPrimaryPartCFrame(target.Character:FindFirstChild("HumanoidRootPart").CFrame)
        end
    else
        --breakvel(p.Character:FindFirstChild("HumanoidRootPart")) nah pt2
        for i,v in pairs(p.Character:GetChildren()) do
            if v:IsA("BasePart") then
                breakvel(v)
            end
        end
        p.Character:SetPrimaryPartCFrame(target.Character:FindFirstChild("HumanoidRootPart").CFrame)
    end
end)

local noclippedtab = {}
addcmd("noclip", function()
    table.insert(noclippedtab, game:GetService("RunService").Stepped:Connect(function()
        local t = target
        for i,v in pairs(target.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide == true then
                v.CanCollide = false
            end
        end
    end))
end)

addcmd("clip", function()
    for i,v in pairs(noclippedtab) do
        v:Disconnect()
    end
end)

addcmd("hipheight", function()
    p.Character:FindFirstChild("Humanoid").HipHeight = args[2]
end)

addcmd("jp", function()
    p.Character:FindFirstChild("Humanoid").JumpPower = args[2]
end)

addcmd("ws", function()
    p.Character:FindFirstChild("Humanoid").WalkSpeed = args[2]
end)

addcmd("equiptools", function()
    for i,v in pairs(p.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            -- Sometimes fails or errors happen so its shit just stop trying p.Character:FindFirstChild("Humanoid"):EquipTool(v)
            v.Parent = p.Character
        end
    end
end)

local netlagtab = {}
addcmd("netlag", function()
    table.insert(netlagtab, game:GetService("RunService").Heartbeat:Connect(function()
        for i,v in pairs(target.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                sethiddenproperty(v, "NetworkIsSleeping", true)
            end
        end
    end))
end)

addcmd("unnetlag", function()
    for i,v in pairs(netlagtab) do
        v:Disconnect()
    end
end)

addcmd("loopflingall", function()
    game:GetService("Workspace").FallenPartsDestroyHeight = tonumber("nan")
    local function flung(plr)
        if plr.Character and plr.Character.PrimaryPart then
            if
                plr.Character.PrimaryPart.Velocity.X >= 100 or plr.Character.PrimaryPart.Velocity.Y >= 100 or
                    plr.Character.PrimaryPart.Velocity.Z >= 100
             then
                return true
            else
                return false
            end
        end
    end
    local stay = Instance.new("BodyVelocity")
    stay.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    stay.P = math.huge
    stay.Velocity = Vector3.new(0, 0, 0)
    local c = game.Players.LocalPlayer.Character
    c.Archivable = true
    local clone = c:Clone()
    clone.Parent = game:GetService("Workspace")
    clone.PrimaryPart.Anchored = true
    for i, v in pairs(clone:GetDescendants()) do
        if
            (pcall(
                function()
                    return v.Transparency
                end
            ))
         then
            v.Transparency = 1
        end
    end
    for i, v in pairs(clone:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
        end
    end
    c:FindFirstChild("HumanoidRootPart").CFrame =
        c:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(9999, 9999, 9999)
    for i, v in pairs(c:GetDescendants()) do
        if v:IsA("BasePart") then
            stay:Clone().Parent = v
        end
    end
    -- Wtf is this shitty rescale disability cmon do better
    --[[for i, v in pairs(c.Humanoid:GetChildren()) do
        if v:IsA("NumberValue") then
            for i, v1 in pairs(c:GetChildren()) do
                if v1:FindFirstChild("AvatarPartScaleType", true) then
                    repeat
                        wait()
                    until v1:FindFirstChild("OriginalSize", true)
                    v1:FindFirstChild("OriginalSize", true):Destroy()
                    v:Destroy()
                end
            end
        end
    end]]
    -- https://raw.githubusercontent.com/noketchupjustrice/MyStuff/main/ActualGoodStuff/Releases/ReweldHatRescale.lua sooooo coooooooool :sunglasses:
    local Character = p.Character
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    for i, v in pairs(Character:GetChildren()) do
        if v:IsA("Accessory") then -- Checking For Accessorys
            for i, v in pairs(v.Handle:GetChildren()) do
                if v:IsA("Attachment") then
                    v:Destroy()
                end
            end
        end
    end
    local function Remove()
        for i, v in pairs(Character:GetChildren()) do
            if v:IsA("Accessory") then
                v.Handle:WaitForChild("OriginalSize"):Destroy()
            end
        end
    end
    Remove()
    Humanoid:WaitForChild("BodyWidthScale"):Destroy()
    Remove()
    Humanoid:WaitForChild("BodyProportionScale"):Destroy()
    Remove()
    Humanoid:WaitForChild("BodyTypeScale"):Destroy()
    Remove()
    Humanoid:WaitForChild("BodyHeightScale"):Destroy()
    Remove()
    Humanoid:WaitForChild("BodyDepthScale"):Destroy()
    Remove()
    Humanoid:WaitForChild("HeadScale"):Destroy()
    Remove()
    --DROP ALL ACCESSORIES IN R6 AND R15 BY ShownApe#7272
    local block = false
    local character = game.Players.LocalPlayer.Character
    game.Players.LocalPlayer.Character = nil
    game.Players.LocalPlayer.Character = character
    wait(game.Players.RespawnTime + 0.05)
    game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v.Name == "Torso" or v.Name == "UpperTorso" then
            v:Destroy()
        end
    end
    character.HumanoidRootPart:Destroy()
    for i, v in pairs(character:GetChildren()) do
        if v:IsA("Accessory") then
            sethiddenproperty(v, "BackendAccoutrementState", 0) --any integer 0-3 works but 4, as 4 is the default state for in character, 0 is for when it has collision in character or other circumstances, 2 is workspace, 1 is unknown if you know or figure out please let me know
        --BackendAccoutrementState is a replicated property similar to NetworkIsSleeping and is further documented in reweld
        end
    end
    if block == true then
        for i, v in pairs(character:GetDescendants()) do
            if v:IsA("SpecialMesh") then
                v:Destroy()
            end
        end
    end
    character:FindFirstChild("Body Colors"):Destroy()
    game:GetService("Workspace").CurrentCamera.CameraSubject = clone:FindFirstChild("Humanoid")
    local stoploop = false
    coroutine.wrap(
        function()
            while true do
                if stoploop == true then
                    break
                end
                for i, v in pairs(game.Players:GetPlayers()) do
                    if
                        v ~= game:GetService("Players").LocalPlayer and v.Character and
                            v.Character:FindFirstChild("HumanoidRootPart") and
                            not flung(v)
                     then
                        for i, v1 in pairs(c:GetDescendants()) do
                            if v1:IsA("BasePart") then
                                v1.Velocity = Vector3.new(0, 100, 0)
                                v1.RotVelocity = Vector3.new(9e11, 9e11, 9e11)
                                v1.Position = v.Character:FindFirstChild("HumanoidRootPart").Position
                            end
                        end
                        game:GetService("RunService").Heartbeat:Wait()
                    elseif clone and clone:FindFirstChild("HumanoidRootPart") then
                        for i, v1 in pairs(c:GetDescendants()) do
                            if v1:IsA("BasePart") then
                                v1.Velocity = Vector3.new(0, 100, 0)
                                v1.RotVelocity = Vector3.new()
                                v1.Rotation = Vector3.new()
                                v1.Orientation = Vector3.new()
                                v1.Position = clone:FindFirstChild("HumanoidRootPart").Position
                            end
                        end
                        game:GetService("RunService").Heartbeat:Wait()
                    end
                end
            end
        end
    )()
    local resetBindable = Instance.new("BindableEvent")
    local connection2
    connection2 =
        resetBindable.Event:connect(
        function()
            clone:Destroy()
            local stoploop = true
            connection2:Disconnect()
            c:FindFirstChild("Humanoid"):Destroy()
            resetBindable:Destroy()
            game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
            game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Information",Text = "Wait approximately " .. game:GetService("Players").RespawnTime .. " seconds to fully respawn."})
        end
    )
    game:GetService("StarterGui"):SetCore("ResetButtonCallback", resetBindable)    
end)

addcmd("toolflingall", function()
    local c = p.Character
    local function flung(plr)
        if plr.Character and plr.Character.PrimaryPart then
            if plr.Character.PrimaryPart.Velocity.X >= 100 or plr.Character.PrimaryPart.Velocity.Y >= 100 or plr.Character.PrimaryPart.Velocity.Z >= 100 then
                return true
            else
                return false
            end
        end
    end
    for i, v in pairs(p.Character:GetChildren()) do
        if v:IsA("Tool") then
            v.Parent = p.Backpack
        end
    end
    for i, v in pairs(p.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            v.Parent = c
            v.Parent = game:GetService("Workspace")
            firetouchinterest(v:FindFirstChild("Handle"), c:FindFirstChild("HumanoidRootPart"), 0)
            firetouchinterest(v:FindFirstChild("Handle"), c:FindFirstChild("HumanoidRootPart"), 1)
            c.ChildAdded:wait()
            task.wait()
            for i, v in pairs(c:GetChildren()) do
                if v:IsA("Tool") then
                    v.Parent = p.Backpack
                    v.Parent = c
                    v.Parent = c:FindFirstChild("Humanoid")
                    v.Parent = p.Backpack
                    v.Parent = c:FindFirstChild("Humanoid")
                    if v:FindFirstChild("Handle") then
                        v:FindFirstChild("Handle").CFrame = c:FindFirstChild("HumanoidRootPart").CFrame
                        if v:FindFirstChild("Handle"):FindFirstChild("TouchInterest") then
                            v:FindFirstChild("Handle"):FindFirstChild("TouchInterest"):Destroy()
                        else
                            repeat task.wait() until v:FindFirstChild("Handle") and v:FindFirstChild("Handle"):FindFirstChild("TouchInterest")
                            v:FindFirstChild("Handle"):FindFirstChild("TouchInterest"):Destroy()
                        end
                    end
                end
            end
        end
    end
    
    for i, v in pairs(c:FindFirstChild("Humanoid"):GetChildren()) do
        if v:IsA("Tool") then
            for i, vprt in pairs(v:GetChildren()) do
                if vprt:IsA("BasePart") then
                    vprt:BreakJoints()
                    coroutine.wrap(function()
                        while true do
                            for i, pr in pairs(game.Players:GetChildren()) do
                                if not v.Parent == c or v.Parent == p.Backpack then
                                    break
                                end
                                if pr ~= p and pr and pr.Character and pr.Character:FindFirstChild("HumanoidRootPart") and not pr.Character:FindFirstChild("HumanoidRootPart"):IsGrounded() and not flung(pr) then
                                    vprt.CanCollide = false
                                    vprt.Velocity = Vector3.new(50,0,0)
                                    vprt.CFrame = pr.Character:FindFirstChild("HumanoidRootPart").CFrame
                                    vprt.RotVelocity = Vector3.new(9e11,9e11,9e11)
                                else
                                    vprt.CanCollide = false
                                    vprt.Velocity = Vector3.new(50,0,0)
                                    vprt.CFrame = c:FindFirstChild("HumanoidRootPart").CFrame
                                    vprt.RotVelocity = Vector3.new()
                                end
                                game:GetService("RunService").Heartbeat:Wait()
                            end
                        end
                    end)()
                end
            end
        end
    end
end)

--[[wtf?
addcmd("jump", function()
    local oldpos = p.Character:FindFirstChild("HumanoidRootPart").CFrame
    if type(target) == "table" then
        for i,v in pairs(target) do
            local jump = true
            coroutine.wrap(function()
                while jump do
                    for i,v in pairs(p.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                    game:GetService("RunService").Stepped:Wait()
                end
            end)()
            local tp = true
            coroutine.wrap(function()
                while tp do
                    p.Character:FindFirstChild("HumanoidRootPart").CFrame = v.Character:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0,-4,0)
                   game:GetService("RunService").RenderStepped:Wait()
                end
            end)()
            wait()
            tp = false
            p.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,54,0)
            repeat task.wait() until p.Character:FindFirstChild("HumanoidRootPart").Velocity.Y < 4
            jump = false
            for i = 1, 1000 do
                p.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new()
                p.Character:FindFirstChild("HumanoidRootPart").CFrame = oldpos + Vector3.new(0,-50,0)
            end
        end
        for i = 1, 1000 do
            p.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new()
            p.Character:FindFirstChild("HumanoidRootPart").CFrame = oldpos
        end
    else
        local jump = true
        coroutine.wrap(function()
            while jump do
                for i,v in pairs(p.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
                game:GetService("RunService").Stepped:Wait()
            end
        end)()
        local tp = true
        coroutine.wrap(function()
            while tp do
                p.Character:FindFirstChild("HumanoidRootPart").CFrame = target.Character:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0,-4,0)
               game:GetService("RunService").RenderStepped:Wait()
            end
        end)()
        wait()
        tp = false
        p.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,54,0)
        repeat task.wait() until p.Character:FindFirstChild("HumanoidRootPart").Velocity.Y < 4
        jump = false
        for i = 1, 1000 do
            p.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new()
            p.Character:FindFirstChild("HumanoidRootPart").CFrame = oldpos
        end
    end
end)
]]

-- Obviously im better at flings

function NWait(n)
    if not type(Input) == "number" then
        return
    end
    local Current = tick()
    Input = Input or 0
    repeat game["RunService"].Heartbeat:Wait() until tick() - Current >= Input
    return tick() - Current
end

addcmd("fling", function()
    if target then
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local OldFPDH = workspace.FallenPartsDestroyHeight
        local AllBool = false
        local Fling = function(Target)
            local Character = LocalPlayer.Character
            local RootPart = Character.HumanoidRootPart
            local Humanoid = Character:FindFirstChild("Humanoid")
            local Head = Character:FindFirstChild("Head")
        
            local TargetCharacter = Target.Character
            local TargetHead = TargetCharacter:FindFirstChild("Head")
            local TargetHumanoid = TargetCharacter:FindFirstChild("Humanoid")
            local TargetRoot = TargetCharacter:FindFirstChild("HumanoidRootPart")
        
            if Character and Humanoid and RootPart and Head then
                OldPos = RootPart.CFrame
                task.wait()
                if TargetHead then
                    workspace.CurrentCamera.CameraSubject = TargetHead
                else
                    workspace.CurrentCamera.CameraSubject = TargetCharacter
                end
                if not Character:FindFirstChildWhichIsA("BasePart") then
                    return
                end
        
                local function ForcePosition(Base, Position, Angle)
                    LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(Base.Position) * Position * Angle)
                    for i,v in pairs(Character:GetChildren()) do
                        if v:IsA("BasePart") then
                            v.Velocity = Vector3.new(10e10, 10e10, 10e10)
                            v.RotVelocity = Vector3.new(10e10, 10e10, 10e10)
                            v.AssemblyAngularVelocity = Vector3.new(10e10, 10e10, 10e10)
                            v.AssemblyLinearVelocity = Vector3.new(10e10, 10e10, 10e10)
                        end
                    end
                end
        
                local ForceBasePart = function(BasePart)
                    local FlingTime = 3.5
                    local Time = tick()
                    local Angle = 0
                    task.wait()
                    repeat
                        for i, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
                            v:Stop()
                        end
                        if RootPart and TargetCharacter then
                            Angle = Angle + 100
                            ForcePosition(BasePart,CFrame.new(0, 3, 0) + TargetHumanoid.MoveDirection * BasePart.Velocity.Magnitude / 2,CFrame.Angles(0, 0, math.rad(Angle)))
                            NWait(0)
                            ForcePosition(BasePart,CFrame.new(0, -3, 0) + TargetHumanoid.MoveDirection * BasePart.Velocity.Magnitude / 2,CFrame.Angles(0, 0, math.rad(Angle)))
                            NWait(0)
                            ForcePosition(BasePart,CFrame.new(0, 3, 0) + TargetHumanoid.MoveDirection * BasePart.Velocity.Magnitude / 2,CFrame.Angles(0, 0, math.rad(Angle)))
                            NWait(0)
                            ForcePosition(BasePart,CFrame.new(0, -3, 0) + TargetHumanoid.MoveDirection * BasePart.Velocity.Magnitude / 2,CFrame.Angles(0, 0, math.rad(Angle)))
                            NWait(0)
                            ForcePosition(BasePart,CFrame.new(0, 3, 0) + TargetHumanoid.MoveDirection,CFrame.Angles(0, 0, math.rad(Angle)))
                            NWait(0)
                            ForcePosition(BasePart,CFrame.new(0, -3, 0) + TargetHumanoid.MoveDirection,CFrame.Angles(0, 0, math.rad(Angle)))
                            NWait(0)
                        else
                            break
                        end
                    until BasePart.Velocity.Magnitude > 1000 or BasePart.Parent ~= TargetCharacter or Humanoid.Health <= 0 or
                        tick() > Time + FlingTime
                end
                workspace.FallenPartsDestroyHeight = 0 / 0
                Humanoid:SetStateEnabled("Seated", false)
                if Character:FindFirstChild("Animate") then
                    Character:FindFirstChild("Animate").Disabled = true
                end
                for i,v in pairs(Character:GetChildren()) do
                    if v:IsA("BasePart") then
                       local B = Instance.new("BodyVelocity")
                       B.Parent = v
                       B.Velocity = Vector3.new(10e10, 10e10, 10e10)
                       B.MaxForce = Vector3.new(1/0, 1/0, 1/0)
                 
                       local BT = Instance.new("BodyThrust")
                       BT.Parent = v
                       BT.Force = Vector3.new(10e10, 10e10, 10e10)
                 
                       local BF = Instance.new("BodyForce")
                       BF.Parent = v
                       BF.Force = Vector3.new(10e10, 10e10, 10e10)
                    end
                end
                if TargetCharacter and TargetRoot then
                    ForceBasePart(TargetRoot)
                else
                    ForceBasePart(TargetHead)
                end
    
                for i,v in pairs(Character:GetDescendants()) do
                    if v:IsA("BodyVelocity") or v:IsA("BodyThrust") or v:IsA("BodyForce") then
                        v:Destroy()
                    end
                end
    
                NWait()
                Humanoid:ChangeState("GettingUp")
                Humanoid:SetStateEnabled("Seated", true)
                workspace.CurrentCamera.CameraSubject = Character
                workspace.FallenPartsDestroyHeight = OldFPDH
                if Character:FindFirstChild("Animate") then
                    Character:FindFirstChild("Animate").Disabled = false
                end
                for i = 1,50 do
                    for i, v in pairs(Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.Velocity, v.RotVelocity, v.AssemblyAngularVelocity, v.AssemblyLinearVelocity =
                            Vector3.new(),
                            Vector3.new(),
                            Vector3.new(),
                            Vector3.new()
                        end
                    end
                end
                for i = 1,10 do
                    Character:SetPrimaryPartCFrame(OldPos)
                end
            end
        end

        Fling(target)
    end
end)

--[[ Wtf this is so complicated for a simple refresh script LMAO

addcmd("re", function()
    replacechar()
    p.Character:FindFirstChild("Humanoid").BreakJointsOnDeath = false
    p.Character:FindFirstChild("Humanoid").RequiresNeck = false
    task.wait(game:GetService("Players").RespawnTime - 0.05)
    p.Character:FindFirstChild("HumanoidRootPart").Anchored = true
    local old = p.Character:FindFirstChild("HumanoidRootPart").CFrame
    p.Character:FindFirstChild("Humanoid").BreakJointsOnDeath = false
    p.Character:FindFirstChild("Humanoid").RequiresNeck = false
    p.Character:FindFirstChild("Neck", true):Destroy()
    p.CharacterAdded:Wait()
    p.Character:WaitForChild("HumanoidRootPart").CFrame = old
end)
]]

addcmd("re",function()
    replacechar()
    p.Character:FindFirstChild("Humanoid").BreakJointsOnDeath = false
    task.wait(game:GetService("Players").RespawnTime - 0.05)
    local Old = p.Character:FindFirstChild("HumanoidRootPart").CFrame
    p.Character:Destroy()
	p.CharacterAdded:Wait()
	p.Character:WaitForChild("ForceField"):Destroy()
	p.Character:SetPrimaryPartCFrame(Old)	
end)

addcmd("dupe", function()
	local UI = Instance.new("ScreenGui",game.CoreGui)
	local DupeTab = Instance.new("Frame")
    local ShadowColor = Instance.new("ImageLabel")
	local BottomProgressBar = Instance.new("TextLabel")
	local BottomProgressBar_Roundify_12px = Instance.new("ImageLabel")
	local TopProgressBar = Instance.new("TextLabel")
	local BottomProgressBar_Roundify_12px_2 = Instance.new("ImageLabel")
	local EstimatedRemainingTime = Instance.new("TextLabel")
	
	DupeTab.Name = "DupeTab"
	DupeTab.Parent = UI
	DupeTab.BackgroundColor3 = Color3.fromRGB(73, 71, 191)
	DupeTab.BorderSizePixel = 0
	DupeTab.Position = UDim2.new(0.75, 0, 0.5, 0)
	DupeTab.Size = UDim2.new(0, 445, 0, 90)
	DupeTab.Visible = true
	
    ShadowColor.Name = "Shadow"
    ShadowColor.Parent = DupeTab
    ShadowColor.AnchorPoint = Vector2.new(0.5, 0.5)
    ShadowColor.BackgroundTransparency = 1.000
    ShadowColor.BorderSizePixel = 0
    ShadowColor.Position = UDim2.new(0.5, 0, 0.467741936, 0)
    ShadowColor.Size = UDim2.new(1, 60, 1.06451619, 60)
    ShadowColor.ZIndex = 0
    ShadowColor.Image = "rbxassetid://6014261993"
    ShadowColor.ImageColor3 = Color3.fromRGB(107, 96, 255)
    ShadowColor.ImageTransparency = 0.600
    ShadowColor.ScaleType = Enum.ScaleType.Slice
    ShadowColor.SliceCenter = Rect.new(49, 49, 450, 450)

	BottomProgressBar.Name = "BottomProgressBar"
	BottomProgressBar.Parent = DupeTab
	BottomProgressBar.BackgroundColor3 = Color3.fromRGB(66, 66, 98)
	BottomProgressBar.BackgroundTransparency = 1
	BottomProgressBar.BorderSizePixel = 0
	BottomProgressBar.Position = UDim2.new(0.0404494368, 0, 0.1, 0)
	BottomProgressBar.Size = UDim2.new(0, 409, 0, 48)
	BottomProgressBar.ZIndex = 2
	BottomProgressBar.Font = Enum.Font.SourceSansBold
	BottomProgressBar.Text = ""
	BottomProgressBar.TextSize = 19
	BottomProgressBar.TextWrapped = true
	
	BottomProgressBar_Roundify_12px.Name = "BottomProgressBar_Roundify_12px"
	BottomProgressBar_Roundify_12px.Parent = BottomProgressBar
	BottomProgressBar_Roundify_12px.AnchorPoint = Vector2.new(0.5, 0.5)
	BottomProgressBar_Roundify_12px.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BottomProgressBar_Roundify_12px.BackgroundTransparency = 1
	BottomProgressBar_Roundify_12px.Position = UDim2.new(0.5, 0, 0.5, 0)
	BottomProgressBar_Roundify_12px.Size = UDim2.new(1, 0, 1, 0)
	BottomProgressBar_Roundify_12px.Image = "rbxassetid://3570695787"
	BottomProgressBar_Roundify_12px.ImageColor3 = Color3.fromRGB(66, 66, 98)
	BottomProgressBar_Roundify_12px.ScaleType = Enum.ScaleType.Slice
	BottomProgressBar_Roundify_12px.SliceCenter = Rect.new(100, 100, 100, 100)
	BottomProgressBar_Roundify_12px.SliceScale = 0.120
	
	TopProgressBar.Name = "TopProgressBar"
	TopProgressBar.Parent = DupeTab
	TopProgressBar.BackgroundColor3 = Color3.fromRGB(157, 155, 230)
	TopProgressBar.BackgroundTransparency = 1
	TopProgressBar.BorderSizePixel = 0
	TopProgressBar.Position = UDim2.new(0.0404494368, 0, 0.1, 0)
	TopProgressBar.Size = UDim2.new(0, 0, 0, 48)
	TopProgressBar.ZIndex = 3
	TopProgressBar.Font = Enum.Font.SourceSansBold
	TopProgressBar.Text = ""
	TopProgressBar.TextColor3 = Color3.fromRGB(100, 100, 100)
	TopProgressBar.TextSize = 19
	TopProgressBar.TextWrapped = true
	
	BottomProgressBar_Roundify_12px_2.Name = "BottomProgressBar_Roundify_12px"
	BottomProgressBar_Roundify_12px_2.Parent = TopProgressBar
	BottomProgressBar_Roundify_12px_2.AnchorPoint = Vector2.new(0.5, 0.5)
	BottomProgressBar_Roundify_12px_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BottomProgressBar_Roundify_12px_2.BackgroundTransparency = 1
	BottomProgressBar_Roundify_12px_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	BottomProgressBar_Roundify_12px_2.Size = UDim2.new(1, 0, 1, 0)
	BottomProgressBar_Roundify_12px_2.Image = "rbxassetid://3570695787"
	BottomProgressBar_Roundify_12px_2.ImageColor3 = Color3.fromRGB(157, 155, 200)
	BottomProgressBar_Roundify_12px_2.ScaleType = Enum.ScaleType.Slice
	BottomProgressBar_Roundify_12px_2.SliceCenter = Rect.new(100, 100, 100, 100)
	BottomProgressBar_Roundify_12px_2.SliceScale = 0.120
	
	EstimatedRemainingTime.Name = "EstimatedRemainingTime"
	EstimatedRemainingTime.Parent = DupeTab
	EstimatedRemainingTime.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	EstimatedRemainingTime.BackgroundTransparency = 1
	EstimatedRemainingTime.Position = UDim2.new(0.274157315, 0, 0.5, 0)
	EstimatedRemainingTime.Size = UDim2.new(0, 200, 0, 50)
	EstimatedRemainingTime.Font = Enum.Font.SourceSansBold
	EstimatedRemainingTime.Text = "Estimated Remaining Time: nil"
	EstimatedRemainingTime.TextColor3 = Color3.fromRGB(157, 155, 255)
	EstimatedRemainingTime.TextSize = 25
	
	local function Dragify(frame)
		local UserInputService = game:GetService('UserInputService')
		local gui = frame
		local dragging
		local dragInput
		local dragStart
		local startPos
	
		local function update(input)
			local delta = input.Position - dragStart
			gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
		gui.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = gui.Position
	
				pcall(function()
					if Taskbar.Parent ~= Main then
						Main.ClipsDescendants = false
						Taskbar.Parent = Main
						Taskbar.Position = UDim2.new(-0.247, 0,0, 0)
						Taskbar.Size = UDim2.new(0, 111,0, 345)
					end
				end)
	
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
	
						pcall(function()
							if Taskbar.Parent ~= AudioHub then
								local ABsoulutePostiion = UDim2.new(0, Taskbar.AbsolutePosition.X, 0, Taskbar.AbsolutePosition.Y)
								local AbsoluteSize = UDim2.new(0, Taskbar.AbsoluteSize.X, 0, Taskbar.AbsoluteSize.Y)
								Taskbar.Parent = AudioHub
								Main.ClipsDescendants = true
								Taskbar.Position = ABsoulutePostiion
								Taskbar.Size = AbsoluteSize
							end
						end)
	
					end
				end)
			end
		end)
	
		gui.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
	
		UserInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)
	end
	
	Dragify(DupeTab)
	
	local Player = game.Players.LocalPlayer
	local DupeA = tonumber(args[2])
	local Duping = false
	
	if not tonumber(DupeA) then
        -- Not adding any noti libs noob
        game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Information",Text = "Please put a valid number"})
	else
		if tonumber(DupeA) > 0 then
			DupeA = tonumber(DupeA)
		else
            game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Information",Text = "Please put a number above 0"})
		end
	end
	
	local function Calculate(Seconds)
		local SS = Seconds % 60
		local MM = (Seconds - SS) / 60
		return MM..":"..(10 > SS and "0"..SS or SS)
	end
	
	if DupeA > 0 then
		if Duping then return end
		Duping = true
		local Tools = {}
		local estimated = 0
		estimated = (game:GetService("Players").RespawnTime * DupeA)
		estimated = estimated + (0.7 * DupeA)
	
		local ss = TopProgressBar.Size
		local sp = TopProgressBar.Position
		local t = game:GetService("TweenService"):Create(TopProgressBar, TweenInfo.new(estimated, Enum.EasingStyle.Linear), {
			Size = BottomProgressBar.Size,
			Position = BottomProgressBar.Position
		}):Play()
		task.spawn(function()
			task.wait(estimated)
			game:GetService("TweenService"):Create(TopProgressBar, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
				Size = ss,
				Position = sp
			}):Play()
			EstimatedRemainingTime.Text = "Estimated Remaining Time: nil"
		end)
	
		task.spawn(function()
			for i =1, math.round(estimated) do
				task.wait(1)
				EstimatedRemainingTime.Text = "Estimated Remaining Time: " .. tostring(Calculate(math.round(estimated) - i))
			end
		end)
		local pos = Player.Character.HumanoidRootPart.CFrame
		for i = 1, DupeA do
			Player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Player.Character:WaitForChild("HumanoidRootPart").Position.X, 50000000, Player.Character:WaitForChild("HumanoidRootPart").Position.Z)
			task.wait(0.5)
			Player.Character:WaitForChild("Humanoid"):UnequipTools()
			for i,v in pairs(Player.Backpack:GetChildren()) do
				if v:IsA("Tool") then
					table.insert(Tools, v)
					v.Parent = Player.Character
					game:GetService("RunService").Heartbeat:wait()
					v.Parent = workspace
					game:GetService("RunService").Heartbeat:wait()
					task.spawn(function()
						task.wait(.3)
						v.Handle.Anchored = true
					end)
				end
			end
			Player.Character:BreakJoints()
			Player.CharacterAdded:wait()
		end
		Player.Character:WaitForChild("HumanoidRootPart").CFrame = pos
		for i,v in pairs(Tools) do
			if v.Parent == workspace then
				v.Handle.Anchored = false
				Player.Character:WaitForChild("Humanoid"):EquipTool(v)
			end
		end
		Duping = false
		UI:Destroy()
	else
        game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Information",Text = "Failed to dupe or you inputted a number below 0 lol"})
	end
end)

--[[ ooooooooooooooo boy check the bottom for a better version of these scripts smh

addcmd("punish", function()
    if type(target) == "table" then
        local old = p.Character:FindFirstChild("HumanoidRootPart").CFrame
        local fpdh = game:GetService("Workspace").FallenPartsDestroyHeight
        game:GetService("Workspace").FallenPartsDestroyHeight = 0/0
        for i,target in pairs(target) do
            if target.Character:FindFirstChild("HumanoidRootPart") and target.Character:FindFirstChild("HumanoidRootPart") then
                local attachtool = p.Character:FindFirstChildWhichIsA("Tool") or p.Backpack:FindFirstChildWhichIsA("Tool")
                attachtool.Parent = p.Backpack
                replacehum()
                attachtool.Parent = p.Character
                p.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(Vector3.new(-100000, 1000000000000000000000, -100000))
                attachtool:FindFirstChild("Handle").ChildAdded:Wait()
                if syn then
                    firetouchinterest(target.Character:FindFirstChild("HumanoidRootPart"),attachtool:FindFirstChild("Handle"),0)
                    firetouchinterest(target.Character:FindFirstChild("HumanoidRootPart"),attachtool:FindFirstChild("Handle"),1)
                    repeat task.wait() until attachtool.Parent == target.Character or target.Character:FindFirstChild("Humanoid").Health == 0 or target.Character.Parent ~= game:GetService("Workspace")
                else
                    repeat
                        target.Character:FindFirstChild("HumanoidRootPart").CFrame = attachtool:FindFirstChild("Handle").CFrame
                        game:GetService("RunService").Heartbeat:Wait()
                    until attachtool.Parent == target.Character or target.Character:FindFirstChild("Humanoid").Health == 0 or target.Character.Parent ~= game:GetService("Workspace")
                end
                breakvel(p.Character:FindFirstChild("HumanoidRootPart"))
            end
            p.Character:FindFirstChild("HumanoidRootPart").CFrame = old
            superwait()
            p.Character:FindFirstChild("HumanoidRootPart").CFrame = old
            game:GetService("Workspace").FallenPartsDestroyHeight = fpdh
        end
    else
        local old = p.Character:FindFirstChild("HumanoidRootPart").CFrame
        local fpdh = game:GetService("Workspace").FallenPartsDestroyHeight
        game:GetService("Workspace").FallenPartsDestroyHeight = 0/0
        local attachtool = p.Character:FindFirstChildWhichIsA("Tool") or p.Backpack:FindFirstChildWhichIsA("Tool")
        attachtool.Parent = p.Backpack
        replacehum()
        attachtool.Parent = p.Character
        attachtool:FindFirstChild("Handle").ChildAdded:Wait()
        if syn then
            firetouchinterest(target.Character:FindFirstChild("HumanoidRootPart"),attachtool:FindFirstChild("Handle"),0)
            firetouchinterest(target.Character:FindFirstChild("HumanoidRootPart"),attachtool:FindFirstChild("Handle"),1)
            repeat task.wait() until attachtool.Parent == target.Character or target.Character:FindFirstChild("Humanoid").Health == 0 or target.Character.Parent ~= game:GetService("Workspace")
        else
            repeat
                target.Character:FindFirstChild("HumanoidRootPart").CFrame = attachtool:FindFirstChild("Handle").CFrame
                game:GetService("RunService").Heartbeat:Wait()
            until attachtool.Parent == target.Character or target.Character:FindFirstChild("Humanoid").Health == 0 or target.Character.Parent ~= game:GetService("Workspace")
        end
        p.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(Vector3.new(-100000, 1000000000000000000000, -100000))
        task.wait(0.5)
        destroyrg()
        p.Character:WaitForChild("HumanoidRootPart")
        breakvel(p.Character:FindFirstChild("HumanoidRootPart"))
        p.Character:FindFirstChild("HumanoidRootPart").CFrame = old
        game:GetService("Workspace").FallenPartsDestroyHeight = fpdh
    end
end)

addcmd("void", function()
    if type(target) == "table" then
        local old = p.Character:FindFirstChild("HumanoidRootPart").CFrame
        local fpdh = game:GetService("Workspace").FallenPartsDestroyHeight
        game:GetService("Workspace").FallenPartsDestroyHeight = 0/0
        for i,target in pairs(target) do
            if target.Character:FindFirstChild("HumanoidRootPart") and target.Character:FindFirstChild("HumanoidRootPart") then
                local attachtool = p.Character:FindFirstChildWhichIsA("Tool") or p.Backpack:FindFirstChildWhichIsA("Tool")
                attachtool.Parent = p.Backpack
                replacehum()
                attachtool.Parent = p.Character
                p.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(math.huge,math.huge,math.huge)
                attachtool:FindFirstChild("Handle").ChildAdded:Wait()
                if syn then
                    firetouchinterest(target.Character:FindFirstChild("HumanoidRootPart"),attachtool:FindFirstChild("Handle"),0)
                    firetouchinterest(target.Character:FindFirstChild("HumanoidRootPart"),attachtool:FindFirstChild("Handle"),1)
                    repeat task.wait() until attachtool.Parent == target.Character or target.Character:FindFirstChild("Humanoid").Health == 0 or target.Character.Parent ~= game:GetService("Workspace")
                else
                    repeat
                        target.Character:FindFirstChild("HumanoidRootPart").CFrame = attachtool:FindFirstChild("Handle").CFrame
                        game:GetService("RunService").Heartbeat:Wait()
                    until attachtool.Parent == target.Character or target.Character:FindFirstChild("Humanoid").Health == 0 or target.Character.Parent ~= game:GetService("Workspace")
                end
                breakvel(p.Character:FindFirstChild("HumanoidRootPart"))
            end
            p.Character:FindFirstChild("HumanoidRootPart").CFrame = old
            superwait()
            p.Character:FindFirstChild("HumanoidRootPart").CFrame = old
            game:GetService("Workspace").FallenPartsDestroyHeight = fpdh
        end
    else
        local old = p.Character:FindFirstChild("HumanoidRootPart").CFrame
        local fpdh = game:GetService("Workspace").FallenPartsDestroyHeight
        local fw
        game:GetService("Workspace").FallenPartsDestroyHeight = 0/0
        p.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,-10e30,0)
        local attachtool = p.Character:FindFirstChildWhichIsA("Tool") or p.Backpack:FindFirstChildWhichIsA("Tool")
        attachtool.Parent = p.Backpack
        replacehum()
        attachtool.Parent = p.Character
        wait()
        if syn then
            firetouchinterest(target.Character:FindFirstChild("HumanoidRootPart"),attachtool:FindFirstChild("Handle"),0)
            firetouchinterest(target.Character:FindFirstChild("HumanoidRootPart"),attachtool:FindFirstChild("Handle"),1)
        else
            repeat
                target.Character:FindFirstChild("HumanoidRootPart").CFrame = attachtool:FindFirstChild("Handle").CFrame
                game:GetService("RunService").Heartbeat:Wait()
            until attachtool.Parent == target.Character or target.Character:FindFirstChild("Humanoid").Health == 0 or target.Character.Parent ~= game:GetService("Workspace")
        end
        task.wait(0.5)
        game:GetService("Workspace").FallenPartsDestroyHeight = fpdh
    end
end)]]

--[[Tf
addcmd("kick", function()
    local old = p.Character:FindFirstChild("HumanoidRootPart").CFrame
    local fpdh = game:GetService("Workspace").FallenPartsDestroyHeight
    game:GetService("Workspace").FallenPartsDestroyHeight = 0/0
    if target.Character:FindFirstChild("HumanoidRootPart") and not target.Character:FindFirstChild("HumanoidRootPart"):IsGrounded() then
        local fling = true
        coroutine.wrap(function()
            while fling do
                for i,v in pairs(p.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
                game:GetService("RunService").Stepped:Wait()
            end
        end)()
        local tp = true
        local flinging = true
        coroutine.wrap(function()
            while tp do
                p.Character:FindFirstChild("HumanoidRootPart").CFrame = target.Character:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0,-10,0) + target.Character:FindFirstChild("HumanoidRootPart").Velocity / 1.75
                p.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,10e5,0)
                game:GetService("RunService").Heartbeat:Wait()
                p.Character:FindFirstChild("HumanoidRootPart").CFrame = target.Character:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0,10,0) + target.Character:FindFirstChild("HumanoidRootPart").Velocity / 1.75
                p.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,10e5,0)
                game:GetService("RunService").Heartbeat:Wait()
            end
        end)()
        coroutine.wrap(function()
            wait(0.5)
            flinging = false
        end)()
        repeat task.wait() until target.Character:FindFirstChild("HumanoidRootPart").Velocity.Y > 100 or not flinging
        tp = false
        fling = false
        breakvel(p.Character:FindFirstChild("HumanoidRootPart"))
        p.Character:FindFirstChild("HumanoidRootPart").CFrame = old
    end
    local kicktp = true
    coroutine.wrap(function()
        while kicktp do
            for i,v in pairs(p.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Velocity = Vector3.new()
                    v.RotVelocity = Vector3.new()
                end
            end
            p.Character:FindFirstChild("HumanoidRootPart").CFrame = target.Character:FindFirstChild("HumanoidRootPart").CFrame
            task.wait()
        end
    end)()
    task.wait(2)
    kicktp = false
    local c = p.Character
    for i,v in pairs(c:GetDescendants()) do
        if v:IsA("BaseWrap") and v.Parent.Name == "Handle" then
            v.Parent.Parent:Destroy()
        end
    end
    for i,v in pairs(c:GetDescendants()) do
        if v:IsA("Motor") and v.Name ~= "Neck" then
            local par = v.Parent
            v:Destroy()
            par.CFrame = CFrame.new(10e11*i,1000,10e11*i)
            par.Velocity = Vector3.new(1e36*i,1000,1e36*i)
           task.wait()
        end
    end
    p.CharacterAdded:Wait()
    p.Character:WaitForChild("HumanoidRootPart")
    breakvel(p.Character:FindFirstChild("HumanoidRootPart"))
    p.Character:FindFirstChild("HumanoidRootPart").CFrame = old
    game:GetService("Workspace").FallenPartsDestroyHeight = fpdh
end)

addcmd("tkick", function()
    local old = p.Character:FindFirstChild("HumanoidRootPart").CFrame
    local fpdh = game:GetService("Workspace").FallenPartsDestroyHeight
    local tkickcf = CFrame.new(old.Position.X+1000000,old.Position.Y+100000,old.Position.Z+1000000)
    replacechar()
    task.wait(players.RespawnTime - 0.5)
    game:GetService("Workspace").FallenPartsDestroyHeight = 0/0
    local attachtool = p.Character:FindFirstChildWhichIsA("Tool") or p.Backpack:FindFirstChildWhichIsA("Tool")
    attachtool.Parent = p.Backpack
    replacehum()
    attachtool.Parent = p.Character
    attachtool:FindFirstChild("Handle").ChildAdded:Wait()
    if syn then
        firetouchinterest(target.Character:FindFirstChild("HumanoidRootPart"),attachtool:FindFirstChild("Handle"),0)
        firetouchinterest(target.Character:FindFirstChild("HumanoidRootPart"),attachtool:FindFirstChild("Handle"),1)
        repeat task.wait() until attachtool.Parent == target.Character or target.Character:FindFirstChild("Humanoid").Health == 0 or target.Character.Parent ~= game:GetService("Workspace")
    else
        repeat
            target.Character:FindFirstChild("HumanoidRootPart").CFrame = attachtool:FindFirstChild("Handle").CFrame
            game:GetService("RunService").Heartbeat:Wait()
        until attachtool.Parent == target.Character or target.Character:FindFirstChild("Humanoid").Health == 0 or target.Character.Parent ~= game:GetService("Workspace")
    end
    p.Character:FindFirstChild("HumanoidRootPart").CFrame = tkickcf
    p.CharacterAdded:Wait()
    local c = p.Character
    local function findbasewrap()
        for i,v in pairs(c:GetDescendants()) do
            if v:IsA("BaseWrap") and v.Parent.Name == "Handle" then
                return true
            end
        end
    end
    repeat task.wait() until findbasewrap()
    task.wait(0.3)
    local tkicktp = true
    coroutine.wrap(function()
        while tkicktp do
            p.Character:FindFirstChild("HumanoidRootPart").CFrame = tkickcf
            task.wait()
        end
    end)()
    task.wait(0.5)
    tkicktp = false
    for i,v in pairs(c:GetDescendants()) do
        if v:IsA("BaseWrap") and v.Parent.Name == "Handle" then
            v.Parent.Parent:Destroy()
        end
    end
    for i,v in pairs(c:GetDescendants()) do
        if v:IsA("Motor") and v.Name ~= "Neck" then
            local par = v.Parent
            v:Destroy()
            par.CFrame = CFrame.new(old.Position.X+10e11,old.Position.Y+1000,old.Position.Z+10e11)
            par.Velocity = Vector3.new(10e11*i,1000,10e11*i)
           task.wait()
        end
    end
    task.wait(1)
    if c.Humanoid:FindFirstChild("BodyTypeScale") then
        c.Humanoid.BodyTypeScale:Remove()
        elseif c.Humanoid:FindFirstChild("BodyWidthScale") then
        c.Humanoid.BodyWidthScale:Remove()
        elseif c.Humanoid:FindFirstChild("BodyHeightScale") then
        c.Humanoid.BodyHeightScale:Remove()
        elseif c.Humanoid:FindFirstChild("BodyDepthScale") then
        c.Humanoid.BodyDepthScale:Remove()
        elseif c.Humanoid:FindFirstChild("HeadScale") then
        c.Humanoid.HeadScale:Remove()
    end
    breakvel(p.Character:FindFirstChild("HumanoidRootPart"))
    p.Character:FindFirstChild("HumanoidRootPart").CFrame = old
    game:GetService("Workspace").FallenPartsDestroyHeight = fpdh
end)
]]

--[[ no comment
addcmd("crash", function()
    local c = p.Character
    for i,v in pairs(c:GetDescendants()) do
        if v:IsA("BaseWrap") and v.Parent.Name == "Handle" then
            v.Parent.Parent:Destroy()
        end
    end
    for i,v in pairs(c:GetDescendants()) do
        if v:IsA("Motor") and v.Name ~= "Neck" then
            local par = v.Parent
            v:Destroy()
            par.CFrame = CFrame.new(10e11*i,1000,10e11*i)
            par.Velocity = Vector3.new(1e36*i,1000,1e36*i)
           task.wait()
        end
    end
end)
]]

local view
local viewing
addcmd("view", function()
    viewing = true
    if ws.CurrentCamera.CameraSubject:IsDescendantOf(ws) then
        view = ws.CurrentCamera.CameraSubject
    else
        view = p.Character:FindFirstChild("Humanoid")
    end
    ws.CurrentCamera.CameraSubject = target.Character:FindFirstChild("Humanoid")
    coroutine.wrap(function()
        while viewing do
            ws.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Wait()
            if not target.Character and not target.Character:FindFirstChild("Humanoid") then
                repeat task.wait() until target.Character and target.Character:FindFirstChild("Humanoid")
            end
            ws.CurrentCamera.CameraSubject = target.Character:FindFirstChild("Humanoid")
        end
    end)()
end)
addcmd("unview", function()
    viewing = false
    ws.CurrentCamera.CameraSubject = view or p.Character:FindFirstChild("Humanoid")
end)
addcmd("fly", function()
    NOFLY()
	sFLY()
    if args[2] and tonumber(args[2]) then
	    flyspeed = tonumber(args[2])
    end
end)
addcmd("flyspeed", function()
    local speed = args[2] or 1
	if tonumber(speed) then
		flyspeed = tonumber(speed)
	end
end)
addcmd("unfly", function()
    NOFLY()
end)

-- more newer cmds

-- This is the script from disabilties github called "Leg Resize" that he claims to be his and he had the audacity to obfuscate it although it has been around way before he even posted it LOLLLLLLLLLL! :troll:
-- full source because im better right
-- originally made by me and includes reweld for hats
local Leg = function()
    p.Character.Humanoid.Sit = false
    p.Character.Humanoid:SetStateEnabled("Seated", false)
    local function Remove()
        for i,v in pairs(p.Character:GetDescendants()) do 
            if v:IsA("MeshPart") or v:IsA("BasePart") and v.Name ~= "Head" then 
                v:WaitForChild("OriginalSize"):Destroy()
            end
        end
    end
    p.Character.LeftLowerLeg.LeftKneeRigAttachment.OriginalPosition:Destroy()
    p.Character.LeftUpperLeg.LeftKneeRigAttachment.OriginalPosition:Destroy()
    p.Character.LeftLowerLeg:WaitForChild "LeftKneeRigAttachment":Destroy()
    p.Character.LeftUpperLeg:WaitForChild "LeftKneeRigAttachment":Destroy()
    for i, v in pairs(p.Character:GetChildren()) do
        if v:IsA("Accessory") then
            sethiddenproperty(v, "BackendAccoutrementState", 0)
            for i, v in pairs(v.Handle:GetChildren()) do
                if v:IsA("Attachment") then
                    v:remove()
                end
            end
        end
    end
    p.Character["Body Colors"]:Destroy()
    for i, v in next, p.Character.Humanoid:GetChildren() do
        if v:IsA "NumberValue" then
            Remove()
            v:Destroy()
        end
    end
end

addcmd("leg",function()
    Leg()
end)

-- thought it needed one
addcmd("kill",function()
    if type(target) == "table" then
        for i,target in pairs(target) do
            p.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
            local Saved = p.Character.HumanoidRootPart.CFrame
            local New = p.Character.Humanoid:Clone()
            New.Parent = p.Character
            p.Character.Humanoid:Destroy()
            local Tool = p.Backpack:FindFirstChildOfClass("Tool")		
            Tool.Parent = p.Character
            firetouchinterest(Tool.Handle, target.Character['Head'],0)
            Tool.AncestryChanged:Wait()
            p.Character.Humanoid.Health = 0
            p.Character = nil
            p.CharacterAdded:Wait()
            if not p.Character.HumanoidRootPart then repeat task.wait() until p.Character.HumanoidRootPart end
            p.Character:SetPrimaryPartCFrame(Saved)
            p:FindFirstChild("ForceField"):Destroy()
        end
    else
        p.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
        local Saved = p.Character.HumanoidRootPart.CFrame
        local New = p.Character.Humanoid:Clone()
        New.Parent = p.Character
        p.Character.Humanoid:Destroy()
        local Tool = p.Backpack:FindFirstChildOfClass("Tool")		
        Tool.Parent = p.Character
        firetouchinterest(Tool.Handle, target.Character['Head'],0)
        Tool.AncestryChanged:Wait()
        p.Character.Humanoid.Health = 0
        p.Character = nil
        p.CharacterAdded:Wait()
        if not p.Character.HumanoidRootPart then repeat task.wait() until p.Character.HumanoidRootPart end
        p.Character:SetPrimaryPartCFrame(Saved)
        p:FindFirstChild("ForceField"):Destroy()
    end
end)

-- renamed the "punish" command to permavoid because its literally what it is
addcmd("permavoid",function()
    if type(target) == "table" then
        for i,target in pairs(target) do
            p.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
            local Saved = p.Character.HumanoidRootPart.CFrame
            local New = p.Character.Humanoid:Clone()
            New.Parent = p.Character
            p.Character.Humanoid:Destroy()
            local Tool = p.Backpack:FindFirstChildOfClass("Tool")		
            Tool.Parent = p.Character
            firetouchinterest(Tool.Handle, target.Character['Head'],0)
            Tool.AncestryChanged:Wait()
            p.Character:SetPrimaryPartCFrame(CFrame.new(-100000, 1000000000000000000000, -100000))
            p.CharacterAdded:Wait()
            if not p.Character.HumanoidRootPart then repeat task.wait() until p.Character.HumanoidRootPart end
            p.Character:SetPrimaryPartCFrame(Saved)
            p:FindFirstChild("ForceField"):Destroy()
        end
    else
        p.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
        local Saved = p.Character.HumanoidRootPart.CFrame
        local New = p.Character.Humanoid:Clone()
        New.Parent = p.Character
        p.Character.Humanoid:Destroy()
        local Tool = p.Backpack:FindFirstChildOfClass("Tool")		
        Tool.Parent = p.Character
        firetouchinterest(Tool.Handle, target.Character['Head'],0)
        Tool.AncestryChanged:Wait()
        p.Character:SetPrimaryPartCFrame(CFrame.new(-100000, 1000000000000000000000, -100000))
        p.CharacterAdded:Wait()
        if not p.Character.HumanoidRootPart then repeat task.wait() until p.Character.HumanoidRootPart end
        p.Character:SetPrimaryPartCFrame(Saved)
        p:FindFirstChild("ForceField"):Destroy()
    end
end)

-- improved void yuessssss
addcmd("void",function()
    if type(target) == "table" then
        for i,target in pairs(target) do
            game.workspace.FallenPartsDestroyHeight = 0/0
            p.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
            local Saved = p.Character.HumanoidRootPart.CFrame
            local New = p.Character.Humanoid:Clone()
            New.Parent = p.Character
            p.Character.Humanoid:Destroy()
            local Tool = p.Backpack:FindFirstChildOfClass("Tool")		
            Tool.Parent = p.Character
            p.Character:SetPrimaryPartCFrame(CFrame.new(-100000, -1000000000000000000000, -100000))
            firetouchinterest(Tool.Handle, target.Character['Head'],0)
            Tool.AncestryChanged:Connect(function(Target)
                if Target then      
                    game.Workspace.FallenPartsDestroyHeight = -500
                end
            end)          
            p.CharacterAdded:Wait()
            if not p.Character.HumanoidRootPart then repeat task.wait() until p.Character.HumanoidRootPart end
            p.Character:SetPrimaryPartCFrame(Saved)
            p:FindFirstChild("ForceField"):Destroy()
            game.Workspace.FallenPartsDestroyHeight = -500
        end
    else
        game.workspace.FallenPartsDestroyHeight = 0/0
        p.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
        local Saved = p.Character.HumanoidRootPart.CFrame
        local New = p.Character.Humanoid:Clone()
        New.Parent = p.Character
        p.Character.Humanoid:Destroy()
        local Tool = p.Backpack:FindFirstChildOfClass("Tool")		
        Tool.Parent = p.Character
        p.Character:SetPrimaryPartCFrame(CFrame.new(-100000, -1000000000000000000000, -100000))
        firetouchinterest(Tool.Handle, target.Character['Head'],0)
        Tool.AncestryChanged:Connect(function(Target)
            if Target then      
                game.Workspace.FallenPartsDestroyHeight = -500
            end
        end)          
        p.CharacterAdded:Wait()
        if not p.Character.HumanoidRootPart then repeat task.wait() until p.Character.HumanoidRootPart end
        p.Character:SetPrimaryPartCFrame(Saved)
        p:FindFirstChild("ForceField"):Destroy()
        game.Workspace.FallenPartsDestroyHeight = -500
    end  
end)



-- Leg rescale variations of those commands
addcmd("lkill",function()
    if type(target) == "table" then
        for i,target in pairs(target) do
            p.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
            local Saved = p.Character.HumanoidRootPart.CFrame
            Leg()
            local New = p.Character.Humanoid:Clone()
            New.Parent = p.Character
            p.Character.Humanoid:Destroy()
            local Tool = p.Backpack:FindFirstChildOfClass("Tool")		
            Tool.Parent = p.Character
            firetouchinterest(Tool.Handle, target.Character['Head'],0)
            Tool.AncestryChanged:Wait()
            p.Character.Humanoid.Health = 0
            p.Character = nil
            p.CharacterAdded:Wait()
            if not p.Character.HumanoidRootPart then repeat task.wait() until p.Character.HumanoidRootPart end
            p.Character:SetPrimaryPartCFrame(Saved)
            p:FindFirstChild("ForceField"):Destroy()
        end
    else
        p.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
        local Saved = p.Character.HumanoidRootPart.CFrame
        Leg()
        local New = p.Character.Humanoid:Clone()
        New.Parent = p.Character
        p.Character.Humanoid:Destroy()
        local Tool = p.Backpack:FindFirstChildOfClass("Tool")		
        Tool.Parent = p.Character
        firetouchinterest(Tool.Handle, target.Character['Head'],0)
        Tool.AncestryChanged:Wait()
        p.Character.Humanoid.Health = 0
        p.Character = nil
        p.CharacterAdded:Wait()
        if not p.Character.HumanoidRootPart then repeat task.wait() until p.Character.HumanoidRootPart end
        p.Character:SetPrimaryPartCFrame(Saved)
        p:FindFirstChild("ForceField"):Destroy()
    end
end)

addcmd("lpermavoid",function()
    if type(target) == "table" then
        for i,target in pairs(target) do
            p.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
            local Saved = p.Character.HumanoidRootPart.CFrame
            Leg()
            local New = p.Character.Humanoid:Clone()
            New.Parent = p.Character
            p.Character.Humanoid:Destroy()
            local Tool = p.Backpack:FindFirstChildOfClass("Tool")		
            Tool.Parent = p.Character
            firetouchinterest(Tool.Handle, target.Character['Head'],0)
            Tool.AncestryChanged:Wait()
            p.Character:SetPrimaryPartCFrame(CFrame.new(-100000, 1000000000000000000000, -100000))
            p.CharacterAdded:Wait()
            if not p.Character.HumanoidRootPart then repeat task.wait() until p.Character.HumanoidRootPart end
            p.Character:SetPrimaryPartCFrame(Saved)
            p:FindFirstChild("ForceField"):Destroy()
        end
    else
        p.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
        local Saved = p.Character.HumanoidRootPart.CFrame
        Leg()
        local New = p.Character.Humanoid:Clone()
        New.Parent = p.Character
        p.Character.Humanoid:Destroy()
        local Tool = p.Backpack:FindFirstChildOfClass("Tool")		
        Tool.Parent = p.Character
        firetouchinterest(Tool.Handle, target.Character['Head'],0)
        Tool.AncestryChanged:Wait()
        p.Character:SetPrimaryPartCFrame(CFrame.new(-100000, 1000000000000000000000, -100000))
        p.CharacterAdded:Wait()
        if not p.Character.HumanoidRootPart then repeat task.wait() until p.Character.HumanoidRootPart end
        p.Character:SetPrimaryPartCFrame(Saved)
        p:FindFirstChild("ForceField"):Destroy()
    end
end)

addcmd("lvoid",function()
    if type(target) == "table" then
        for i,target in pairs(target) do
            game.workspace.FallenPartsDestroyHeight = 0/0
            p.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
            Leg()
            local Saved = p.Character.HumanoidRootPart.CFrame
            local New = p.Character.Humanoid:Clone()
            New.Parent = p.Character
            p.Character.Humanoid:Destroy()
            local Tool = p.Backpack:FindFirstChildOfClass("Tool")		
            Tool.Parent = p.Character
            p.Character:SetPrimaryPartCFrame(CFrame.new(-100000, -1000000000000000000000, -100000))
            firetouchinterest(Tool.Handle, target.Character['Head'],0)
            Tool.AncestryChanged:Connect(function(Target)
                if Target then      
                    game.Workspace.FallenPartsDestroyHeight = -500
                end
            end)          
            p.CharacterAdded:Wait()
            if not p.Character.HumanoidRootPart then repeat task.wait() until p.Character.HumanoidRootPart end
            p.Character:SetPrimaryPartCFrame(Saved)
            p:FindFirstChild("ForceField"):Destroy()
            game.Workspace.FallenPartsDestroyHeight = -500
        end
    else
        game.workspace.FallenPartsDestroyHeight = 0/0
        p.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
        Leg()
        local Saved = p.Character.HumanoidRootPart.CFrame
        local New = p.Character.Humanoid:Clone()
        New.Parent = p.Character
        p.Character.Humanoid:Destroy()
        local Tool = p.Backpack:FindFirstChildOfClass("Tool")		
        Tool.Parent = p.Character
        p.Character:SetPrimaryPartCFrame(CFrame.new(-100000, -1000000000000000000000, -100000))
        firetouchinterest(Tool.Handle, target.Character['Head'],0)
        Tool.AncestryChanged:Connect(function(Target)
            if Target then      
                game.Workspace.FallenPartsDestroyHeight = -500
            end
        end)          
        p.CharacterAdded:Wait()
        if not p.Character.HumanoidRootPart then repeat task.wait() until p.Character.HumanoidRootPart end
        p.Character:SetPrimaryPartCFrame(Saved)
        p:FindFirstChild("ForceField"):Destroy()
        game.Workspace.FallenPartsDestroyHeight = -500
    end  
end)
