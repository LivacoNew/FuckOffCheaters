FOffCheaters:Require("lua/tests/cheater-tag")
FOffCheaters:Require("lua/tests/mods")
FOffCheaters:Require("lua/tests/p3dhack")
FOffCheaters:Require("lua/tests/skills")

function FOffCheaters:CheckPeer(peer)
	if not peer:synched() or not peer:skills() then return end

	FOffCheaters:SendLocally("Checking Peer " .. peer:name() .. " (" .. peer:account_id() .. ")")
	local isCheater = FOffCheaters:TestPeer(peer)

	if isCheater then
		local detections = FOffCheaters:CheckDetection(peer:account_id())
		FOffCheaters:SendLocally(peer:name() .. " has been identified as a cheater: ")
		for _,v in pairs(detections) do
			FOffCheaters:SendLocally(" - " .. v)
		end
	else
		FOffCheaters:SendLocally("Cleared " .. peer:name())
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

if RequiredScript == "lib/network/base/networkpeer" then 
	Hooks:PostHook(BaseNetworkSession, "on_peer_sync_complete", "foffcheater_peer_check", function(_, peer, peerID)
		-- We're not loaded in yet either, meaning info on other peers isn't available
		if not managers.network:session():peer(NetworkHelper:LocalPeerID()):synched() then return end 

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
	end)
end
