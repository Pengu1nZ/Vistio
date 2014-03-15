local COMMAND = {}
COMMAND.Name = "SetGroupID"
COMMAND.RequiredFlag = "D"
COMMAND.Description = "Sets the group of the selected SteamID"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
