local COMMAND = {}
COMMAND.Name = "DamageLogs"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Opens damagelogs for the past five rounds"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
