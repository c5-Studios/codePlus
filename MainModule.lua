--// Place this in ReplicatedStorage

--// Find instructions at https://github.com/c5-Studios/codePlus
--// 
--// Find legal information at https://github.com/c5-Studios/codePlus/blob/master/LEGAL

--// DO NOT EDIT ANY CODE BELOW WITHOUT FIRST READING LEGAL DOCUMENTATION //--
--// FAILURE TO FOLLOW LEGAL TERMS CAN RESULT IN A TERMINATION OF THE PLACE CONTAINING CODEPLUS //--


local codePlusModule

do -- Find all functions here
	local cp = {}
	
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
		local f = math.ceil(n)
		local format = n-f
		
		return (format >= 0.5 and f+1) or f
	end
	
	codePlusModule = cp
end

return codePlusModule
