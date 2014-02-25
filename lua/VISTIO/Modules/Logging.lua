local MODULE = {}
MODULE.Name = "Logging"


--[[CHATLOGS FUNCTIONS]]--
function MODULE.SaveToChatLogs( sender, text, teamChat )
	--I hate lowerCamelCase
	local Sender = sender
	local Text = text
	local TeamChat = teamChat
	--Get a readable timestamp
	local TimeStamp = tostring(os.date("%m/%d/%y %I:%M %p",os.time()))
	--Create an index value for the table
	local ChatLogIndex = ChatLogIndex + 1
	--Create the table
	VISTIO.ChatLogs = []

	if TeamChat then
		local ChatLogLine = "["..TimeStamp.."](TEAM)"..Sender..":"..text.."/n"
	else
		local ChatLogLine = "["..TimeStamp.."]"..Sender..":"..text.."/n"
	end
	
	table.insert(VISTIO.ChatLogs, ChatLogIndex, ChatLogLine)
end
hook.Add( "PlayerSay", "SaveToChatLogs", MODULE.SaveToChatLogs )

function MODULE.DumpChatLogs( Sender, Text, TeamChat )
	
end


--[[WEBDUMP FUNCTIONS]]--

function MODULE.SendLogsToWeb()

end



--[[ADDING OTHER THINGS TO LOG]]--

function MODULE.FindOtherLogs()

end

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
function meta:LAMMessage(msg, col)
	VISTIO.Notify(self, msg, col)
end



VISTIO.Core.RegisterModule(MODULE)