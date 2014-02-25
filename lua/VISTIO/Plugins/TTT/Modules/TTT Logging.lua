local MODULE = {}
MODULE.Name = " TTT Logging"


--[[DAMAGELOGS FUNCTIONS]]--
function MODULE.SaveToDamageLogs( victim, attacker, healthRemaining, damageTaken )
	
	--I hate lowerCamelCase
	local Victim = victim
	local Attacker = attacker
	local HealthRemaining = healthRemaining
	local DamageTaken = damageTaken
	--Grab the steamids
	local VictimID = Victim:SteamID()
	local AttackerID = Attacker:SteamID()
	local VictimTeam = Victim:Team()
	local AttackerTeam = Attacker:Team()
	--Get a readable timestamp
	local TimeStamp = tostring(os.date("%m/%d/%y %I:%M %p",os.time()))
	--Create an index value for the table
	local DamageIndex = DamageIndex + 1
	--Create the table for it
	VISTIO.DamageLogs = []
	
	if HealthRemaining <= 0 then
		local DamageLogLine = "["..TimeStamp.."] "..Attacker.." ( "..AttackerID.." ) ["..AttackerTeam.."] killed "..Victim.."( "..VictimID.." ) ["..VictimTeam.."] /n"
	elseif HealthRemaining > 0 then
		local DamageLogLine = "["..TimeStamp.."] "..Attacker.." ( "..AttackerID.." ) ["..AttackerTeam.."] dealt "..DamageTaken.." to "..Victim.."( "..VictimID.." ) ["..VictimTeam.."] /n"
	end
	
	table.insert( VISTIO.DamageLogs, DamageIndex, DamageLogLine )
end
hook.Add( "PlayerHurt", "SaveToDamageLogs" , MODULE.SaveToDamageLogs )


--[[KILLLOGS FUNCTIONS]]--
function MODULE.SaveToKillLogs( victim, attacker, inflictor )
	--I hate lowerCaelCase
	local Victim = victim
	local Attacker = attacker
	local WeaponUsed = inflictor
	--Grab the steamids
	local VictimID = Victim:SteamID()
	local AttackerID = Attacker:SteamID()
	local VictimTeam = Victim:Team()
	local AttackerTeam = Attacker:Team()
	--Get a readable timestamp
	local TimeStamp = tostring(os.date("%m/%d/%y %I:%M %p",os.time()))
	--Create an index value for the table
	local KillIndex = KillIndex + 1
	--Create the table
	VISTIO.KillLogs = []
	
	local KillLogLine = "["..TimeStamp.."] "..Attacker.." ( "..AttackerID.." ) ["..AttackerTeam.."] killed "..Victim.."( "..VictimID.." ) ["..VictimTeam.."] using "..WeaponUsed.."/n"
	
	table.insert( VISTIO.KillLogs, KillIndex, LogLine )
	
	
end
hook.Add( "PlayerDeath", "SaveToKillLogs" , MODULE.SaveToKillLogs )


VISTIO.Core.RegisterModule(MODULE)