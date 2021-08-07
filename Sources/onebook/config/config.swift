import Foundation
import Yams

func testYAML() {
    struct Test: Codable {
        var p: String
    }

    let s = Test(p: "test")
    let encoder = YAMLEncoder()
    let encodedYAML = try! encoder.encode(s)
    print(encodedYAML)

    let decoder = YAMLDecoder()
    let decoded = try! decoder.decode(Test.self, from: encodedYAML)
    print(decoded.p)
}
