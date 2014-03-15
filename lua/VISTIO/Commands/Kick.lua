local COMMAND = {}
COMMAND.Name = "Kick"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Kicks the argsted player"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
