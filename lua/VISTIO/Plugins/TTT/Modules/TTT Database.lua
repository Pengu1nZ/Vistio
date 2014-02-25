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


VISTIO.Core.RegisterModule(MODULE)