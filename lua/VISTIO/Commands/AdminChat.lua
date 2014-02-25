local COMMAND = {}
COMMAND.Name = "AdminChat"
COMMAND.RequiredFlag = "U"
COMMAND.Description = "Sends a message to all connected staff"

function COMMAND.CheckArgs(ply, target)
	
end

function COMMAND.CanRun(ply, target)
	
end

function COMMAND.CMD(ply, target)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
