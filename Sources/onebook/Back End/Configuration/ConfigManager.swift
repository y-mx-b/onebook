import Foundation
import BookmarkParser

enum ConfigError: Error {
    case unknownError
    case invalidKey
    enum InvalidValue: Error {
        case notBool
        case invalidBrowser
        case invalidFormatType
        case generic
    }
}

fileprivate func checkIfBool(_ value: String) throws -> Bool {
    switch value {
    case "on":
        return true
    case "off":
        return false
    default:
        throw ConfigError.InvalidValue.notBool
    }
}

fileprivate func checkBrowsers(_ value: String) throws -> [String] {
    let browsers = value.lowercased().components(separatedBy: " ")
    for browser in browsers {
        guard let _ = Browser(rawValue: browser) else {
            throw ConfigError.InvalidValue.invalidBrowser
        }
    }
    return browsers
}

fileprivate func checkFormatTypes(_ value: String) throws -> [String] {
    let formats = value.lowercased().components(separatedBy: " ")
    for format in formats {
        guard let _ = FormatTypes(rawValue: format) else {
            throw ConfigError.InvalidValue.invalidFormatType
        }
    }
    return formats
}

struct ConfigManager {
    func set(_ key: String?, value: String?) throws {
        guard let pKey = PreferenceKeys(rawValue: key!) else {
            throw ConfigError.invalidKey
        }

        let fm = FileManager.default
        let pld = PropertyListDecoder()
        let ple = PropertyListEncoder()

        let currentPreferencesData = fm.contents(atPath: Preferences().preferencesPath)
        let currentPreferences = try! pld.decode(Preferences.self, from: currentPreferencesData!)
        var newPreferences = currentPreferences

        switch pKey {
        // PATHS
        case .storageDirectory:
            newPreferences.storageDirectory = value!
        case .configPath:
            newPreferences.configPath = value!
        // SETTINGS
        case .configState:
            newPreferences.configState = try checkIfBool(value!)
        case .editor:
            newPreferences.editor = value!
        case .importDefault:
            newPreferences.importDefault = try checkBrowsers(value!)
        case .cleanPreferences:
            newPreferences.cleanPreferences = [:]
            // clear cleanPreferences to overwrite it
            let allCleanPreferences: Set = ["f", "b"]
            let cleanPreferences: Set = Set(value!.lowercased().components(separatedBy: ","))

            guard cleanPreferences.isSubset(of: allCleanPreferences) else {
                throw ConfigError.InvalidValue.generic
            }

            if cleanPreferences.contains("f") {
                newPreferences.cleanPreferences[CleanState.emptyFolders.rawValue] = true
            } else {
                newPreferences.cleanPreferences[CleanState.emptyFolders.rawValue] = false
            }

            if cleanPreferences.contains("b") {
                newPreferences.cleanPreferences[CleanState.emptyBookmarks.rawValue] = true
            } else {
                newPreferences.cleanPreferences[CleanState.emptyBookmarks.rawValue] = false
            }
        case .syncDefault:
            newPreferences.importDefault = try checkBrowsers(value!)
        case .exportDefault:
            newPreferences.exportDefault = try checkFormatTypes(value!)
        case .readingList:
            newPreferences.readingList = try checkIfBool(value!)
        case .debug:
            newPreferences.debug = try checkIfBool(value!)
        // FUN
        case .progressBar:
            newPreferences.progressBar = try checkIfBool(value!)
        }

        let newPreferencesData = try! ple.encode(newPreferences)
        try! fm.removeItem(atPath: Preferences().preferencesPath)
        fm.createFile(atPath: Preferences().preferencesPath, contents: newPreferencesData, attributes: nil)
    }
}
