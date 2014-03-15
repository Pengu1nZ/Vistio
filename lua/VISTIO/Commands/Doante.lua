local COMMAND = {}
COMMAND.Name = "Donate"
COMMAND.RequiredFlag = "U"
COMMAND.Description = "Displays the donation page"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
