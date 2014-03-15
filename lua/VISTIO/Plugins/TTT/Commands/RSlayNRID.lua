local COMMAND = {}
COMMAND.Name = "RSlayNRID"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Removes rounsd of slaying from the selected ID"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
