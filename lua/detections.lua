-- Creates an "infraction" object
function FOffCheaters:Infraction(level, description)
	return {
		level = level,
		description = description
	}
end 

function FOffCheaters:RegisterInfraction(peer, infraction)
	local steamid = peer:account_id()

	if not FOffCheaters.FlaggedCheaters[steamid] then
		FOffCheaters.FlaggedCheaters[steamid] = {
			knownMods = {},
			infractions = {}
		}
		local mods = peer:synced_mods()
		for _,v in pairs(mods) do
			FOffCheaters.FlaggedCheaters[steamid].knownMods[v.id] = v.name
		end
	end
	table.insert(FOffCheaters.FlaggedCheaters[steamid].infractions, infraction)

	-- Write to detections 
	if FOffCheaters.Settings.LogDetections then
		if not file.DirectoryExists(FOffCheaters.PathToDetections) then
			file.CreateDirectory(FOffCheaters.PathToDetections)
		end
		io.save_as_json(FOffCheaters.FlaggedCheaters[steamid], FOffCheaters.PathToDetections .. steamid .. ".json")
	end
end

function FOffCheaters:CheckCheaterFlag(steamid)
	return FOffCheaters.FlaggedCheaters[steamid]
end
