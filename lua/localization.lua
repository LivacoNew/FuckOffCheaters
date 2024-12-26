FOffCheaters.Localizations = {
	"english.json"
}
FOffCheaters.LocalizationDirectory = FOffCheaters.PathToMod .. "loc/"

Hooks:Add("LocalizationManagerPostInit", "foffcheaters_localization", function(loc)
	for _,v in pairs(FOffCheaters.Localizations) do
		loc:load_localization_file(FOffCheaters.LocalizationDirectory .. "/" .. v)
	end
end)
