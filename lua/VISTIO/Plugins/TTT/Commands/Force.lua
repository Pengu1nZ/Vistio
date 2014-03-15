local COMMAND = {}
COMMAND.Name = "Force"
COMMAND.RequiredFlag = "D"
COMMAND.Description = "Forces a player to the selected team"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
