local COMMAND = {}
COMMAND.Name = "Goto"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Moves you to the targetted player"

function COMMAND.CheckArgs(ply, target)
	
end

function COMMAND.CanRun(ply, target)
	
end

function COMMAND.CMD(ply, target)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
