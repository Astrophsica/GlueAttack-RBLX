local Fenner = game.Workspace.Fenner
local spawnLocations = Fenner.Spawn
local NPCStorage = game.ServerStorage.NPC
local NPCLoadModule = game.ServerScriptService.Modules.NPC.LoadModule
local chatService = game:GetService("Chat")


function spawnNPC(NPC, spawnSpot, Parent, health, speed)
	local NPC = NPC:Clone()
	
	local NPCHumanoid = NPC:WaitForChild("Humanoid")
	NPCHumanoid.MaxHealth = health
	NPCHumanoid.Health = health
	NPCHumanoid.WalkSpeed = speed
	
	NPC:SetPrimaryPartCFrame(spawnSpot.CFrame)
	NPC.Parent = Parent
	local NPCModule = NPCLoadModule:Clone()
	NPCModule.Parent = NPCHumanoid
	NPCModule.Disabled = false
	
	return NPC
end

function resetHealth()
	for _, player in pairs(game.Players:GetChildren())do
		player.Character:WaitForChild("Humanoid").Health = player.Character.Humanoid.MaxHealth
	end
end

--------------------------


function Round1()
	if game.StarterGui:FindFirstChild("StartGui") then
		game.StarterGui.StartGui:Destroy()
	end
	
	wait(10)
	
	resetHealth()
	local NPCs = {NPCStorage.Sarah, NPCStorage.Sam}
	for _, spawnSpot in pairs(spawnLocations.Round1:GetChildren())do
		local NPC = NPCs[math.random(#NPCs)]
		spawnNPC(NPC, spawnSpot, Fenner.NPC.Round1, 50, 10)
	end
	
	Round1EndEvent = Fenner.NPC.Round1.ChildRemoved:Connect(function()
		if #Fenner.NPC.Round1:GetChildren() == 0 then
			Round1EndEvent:Disconnect()
			if Round1PlayerDiedEvent ~= nil then
				Round1PlayerDiedEvent:Disconnect()
			end
			Fenner.GlueWalls.Round1:Destroy()
			Round2()
		end
	end)
	
	for _, player in pairs(game.Players:GetChildren())do
		Round1PlayerDiedEvent = player.Character:WaitForChild("Humanoid").Died:Connect(function()	
			Round1EndEvent:Disconnect()
			Round1PlayerDiedEvent:Disconnect()
			for _, NPC in pairs(Fenner.NPC.Round1:GetChildren())do
				NPC:Destroy()
			end
			Round1()
		end)
	end
	
end


function Round2()
	wait(10)
	
	resetHealth()
	local NPCs = {NPCStorage.Jessica, NPCStorage.John}
	for _, spawnSpot in pairs(spawnLocations.Round2:GetChildren())do
		local NPC = NPCs[math.random(#NPCs)]
		spawnNPC(NPC, spawnSpot, Fenner.NPC.Round2, 100, 16)
	end
	
	Round2EndEvent = Fenner.NPC.Round2.ChildRemoved:Connect(function()
		if #Fenner.NPC.Round2:GetChildren() == 0 then
			Round2EndEvent:Disconnect()
			if Round2PlayerDiedEvent ~= nil then
				Round2PlayerDiedEvent:Disconnect()
			end
			Fenner.GlueWalls.Round2:Destroy()
			Round3DetectorWall()
		end
	end)
	
	for _, player in pairs(game.Players:GetChildren())do

		player.Team = game.Teams["Round 2"]
		Round2PlayerDiedEvent = player.Character:WaitForChild("Humanoid").Died:Connect(function()	
			Round2EndEvent:Disconnect()
			for _, NPC in pairs(Fenner.NPC.Round2:GetChildren())do
				NPC:Destroy()
			end
			Round2()
		end)
	end
	
end

function Round3DetectorWall()
	local detectorActivated = false
	Fenner.GlueWalls.Round3Detector.TouchEnded:Connect(function(hit)
		if not detectorActivated then
			if hit.Parent:FindFirstChild("Humanoid") then
				detectorActivated = true
				
				Fenner.GlueWalls.Round3Detector:Destroy()
				for _, glueRow in pairs(Fenner.GlueWalls.Round3:GetChildren())do
					for _, glue in pairs(glueRow:GetChildren())do
						glue.Transparency = 0.1
						glue.CanCollide = true
					end
				end
								
				Round3()
			end
		end
	end)

end

function Round3()

	wait(5)
	resetHealth()
				
	local NPC = NPCStorage.David
	NPC = spawnNPC(NPC, spawnLocations.Round3.David, Fenner.NPC.Round3, 500, 0)
	
	local NPChumanoid = NPC:WaitForChild("Humanoid")
	
	local forceField = Instance.new("ForceField")
	forceField.Parent = NPC
	forceField.Visible = true
				
	chatService:Chat(NPChumanoid.Parent.Head, "Woah, how did you get past all my minions?", Enum.ChatColor.Red)
	wait(5)
	chatService:Chat(NPChumanoid.Parent.Head, "Wait.... Have you been freeing students that I glued?", Enum.ChatColor.Red)
	wait(5)
	chatService:Chat(NPChumanoid.Parent.Head, "You want to free David? Too bad, I control him now.", Enum.ChatColor.Red)
	wait(5)
	chatService:Chat(NPChumanoid.Parent.Head, "3tg is doomed - Minions, ATTACK!!!", Enum.ChatColor.Red)
	wait(3)
	
	
	if Round3P1() then
		forceField.Parent = NPChumanoid
		chatService:Chat(NPChumanoid.Parent.Head, "Ouch. What happened to my forcefield!!", Enum.ChatColor.Red)
		repeat wait() until NPChumanoid.Health < 250
		forceField.Parent = NPC
		if Round3P2() then
			forceField.Parent = NPChumanoid
			chatService:Chat(NPChumanoid.Parent.Head, "STOP IT!!!!", Enum.ChatColor.Red)
		else
			Round3()
		end
	else
		Round3()
	end
				
end

function Round3P1()
	
	local Success = false
	local RoundOver = false
	
	local NPCs = {NPCStorage.John, NPCStorage.Jessica, NPCStorage.Sam, NPCStorage.Sarah}
	for _, spawnSpot in pairs(spawnLocations.Round3:GetChildren())do
		if spawnSpot.Name == "Minion" then
			local NPC = NPCs[math.random(#NPCs)]
			spawnNPC(NPC, spawnSpot, Fenner.NPC.Round3, 100, 20)
		end
	end
	
	Round3P1EndEvent = Fenner.NPC.Round3.ChildRemoved:Connect(function()
		if #Fenner.NPC.Round3:GetChildren() == 1 then
			Round3P1EndEvent:Disconnect()
			if Round3P1PlayerDiedEvent ~= nil then
				Round3P1PlayerDiedEvent:Disconnect()
			end
			Success = true
			RoundOver = true
		end
	end)
				
	for _, player in pairs(game.Players:GetChildren())do

		player.Team = game.Teams["Round 3"]
		Round3P1PlayerDiedEvent = player.Character:WaitForChild("Humanoid").Died:Connect(function()	
			Round3P1EndEvent:Disconnect()
			for _, NPC in pairs(Fenner.NPC.Round3:GetChildren())do
				NPC:Destroy()
			end
			Success = false
			RoundOver = true
		end)
	end
	
	repeat wait() until RoundOver == true
	return Success
end


function Round3P2()
	
	local Success = false
	local RoundOver = false
	
	local NPCs = {NPCStorage.John, NPCStorage.Jessica, NPCStorage.Sam, NPCStorage.Sarah}
	for _, spawnSpot in pairs(spawnLocations.Round3:GetChildren())do
		if spawnSpot.Name == "Minion" then
			local NPC = NPCs[math.random(#NPCs)]
			spawnNPC(NPC, spawnSpot, Fenner.NPC.Round3, 100, 20)
		end
	end
	
	Round3P2EndEvent = Fenner.NPC.Round3.ChildRemoved:Connect(function()
		if #Fenner.NPC.Round3:GetChildren() == 1 then
			Round3P2EndEvent:Disconnect()
			if Round3P2PlayerDiedEvent ~= nil then
				Round3P2PlayerDiedEvent:Disconnect()
			end
			Success = true
			RoundOver = true
		end
	end)
				
	for _, player in pairs(game.Players:GetChildren())do

		player.Team = game.Teams["Round 3"]
		Round3P2PlayerDiedEvent = player.Character:WaitForChild("Humanoid").Died:Connect(function()	
			Round3P2EndEvent:Disconnect()
			for _, NPC in pairs(Fenner.NPC.Round3:GetChildren())do
				NPC:Destroy()
			end
			Success = false
			RoundOver = true
		end)
	end
	
	repeat wait() until RoundOver == true
	return Success
end


game.ReplicatedStorage.Remotes.RunGame.OnServerEvent:Connect(Round1)