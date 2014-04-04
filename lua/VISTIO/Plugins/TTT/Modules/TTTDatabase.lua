local MODULE = {}
MODULE.Name = "TTT Database"

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

function VISTIO.CheckSlayNR( target )
	local steamid = target:SteamID()
	local q = db:query("SELECT * FROM 'tttstats' WHERE 'steamid' = '"..steamid.."' ;")
	q:start()
	local Data = q:getData()
	local PlayerResults = Data[1]
	local SlaysLeft = PlayerResults.slaysleft
	
	if SlaysLeft > 0 then
		return SlaysLeft
	else
		return 0
	end
end

function VISTIO.AddSlayNR( target, NumSlays )
	local steamid = target:SteamID()
	local q = db:query("UPDATE 'tttstats' SET 'slaysleft'="..NumSlays.." WHERE 'steamid'="..steamid.."' ;")
	q:start()
	
end

function VISTIO.AddSlayNRID( steamid, NumSlays )
	local q = db:query("UPDATE 'tttstats' SET 'slaysleft'="..NumSlays.." WHERE 'steamid'="..steamid.."' ;")
	q:start()
end

function VISTIO.RemoveSlays( target, NumSlays )
	local steamid = target:SteamID()
	local q = db:query("SELECT * FROM 'tttstats' WHERE 'steamid' = '"..steamid.."' ;")
	q:start()
	local Data = q:getData()
	local PlayerResults = Data[1]
	local SlaysLeft = PlayerResults.slaysleft
	
	local NewSlays = SlaysLeft - NumSlays
	local NewSlays = math.Round( NewSlays )
	local q = db:query("UPDATE 'tttstats' SET 'slaysleft'="..NewSlays.." WHERE 'steamid'="..steamid.."' ;")
	q:start()
	
	
end

function VISTIO.RemoveSlaysID( steamid, NumSlays )
	local q = db:query("SELECT * FROM 'tttstats' WHERE 'steamid' = '"..steamid.."' ;")
	q:start()
	local Data = q:getData()
	local PlayerResults = Data[1]
	local SlaysLeft = PlayerResults.slaysleft
	
	local NewSlays = SlaysLeft - NumSlays
	local NewSlays = math.Round( NewSlays )
	local q = db:query("UPDATE 'tttstats' SET 'slaysleft'="..NewSlays.." WHERE 'steamid'="..steamid.."' ;")
	q:start()
end

function VISTIO.CheckForce( target )

end

function VISTIO.AddForce( target, NumRounds, Team )
	
end

function VISTIO.AddForceID( steamid, NumRounds, Team )

end

function VISTIO.RemoveForce( target, NumRounds, Team )

end

function VISTIO.RemoveForceID( steamid, NumRounds, Team )

end

VISTIO.Core.RegisterModule(MODULE)