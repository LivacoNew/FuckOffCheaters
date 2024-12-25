FOffCheaters:Require("lua/tests/cheater-tag")
FOffCheaters:Require("lua/tests/mods")
FOffCheaters:Require("lua/tests/p3dhack")
FOffCheaters:Require("lua/tests/skills")

function FOffCheaters:CheckPeer(peer)
	if not peer:synched() or not peer:skills() then return end

	FOffCheaters:SendLocally("Checking Peer " .. peer:name() .. " (" .. peer:account_id() .. ")", false)
	local isCheater = FOffCheaters:TestPeer(peer)

	if isCheater then
		local detections = FOffCheaters:CheckDetection(peer:account_id())
		FOffCheaters:SendLocally(peer:name() .. " has been identified as a cheater: ", true)
		for _,v in pairs(detections) do
			FOffCheaters:SendLocally(" - " .. v, true)
		end
	else
		FOffCheaters:SendLocally("Cleared " .. peer:name(), false)
		FOffCheaters:ClearPlayer(peer:account_id())
	end
end

function FOffCheaters:TestPeer(peer)
	local detection = FOffCheaters:CheckDetection(peer:account_id())
	if detection then return true end

	local isCheater = false

	if FOffCheaters.Settings.Detections.CheaterTag then
		if FOffCheaters:CheckCheaterTag(peer) then isCheater = true end
	end
	if FOffCheaters.Settings.Detections.Skills then
		if FOffCheaters:CheckSkills(peer) then isCheater = true end
	end
	if FOffCheaters.Settings.Detections.P3DHack then
		if FOffCheaters:CheckP3DHack(peer) then isCheater = true end
	end
	if FOffCheaters.Settings.Detections.ModList then
		if FOffCheaters:CheckMods(peer) then isCheater = true end
	end

	return isCheater
end

function FOffCheaters:TriggerChecks(peer)
	local us = managers.network:session():peer(NetworkHelper:LocalPeerID())
	-- We're not loaded in yet either, meaning info on other peers isn't available
	if not us:synched() and not NetworkHelper:IsHost() then return end

	-- Re-Check all other players in-case we're joining a lobby
	for _,v in pairs(NetworkHelper:GetPeers()) do
		if v:synched() then
			if not FOffCheaters:IsClear(v:account_id()) and not FOffCheaters:CheckDetection(v:account_id()) then
				FOffCheaters:CheckPeer(v)
			end
		end
	end

	if FOffCheaters:IsClear(peer:account_id()) or FOffCheaters:CheckDetection(peer:account_id()) then return end
	FOffCheaters:CheckPeer(peer)
end

if RequiredScript == "lib/managers/hudmanagerpd2" then
	log("[FOffCheaters] Setting up hud manager hooks")
	-- Credit to Blacklist for this method of getting the peer
	Hooks:PostHook(HUDManager, "set_teammate_name", "foffcheater_peer_check", function(_, peerID, _)
		if peerID == NetworkHelper:LocalPeerID() then return end
		local peer = managers.network:session():peer(peerID)
		if not peer then return end

		FOffCheaters:TriggerChecks(peer)
	end)
end
if RequiredScript == "lib/network/base/networkpeer" then
	log("[FOffCheaters] Setting up network peer hooks")
	Hooks:PostHook(BaseNetworkSession, "on_peer_sync_complete", "foffcheater_peer_check", function(_, peer, _)
		FOffCheaters:TriggerChecks(peer)
	end)
end
