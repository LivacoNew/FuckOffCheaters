-- All of these should be lower-case!
-- Can be both IDs and Names
FOffCheaters.DangerousMods = {
	-- "Can be used normally but still needs to be counted"
	["berserker live matters"] = true,
	["freeflightcamera"] = true,

	-- "Depends on who you ask"
	["carrystackerreloaded"] = true,
	["carry stacker reloaded"] = true,
	["carry stacker live and reloaded"] = true,
	["carry stacker2.0"] = true,
	["carry stacker 2.0"] = true,
	["carry stacker"] = true,
	["lock smasher"] = true,
	["locksmasher"] = true,
	-- DLC Unlocker
	["unlock_only_heists"] = true,
	["unlock_only_characters"] = true,
	["unlock_all_dlcs"] = true,
	["selective downloadable content"] = true,
	["old spawnpoint delays"] = true,
	["character"] = true,
	["downloadable content"] = true,

	-- "Definitely Cheating"
	["rngmodifier"] = true,
	["infinite ammo"] = true,
	["infiniteammo"] = true,
	["cookfaster"] = true,
	["cook faster"] = true,
	["printfaster"] = true,
	["print faster"] = true,
	["unlimited pagers"] = true,
	["no pager on domination"] = true,
	["cc and money generator"] = true,
	["inf pager"] = true,
	["infpagers"] = true,
	["inf pagers"] = true,
	["inf pagers & answer time"] = true,
	["lowcostskill"] = true,
	["xp increaser"] = true,
	["xp increaser (on mission end) - gab"] = true,
}

function FOffCheaters:CheckMods(peer)
	if not peer:is_modded() then return false end
	local mods = peer:synced_mods()
	if #mods <= 0 then return false end

	local isCheater = false
	for _,v in pairs(mods) do
		if FOffCheaters.DangerousMods[string.lower(v.id)] or FOffCheaters.DangerousMods[string.lower(v.name)] then
			FOffCheaters:RegisterInfraction(peer, FOffCheaters:Infraction(1, "Found malicious mod: " .. v.name .. " (" .. v.id .. ")"))
			isCheater = true
		end
	end

	return isCheater
end
