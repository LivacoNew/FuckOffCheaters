-- Table Inits
FOffCheaters = FOffCheaters or {}
FOffCheaters.Settings = {}
FOffCheaters.HookRoutes = {
	["lib/network/base/networkpeer"] = "lua/test",
	["lib/managers/hudmanagerpd2"] = "lua/test",
	["lib/managers/menumanager"] = "lua/menus",
	["lib/managers/localizationmanager"] = "lua/localization"
}
FOffCheaters.Checked = FOffCheaters.Checked or {}
FOffCheaters.FlaggedCheaters = FOffCheaters.FlaggedCheaters or {}
FOffCheaters.PathToMod = ModPath
FOffCheaters.PathToSave = SavePath
FOffCheaters.PathToDetections = ModPath .. "detections/"

-- Require files
function FOffCheaters:Require(path)
	dofile(FOffCheaters.PathToMod .. path .. ".lua")
end

-- Logging
-- Call it overengineered for a payday mod, but I like good log files
FOffCheaters.LogLevels = {
	ERROR = {
		level = 1,
		string = "Error"
	},
	WARNING = {
		level = 2,
		string = "Warning"
	},
	INFO = {
		level = 3,
		string = "Info"
	},
	DEBUG = {
		level = 4,
		string = "Debug"
	}
	-- No verbose :^)
}
FOffCheaters.LogLevel = FOffCheaters.LogLevels.DEBUG
function FOffCheaters:Logger(level, message, ...)
	if level.level > FOffCheaters.LogLevel.level then return end
	-- ignore any deprecated warnings you get from your ide here, blt is still below lua 5.1 
	log(string.format("[FOffCheaters: " .. level.string .. "] " .. message, unpack({...})))
end
-- Shortcuts
function FOffCheaters:LogError(message, ...)
	FOffCheaters:Logger(FOffCheaters.LogLevels.ERROR, message, unpack({...}))
end
function FOffCheaters:LogWarning(message, ...)
	FOffCheaters:Logger(FOffCheaters.LogLevels.WARNING, message, unpack({...}))
end
function FOffCheaters:LogInfo(message, ...)
	FOffCheaters:Logger(FOffCheaters.LogLevels.INFO, message, unpack({...}))
end
function FOffCheaters:LogDebug(message, ...)
	FOffCheaters:Logger(FOffCheaters.LogLevels.DEBUG, message, unpack({...}))
end

-- Messages to the player
function FOffCheaters:LocalMessage(key, values, bypassSilent)
	FOffCheaters:LocalMessageRaw(managers.localization:text(key, values), bypassSilent)
end
function FOffCheaters:LocalMessageRaw(message, bypassSilent)
	if FOffCheaters.Settings.SilentMode and not bypassSilent then return end
	managers.chat:_receive_message(ChatManager.GAME, "Fuck Off Cheaters", message, tweak_data.system_chat_color)
end

-- Marks players has have been checked already, to prevent spamming 
function FOffCheaters:MarkChecked(steamid)
	FOffCheaters.Checked[steamid] = true
end
function FOffCheaters:HasBeenChecked(steamid)
	return FOffCheaters.Checked[steamid] or false
end

-- Load/Save Settings
function FOffCheaters:DefaultSettings()
	return {
		SilentMode = true,
		LogDetections = true,
		MarkCheaters = false,
		Detections = {
			CheaterTag = true,
			Skills = true,
			P3DHack = true,
			ModList = true
		},
		DisabledModFilters = {}
	}
end	
function FOffCheaters:SaveSettings()
	io.save_as_json(FOffCheaters.Settings, FOffCheaters.PathToSave .. "foffcheaters_settings.json")
end
function FOffCheaters:LoadSettings()
	FOffCheaters.Settings = io.load_as_json(FOffCheaters.PathToSave .. "foffcheaters_settings.json") or FOffCheaters:DefaultSettings()
	-- Account for old settings files
	FOffCheaters.Settings.DisabledModFilters = FOffCheaters.Settings.DisabledModFilters or {}
end
FOffCheaters:LoadSettings()

-- Hook Routing
if RequiredScript then
	if not FOffCheaters.HookRoutes[RequiredScript] then return end
	FOffCheaters:LogDebug("Routing hook %s -> %s", RequiredScript, FOffCheaters.HookRoutes[RequiredScript])
	FOffCheaters:Require(FOffCheaters.HookRoutes[RequiredScript])
end

-- From here, the hook takes over from wherever it routed to
