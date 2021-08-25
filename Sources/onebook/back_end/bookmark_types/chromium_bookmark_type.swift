import Foundation

struct ChromiumBookmarks: Codable {
    let checksum: String
    struct Roots: Codable {
        struct Children: Codable {
            let children: [Children]?
            let date_added: String
            let guid: String
            let id: String
            let name: String
            let type: String
            let url: String?
        }
        // struct Folder: Codable {
        //     let children: [Children]
        //     let date_added: String
        //     let guid: String
        //     let id: String
        //     let name: String
        //     let type: String
        // }
        // struct NestedFolders: Codable {
        //     let children: [Folder]
        //     let date_added: String
        //     let guid: String
        //     let id: String
        //     let name: String
        //     let type: String
        // }
        let bookmark_bar: Children
        let other: Children
        let synced: Children
    }
    let roots: Roots
    let version: Int
}
