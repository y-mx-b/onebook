import Foundation

do {
    let fm = FileManager.default
    let propertiesData = fm.contents(atPath: Preferences().preferencesPath)
    let preferences = try PropertyListDecoder().decode(Preferences.self, from: propertiesData!)
    if preferences.configModifiedDateCalc! > preferences.configModifiedDate!
            && InitManager().checkForConfigFile(preferences.configPath) {
        ConfigManager().runConfig()
    }
} catch {
}

Onebook.main()
