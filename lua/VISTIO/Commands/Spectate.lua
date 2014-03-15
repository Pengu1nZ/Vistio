local COMMAND = {}
COMMAND.Name = "Spectate"
COMMAND.RequiredFlag = "A"
COMMAND.Description = "Matches your view with the argsted player's"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
