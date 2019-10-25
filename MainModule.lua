--// Place this in ReplicatedStorage

--// Find instructions at https://github.com/c5-Studios/codePlus
--// To see what an individual function does, you can scroll down and read the comments!
--// Find legal information at https://github.com/c5-Studios/codePlus/blob/master/LEGAL

--// DO NOT EDIT ANY CODE BELOW WITHOUT FIRST READING LEGAL DOCUMENTATION //--
--// FAILURE TO FOLLOW LEGAL TERMS CAN RESULT IN A TERMINATION OF THE PLACE CONTAINING CODEPLUS //--


return { -- Don't remove this
	
	function cp:kill(o) --// SERVER // Must kill a player, character, or humanoid
		local hum = o
		if o:IsA("Model") then
			hum = o:FindFirstChildOfClass("Humanoid")
		elseif o:IsA("Player") then
			local char = o.Character or o.CharacterAdded:Wait()
			local hum = char:WaitForChild("Humanoid")
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
			local hum = char:WaitForChild("Humanoid")
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
		for i,v in pairs(workspace:GetChildren()) do
			local hum = v:FindFirstChildOfClass("Humanoid")
			if hum == nil or hum.Health < 1 then
				return
			end
			if include_npcs == false and game.Players:FindFirstChild(v.Name) == nil then
				return
			end
			
			table.insert(alive,v)
		end
	end
	
	function cp:set_screen_text(message,time,Font,TextSize) --// SHARED // Displays a message on the screen with a given amount of time. Font and TextSize is optional
		local ui = Instance.new("ScreenGui")
		ui.ResetOnSpawn = false
		local text = Instance.new("TextLabel",ui)
		text.Text = message or "Sample Text"
		text.Font = Font or Enum.Font.SourceSansLight
		text.TextSize = TextSize or 24
		text.Size = Udim2.new(1,0,1,0)
		text.BackgroundTransparency = 1
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
			o.Character or o.CharacterAdded:Wait()
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
	
} -- Don't remove this
