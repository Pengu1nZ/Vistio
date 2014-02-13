VISTIO = {}
local CORE = {}
CORE.Phrases = {}
CORE.Phrase = function(name, ...)
		local phrase = "#phrase_" .. name
		if ( CORE.Phrases[name]) then
			phrase = Format(CORE.Phrases[name][math.random(1, #CORE.Phrases[name])], unpack({...}))
		end
		
		return phrase
end

CORE.AddPhrases = function(name, ...)
	CORE.Phrases[name] = CORE.Phrases[name] or {}
	
	for k, v in pairs({...}) do
		if (!table.HasValue(CORE.Phrases[name], v)) then
			table.insert(CORE.Phrases[name], v)
		end
	end
end
	
function CORE.Init()
	CORE.LoadModules()
	CORE.InitModules()
end

function CORE.RegisterModule(t) -- Detects registration code in the files
	VISTIO.Modules[t.Name] = t
end

function CORE.LoadModule(s) -- Locates the files
	include("VISTIO/Modules/"..s)
end

function CORE.LoadModules() -- Loads the Module files
	VISTIO.Modules = {}
	local files = file.Find("VISTIO/Modules/*.lua", "LUA")
	for k, v in pairs(files) do
		CORE.LoadModule(v)
	end
end

function CORE.InitModules() -- Initializes the Modules
	for k, v in pairs(VISTIO.Modules) do
		if v.Init then
			v.Init()
		end
	end
end
-- Don't let Liam fuck with this ^ --
-- Add whatever you want down here. --
-- Adding Commands, Plugins, Connecting to the DB and etc can be accessed with Modules. --






VISTIO.Core = CORE