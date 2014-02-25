local MODULE = {}
MODULE.Name = "Database"

local Queue = {}
require("mysqloo")

local mysql_hostname = 'carbonitegaming.net' -- Your MySQL server address.
local mysql_username = 'applewebsite' -- Your MySQL username.
local mysql_password = 'CarbonGamingSQL123' -- Your MySQL password.
local mysql_database = 'applewebsite_vistiodata' -- Your MySQL database.
local mysql_port = 3306 -- Your MySQL port. Most likely is 3306.

local db = mysqloo.connect(mysql_hostname, mysql_username, mysql_password, mysql_database, mysql_port)


function db:onConnected()
        MsgN('VISTIO has successfully connected to SQL Database!')
end

function db:onConnectionFailed(err)
        MsgN('VISTIO SQL is encountering an error: ' .. err)
end


function VISTIO.GetName(calling_ply, steamid)
	local q = db:query("SELECT name FROM playerdata WHERE steamid='"..steamid.."' ;")
	q:start()
	local PlayerName = Data[2]		--Get the player's name. Useful for display stuff mainly

end

function VISTIO.BanQuery(calling_ply, target_ply, reason, bantime )
	local AdminName = calling_ply:Name() 		--Grab admin name
	local AdminID = calling_ply:SteamID()		--Grab Admin SteamID
	local TargetName = target_ply:Name()		--Grab the Target's Name
	local TargetID = target_ply:SteamID()		--Grab the Target's SteamID
	local TimeCreated = os.time()				--Grab the Time the ban was created
	local BanTimeSeconds = bantime * 60			--Get the ban time from minutes to seconds
	local UnbanTime = TimeCreated + BanTimeSeconds	--Create the time where he'll be unbanned
	
	--Set up the query for a ban
	local q = db:query("INSERT INTO bans ( `plysteamid`, `plyname`, `adminname`, `adminsteamid`, `reason`, `time`, `unbantime`, `timecreated` ) VALUES( '"..TargetID.."', '"..db:escape(TargetName).."', '"..db:escape(AdminName).."', '"..AdminID.."', '"..db:escape(reason).."', "..BanTimeSeconds..", "..UnbanTime..", "..TimeCreated.."	);")
	
end

function VISTIO.BanIDQuery(calling_ply, SteamID, TargetName, reason, bantime )
	local AdminName = calling_ply:Name() 		--Grab admin name
	local AdminID = calling_ply:SteamID()		--Grab Admin SteamID
	local TargetID = SteamID					--just change the variable cuz lazy
	local TimeCreated = os.time()				--Grab the Time the ban was created
	local BanTimeSeconds = bantime * 60			--Get the ban time from minutes to seconds
	local UnbanTime = TimeCreated + BanTimeSeconds	--Create the time where he'll be unbanned
	
	--Set up the query for a ban
	if bantime != 0 then
		local q = db:query("INSERT INTO bans ( `plysteamid`, `plyname`, `adminname`, `adminsteamid`, `reason`, `time`, `unbantime`, `timecreated` ) VALUES( '"..TargetID.."', '"..db:escape(TargetName).."', '"..db:escape(AdminName).."', '"..AdminID.."', '"..db:escape(reason).."', "..BanTimeSeconds..", "..UnbanTime..", "..TimeCreated.."	);")
	elseif bantime == 0 then
		local q = db:query("INSERT INTO bans ( `plysteamid`, `plyname`, `adminname`, `adminsteamid`, `reason`, `time`, `unbantime`, `timecreated` ) VALUES( '"..TargetID.."', '"..db:escape(TargetName).."', '"..db:escape(AdminName).."', '"..AdminID.."', '"..db:escape(reason).."', 0, "..UnbanTime..", "..TimeCreated.."	);")
	end
	
	q:start()
end


function VISTIO.AddUserQuery(calling_ply, target_ply, usergroup, time)
	local AdminName = calling_ply:Name() 		--Grab admin name
	local AdminID = calling_ply:SteamID()		--Grab Admin SteamID
	local TargetName = target_ply:Name()		--Grab the Target's Name
	local TargetID = target_ply:SteamID()		--Grab the Target's SteamID
	local TimeCreated = os.time()				--Grab the Time the user was set
	local LengthSeconds = time * 60				--Change trial length from minutes to seconds
	local ExpireTime = TimeCreated + LengthSeconds	--Create the time where the rank expires
	
	if time != 0 then
		local q = db:query("UPDATE playerdata SET name='"..TargetName.."', accessgroup='"..usergroup.."', expiretime="..ExpireTime.." WHERE steamid='"..TargetID.." ;")
	elseif time = 0 then
		local q = db:query("UPDATE playerdata SET name='"..TargetName.."', accessgroup='"..usergroup.."', expiretime=0 WHERE steamid='"..TargetID.." ;")
	end
	
	q:start()
