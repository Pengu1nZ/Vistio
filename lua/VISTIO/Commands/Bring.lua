local COMMAND = {}
COMMAND.Name = "Bring"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Bring a player to your location. Arguments: <Player>."

function COMMAND.CheckArgs(p,a)
	if #a > 0 and a[1] != "" then
		if VISTIO.Core.FindPlayer(a[1]) then
			return true
		else
			p:VISTIOMessage(Format("Invalid player '%s'.",a[1]))
		end
	else
		p:VISTIOMessage("Bring requires 1 argument <Player>.")
	end
end

function COMMAND.CanRun(p,a)
	local target = VISTIO.Core.FindPlayer(a[1])
	if VISTIO.CanTarget( p, target) then
		return true
	else
		p:VISTIOMessage(Format("%s cannot be brought (Has higher authority).",a[1]))
	end
end

function COMMAND.CMD(p,a)
	local target = VISTIO.Core.FindPlayer(a[1])
	target:SetPos(p:GetPos() + Vector(0, 0, 75))
	local text = Format("%s has brought %s.",p:Name(),target:Name())
	local mtext = Format("Brought %s.",target:Name())
	for k,v in pairs(player.GetAll()) do
		if v != p then
			v:VISTIOMessage(text)
		else
			v:VISTIOMessage(mtext)
		end
	end
end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
