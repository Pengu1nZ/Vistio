local COMMAND = {}
COMMAND.Name = "MOTD"
COMMAND.RequiredFlag = "U"
COMMAND.Description = "Displays the MOTD"

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
