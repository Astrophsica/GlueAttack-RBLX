local module = {}

local humanoid = nil
local players = game:GetService("Players")
local pathFindingService = game:GetService("PathfindingService") 


function walkToPlayer(player)
	local path = pathFindingService:CreatePath({AgentCanJump = false})
	local npcHumanoidRootPart = humanoid.Parent.HumanoidRootPart
	local playerHumanoidRootPart = player.Character.HumanoidRootPart
	
	path:ComputeAsync(npcHumanoidRootPart.Position, playerHumanoidRootPart.Position)
	
	local wayPoints = path:GetWaypoints()

	for _, wayPoint in pairs(wayPoints)do
		humanoid:MoveTo(wayPoint.Position)
		wait(0.25)
		humanoid.Jump = true
	end
end


function module.Run(NPChumanoid)
	humanoid = NPChumanoid
	while humanoid.GlueMode.Value do
		for _, player in pairs(players:GetChildren())do
			if player.Character then
				if (humanoid.Parent.HumanoidRootPart.Position - player.Character:FindFirstChild("HumanoidRootPart").Position).magnitude < 50 then
					walkToPlayer(player)
				end
			end
		end
		wait(0.5)
	end
end


return module
