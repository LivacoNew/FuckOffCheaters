FOffCheaters = FOffCheaters or {}
FOffCheaters.Settings = FOffCheaters.Settings or {
	Detections = {
		CheaterTag = true,
		Skills = true,
		P3DHack = true,
		ModList = true
	}
}
-- SteamID -> Message of Detection
FOffCheaters.Cleared = FOffCheaters.Cleared or {}
FOffCheaters.DetectionCache = FOffCheaters.DetectionCache or {}
FOffCheaters.PathToMod = ModPath
function FOffCheaters:SendLocally(message)
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
end
function FOffCheaters:CheckDetection(steamid)
	return FOffCheaters.DetectionCache[steamid]
end

-- Hook Routing
if RequiredScript == "lib/setups/gamesetup" then
	FOffCheaters:Require("lua/test")
end
if RequiredScript == "lib/network/base/networkpeer" then
	FOffCheaters:Require("lua/test")
end
