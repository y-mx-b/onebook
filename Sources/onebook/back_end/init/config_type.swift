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
