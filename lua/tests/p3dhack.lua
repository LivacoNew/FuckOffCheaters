function FOffCheaters:CheckP3DHack(peer)
	if string.find(string.lower(peer:name()), "p3dhack") then
		FOffCheaters:RegisterInfraction(peer, FOffCheaters:Infraction(1, "Users name contains \"pd3hack\", indicating usage of P3DHack."))
		return true
	end
	return false
end
