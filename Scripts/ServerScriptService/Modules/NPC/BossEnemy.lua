local module = {}

local humanoid = nil
local players = game:GetService("Players")
local chatService = game:GetService("Chat")

function SetOnDied()
	humanoid.Died:Connect(function()
		local clone = game.ServerStorage.NPC:FindFirstChild(humanoid.Parent.Name):Clone()
		clone:WaitForChild("Glue"):Destroy()
		
		local NPCModule = game.ServerScriptService.Modules.NPC.LoadModule:Clone()
		NPCModule.Parent = clone:WaitForChild("Humanoid")
		NPCModule.Disabled = false
		
		clone.Parent = workspace
		clone:MakeJoints()
		clone:SetPrimaryPartCFrame(humanoid.Parent.PrimaryPart.CFrame)
		humanoid.Parent:Destroy()
	end)
end





function module.Run(NPChumanoid)
	humanoid = NPChumanoid
	SetOnDied()
end


return module
