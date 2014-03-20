local COMMAND = {}
COMMAND.Name = "HighAdminChat"
COMMAND.RequiredFlag = "D"
COMMAND.Description = "Sends a message to all connected higher staff"

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
