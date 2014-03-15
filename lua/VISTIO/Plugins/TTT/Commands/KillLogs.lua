local COMMAND = {}
COMMAND.Name = "KillLogs"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Opens killlogs for the past five rounds"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
