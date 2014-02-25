local COMMAND = {}
COMMAND.Name = "RespawnTP"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Respawns the targetted player where you are looking"

function COMMAND.CheckArgs(ply, target)
	
end

function COMMAND.CanRun(ply, target)
	
end

function COMMAND.CMD(ply, target)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
