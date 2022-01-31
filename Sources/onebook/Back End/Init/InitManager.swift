import Foundation

enum InitErrors: Error {
    // NO ITEM AT PATH
    case noPreferences(String)
    case noConfig(String)
    case noStorage(String)
}

fileprivate let configFileContents =
    """
    #!/bin/sh

    ##### ONEBOOK CONFIGURATION FILE #####

    # Any valid shell commands can be run
    """.data(using: .utf8)

struct InitManager {
    // CHECKS
    // NO ITEM -> ERROR
    // ITEM EMPTY -> FALSE
    // -> TRUE
    func checkForPreferencesFile() throws -> Bool {
        let fm = FileManager.default
        let preferencesPath = Preferences().preferencesPath
        guard fm.fileExists(atPath: preferencesPath) else { throw InitErrors.noPreferences(preferencesPath) }
        guard let _ = fm.contents(atPath: preferencesPath) else { return false }
        return true
    }

    func checkForConfigFile(_ configPath: String) throws -> Bool {
        let fm = FileManager.default
        guard fm.fileExists(atPath: configPath) else { throw InitErrors.noConfig(configPath) }
        guard let _ = fm.contents(atPath: configPath) else { return false }
        return true
    }

    func checkForStorageDirectory(_ storageDirectory: String) throws -> Bool {
        let fm = FileManager.default
        guard fm.fileExists(atPath: storageDirectory) else { throw InitErrors.noStorage(storageDirectory) }
        guard let _ = fm.contents(atPath: storageDirectory) else { return false }
        return true
    }

    // CREATE
    func createConfigFile(_ configPath: String) -> Bool {
        let fm = FileManager.default

        var attributes = [FileAttributeKey: Any]()
        attributes[.posixPermissions] = 0o755

        var pathArray = configPath.components(separatedBy: "/")
        _ = pathArray.popLast()
        let directoryPath = pathArray.joined(separator: "/")

        if !fm.createFile(atPath: configPath, contents: configFileContents, attributes: attributes) {
            do {
                try fm.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
                fm.createFile(atPath: configPath, contents: configFileContents, attributes: attributes)
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
        var preferences = Preferences()

        do {
            if try checkForConfigFile(preferences.configPath) {
                preferences.configModifiedDate = preferences.configModifiedDateCalc
            }
        } catch {
        }

        let preferencesData = try! PropertyListEncoder().encode(preferences)

        var pathArray = preferences.preferencesPath.components(separatedBy: "/")
        _ = pathArray.popLast()
        let directoryPath = pathArray.joined(separator: "/")

        if !fm.createFile(atPath: preferences.preferencesPath, contents: preferencesData, attributes: nil) {
            do {
                try fm.createDirectory(
                    atPath: directoryPath,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
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
