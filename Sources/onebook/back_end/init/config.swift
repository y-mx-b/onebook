import Foundation

// TODO remove hard-coded config directory

// separate back-end and front-end more
// use throwing functions

func createConfig() {
    let configFolderPath = "\(NSHomeDirectory())/.config/onebook"
    let fileManager = FileManager.default
    try! fileManager.createDirectory(atPath: configFolderPath, withIntermediateDirectories: true)
    fileManager.createFile(atPath: "\(configFolderPath)/onebookrc", contents: nil, attributes: nil)
}

func checkForConfigFile() -> (Bool, String) {
    let configPath = "\(NSHomeDirectory())/.config/onebook/onebookrc"
    return (FileManager.default.fileExists(atPath: configPath), configPath)
    let fileState = FileManager.default.fileExists(atPath: configPath)
    // move error message here
}

// func readFromConfig(_ configData: String?) -> Config? {
//     do {
//         let data = try decoder.decode(Config.self, from: configData ?? "")
//         return data
//     } catch {
//         print("Configuration file not detected.")
//         print("Try running `onebook init`")
//         return nil
//     }
// }
