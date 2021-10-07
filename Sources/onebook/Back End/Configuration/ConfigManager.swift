import Foundation

struct ConfigManager {
    let plistPath: String = "\(NSHomeDirectory())/Library/Application Support/onebook/Preferences.plist"
    var configPath: String? = "\(NSHomeDirectory())/.config/onebook/onebookrc"
    // shell script, runs config options if file has been edited
    var configState: Bool = true
    // if false, don't run config path
}
