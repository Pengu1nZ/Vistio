local COMMAND = {}
COMMAND.Name = "SlayNRID"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Slays the player next time he connects."

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
