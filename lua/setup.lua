FOffCheaters = FOffCheaters or {}
FOffCheaters.Settings = FOffCheaters.Settings or {
	SilentMode = true,
	Detections = {
		CheaterTag = true,
		Skills = true,
		P3DHack = true,
		ModList = true
	},
	LogDetections = true
}
FOffCheaters.HookRoutes = {
	["lib/network/base/networkpeer"] = "lua/test",
	["lib/managers/hudmanagerpd2"] = "lua/test",
}
-- SteamID -> Message of Detection
FOffCheaters.Cleared = FOffCheaters.Cleared or {}
FOffCheaters.DetectionCache = FOffCheaters.DetectionCache or {}
FOffCheaters.PathToMod = ModPath
FOffCheaters.PathToDetections = ModPath .. "detections/"
function FOffCheaters:SendLocally(message, bypassSilent)
	if FOffCheaters.Settings.SilentMode and not bypassSilent then return end
	managers.chat:_receive_message(ChatManager.GAME, "Fuck Off Cheaters", message, tweak_data.system_chat_color)
end

function FOffCheaters:Require(path)
	dofile(FOffCheaters.PathToMod .. path .. ".lua")
end

function FOffCheaters:ClearPlayer(steamid)
	FOffCheaters.Cleared[steamid] = true
end
function FOffCheaters:IsClear(steamid)
	return FOffCheaters.Cleared[steamid] or false
end
function FOffCheaters:RegisterDetection(steamid, message)
	if not FOffCheaters.DetectionCache[steamid] then
		FOffCheaters.DetectionCache[steamid] = {}
	end
	table.insert(FOffCheaters.DetectionCache[steamid], message)

	-- Write to detections 
	if FOffCheaters.Settings.LogDetections then
		io.save_as_json(FOffCheaters.DetectionCache[steamid], FOffCheaters.PathToDetections .. steamid .. ".json")
	end
end
function FOffCheaters:CheckDetection(steamid)
	return FOffCheaters.DetectionCache[steamid]
end

-- Hook Routing
if RequiredScript then
	if not FOffCheaters.HookRoutes[RequiredScript] then return end
	log("[FOffCheaters] Routing hook " .. RequiredScript .. " -> " .. FOffCheaters.HookRoutes[RequiredScript])
	FOffCheaters:Require(FOffCheaters.HookRoutes[RequiredScript])
end