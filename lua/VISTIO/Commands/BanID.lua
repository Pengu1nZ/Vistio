local COMMAND = {}
COMMAND.Name = "BanID"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Bans the selected steamid"

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
