import Foundation

struct ChromiumChildren: Codable {
    let children: [ChromiumChildren]?
    let date_added: String
    let guid: String
    let id: String
    let name: String
    let type: String
    let url: String?
}

struct ChromiumBookmarks: Codable {
    let checksum: String
    struct Roots: Codable {
        let bookmark_bar: ChromiumChildren
        let other: ChromiumChildren
        let synced: ChromiumChildren
    }
    let roots: Roots
    let version: Int
}
