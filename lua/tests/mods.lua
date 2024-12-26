-- All of these should be lower-case!
FOffCheaters.DangerousModIDs = {
	["carrystackerreloaded"] = true,
	["carry stacker live and reloaded"] = true,
	["carry stacker 2.0"] = true,
	["carry stacker"] = true,
	["infiniteammo"] = true,
	["unlock_only_heists"] = true,
	["unlock_only_characters"] = true,
	["unlock_all_dlcs"] = true,
	["cookfaster"] = true,
	["print faster"] = true,
	["unlimited pagers"] = true,
	["no pager on domination"] = true,
	["cc and money generator"] = true,
	["berserker live matters"] = true,
	["locksmasher"] = true,
	["rngmodifier"] = true,
	["inf pager"] = true,
	["infpagers"] = true,
	["lowcostskill"] = true,
	["xp increaser (on mission end) - gab"] = true,
	["old spawnpoint delays"] = true,
}
FOffCheaters.DangerousModNames = {
	["carry stacker reloaded"] = true,
	["carry stacker: live and reloaded"] = true,
	["carry stacker2.0"] = true,
	["carry stacker 2.0"] = true,
	["infinite ammo"] = true,
	["selective downloadable content"] = true,
	["character"] = true,
	["downloadable content"] = true,
	["cook faster"] = true,
	["print faster"] = true,
	["unlimited pagers"] = true,
	["no pager on domination"] = true,
	["cc and money generator"] = true,
	["berserker live matters"] = true,
	["lock smasher"] = true,
	["rngmodifier"] = true,
	["inf pagers"] = true,
	["inf pagers & answer time"] = true,
	["lowcostskill"] = true,
	["xp increaser"] = true,
	["xp increaser (on mission end) - gab"] = true,
	["old spawnpoint delays"] = true,
}

function FOffCheaters:CheckMods(peer)
	if not peer:is_modded() then return false end
	local mods = peer:synced_mods()
	if #mods <= 0 then return false end

	local isCheater = false
	for _,v in pairs(mods) do
		if FOffCheaters.DangerousModIDs[string.lower(v.id)] or FOffCheaters.DangerousModNames[string.lower(v.name)] then
			FOffCheaters:RegisterInfraction(peer, FOffCheaters:Infraction(1, "Found malicious mod: " .. v.name .. " (" .. v.id .. ")"))
			isCheater = true
		end
	end

	return isCheater
end
