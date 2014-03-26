local COMMAND = {}
COMMAND.Name = "Megathread"
COMMAND.RequiredFlag = "U"
COMMAND.Description = "Displays the Megathread"

function COMMAND.CheckArgs(p, a)
	return true
end

function COMMAND.CanRun(p, a)
	return true
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
