function FOffCheaters:CheckP3DHack(peer)
	if string.find(string.lower(peer:name()), "p3dhack") then
		FOffCheaters:RegisterInfraction(peer, FOffCheaters:Infraction(1, managers.localization:text("foffcheaters_infraction_p3dhack")))
		return true
	end
	return false
end
