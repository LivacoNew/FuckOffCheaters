function FOffCheaters:CheckSkills(peer)
	local str = string.split(peer:skills(), "-")[1]
	local values = string.split(str, "_")

	local total_skill_points = 0
	for _,v in pairs(values) do
		total_skill_points = total_skill_points + tonumber(v)
	end

	if total_skill_points > 120 then
		FOffCheaters:RegisterInfraction(peer, FOffCheaters:Infraction(1, "User has over 120 skill points allocated."))
		return true
	end
	return false
end
