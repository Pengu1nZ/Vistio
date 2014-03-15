local COMMAND = {}
COMMAND.Name = "MuteVoice"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Mutes the voice of the selected player"

function COMMAND.CheckArgs(p, args)
	
end

function COMMAND.CanRun(p, args)
	
end

function COMMAND.CMD(p, args)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
