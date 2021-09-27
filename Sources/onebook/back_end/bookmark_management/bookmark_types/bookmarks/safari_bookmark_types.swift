#if os(macOS)
import Foundation

struct SafariURIDictionary: Codable {
    let title: String
}
struct SafariChildren: Codable {
    let WebBookmarkUUID: String
    let Title: String?
    let Children: [SafariChildren]?
    let URLString: String?
    let WebBookmarkType: String
    let URIDictionary: SafariURIDictionary?
}
#endif