end

function VISTIO.AddUserIDQuery(calling_ply, TargetName, SteamID, usergroup, time)
	local AdminName = calling_ply:Name() 		--Grab admin name
	local AdminID = calling_ply:SteamID()		--Grab Admin SteamID
	local TargetID = SteamID					--Swap Variables
	local TimeCreated = os.time()				--Grab the Time the user was set
	local LengthSeconds = time * 60				--Change trial length from minutes to seconds
	local ExpireTime = TimeCreated + LengthSeconds	--Create the time where the rank expires
	
	if time != 0 then
		local q = db:query("UPDATE playerdata SET accessgroup='"..usergroup.."', expiretime="..ExpireTime.." WHERE steamid='"..TargetID.." ;")
	elseif time = 0 then
		local q = db:query("UPDATE playerdata SET  accessgroup='"..usergroup.."', expiretime=0 WHERE steamid='"..TargetID.." ;")
	end
	
	q:start()
end



function VISTIO.IsPlayerBanned(SteamID)
	local q = db:query("SELECT * FROM bans WHERE steamid='"..SteamID.."' AND unbanreason IS NULL") --Grab the date where the player should be unbanned in UNIX format
	q:start()
	
	local UnbanTime = Data[8]
	local TimeBanned = Data[7]
	local CurrentTime = os.time()/60
	local UnbanTimeMinutes = Unbantime/60
	local BanTimeLeft = math.Round(UnbanTimeMinutes-CurrentTime)
	--Check whether or not player should be unbanned at this point
	if UnbanTime = 0 then
		local KickMessage = "You are permanently banned. Appeal this at ttt.carbonitegaming.net"
	elseif UnbanTime > 1 then
		if UnbanTime > os.time() and UnbanTime then
			return true
			local KickMessage = "You have been banned for "..TimeBanned..". Your ban will expire in "..BanTimeLeft.." minutes. You may appeal at ttt.carbonitegaming.net"
		elseif UnbanTime <= os.time() then
			VISTIO.BanExpired(steamid)		--Set the ban to expired in the database if it is expired
			return false
		end
	end
end

function VISTIO.BanExpired(SteamID)
	local q = db:query("UPDATE bans SET unbanreason='EXPIRED' WHERE steamid='"..SteamID.."' AND unbanreason IS NULL;") --If the ban expires normally, set the reason to expired
	q:start()

end

function VISTIO.UnbanPlayer(SteamID)
	local q = db:query("UPDATE bans SET unbanreason='UNBANNED' WHERE steamid='"..SteamID.."';") -- If the person is manually unbanned, set the reason to unbanned
	q:start()
	
end

function VISTIO.GetPlayerFlags(SteamID)
	local q = db:query("SELECT * FROM playerdata WHERE steamid='"..SteamID.."';")
	q:start()
	
	local PlayerFlags = Data[4] --localize4jeezus
end

function VISTIO.SavePlayerFlags(SteamID, PlayerFlags)
	local q = db:query("UPDATE playerdata SET flags='"..PlayerFlags.."' WHERE steamid='"..SteamID.."';")
	q:start()
	
end

function VISTIO.GetPlaytime(SteamID)
	local q = db:query("SELECT playtime FROM playerdata WHERE steamid='"..SteamID.."';")
	q:start()
	
	local PlayTime = Data[8]
end

function VISTIO.SavePlaytime(SteamID, PlayTime)
	local q = db:query("INSERT INTO playerdata( 'playtime', 'steamid') VALUES(PlayTime,steamid) ON DUPLICATE KEY UPDATE  'playtime'='"..PlayTime.."' ;")
	q:start()
	

end

function VISTIO.UpdateLastSeen(SteamID)
	local q = db:query("UPDATE playerdata SET lastseen="..os.time().." WHERE steamid='"..SteamID.."';")
	q:start()

end


function q:onError( q, err , sql )
		MsgN("Query failed! /n Error:" ..err)
end
	
function q:onSuccess( q )
		MsgN("Query successful!")
end

db:connect()

VISTIO.Core.RegisterModule(MODULE)