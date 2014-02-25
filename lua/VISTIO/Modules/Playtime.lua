local MODULE = {}
MODULE.Name = "Playtime"

local META = FindMetaTable( "Player" )
function META:SetPlayTime( Playtime )
	self:SetNWInt( "mb_time", math.abs( PlayTime ) )
	return PlayTime
end

function META:GetPlayTime( )
	return self:GetNWInt( "mb_time" )
end

function META:IncreasePlayTime()
	self:SetPlayTime( self:GetPlayTime() + 1 )
	return self:GetPlayTime()
end

function META:mb_formatTime( )
	if( self:GetNWInt( "mb_time" ) == nil ) then return 0 end
end


local function SavePlyTime( ply )
	local PlayTime = ply:GetPlayTime()
	local steamid = ply:SteamID()
	
	VISTIO.SavePlaytime(PlayTime, steamid)
end

local function LoadPlyTime( ply )
	local steamid = ply:SteamID()
	
	VISTIO.GetPlaytime( steamid )
	if Playtime == nil then
		ply:SetPlayTime( 0 )
		print( "No time found for player: " .. ply:SteamID() .. " - " .. ply:Nick() )
		return
	end
	ply:SetPlayTime( PlayTime )
end
hook.Add( "PlayerInitialSpawn", "LoadPlayerTime", LoadPlyTime )

timer.Create( "PlayerTimesIIncrement", 1, 0, function()
	for k, ply in pairs( player.GetAll() ) do
		if( not ply:IsValid() ) then continue end
		ply:IncreasePlayTime( )	
	end
end)

timer.Create("SavePlayerTimes", 120, 0, function()
	for k, ply in pairs( player.GetAll() ) do
		SavePlyTime( ply )
	end
end)