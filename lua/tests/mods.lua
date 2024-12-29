FOffCheaters.ModDetections = {}
function FOffCheaters:RegisterModDetection(modName, modDetectionFunc)
	FOffCheaters.ModDetections[modName] = {
		enabled = true,
		func = modDetectionFunc
	}
end
function FOffCheaters:CheckMod(modID, modName)
	local lowerID = string.lower(modID)
	local lowerName = string.lower(modName)

	for k,v in pairs(FOffCheaters.ModDetections) do
		if v.enabled then 
			if v.func(lowerID, lowerName) then
				return k
			end 
		end 
	end 
end 

-- The actual check 
function FOffCheaters:CheckMods(peer)
	if not peer:is_modded() then return false end
	local mods = peer:synced_mods()
	if #mods <= 0 then return false end

	local isCheater = false
	for _,v in pairs(mods) do
		local mod = FOffCheaters:CheckMod(v.id, v.name)
		if mod then
			FOffCheaters:RegisterInfraction(peer, FOffCheaters:Infraction(1, managers.localization:text("foffcheaters_infraction_mod", {
				MODNAME = mod
			})))
			isCheater = true
		end
	end

	return isCheater
end

-- All the mods
-- Lots of repetition down here!
local function BasicContains(modID, modName, target)
	-- Lots of mods just simply need something like this
	return string.match(modID, target) or string.match(modName, target)
end


-- 
-- "Can be used normally but still needs to be counted"
--
FOffCheaters:RegisterModDetection("Bezerker Live Matter", function(modID, modName)
	-- ["berserker live matters"] = true,
	return BasicContains(modID, modName, "berserker live matter")
end)
FOffCheaters:RegisterModDetection("Free Flight Camera", function(modID, modName)
	-- ["freeflightcamera"] = true,
	return BasicContains(modID, modName, "freeflightcamera") or BasicContains(modID, modName, "free flight camera")
end)

-- NOT AN ACTUAL CHEAT I HAVE IT HERE FOR TESTING REASONS IGNORE ME PLEASE
FOffCheaters:RegisterModDetection("CustomFOV", function(modID, modName)
	-- ["freeflightcamera"] = true,
	return BasicContains(modID, modName, "customfov") 
end)

--
-- "Cheaty but depends on who you ask"
--
FOffCheaters:RegisterModDetection("Carry Stacker", function(modID, modName)
	-- ["carrystackerreloaded"] = true,
	-- ["carry stacker reloaded"] = true,
	-- ["carry stacker live and reloaded"] = true,
	-- ["carry stacker2.0"] = true,
	-- ["carry stacker 2.0"] = true,
	-- ["carry stacker"] = true,
	return BasicContains(modID, modName, "carrystacker") or BasicContains(modID, modName, "carry stacker")
end)
FOffCheaters:RegisterModDetection("Equipment Stacker", function(modID, modName)
	-- ["equipment stacker"] = true,
	return BasicContains(modID, modName, "equipmentstacker") or BasicContains(modID, modName, "equipment stacker")
end)
FOffCheaters:RegisterModDetection("Lock Smasher", function(modID, modName)
	-- ["lock smasher"] = true,
	-- ["locksmasher"] = true,
	return BasicContains(modID, modName, "locksmasher") or BasicContains(modID, modName, "lock smasher")
end)
FOffCheaters:RegisterModDetection("Silent Assassin", function(modID, modName)
	-- ["silentassassin"] = true,
	-- ["silent assassin"] = true,
	return BasicContains(modID, modName, "silentassassin") or BasicContains(modID, modName, "silent assassin")
end)
FOffCheaters:RegisterModDetection("Drag Not Bag", function(modID, modName)
	-- ["drag not bag"] = true,
	return BasicContains(modID, modName, "drag not bag") or BasicContains(modID, modName, "silent assassin")
end)
FOffCheaters:RegisterModDetection("Get Spree From Bags", function(modID, modName)
	-- Also known on the mods page: Bags add points in Crime Spree
	-- ["get spree from bags"] = true,
	-- ["bags in spree"] = true,
	return BasicContains(modID, modName, "get spree from bags") or BasicContains(modID, modName, "bags in spree")
end)
FOffCheaters:RegisterModDetection("Old Spawnpoint Delays", function(modID, modName)
	-- ["old spawnpoint delays"] = true,
	return BasicContains(modID, modName, "old spawnpoint delays")
end)
FOffCheaters:RegisterModDetection("DLC Unlocker", function(modID, modName)
	-- ["unlock_only_heists"] = true,
	-- ["unlock_only_characters"] = true,
	-- ["unlock_all_dlcs"] = true,
	-- ["selective downloadable content"] = true,
	-- ["character"] = true,
	-- ["downloadable content"] = true,

	-- awful `or` chain
	return BasicContains(modID, modName, "unlock_only_heists")
		or BasicContains(modID, modName, "unlock_only_characters")
		or BasicContains(modID, modName, "unlock_all_dlcs")
		or BasicContains(modID, modName, "downloadable content")
		or BasicContains(modID, modName, "character")
end)

