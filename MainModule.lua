--// Place this in ReplicatedStorage

--// Find instructions at https://github.com/c5-Studios/codePlus
--// To see what an individual function does, you can scroll down and read the comments!
--// Find legal information at https://github.com/c5-Studios/codePlus/blob/master/LEGAL

--// DO NOT EDIT ANY CODE BELOW WITHOUT FIRST READING LEGAL DOCUMENTATION //--
--// FAILURE TO FOLLOW LEGAL TERMS CAN RESULT IN A TERMINATION OF THE PLACE CONTAINING CODEPLUS //--


local codePlusModule

do -- Find all functions here
	local cp = {}
	
	
	--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
	
	cp.kill = function(o) --// SERVER // Must kill a player, character, or humanoid
		local hum = o
		if o:IsA("Model") then
			hum = o:FindFirstChildOfClass("Humanoid")
		elseif o:IsA("Player") then
			local char = o.Character or o.CharacterAdded:Wait()
			local hum = char:WaitForChild("Humanoid")
		end
		
		hum.Health = 0
	end
	
	cp.round = function(n) --// SHARED // Must be a number of some sort
		-- Rounds a number to the nearest whole
		local f = math.floor(n)
		local format = n-f
		
		return (format >= 0.5 and f+1) or f
	end
	
	cp.letter = function() --// SHARED // No input. Returns a random letter
		local letters = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
		local cap = math.random(1,2) == 1
		
		return (cap == true and string.upper(letters[math.random(1,#letters)])) or letters[math.random(1,#letters)]
	end
	
	cp.dmg = function(o,damage) --// SERVER // Must damage a player, character, or humanoid
		local hum = o
		if o:IsA("Model") then
			hum = o:FindFirstChildOfClass("Humanoid")
		elseif o:IsA("Player") then
			local char = o.Character or o.CharacterAdded:Wait()
			local hum = char:WaitForChild("Humanoid")
		end
		
		hum:TakeDamage(damage)
	end
	
	cp.fix_random = function() --// SHARED // No input. Fixes the math.random() function when it keeps picking the same number
		local seed = os.time() * tick() * math.random(1,10000)
		math.randomseed(seed)
		for i = 1,157 do
			local _ = math.random()
		end
	end
	
	cp.get_alive = function(include_npcs) --// SHARED // Returns a table of alive player characters (and npcs under workspace if desired)
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
	
	cp.set_screen_text = function(message,time,Font,TextSize) --// SHARED // Displays a message on the screen with a given amount of time. Font and TextSize is optional
		local ui = Instance.new("ScreenGui")
		ui.ResetOnSpawn = false
		game:GetService("Debris"):AddItem(ui,time)
	end
	
	--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
	
	
	codePlusModule = cp
end

return codePlusModule
