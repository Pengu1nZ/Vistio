local COMMAND = {}
COMMAND.Name = "Donate"
COMMAND.RequiredFlag = "U"
COMMAND.Description = "Displays the donation page"

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
