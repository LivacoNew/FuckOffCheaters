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
FOffCheaters.Checked = FOffCheaters.Checked or {}
FOffCheaters.FlaggedCheaters = FOffCheaters.FlaggedCheaters or {}
FOffCheaters.PathToMod = ModPath
FOffCheaters.PathToDetections = ModPath .. "detections/"
function FOffCheaters:SendLocally(message, bypassSilent)
	if FOffCheaters.Settings.SilentMode and not bypassSilent then return end
	managers.chat:_receive_message(ChatManager.GAME, "Fuck Off Cheaters", message, tweak_data.system_chat_color)
end

function FOffCheaters:Require(path)
	dofile(FOffCheaters.PathToMod .. path .. ".lua")
end

function FOffCheaters:MarkChecked(steamid)
	FOffCheaters.Checked[steamid] = true
end
function FOffCheaters:HasBeenChecked(steamid)
	return FOffCheaters.Checked[steamid] or false
end

-- Hook Routing
if RequiredScript then
	if not FOffCheaters.HookRoutes[RequiredScript] then return end
	log("[FOffCheaters] Routing hook " .. RequiredScript .. " -> " .. FOffCheaters.HookRoutes[RequiredScript])
	FOffCheaters:Require(FOffCheaters.HookRoutes[RequiredScript])
end
