local COMMAND = {}
COMMAND.Name = "AdminChat"
COMMAND.RequiredFlag = "U"
COMMAND.Description = "Sends a message to all connected staff"

function COMMAND.CheckArgs(p, a)
	if a[2] = "" then
		return false
	else
		return true
	end
end

function COMMAND.CanRun(p, a)
	return true
end

function COMMAND.CMD(p, a)

end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
