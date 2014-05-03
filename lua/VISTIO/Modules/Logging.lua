local MODULE = {}
MODULE.Name = "Logging"

VISTIO.Logs = {}

/*
--[[CHATLOGS FUNCTIONS]]--
VISTIO.Logs.ChatLogs = {}
function MODULE.SaveToChatLogs( sender, text, teamChat )
	--I hate lowerCamelCase
	local Sender = sender
	local Text = text
	local TeamChat = teamChat
	--Get a readable timestamp
	local TimeStamp = tostring(os.date("%m/%d/%y %I:%M %p",os.time()))
	--Create an index value for the table
	local ChatLogIndex = ChatLogIndex - 1
	--Create the table
	VISTIO.ChatLogs = {}

	if TeamChat then
		local ChatLogLine = "["..TimeStamp.."](TEAM)"..Sender..":"..text.."\n"
	else
		local ChatLogLine = "["..TimeStamp.."]"..Sender..":"..text.."\n"
	end
	if ChatLogIndex = 1 then
		MODULE.DumpChatLogs()
		ChatLogIndex = 100
	else
		table.insert(VISTIO.Logs.ChatLogs, ChatLogIndex, ChatLogLine)
	end
end
hook.Add( "PlayerSay", "SaveToChatLogs", MODULE.SaveToChatLogs )


--[[Command Logs]]--
VISTIO.Logs.CMDLogs = {}
function VISTIO.SaveToCommandLogs( p , a , c )
	local TimeStamp = tostring(os.date("%m/%d/%y %I:%M %p",os.time()))
	
	local CMDLogIndex = CMDLogIndex - 1
	
	local CMDLogLine = "["..TimeStamp.."] VISTIO COMMAND: "..p:Name().."("..p:SteamID().." " .. c:lower() .. " " .. table.concat(a, " ") .. ". \n"
	
	VISTIO.CMDLogs = {}
	
	if ChatLogIndex = 1 then
		MODULE.DumpChatLogs()
		ChatLogIndex = 100
	else
		table.insert(VISTIO.Logs.CMDLogs, CMDLogIndex, CMDLogLine)
	end
	
end


function MODULE.SaveLogs()
	if !file.Exists("VISTIO","DATA") then
		file.CreateDir( "VISTIO" )
	end
	
	local TimeStamp = tostring(os.date("%m/%d/%y %I:%M %p",os.time()))
	file.Write("VISTIO Log - "..TimeStamp, "")
end
*/

--[[Chat notifications]]--
util.AddNetworkString("VISTIO.Message")
util.AddNetworkString("_CMessage")

function VISTIO.Notify(pl, msg, col)
	if not pl then return end
	if not msg then msg = "" end
	if not col then col = 3 end
	
	net.Start("VISTIO.Message")
		net.WriteString(msg)
		net.WriteString(col)
	net.Send(pl)
end

function VISTIO.AdminConsole(R,G,B,Message, Player)
	local RF = {}
	for k,v in pairs(player.GetAll()) do
		if v:IsAdmin() then
			table.insert(RF, v)
		end
	end
	
	if Player then
		table.insert(RF, Player)
	end
	
	net.Start("_CMessage")
		net.WriteInt(R, 9)
		net.WriteInt(G, 9)
		net.WriteInt(B, 9)
		net.WriteString(Message)
	net.Send(RF)
end

function VISTIO.CMessageAll(R,G,B,Message)
	net.Start("_CMessage")
		net.WriteInt(R, 9)
		net.WriteInt(G, 9)
		net.WriteInt(B, 9)
		net.WriteString(Message)
	net.Broadcast()
end

function VISTIO.CMessage(Table, R,G,B,Message)
	net.Start("_CMessage")
		net.WriteInt(R, 9)
		net.WriteInt(G, 9)
		net.WriteInt(B, 9)
		net.WriteString(Message)
	net.Send(Table)
end
	
		
local meta = FindMetaTable("Player")
function meta:VISTIOMessage(msg, col)
	VISTIO.Notify(self, msg, col)
end



VISTIO.Core.RegisterModule(MODULE)