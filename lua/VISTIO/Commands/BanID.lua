local COMMAND = {}
COMMAND.Name = "BanID"
COMMAND.RequiredFlag = "M"
COMMAND.Description = "Bans the selected steamid"

function COMMAND.CheckArgs(p,a)
	if p and p:IsValid() then
		if #a > 0 and a[1] != "" then
			if string.find(a[1], "STEAM_%d:%d:%d") then
				local time = tonumber(a[2])
				if time and time >= 0 then
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
							if time == 0 then
								if string.find(reason, "perm:") then
									return true
								else
									p:VISTIOMessage("You need permission to ban for this long. Append Perm: <Admin> at the end of the reason.")
									return false
								end
							else
								return true
							end
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
				p:VISTIOMessage(Format("Invalid SteamID %s.",a[1] or "NONE"))
			end
		else
			if p and p:IsValid() then
				p:VISTIOMessage("Ban requires 3 arguments <SteamID> <Time> <Reason>.")
			end
		end
		
		return false
	else
		if #a > 0 and a[1] != "" then
			if string.find(a[1], "STEAM_%d:%d:%d") then
				if tonumber(a[2]) and tonumber(a[2]) >= 0 then
					if a[3] and a[3] != "" then
						return true
					else
						print(Format("Ban reason required!",a[1]))
					end
				else
					print(Format("Invalid ban time %s.",a[1]))
				end
			else
				print(Format("Invalid SteamID %s.",a[1]))
			end
		else
			print("Ban requires 3 arguments <steamid> <time> <reason>")
		end
	end
end

function COMMAND.CanRun(p,a)
	return true
end

local function CheckBanTime(bts, bantime)
	if bantime == 0  then return 0 end
	local ct = os.time()
	local bt = (tonumber(bantime)*60) + tonumber(bts)
	if ct > bt then return -1 end
	
	return math.Round(bt - ct)/60
end

function COMMAND.CMD(p,a)
	local steamid = a[1]
	local time = a[2]
	time = math.floor(time)
	local reason = table.concat(a," ",3)
	if p and p:IsValid() then
		VISTIO.GetName( steamid )
			if tb and tb[1] then
				if VISTIO.Access.Groups[string.upper(p.AccessGroup)].Level > VISTIO.Access.Groups[string.upper(tb[1].AccessGroup)].Level then
					local query = Format([[SELECT ban_time, time_stamp, Unbanned FROM darkrp_banlist WHERE ban_steamid=%q ORDER By time_stamp DESC]],steamid)
					DB.Query(query, function(target)
						if target && target[1] then
							local C = CheckBanTime(target[1]["time_stamp"], target[1]["ban_time"])
							if (C != -1 && target[1].Unbanned != 1) then
								p:VISTIOMessage("SteamID is already banned.")
								return
							end
							query = Format([[INSERT INTO darkrp_banlist (`ban_name`, `ban_steamid`, `ban_time`, `banner`, `banner_steamid`, `reason`, `time_stamp` ) VALUES (%q,%q,%s,%q,%q,%q,%s)]], tb[1].Name, steamid, time,  p:Name(),p:SteamID(), reason, os.time())
							DB.Query(query)
							
							local ta = VISTIO.Core.FindPlayer(a[1])
							if ta then ta:Kick(reason) end
							
							ta = tb[1]
							for k, v in pairs(player.GetAll()) do
								v:VISTIOMessage(Format("%s(%s) was banned for %s minutes by %s for %q.",ta.Name,steamid,time,p:Name(),reason))
							end
							print(Format("%s(%s) was banned for %s minutes by %s for %q.",ta.Name,steamid,time,p:Name(),reason))
						else
							query = Format([[INSERT INTO darkrp_banlist (`ban_name`, `ban_steamid`, `ban_time`, `banner`, `banner_steamid`, `reason`, `time_stamp` ) VALUES (%q,%q,%s,%q,%q,%q,%s)]], tb[1].Name, steamid, time,  p:Name(),p:SteamID(), reason, os.time())
							DB.Query(query)
							
							local ta = VISTIO.Core.FindPlayer(a[1])
							if ta then ta:Kick(reason) end
							
							ta = tb[1]
							
							for k, v in pairs(player.GetAll()) do
								v:VISTIOMessage(Format("%s(%s) was banned for %s minutes by %s for %q.",ta.Name,steamid,time,p:Name(),reason))
							end
							print(Format("%s(%s) was banned for %s minutes by %s for %q.",ta.Name,steamid,time,p:Name(),reason))
						end
					end)
				else
					p:VISTIOMessage("SteamID has same/higher authority.")
				end
			else
				p:VISTIOMessage("Invalid SteamID: " .. a[1] .. ".")
			end
		end)
	end
end

VISTIO.Modules.Commands.RegisterCommand(COMMAND)