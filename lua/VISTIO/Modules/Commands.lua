local MODULE = {}
MODULE.Name = "Commands"

function MODULE.Init()
	MODULE.LoadCommands()
end

function MODULE.RegisterCommand(t)
	VISTIO.Commands[string.upper(t.Name)] = t
end

function MODULE.LoadCommand(s)
	include("VISTIO/Commands/"..s)
	include("VISTIO/Plugins/*/Commands/"..s)
end


function MODULE.LoadCommands()
	VISTIO.Commands = {}
	local files = file.Find("VISTIO/Commands/*.lua", "LUA") and file.Find("VISTIO/Plugins/*/Commands/*.lua", "LUA")
	for k, v in pairs(files) do
		MODULE.LoadCommand(v)
	end

end

function MODULE.ParseCMD()
	local newargs = {}
	
	if (p.VISTIOCMD) and (p.VISTIOCMD >= CurTime()) then return end
	
	for k, v in pairs(a) do
		if (string.find(v:lower(), "steam_")) and (v:len() == 7) then
			if (a[k+4]) then
				local str = a[k] .. a[k+1] .. a[k+2] .. a[k+3] .. a[k+4]
				table.insert(newargs, str)
				a[k] = nil
				a[k+1] = nil
				a[k+2] = nil
				a[k+3] = nil
				a[k+4] = nil
			else
				if (p:IsPlayer()) then p:VISTIOMessage("Error parsing SteamID: Not enough Args (expect command to malfunction") end
				break
			end
		else
			table.insert(newargs, v)
		end
	end
	
	a = newargs
	
	local isargs = false
	if (a[1] and a[1] != "") then
		c = table.remove(a, 1):upper()
		isargs = true
	end
	
	if (p:IsPlayer()) then
		p.VISTIOCMD = CurTime() + 3
		local sound = 2
		
		if (isargs) then
			if (VISTIO.Commands[c]) then
				if (VISTIO.Commands[c].CheckArgs(p, a)) then
					if (p:CanRun(c) and VISTIO.Commands[c].CanRun(p, a)) then
						sound = 9
						VISTIO.Commands[c].CMD(p, a)
						
					elseif (!p:CanRun(c)) then
						p:VISTIOMessage("You don't have access to '" .. c .. "'.")
					end
				end
			else
				p:VISTIOMessage("Unknown command: '" .. c .. "'.")
			end
		else
			p:VISTIOMessage("Type !help to view commands.")
		end
		
		p:ConCommand("play buttons/button" .. sound .. ".wav")
	else
		if (isargs) then
			if (VISTIO.Commands[c]) then
				if (VISTIO.Commands[c].CheckArgs(p, a)) then VISTIO.Commands[c].CMD(p, a) end
			else
				print("Invalid command: " .. c)
			end
		else
			print("No command specified.")
		end
	end
end
concommand.Add("VISTIO",MODULE.ParseCMD)

function VISTIO.ChatCommand( p , text , teamChat )

	if p.ChatMuted then 
		return false 
	end
	
	if teamChat then
		return true
	else
		local textfcmd
		if string.sub(text,0,1) == "!" then
			textfcmd = string.Replace(text,"!","")
			p:ConCommand("VISTIO "..textfcmd)
			return false
		elseif string.sub(text,0,1) == "/" then
			textfcmd = string.Replace(text,"/","")
			p:ConCommand("VISTIO "..textfcmd)
			return false
		end
	end
end
hook.Add("PlayerSay", "VistioChat", VISTIO.ChatCommand)

VISTIO.Core.RegisterModule(MODULE)