local COMMAND = {}
COMMAND.Name = "SlayNRID"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Slays the player next time he connects."

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
