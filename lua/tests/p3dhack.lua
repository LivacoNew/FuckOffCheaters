function FOffCheaters:CheckP3DHack(peer)
	if string.find(string.lower(peer:name()), "p3dhack") then
		FOffCheaters:RegisterDetection(peer:account_id(), "Name contains \"pd3hack\"")
		return true
	end
	return false
end
