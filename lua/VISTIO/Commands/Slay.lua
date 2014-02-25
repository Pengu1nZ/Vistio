local COMMAND = {}
COMMAND.Name = "Slay"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Slays the targetted player"

function COMMAND.CheckArgs(ply, target)
	
end

function COMMAND.CanRun(ply, target)
	
end

function COMMAND.CMD(ply, target)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
