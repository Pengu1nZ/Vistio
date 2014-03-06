local COMMAND = {}
COMMAND.Name = "AdminChat"
COMMAND.RequiredFlag = "U"
COMMAND.Description = "Sends a message to all connected staff"

function COMMAND.CheckArgs(ply, args)
	
end

function COMMAND.CanRun(ply, args)
	
end

function COMMAND.CMD(ply, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
