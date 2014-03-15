local COMMAND = {}
COMMAND.Name = "Help"
COMMAND.RequiredFlag = "U"
COMMAND.Description = "Shows all commands that you can use"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
