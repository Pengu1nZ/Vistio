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
	local PlayerName = name		--Get the player's name. Useful for display stuff mainly

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

function VISTIO.BanIDQuery(calling_ply, steamid, TargetName, reason, bantime )
	local AdminName = calling_ply:Name() 		--Grab admin name
	local AdminID = calling_ply:SteamID()		--Grab Admin SteamID
	local TargetID = steamid					--just change the variable cuz lazy
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

function VISTIO.AddUserIDQuery(calling_ply, TargetName, steamid, usergroup, time)
	local AdminName = calling_ply:Name() 		--Grab admin name
	local AdminID = calling_ply:SteamID()		--Grab Admin SteamID
	local TargetID = steamid					--Swap Variables
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

function VISTIO.GetPlaytimeQuery(steamid)
	local q = db:query("SELECT playtime FROM playerdata WHERE steamid='"..steamid.."';") --Get the playtime from the database
	q:start()
	
	local Playtime = playtime --put it in a better variable
end

function VISTIO.IsPlayerBanned(steamid)
	local q = db:query("SELECT unbantime FROM bans WHERE steamid='"..steamid"' AND unbanreason IS NULL") --Grab the date where the player should be unbanned in UNIX format
	q:start()
	
	local UnbanTime = unbantime
	--Check whether or not player should be unbanned at this point
	if UnbanTime > os.time() then
		return true
	elseif UnbanTime <= os.time() then
		VISTIO.BanExpired(steamid)		--Set the ban to expired in the database if it is expired
		return false
	end

end

function VISTIO.BanExpired(steamid)
	local q = db:query("UPDATE bans SET unbanreason='EXPIRED' WHERE steamid='"..steamid.."';")
	q:start()

end

function VISTIO.UnbanPlayer(steamid)
	local q = db:query("UPDATE bans SET unbanreason='UNBANNED' WHERE steamid='"..steamid.."';")
	q:start()
	
end


function q:onError( q, err , sql )
		MsgN("Query failed! /n Error:" ..err.. "/n You should tell a super about this!")
end
	
function q:onSuccess( q )
		MsgN("Query successful!")
end

db:connect()