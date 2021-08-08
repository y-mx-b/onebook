import Foundation
import Yams

struct Config: Codable {
    var browser: String
}

func writeToConfig() {
    let encoder = YAMLEncoder()
}

func readFromConfig() {
    let decoder = YAMLDecoder()
}
