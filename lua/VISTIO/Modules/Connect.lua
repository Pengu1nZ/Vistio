local MODULE = {}
MODULE.Name = "Connect"

function MODULE.RefuseConnect(steamID)
	--Change the steamid to the type we want
	local SteamID = util.SteamIDFrom64(steamID)
	
	if VISTIO.IsPlayerBanned( SteamID ) then
		game.ConsoleCommand("kickid "..SteamID.." "..KickMessage.."\n")
		MsgN(SteamID.." attempted to connect to the server.")
	end
	
	
end
hook.Add("CheckPassword", "VISTIOCheckBan" , MODULE.RefuseConnect)

function MODULE.ExpirePlayer( p )
	if VISTIO.ShouldUserExpire( p ) then
		VISTIO.GetPlayerFlags( p )
		if string.find( PlayerFlags, "V" ) then
			VISTIO.AddUserQuery( p , "VIP" , 0 )
		else
			VISTIO.AddUserQuery( p , "USER", 0 )
		end
	end
end
hook.Add("PlayerInitialSpawn", "VISTIOExpirePlayer", MODULE.ExpirePlayer )

function MODULE.SetPlayerFlags( p )
	VISTIO.SetPlayerFlags( p )
	
end
hook.Add("PlayerInitialSpawn", "VISTIOSetFlags", MODULE.SetPlayerFlags)

function MODULE.SetPlayerAccess( p )
	VISTIO.GetUserGroup( p )
	if TargetGroup = nil then
		TargetGroup = "USER"
		VISTIO.SetPlayerAccess( p , TargetGroup, 0 )
		local target = p
		VISTIO.AddUserQuery( target, TargetGroup, 0)
	else
		VISTIO.SetPlayerAccess( p , TargetGroup, Time )
	end

end
hook.Add("PlayerInitialSpawn", "VISTIOSetAccess", MODULE.SetPlayerAccess)

function MODULE.UpdateLastSeen( ply )
	local SteamID = ply:SteamID()
	
	VISTIO.UpdateLastSeen(SteamID)
end
hook.Add("PlayerInitialSpawn", "UpdateLastSeen", MODULE.UpdateLastSeen)

function MODULE.JoinMessage( ply )
	SteamID = ply:SteamID()
	Name = ply:Name()
	
	for k, ply in pairs( player.GetAll() ) do
		ply:ChatPrint( "[LAM]:"..Name.."("..SteamID..") has joined the server" )
	end

end
hook.Add("PlayerInitialSpawn", "VISTIOJoinMessage", MODULE.JoinMessage )




VISTIO.Core.RegisterModule(MODULE)