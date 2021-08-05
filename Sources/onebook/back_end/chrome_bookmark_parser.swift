import Foundation

/* TODO: JSON parsing
    structure:
    "roots": {
    "children": [ {
        "date_added": unix time
        ...
        "name": String
        ...
        "url": URL
    }, {
        ...
    } ],
    "date_added": unix time
    "name": tag
    },
    "other": {
        "children": [ {
        "children": [ {
            ***same as above***
        } ],

    } ],
    ...
    },
    "synced": {
    ***same as above***
    }
*/

func jsonTest() {
    struct BlogPost: Decodable {
        enum Category: String, Decodable {
            case swift, combine, debugging, xcode
        }

        let title: String
        let url: URL
        let category: Category
        let views: Int
    }

    let JSON = """
    {
        "title": "Options in Swift explained: 5 things you should know",
        "url": "https://www.avanderlee.com/swift/optionals-in-swift-explained-5-things-you-should-know/",
        "category": "swift",
        "views": 47093
    }
    """

    let jsonData = JSON.data(using: .utf8)!
    let blogPost: BlogPost = try! JSONDecoder().decode(BlogPost.self, from: jsonData)

    print(blogPost.title)
}
