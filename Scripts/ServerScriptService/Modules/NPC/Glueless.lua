local module = {}

chatService = game:GetService("Chat")

local chatColor = Enum.ChatColor.Blue

function Chat(head, message, color)
	chatService:Chat(head, message, color)
end


function module.Run(npcHumanoid)
	local npcHead = npcHumanoid.Parent.Head
	if npcHumanoid.Parent.Name == "David" then
		chatService:Chat(npcHead, "Wait.... What just happened", chatColor)
		wait(3)
		chatService:Chat(npcHead, "I'm...... Glueless", chatColor)
		wait(3)
		chatService:Chat(npcHead, "Did you free us?", chatColor)
		wait(3)
		chatService:Chat(npcHead, "Oh my gosh, you saved 3tg!", chatColor)
		wait(3)
		chatService:Chat(npcHead, "You are our saviour! You defeated the glue monster.", chatColor)
		wait(3)
	end
	Chat(npcHead, "I'm free!", chatColor) 
	wait(3)
	local medicBox = game.ServerStorage.Medic:Clone()
	medicBox.Parent = workspace
	medicBox.CFrame = npcHumanoid.Parent.HumanoidRootPart.CFrame
	npcHumanoid.Parent:Destroy()
end


return module
