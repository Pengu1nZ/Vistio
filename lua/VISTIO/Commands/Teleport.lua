local COMMAND = {}
COMMAND.Name = "Tele"
COMMAND.RequiredFlag = "A"
COMMAND.Description = "Teleports the targetted players to where you are looking"

function COMMAND.CheckArgs(ply, target)
	
end

function COMMAND.CanRun(ply, target)
	
end

function COMMAND.CMD(ply, target)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
