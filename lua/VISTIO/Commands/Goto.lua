local COMMAND = {}
COMMAND.Name = "Goto"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Moves you to the argsted player"

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
