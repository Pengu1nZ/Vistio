local COMMAND = {}
COMMAND.Name = "Help"
COMMAND.RequiredFlag = "U"
COMMAND.Description = "Shows all commands that you can use"

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
