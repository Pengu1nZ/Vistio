local COMMAND = {}
COMMAND.Name = "Kick"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Kicks the targetted player"

function COMMAND.CheckArgs(ply, target)
	
end

function COMMAND.CanRun(ply, target)
	
end

function COMMAND.CMD(ply, target)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
