import XCTest
@testable import BBSwift

final class BBSwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BBSwift().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
