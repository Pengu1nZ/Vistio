local COMMAND = {}
COMMAND.Name = "Goto"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Moves you to the argsted player"

function COMMAND.CheckArgs(ply, args)
	
end

function COMMAND.CanRun(ply, args)
	
end

function COMMAND.CMD(ply, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
