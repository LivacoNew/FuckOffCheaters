local DetectionNameLookup = {
	["cheatertag"] = "CheaterTag",
	["skills"] = "Skills",
	["p3dhack"] = "P3DHack",
	["modlist"] = "ModList"
}

Hooks:Add("MenuManagerSetupCustomMenus", "foffcheaters_settings_menu", function()
	MenuCallbackHandler.FOffCheaters_SaveSettings = function(_)
		FOffCheaters:SaveSettings()
	end
	MenuCallbackHandler.FOffCheaters_SilentModeSetting = function(_, item)
		-- just... why blt
		FOffCheaters.Settings.SilentMode = item:value() == "on"
	end
	MenuCallbackHandler.FOffCheaters_LogDetectionsSetting = function(_, item)
		FOffCheaters.Settings.LogDetections = item:value() == "on"
	end

	MenuCallbackHandler.FOffCheaters_DetectionSettingSet = function(_, item)
		FOffCheaters.Settings.Detections[DetectionNameLookup[string.sub(item:parameter("name"), 21)]] = item:value() == "on"
	end

	MenuHelper:LoadFromJsonFile(FOffCheaters.PathToMod .. "menus/settings.json", FOffCheaters, FOffCheaters.Settings)
	MenuHelper:LoadFromJsonFile(FOffCheaters.PathToMod .. "menus/detections.json", FOffCheaters, FOffCheaters.Settings.Detections)
end)