--
-- "Definitely Cheating"
--
FOffCheaters:RegisterModDetection("RNG Modifier", function(modID, modName)
	-- ["rngmodifier"] = true,
	return BasicContains(modID, modName, "rngmodifier")
end)
FOffCheaters:RegisterModDetection("Infinite Ammo", function(modID, modName)
	-- ["infinite ammo"] = true,
	-- ["infiniteammo"] = true,
	return BasicContains(modID, modName, "infiniteammo") or BasicContains(modID, modName, "infinite ammo")
end)
FOffCheaters:RegisterModDetection("Removable Mask", function(modID, modName)
	-- ["removable mask"] = true,
	return BasicContains(modID, modName, "removable mask")
end)
FOffCheaters:RegisterModDetection("Cook Faster", function(modID, modName)
	-- ["cookfaster-master"] = true,
	-- ["cookfaster"] = true,
	-- ["cook faster"] = true,
	return BasicContains(modID, modName, "cookfaster") or BasicContains(modID, modName, "cook faster")
end)
FOffCheaters:RegisterModDetection("Super Cooker", function(modID, modName)
	-- Auto-cooker https://mod.3dmgame.com/mod/155455
	-- ["supercooker"] = true, 
	-- ["weber's super cooker"] = true,
	return BasicContains(modID, modName, "supercooker") or BasicContains(modID, modName, "weber's super cooker")
end)
FOffCheaters:RegisterModDetection("Print Faster", function(modID, modName)
	-- ["printfaster"] = true,
	-- ["print faster"] = true,
	return BasicContains(modID, modName, "printfaster") or BasicContains(modID, modName, "print faster")
end)
FOffCheaters:RegisterModDetection("XP Increaser", function(modID, modName)
	-- ["xp increaser"] = true,
	-- ["xp increaser (on mission end) - gab"] = true,
	return BasicContains(modID, modName, "xp increaser")
end)
FOffCheaters:RegisterModDetection("Experience on Kill", function(modID, modName)
	-- ["experience on kill"] = true,
	return BasicContains(modID, modName, "experience on kill")
end)
FOffCheaters:RegisterModDetection("Run Faster", function(modID, modName)
	-- ["run faster (legit version) - gab"] = true, -- despite it's name, it's source code indicates it is not in-fact legit
	-- ["run 2x faster - gab"] = true,
	return BasicContains(modID, modName, "run faster") or BasicContains(modID, modName, "run 2x faster")
end)
FOffCheaters:RegisterModDetection("Unlimited/Infinite Pagers", function(modID, modName)
	-- ["unlimited pagers"] = true,
	-- ["inf pager"] = true,
	-- ["infpagers"] = true,
	-- ["inf pagers"] = true,
	-- ["inf pagers & answer time"] = true,
	return BasicContains(modID, modName, "unlimited pagers")
		or BasicContains(modID, modName, "inf pager")
		or BasicContains(modID, modName, "infpagers")
end)
FOffCheaters:RegisterModDetection("God Mode", function(modID, modName)
	-- ["payday2-god-master"] = true, -- found in the wild, i believe from this https://github.com/pinchedloaf/payday2-god/tree/master
	-- ["god"] = true,
	return BasicContains(modID, modName, "god")
end)
FOffCheaters:RegisterModDetection("Invincible Sentries", function(modID, modName)
	-- ["invincible sentries"] = true,
	return BasicContains(modID, modName, "invincible sentries")
end)
FOffCheaters:RegisterModDetection("MySentry", function(modID, modName)
	-- ["mysentry"] = true, -- Found in the wild, no online info on it. From what I can tell, infinite turrets
	-- ["mysentry2"] = true, -- See above
	return BasicContains(modID, modName, "mysentry")
end)
FOffCheaters:RegisterModDetection("Infinite Sentry Ammo", function(modID, modName)
	-- ["infinite sentry ammo"] = true,
	return BasicContains(modID, modName, "infinite sentry ammo")
end)
FOffCheaters:RegisterModDetection("No Pager on Domination", function(modID, modName)
	-- ["no pager on domination"] = true,
	return BasicContains(modID, modName, "no pager on domination")
end)
FOffCheaters:RegisterModDetection("CC and Money Generator", function(modID, modName)
	-- ["cc and money generator"] = true,
	return BasicContains(modID, modName, "cc and money generator")
end)
FOffCheaters:RegisterModDetection("Low Cost Skill", function(modID, modName)
	-- ["lowcostskill"] = true,
	return BasicContains(modID, modName, "lowcostskill")
end)
FOffCheaters:RegisterModDetection("Pirate Perfection", function(modID, modName)
	-- ["pirate perfection reborn trainer! free edition"] = true,
	-- ["pirate perfection reborn trainer! pro edition"] = true,
	-- ["pirate perfection reborn trainer! v.i.p. edition"] = true,
	return BasicContains(modID, modName, "pirate perfection")
end)
FOffCheaters:RegisterModDetection("Utimate Trainer", function(modID, modName)
	-- ["ultimatetrainer-6"] = true,
	-- ["ultimate trainer 6"] = true,
	return BasicContains(modID, modName, "ultimate trainer") or BasicContains(modID, modName, "ultimatetrainer")
end)
