local COMMAND = {}
COMMAND.Name = "MOTD"
COMMAND.RequiredFlag = "U"
COMMAND.Description = "Displays the MOTD"

function COMMAND.CheckArgs(p, a)
	return true
end

function COMMAND.CanRun(p, a)
	return true
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
