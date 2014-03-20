local COMMAND = {}
COMMAND.Name = "MuteVoice"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Mutes the voice of the selected player"

function COMMAND.CheckArgs(p, a)
	
end

function COMMAND.CanRun(p, a)
	
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
