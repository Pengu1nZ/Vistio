local COMMAND = {}
COMMAND.Name = "AdminChat"
COMMAND.RequiredFlag = "U"
COMMAND.Description = "Sends a message to all connected staff"

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
