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
        MsgN('VISTIO Connect to SQL Database!')
end

function db:onConnectionFailed(err)
        MsgN('VISTIO SQL is encountering an error: ' .. err)
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
end

function VISTIO.AddUserIDQuery(calling_ply, steamid, usergroup, time)
	local AdminName = calling_ply:Name() 		--Grab admin name
	local AdminID = calling_ply:SteamID()		--Grab Admin SteamID
	local TargetName = target_ply:Name()		--Grab the Target's Name
	local TargetID = target_ply:SteamID()		--Grab the Target's SteamID
	local TimeCreated = os.time()				--Grab the Time the user was set
	local LengthSeconds = time * 60				--Change trial length from minutes to seconds
	local ExpireTime = TimeCreated + LengthSeconds	--Create the time where the rank expires
	
	if time != 0 then
		local q = db:query("UPDATE playerdata SET accessgroup='"..usergroup.."', expiretime="..ExpireTime.." WHERE steamid='"..TargetID.." ;")
	elseif time = 0 then
		local q = db:query("UPDATE playerdata SET  accessgroup='"..usergroup.."', expiretime=0 WHERE steamid='"..TargetID.." ;")
	end
end



function q:onError( q, err , sql )
		MsgN("Query failed! /n Error:" ..err.. "/n You should tell a super about this!")
end
	
function q:onSuccess( q )
		MsgN("Query successful!")
end

q:start()