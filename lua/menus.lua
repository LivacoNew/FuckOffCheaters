Hooks:Add("MenuManagerSetupCustomMenus", "foffcheaters_settings_menu", function()
	MenuCallbackHandler.FOffCheaters_SaveSettings = function(self)
		FOffCheaters:SaveSettings()
	end
	MenuCallbackHandler.FOffCheaters_SilentModeSetting = function(self, item)
		-- just... why blt
		FOffCheaters.Settings.SilentMode = item:value() == "on"
	end

	MenuHelper:LoadFromJsonFile(FOffCheaters.PathToMod .. "menus/settings.json", FOffCheaters, FOffCheaters.Settings)
end)
