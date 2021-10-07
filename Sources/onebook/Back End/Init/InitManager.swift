import Foundation

struct InitManager {
    // CHECKS

    func checkForConfigFile(_ configPath: String) -> Bool {
        return false
    }

    func checkForStorageDirectory(_ storageDirectory: String) -> Bool {
        return false
    }

    func checkForPreferences(_ plistPath: String) -> Bool {
        return false
    }

}
