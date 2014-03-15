local MODULE = {}
MODULE.Name = "Commands"

function MODULE.Init()
	MODULE.LoadCommands()
end

function MODULE.RegisterCommand(t)
	VISTIO.Commands[string.upper(t.Name)] = t
end

function MODULE.LoadCommand(s)
	include("VISTIO/Commands/"..s)
	include("VISTIO/Plugins/*/Commands/"..s)
end


function MODULE.LoadCommands()
	VISTIO.Commands = {}
	local files = file.Find("VISTIO/Commands/*.lua", "LUA") and file.Find("VISTIO/Plugins/*/Commands/*.lua", "LUA")
	for k, v in pairs(files) do
		MODULE.LoadCommand(v)
	end

end

function MODULE.ParseCMD()


end

VISTIO.Core.RegisterModule(MODULE)