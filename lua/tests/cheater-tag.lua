function FOffCheaters:CheckCheaterTag(peer)
	if peer:is_cheater() then
		FOffCheaters:RegisterInfraction(peer, FOffCheaters:Infraction(1, managers.localization:text("foffcheaters_infraction_cheatertag")))
		return true
	end
	return false
end
