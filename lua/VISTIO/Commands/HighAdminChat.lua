local COMMAND = {}
COMMAND.Name = "HighAdminChat"
COMMAND.RequiredFlag = "D"
COMMAND.Description = "Sends a message to all connected higher staff"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
