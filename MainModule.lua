--// Place this in ReplicatedStorage

--// Find instructions at https://github.com/c5-Studios/codePlus
--// To see what an individual function does, you can scroll down and read the comments!
--// Find legal information at https://github.com/c5-Studios/codePlus/blob/master/LEGAL

--// DO NOT EDIT ANY CODE BELOW WITHOUT FIRST READING LEGAL DOCUMENTATION //--
--// FAILURE TO FOLLOW LEGAL TERMS CAN RESULT IN A TERMINATION OF THE PLACE CONTAINING CODEPLUS //--

local cp = {} --// Don't remove this!

do --// Don't remove this!
	
	function cp:kill(o) --// SERVER // Must kill a player, character, or humanoid
		local hum = o
		if o:IsA("Model") then
			hum = o:FindFirstChildOfClass("Humanoid")
		elseif o:IsA("Player") then
			local char = o.Character or o.CharacterAdded:Wait()
			hum = char:WaitForChild("Humanoid")
		end
		
		hum.Health = 0
	end
	
	function cp:round(n) --// SHARED // Must be a number of some sort
		-- Rounds a number to the nearest whole
		local f = math.floor(n)
		local format = n-f
		
		return (format >= 0.5 and f+1) or f
	end
	
	function cp:get_letter() --// SHARED // No input. Returns a random letter
		local letters = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
		local cap = math.random(1,2) == 1
		
		return (cap == true and string.upper(letters[math.random(1,#letters)])) or letters[math.random(1,#letters)]
	end
	
	function cp:dmg(o,damage) --// SERVER // Must damage a player, character, or humanoid
		local hum = o
		if o:IsA("Model") then
			hum = o:FindFirstChildOfClass("Humanoid")
		elseif o:IsA("Player") then
			local char = o.Character or o.CharacterAdded:Wait()
			hum = char:WaitForChild("Humanoid")
		end
		
		hum:TakeDamage(damage)
	end
	
	function cp:fix_random() --// SHARED // No input. Fixes the math.random() function when it keeps picking the same number
		local seed = os.time() * tick() * math.random(1,10000)
		math.randomseed(seed)
		for i = 1,157 do
			local _ = math.random()
		end
	end
	
	function cp:get_alive(include_npcs) --// SHARED // Returns a table of alive player characters (and npcs under workspace if desired)
		if include_npcs == nil then
			include_npcs = false
		end
		
		local alive = {}
		local function Scan()
			for i,v in pairs(workspace:GetChildren()) do
				local hum = v:FindFirstChildOfClass("Humanoid")
				if hum == nil or hum.Health < 1 then
					--
				else
					if include_npcs == false then
						if game.Players:FindFirstChild(v.Name) ~= nil then
							table.insert(alive,v)
						end
					else
						table.insert(alive,v)
					end
				end
			end
		end
		
		Scan()
		
		return alive, (alive ~= nil and #alive) or 0
	end
	
	function cp:message(message,time,Font,TextSize,color,stroke,strokeColor) --// SHARED // Displays a message on the screen with a given amount of time. Font and TextSize is optional
		local ui = Instance.new("ScreenGui")
		ui.ResetOnSpawn = false
		local text = Instance.new("TextLabel",ui)
		text.Text = message or "Sample Text"
		text.Font = Font or Enum.Font.SourceSansLight
		text.TextSize = TextSize or 34
		text.Size = UDim2.new(1,0,1,0)
		text.BackgroundTransparency = 1
		text.TextColor3 = color or Color3.fromRGB(255,255,255)
		text.TextStrokeColor3 = strokeColor or Color3.fromRGB(0,0,0)
		text.TextStrokeTransparency = stroke or 0.5
		local isLocal = game:GetService("RunService"):IsClient()
		
		if isLocal then
			ui.Parent = game.Players.LocalPlayer.PlayerGui
			game:GetService("Debris"):AddItem(ui,time or 3)
		else
			for i,v in pairs(game.Players:GetChildren()) do
				local ui = ui:Clone()
				ui.Parent = v.PlayerGui
				game:GetService("Debris"):AddItem(ui,time or 3)
			end
			ui:Destroy()
		end
	end
	
	function cp:tele(o,pos) --// SHARED // Must teleport a player, character, or humanoid. Position can be either a Vector or CFrame
		local char = o
		if o:IsA("Humanoid") then
			char = o.Parent
		elseif o:IsA("Player") then
			char = o.Character or o.CharacterAdded:Wait()
		end
		
		local root = char:WaitForChild("HumanoidRootPart")
		pos = (typeof(pos) == "Vector3" and CFrame.new(pos)) or pos
		
		root.CFrame = pos
	end
	
	function cp:connect_remote(remote,func) -- // SHARED // Connects a function to a RemoteEvent or RemoteFunction
		local isLocal = game:GetService("RunService"):IsClient()
		local isFunc = remote:IsA("RemoteFunction")
		
		if isFunc then
			if isLocal then
				remote.OnClientInvoke = func
			else
				remote.OnServerInvoke = func
			end
		else
			if isLocal then
				remote.OnClientEvent:Connect(func)
			else
				remote.OnServerEvent:Connect(func)
			end
		end
	end
	
	function cp:fire_remote(remote,...) -- // SHARED // Fires/Invokes values to a RemoteEvent or RemoteFunction
		local isLocal = game:GetService("RunService"):IsClient()
		local isFunc = remote:IsA("RemoteFunction")
		
		if isFunc then
			if isLocal then
				remote:InvokeServer(...)
			else
				remote:InvokeAllClients(...)
			end
		else
			if isLocal then
				remote:FireServer(...)
			else
				remote:FireAllClients(...)
			end
		end
	end
	
	function cp:get_closest_player(char,include_npcs,max_distance) --// SHARED // Best used for npcs. Finds the closest player character (or NPC, if desired) from the character inputted.
		local c = workspace:GetChildren()
		local clos_dis = max_distance or math.huge
		local clos_char = nil
		local myRoot = char:WaitForChild("HumanoidRootPart").Position
		
		local function calculate(c)
			local root = c:FindFirstChild("HumanoidRootPart")
			local dis = (myRoot - root.Position).Magnitude
			
			if dis <= clos_dis then
				clos_char = c
				clos_dis = dis
			end
			
			return
		end
		
		for i,v in pairs(c) do
			if include_npcs then
				if c:FindFirstChildOfClass("Humanoid") then
					calculate(v)
				end
			else
				if game.Players:FindFirstChild(c.Name) then
					calculate(v)
				end
			end
		end
		
		return close_char,close_dis
	end
	
end --// Don't remove this!

return cp --// Don't remove this!
