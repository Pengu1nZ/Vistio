local COMMAND = {}
COMMAND.Name = "ForceNR"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Silently forces the args to the selected team"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
