local COMMAND = {}
COMMAND.Name = "MOTD"
COMMAND.RequiredFlag = "U"
COMMAND.Description = "Displays the MOTD"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
