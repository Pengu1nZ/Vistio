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
hook.Add("CheckPassword", "CheckBan" , MODULE.RefuseConnect)

function MODULE.SetPlayerFlags( ply )
	local SteamID = ply:SteamID()
	local PlayerName = ply:Name()
	
	VISTIO.GetPlayerFlags(SteamID)
	VISTIO.SetPlayerFlags(ply)
	
end
hook.Add("PlayerInitialSpawn", "SetFlags", MODULE.SetPlayerFlags)

function MODULE.UpdateLastSeen( ply )
	local SteamID = ply:SteamID()
	
	VISTIO.UpdateLastSeen(SteamID)
end
hook.Add("PlayerInitialSpawn", "UpdateLastSeen", MODULE.UpdateLastSeen)




VISTIO.Core.RegisterModule(MODULE)