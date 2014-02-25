local COMMAND = {}
COMMAND.Name = "Send"
COMMAND.RequiredFlag = "A"
COMMAND.Description = "Teleports the targetted player to the second targetted player"

function COMMAND.CheckArgs(ply, target)
	
end

function COMMAND.CanRun(ply, target)
	
end

function COMMAND.CMD(ply, target)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
