FOffCheaters:Require("lua/tests/mods")

local DetectionNameLookup = {
	["cheatertag"] = "CheaterTag",
	["skills"] = "Skills",
	["p3dhack"] = "P3DHack",
	["modlist"] = "ModList"
}

Hooks:Add("MenuManagerSetupCustomMenus", "foffcheaters_settings_menu", function()
	MenuCallbackHandler.FOffCheaters_SaveSettings = function(_)
		-- Mod Detections
		FOffCheaters.Settings.DisabledModFilters = {}
		for k,v in pairs(FOffCheaters.ModDetections) do
			if not v.enabled then
				FOffCheaters.Settings.DisabledModFilters[k] = true
			end
		end
		FOffCheaters:SaveSettings()
	end

	-- TODO: Merge these
	MenuCallbackHandler.FOffCheaters_SilentModeSetting = function(_, item)
		-- just... why blt
		FOffCheaters.Settings.SilentMode = item:value() == "on"
	end
	MenuCallbackHandler.FOffCheaters_LogDetectionsSetting = function(_, item)
		FOffCheaters.Settings.LogDetections = item:value() == "on"
	end
	MenuCallbackHandler.FOffCheaters_MarkCheatersSetting = function(_, item)
		FOffCheaters.Settings.MarkCheaters = item:value() == "on"
	end

	MenuCallbackHandler.FOffCheaters_DetectionSettingSet = function(_, item)
		FOffCheaters.Settings.Detections[DetectionNameLookup[string.sub(item:parameter("name"), 21)]] = item:value() == "on"
	end

	MenuCallbackHandler.FOffCheaters_ToggleModDetection = function(_, item)
		local modName = string.sub(item:parameter("name"), 24)
		FOffCheaters.ModDetections[modName].enabled = item:value() == "on"
	end

	MenuHelper:LoadFromJsonFile(FOffCheaters.PathToMod .. "menus/settings.json", FOffCheaters, FOffCheaters.Settings)
	MenuHelper:LoadFromJsonFile(FOffCheaters.PathToMod .. "menus/detections.json", FOffCheaters, FOffCheaters.Settings.Detections)
	MenuHelper:LoadFromJsonFile(FOffCheaters.PathToMod .. "menus/mods.json", FOffCheaters, FOffCheaters.Settings.Detections)
end)

Hooks:Add("MenuManagerPopulateCustomMenus", "foffcheaters_modtoggle_populate", function(menu_manager, nodes)
	for k,v in pairs(FOffCheaters.ModDetections) do
		MenuHelper:AddToggle({
			id = "foffcheaters_modtoggle_" .. k,
			title = k,
			desc = "",
			value = v.enabled,
			callback = "FOffCheaters_ToggleModDetection",
			menu_id = "foffcheaters_mods",
			localized = false
		})
	end
end)
