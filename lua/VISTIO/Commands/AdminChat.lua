local COMMAND = {}
COMMAND.Name = "AdminChat"
COMMAND.RequiredFlag = "U"
COMMAND.Description = "Sends a message to all connected staff"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
