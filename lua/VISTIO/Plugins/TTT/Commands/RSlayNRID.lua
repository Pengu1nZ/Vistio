local COMMAND = {}
COMMAND.Name = "RSlayNRID"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Removes rounsd of slaying from the selected ID"

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
