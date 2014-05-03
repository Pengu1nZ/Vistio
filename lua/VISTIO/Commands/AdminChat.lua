local COMMAND = {}
COMMAND.Name = "@"
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
	local ChatString = p:Name()..":"
	for k,v in pairs( a ) do
		if v >= 1 then
			local ChatString = ChatString .. a[v]
		end
	end
	if !string.find(p.Access.Flags, "M") then
		local ChatString = "[TO STAFF] "..ChatString
		
	else
		local ChatString = "[STAFF]" "..ChatString
		
	end
end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
