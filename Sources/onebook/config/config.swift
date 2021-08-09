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
}

func createConfigPrompt() {
    print("Create configuration file?")
    print("Y/N?", terminator: " ")
    let input = readLine()
    switch input!.uppercased() {
    case "Y":
        createConfig()
        print("Yes.")
    case "N":
        print("No.")
    default:
        print("ERROR: INVALID INPUT")
        createConfigPrompt()
    }
}

func readFromConfig(_ configData: String?) {
    let decoder = TOMLDecoder()
    do {
        let data = try decoder.decode(Config.self, from: configData ?? "")
    } catch {
        print("ERROR: NO CONFIGURATION FILE")
        createConfigPrompt()
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
