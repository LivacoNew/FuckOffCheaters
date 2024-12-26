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

	MenuHelper:LoadFromJsonFile(FOffCheaters.PathToMod .. "menus/settings.json", FOffCheaters, FOffCheaters.Settings)
end)
