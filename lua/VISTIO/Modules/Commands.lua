local MODULE = {}
MODULE.Name = "Commands"

function MODULE.Init()
	MODULE.LoadCommands()
	MODULE.LoadPluginCommands()
end

function MODULE.RegisterCommand(t)
	VISTIO.Commands[string.upper(t.Name)] = t
end

function MODULE.LoadCommand(s)
	include("VISTIO/Commands/"..s)
end

function MODULE.LoadPluginCommands(s)
	include("VISTIO/Plugins/*/Commands/"..s)
end

function MODULE.LoadCommands()
	VISTIO.Commands = {}
	local files = file.Find("VISTIO/Commands/*.lua", "LUA")
	for k, v in pairs(files) do
		MODULE.LoadCommand(v)
	end
	local CommandFiles = file.Find("VISTIO/Plugins/*/Commands/*.lua", "LUA")
	for k, v in pairs(CommandFiles) do
		MODULE.LoadPluginCommands(v)
	end
end



VISTIO.Core.RegisterModule(MODULE)