import Foundation

struct ConfigManager {
    let plistPath: String = "\(NSHomeDirectory())/Library/Application Support/onebook/Preferences.plist"
    var configState: Bool = true
    // if false, don't run config path
}
