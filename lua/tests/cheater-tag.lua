function FOffCheaters:CheckCheaterTag(peer)
	if peer:is_cheater() then
		FOffCheaters:RegisterInfraction(peer, FOffCheaters:Infraction(1, "Player marked as cheater by PAYDAY 2."))
		return true
	end
	return false
end
