local COMMAND = {}
COMMAND.Name = "SetGroup"
COMMAND.RequiredFlag = "D"
COMMAND.Description = "Sets the group of the selected player"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
