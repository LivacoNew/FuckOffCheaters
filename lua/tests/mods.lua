-- All of these should be lower-case!
-- Can be both IDs and Names
FOffCheaters.DangerousMods = {
	-- "Can be used normally but still needs to be counted"
	["berserker live matters"] = true,
	["freeflightcamera"] = true,
	["customfov"] = true,

	-- "Cheaty but depends on who you ask"
	["carrystackerreloaded"] = true,
	["carry stacker reloaded"] = true,
	["carry stacker live and reloaded"] = true,
	["carry stacker2.0"] = true,
	["carry stacker 2.0"] = true,
	["carry stacker"] = true,
	["equipment stacker"] = true,
	["lock smasher"] = true,
	["locksmasher"] = true,
	["silentassassin"] = true,
	["silent assassin"] = true,
	["drag not bag"] = true,
	["get spree from bags"] = true,
	["bags in spree"] = true,
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
	["run faster (legit version) - gab"] = true, -- despite it's name, it's source code indicates it is not in-fact legit
	["run 2x faster - gab"] = true,
	["removable mask"] = true,
	["payday2-god-master"] = true, -- found in the wild, i believe from this https://github.com/pinchedloaf/payday2-god/tree/master
	["god"] = true,
	["invincible sentries"] = true,
	["infinite Sentry ammo"] = true,
}

function FOffCheaters:CheckMods(peer)
	if not peer:is_modded() then return false end
	local mods = peer:synced_mods()
	if #mods <= 0 then return false end

	local isCheater = false
	for _,v in pairs(mods) do
		if FOffCheaters.DangerousMods[string.lower(v.id)] or FOffCheaters.DangerousMods[string.lower(v.name)] then
			FOffCheaters:RegisterInfraction(peer, FOffCheaters:Infraction(1, managers.localization:text("foffcheaters_infraction_mod", {
				MODNAME = v.name,
				MODID = v.id
			})))
			isCheater = true
		end
	end

	return isCheater
end
