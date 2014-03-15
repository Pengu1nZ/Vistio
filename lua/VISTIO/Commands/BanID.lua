local COMMAND = {}
COMMAND.Name = "BanID"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Bans the selected steamid"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
