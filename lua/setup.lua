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

function FOffCheaters:Require(path)
	dofile(FOffCheaters.PathToMod .. path .. ".lua")
end

function FOffCheaters:Logger(message, ...)
	-- ignore any deprecated warnings you get from your ide here, blt is still below lua 5.1 
	log(string.format("[FOffCheaters] " .. message, unpack({...})))
end

function FOffCheaters:SendLocally(message, bypassSilent)
	if FOffCheaters.Settings.SilentMode and not bypassSilent then return end
	managers.chat:_receive_message(ChatManager.GAME, "Fuck Off Cheaters", message, tweak_data.system_chat_color)
end

function FOffCheaters:MarkChecked(steamid)
	FOffCheaters.Checked[steamid] = true
end
function FOffCheaters:HasBeenChecked(steamid)
	return FOffCheaters.Checked[steamid] or false
end

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
	FOffCheaters:Logger("Routing hook %s -> %s", RequiredScript, FOffCheaters.HookRoutes[RequiredScript])
	FOffCheaters:Require(FOffCheaters.HookRoutes[RequiredScript])
end
