local COMMAND = {}
COMMAND.Name = "DamageLogs"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Opens damagelogs for the past five rounds"

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
