local COMMAND = {}
COMMAND.Name = "KillLogs"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Opens killlogs for the past five rounds"

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
