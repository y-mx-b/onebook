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
struct SafariBookmarks: Codable {
    let WebBookmarkUUID: String
    // let WebBookmarkFileVersion: Int
    let Children: [SafariChildren]?
    let Title: String
    // only exists for lone bookmarks
    let URIDictionary: SafariURIDictionary?
    let URLString: String?
    let WebBookmarkType: String
}
