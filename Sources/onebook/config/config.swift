import Foundation
import TOMLDecoder

struct Config: Decodable {
    struct Import: Decodable {
        let default_browsers: [String]
    }
    struct Export: Decodable {
        let default_browsers: [String]
    }
    struct Sync: Decodable {
        let default_browsers: [String]
    }
    let `import`: Import
    let export: Export
    let sync: Sync
}

func createConfig() {
    let configPath = "\(NSHomeDirectory())/.config/onebook/onebook.toml"
    let fileCreater = FileManager.default
    let configContent = returnDefaultConfig()
    fileCreater.createFile(atPath: configPath, contents: configContent.data(using: .utf8), attributes: nil)
}

func createConfigPrompt() {
    print("Create configuration file?")
    print("Y/N?", terminator: " ")
    let input = readLine()
    switch input!.uppercased() {
    case "Y", "YES":
        createConfig()
    case "N", "NO":
        print("Aborting.")
    default:
        print("ERROR: INVALID INPUT")
        createConfigPrompt()
    }
}

func checkForConfigFile() -> (Bool, String) {
    let configPath = "\(NSHomeDirectory())/.config/onebook/onebook.toml"
    let fileChecker = FileManager.default
    return (fileChecker.fileExists(atPath: configPath), configPath)
}

func readFromConfig(_ configData: String?) -> Config? {
    let decoder = TOMLDecoder()
    do {
        let data = try decoder.decode(Config.self, from: configData ?? "")
        return data
    } catch {
        print("Configuration file not detected.")
        print("Try running `onebook init`")
        return nil
    }
}

func getConfigData() -> String? {
    let configPath = NSURL(fileURLWithPath: "\(NSHomeDirectory())/.config/onebook/onebook.toml") as URL
    // let configPath = NSURL(fileURLWithPath: "\(NSHomeDirectory())/git-dir/onebook/default_config.toml") as URL

    do {
        let contents = try String(contentsOf: configPath, encoding: .utf8)
        return contents
    } catch {
        return nil
    }
}
