import Foundation

struct InitManager {
    // CHECKS
    func checkForConfigFile(_ configPath: String) -> Bool {
        let fm = FileManager.default
        return fm.fileExists(atPath: configPath)
    }

    func checkForStorageDirectory(_ storageDirectory: String) -> Bool {
        let fm = FileManager.default
        return fm.fileExists(atPath: storageDirectory)
    }

    func checkForPreferencesFile() -> Bool {
        let fm = FileManager.default
        let preferences = Preferences()
        return fm.fileExists(atPath: preferences.preferencesPath)
    }


    // CREATE
    func createConfigFile(_ configPath: String) -> Bool {
        let fm = FileManager.default

        var pathArray = configPath.components(separatedBy: "/")
        pathArray.popLast()
        let directoryPath = pathArray.joined(separator: "/")

        if !fm.createFile(atPath: configPath, contents: nil, attributes: nil) {
            do {
                try fm.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
                fm.createFile(atPath: configPath, contents: nil, attributes: nil)
                return true
            } catch {
                return false
            }
        } else {
            return true
        }
    }

    func createStorageDirectory(_ storageDirectory: String) -> Bool {
        let fm = FileManager.default

        do {
            try fm.createDirectory(atPath: storageDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            return false
        }
        return true
    }

    func createPreferencesFile() -> Bool {
        let fm = FileManager.default
        let preferences = Preferences()
        let preferencesData = try! PropertyListEncoder().encode(preferences)

        var pathArray = preferences.preferencesPath.components(separatedBy: "/")
        pathArray.popLast()
        let directoryPath = pathArray.joined(separator: "/")

        if !fm.createFile(atPath: preferences.preferencesPath, contents: preferencesData, attributes: nil) {
            do {
                try fm.createDirectory(atPath: directoryPath, withIntermediateDirectories: true,
                                       attributes: nil)
                fm.createFile(atPath: preferences.preferencesPath, contents: preferencesData, attributes: nil)
                return true
            } catch {
                return false
            }
        } else {
            return true
        }
    }
}
