function FOffCheaters:CheckCheaterTag(peer)
	if peer:is_cheater() then
		FOffCheaters:RegisterDetection(peer:account_id(), "Marked as cheater by game.")
		return true
	end
	return false
end
