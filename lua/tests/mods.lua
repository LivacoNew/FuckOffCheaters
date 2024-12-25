-- All of these should be lower-case!
FOffCheaters.DangerousModIDs = {
	-- Carry Stacker
	["carrystackerreloaded"] = true,
	["carry stacker live and reloaded"] = true,
	["carry stacker 2.0"] = true,
	["carry stacker"] = true,
	-- Infinite Ammo
	["infiniteammo"] = true,
	-- DLC Unlocker: https://github.com/pd2-stuff/DLC-Unlocker-PD2/tree/master
	["unlock_only_heists"] = true,
	["unlock_only_characters"] = true,
	["unlock_all_dlcs"] = true,
	-- Cook Faster: https://github.com/DrNewbie/CookFaster
	["cookfaster"] = true,
	-- Unlimited Pagers: https://modworkshop.net/mod/41337
	["unlimited pagers"] = true,
	-- https://modworkshop.net/mod/24657
	["no pager on domination"] = true,
	-- https://www.nexusmods.com/payday2/mods/167
	["cc and money generator"] = true,
	-- https://modworkshop.net/mod/19579
	-- i understand it's technically not by default, but can be used as one 
	["berserker live matters"] = true,
	-- Misc 
	["inf pager"] = true,
	["infpagers"] = true,
}
FOffCheaters.DangerousModNames = {
	-- Carry Stacker
	["carry stacker reloaded"] = true,
	["carry stacker: live and reloaded"] = true,
	["carry stacker2.0"] = true,
	["carry stacker 2.0"] = true,
	-- Infinite Ammo
	["infinite ammo"] = true,
	-- DLC Unlocker: https://github.com/pd2-stuff/DLC-Unlocker-PD2/tree/master
	["selective downloadable content"] = true,
	["character"] = true,
	["downloadable content"] = true,
	-- Cook Faster: https://github.com/DrNewbie/CookFaster
	["cook faster"] = true,
	-- Unlimited Pagers: https://modworkshop.net/mod/41337
	["unlimited pagers"] = true,
	-- https://modworkshop.net/mod/24657
	["no pager on domination"] = true,
	-- https://www.nexusmods.com/payday2/mods/167
	["cc and money generator"] = true,
	-- https://modworkshop.net/mod/19579
	-- i understand it's technically not by default, but can be used as one 
	["berserker live matters"] = true,
	-- Misc 
	["inf pagers"] = true,
	["inf pagers & answer time"] = true,
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
