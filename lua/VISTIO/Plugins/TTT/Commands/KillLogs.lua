local COMMAND = {}
COMMAND.Name = "KillLogs"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Opens killlogs for the past five rounds"

function COMMAND.CheckArgs(ply, args)
	
end

function COMMAND.CanRun(ply, args)
	
end

function COMMAND.CMD(ply, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
