local COMMAND = {}
COMMAND.Name = "RespawnTP"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Respawns the argsted player where you are looking"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
