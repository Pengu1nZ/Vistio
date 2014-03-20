local COMMAND = {}
COMMAND.Name = "ForceNR"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Silently forces the args to the selected team"

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
