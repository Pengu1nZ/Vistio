local MODULE = {}
MODULE.Name = "Access"


--[[Group Ordering]]--


VISTIO.Access = {}

VISTIO.Access.Groups = {}

VISTIO.Access.Groups["SUPERADMIN"].Name = "Super Administrator"
VISTIO.Access.Groups["DOUBLEADMIN"].Name = "Double Administrator"
VISTIO.Access.Groups["ADMIN"].Name = "Administrator"
VISTIO.Access.Groups["MODERATOR"].Name = "Moderator"
VISTIO.Access.Groups["VIP"].Name = "VIP"
VISTIO.Access.Groups["USER"].Name = "User"


VISTIO.Access.Groups["SUPERADMIN"].AccessLevel = 1
VISTIO.Access.Groups["DOUBLEADMIN"].AccessLevel = 2
VISTIO.Access.Groups["ADMIN"].AccessLevel = 3
VISTIO.Access.Groups["MODERATOR"].AccessLevel = 4
VISTIO.Access.Groups["VIP"].AccessLevel = 5
VISTIO.Access.Groups["USER"].AccessLevel = 6

VISTIO.Access.Groups["SUPERADMIN"].Flags = "SDAMU"
VISTIO.Access.Groups["DOUBLEADMIN"].Flags = "DAMU"
VISTIO.Access.Groups["ADMIN"].Flags = "AMU"
VISTIO.Access.Groups["MODERATOR"].Flags = "MU"
VISTIO.Access.Groups["VIP"].Flags = "VU"
VISTIO.Access.Groups["USER"].Flags = "U"
--[[Flag Functions]]--

function VISTIO.GrantFlags( p, GrantedFlags )

	local SteamID = p:SteamID()
	local GrantedFlags = GrantedFlags
	local CurFlags = p.Access.Flags
	
	if string.find(CurFlags, GrantedFlags) then
		string.Replace( CurFlags , GrantedFlags, "" )
		p.Access.Flags = CurFlags..""..GrantedFlags
	else
		p.Access.Flags = CurFlags..""..GrantedFlags
	end
	
	VISTIO.SavePlayerFlags( SteamID, PlayerFlags )
end

function VISTIO.RevokeFlags( p, flags )
	if string.find(p.Access.Flags , flags ) then
		string.Replace(p.Access.Flags, flags, "")
	else
		return
	end


end

function VISTIO.SetPlayerFlags( p )
	local SteamID = ply:SteamID()
	VISTIO.GetPlayerFlags(SteamID)
	
	p.Access.Flags = PlayerFlags
end


function VISTIO.HasFlag( p, RequiredFlag )
	local PlayerFlags = p.Access.Flags
	
	if string.find( PlayerFlags, RequiredFlag ) then
		return true
	else
		return false
	end
	
end



--[[General Access Functions]]--

function VISTIO.SetPlayerAccess( p, TargetGroup, time )
	p.AccessGroup = TargetGroup
	if time = 0 then
		TimeFlag = "P"
	elseif time >= 1 then
		TimeFlag = "T"
	end
	VISTIO.GrantFlags( p , VISTIO.Access.Groups[TargetGroup].Flags )
	VISTIO.GrantFlags( p , TimeFlag )
end

function VISTIO.CanTarget( p, targetp )
	if VISTIO.HasFlag( targetp  , "X" ) then
		return false
	else
		if VISTIO.Access.Groups[targetp.AccessGroup].AccessLevel < VISTIO.Access.Groups[p.AccessGroup].AccessLevel then
			return false
		elseif VISTIO.Access.Groups[p.AccessGroup].AccessLevel > VISTIO.Access.Groups[targetp.AccessGroup].AccessLevel then
			return false
		elseif VISTIO.Access.Groups[targetp.AccessGroup].AccessLevel = VISTIO.Access.Groups[p.AccessGroup].AccessLevel then
			if VISTIO.HasFlag( p , "T" ) and VISTIO.HasFlag( targetp, "P" ) then
				return false
			else
				return true
			end
		elseif VISTIO.Access.Groups[targetp.AccessGroup].AccessLevel > VISTIO.Access.Groups[p.AccessGroup].AccessLevel then
			return true
		elseif VISTIO.Access.Groups[p.AccessGroup].AccessLevel < VISTIO.Access.Groups[targetp.AccessGroup].AccessLevel then
			return true
		end
	end
end

function VISTIO.CanTargetSteamID( p, SteamID )
	VISTIO.GetPlayerFlags( SteamID )
	VISTIO.GetUserGroup( SteamID )
	
	if string.find( PlayerFlags , "X" ) then
		return false
	else
		if VISTIO.Access.Groups[TargetGroup].AccessLevel < VISTIO.Access.Groups[p.AccessGroup].AccessLevel then
			return false
		elseif VISTIO.Access.Groups[p.AccessGroup].AccessLevel > VISTIO.Access.Groups[TargetGroup].AccessLevel then
			return false
		elseif VISTIO.Access.Groups[TargetGroup].AccessLevel = VISTIO.Access.Groups[p.AccessGroup].AccessLevel then
			if VISTIO.HasFlag( p , "T" ) and string.find(PlayerFlags, "P") then
				return false
			else
				return true
			end
		elseif VISTIO.Access.Groups[TargetGroup].AccessLevel > VISTIO.Access.Groups[p.AccessGroup].AccessLevel then
			return true
		elseif VISTIO.Access.Groups[p.AccessGroup].AccessLevel < VISTIO.Access.Groups[TargetGroup].AccessLevel then
			return true
		end
	end

end





VISTIO.Core.RegisterModule(MODULE)