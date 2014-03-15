local COMMAND = {}
COMMAND.Name = "SlayNR"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Slays the argsted player next round"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
