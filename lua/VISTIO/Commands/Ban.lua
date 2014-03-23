local COMMAND = {}
COMMAND.Name = "Ban"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Bans a player off the server. Arguments: <Player> <Time> <Reason>."

local function GetPlayers(s)
	local Players = {}
	local pls = player.GetAll()
	for k = 1, #pls do -- Proven to be faster than pairs loop.
		local v = pls[k]
		if s == v:SteamID() then
			table.insert(Players, v)
		elseif string.find(v:Name():lower(), s:lower(), 1, true) then
			table.insert(Players, v)
		end
	end
	return Players
end

function COMMAND.CheckArgs(p, a)
	if p and p:IsValid() then
		if #a > 0 and a[1] != "" then
			if #GetPlayers(a[1]) > 1 then p:VISTIOMessage("Targetting more than one player, specify.") file.Append("MisBans.txt", p:SteamID() .. " - " .. table.concat(a, " ") .. "\n") return false end
			if VISTIO.Core.FindPlayer(a[1]) then
				local time = tonumber(a[2])
				if time && time >= 0 then
					if a[3] and a[3] != "" then
						local reason = table.concat(a," ",3):lower()
						if p.AccessGroup == "MODERATOR" then
							if time > 20160 or time == 0 then
								if string.find(reason, "perm:") then
									return true
								else
									p:VISTIOMessage("You need permission to ban for this long. Append Perm: <Admin> at the end of the reason.")
									return false
								end
							else
								return true
							end
						elseif p.AccessGroup == "ADMIN" then
							if time <= 0 then
								if string.find(reason, "perm:") then
									return true
								else
									p:VISTIOMessage("You need permission to ban for this long. Append Perm: <Admin> at the end of the reason.")
									return false
								end
							else
								return true
							end
							return true
						else
							return true
						end
					else
						p:VISTIOMessage("Ban reason required!")
					end
				else
					p:VISTIOMessage(Format("Invalid ban time %s.",a[2] or "NONE"))
				end
			else
				p:VISTIOMessage(Format("Invalid player '%s'.",a[1]))
			end
			
			return false;
		else
			if p and p:IsValid() then
				p:VISTIOMessage("Ban requires 3 arguments <Player> <Time> <Reason>.")
			end
		end
	else
		if #a > 0 and a[1] != "" then
			if VISTIO.Core.FindPlayer(a[1]) then
				if tonumber(a[2]) and tonumber(a[2]) >= 0 then
					if a[3] and a[3] != "" then
						return true
					else
						print(Format("Ban reason required!",a[3]))
					end
				else
					print(Format("Invalid ban time %s.",a[2]))
				end
			else
				print(Format("Invalid player '%s'.",a[1]))
			end
		else
			print("Ban requires 3 arguments <Player> <Time> <Reason>.")
		end
	end
end

function COMMAND.CanRun(p, a)
	local target = VISTIO.Core.FindPlayer(a[1])
	if VISTIO.Access.Groups[string.upper(p.AccessGroup)].Level > VISTIO.Access.Groups[string.upper(target.AccessGroup)].Level then
		return true
	else
		p:VISTIOMessage(Format("%s cannot be banned (Has same/higher authority).",a[1]))
	end
end

function COMMAND.CMD(p, a)
	local target = VISTIO.Core.FindPlayer(a[1])
	local time = a[2]
	time = math.floor(time)
	local reason = table.concat(a," ",3)
	local query
	if p and p:IsValid() then
		if p == target then return end
			VISTIO.BanQuery(p, target, reason, time)
		for k, v in pairs(player.GetAll()) do
			v:VISTIOMessage(Format("%s(%s) was banned for %s minutes by %s for %q.",target:Name(),target:SteamID(),time,p:Name(),reason))
		end
			print(Format("%s(%s) was banned for %s minutes by %s for %q.",target:Name(),target:SteamID(),time,p:Name(),reason))
		
		target:Kick(reason)
	else
		VISTIO.ConsoleBanQuery( target, reason, time)
		if succ then 
			for k, v in pairs(player.GetAll()) do
				v:VISTIOMessage(Format("%s(%s) was banned for %s minutes by Console for %q.",target:Name(),target:SteamID(),time,reason))
			end
				print(Format("%s(%s) was banned for %s minutes by Console for %q.",target:Name(),target:SteamID(),time,reason))
		end
		target:Kick(reason)
	end
end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)
