import Foundation

/*
Things to Ignore:
 - Item 0 = History
 - Item 1 = Bookmarks Bar
 - Item 3 = come.apple.ReadingList
*/

/*
Types of Entries (From Item 4 on)
 - Lone bookmarks (no Title, no Children, has URIDictionary)
    - WebBookmarkType = "WebBookmarkTypeLeaf"
 - Folders (has Title, has Children)
    - WebBookmarkType = "WebBookmarkTypeList"
 - Nested Folders (has Title, Children have Children)
    - WebBookmarkType = "WebBookmarkTypeList"
*/
struct URIDictionary: Codable {
    let title: String
}
struct Children: Codable {
    let WebBookmarkUUID: String
    let URLString: String?
    let WebBookmarkType: String
    let URIDictionary: URIDictionary?
}
struct Folder: Codable {
    let WebBookmarkUUID: String
    let Children: [Children]?
    let WebBookmarkType: String
    let Title: String?
}
struct SafariBookmarks: Codable {
    let WebBookmarkUUID: String
    // let WebBookmarkFileVersion: Int
    let Children: [Folder]?
    let Title: String
    // only exists for lone bookmarks
    let URIDictionary: URIDictionary?
    let URLString: String?
    let WebBookmarkType: String
}
