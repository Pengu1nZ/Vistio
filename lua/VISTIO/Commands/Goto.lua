local COMMAND = {}
COMMAND.Name = "Goto"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Moves you to the argsted player"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
