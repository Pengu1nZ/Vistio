local COMMAND = {}
COMMAND.Name = "SetGroupID"
COMMAND.RequiredFlag = "D"
COMMAND.Description = "Sets the group of the selected SteamID"

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
